#Requires -Version 6

$LF = "`n"

filter Get-ShellScriptExtension {
    @{
        bash = 'sh'
        pwsh = 'ps1'
    }.$_
}

filter ConvertTo-ShellScript {
    Param (
        [ValidateSet('bash', 'pwsh')]
        [string]$Shell
    )

    $ShellCmdMap = @{
        bash = @{
            env = "export {0}='{1}'"
            exec = @(
                "if command -v '{0}' >/dev/null 2>&1 >/dev/null"
                'then'
                "  '{0}' {1} >/dev/null 2>&1"
                'fi'
            ) -join $LF
        }
        pwsh = @{
            env = "`${{env:{0}}} = '{1}'"
            exec = @(
                '. {{'
                "  & (Get-Command -Name '{0}' -CommandType Application -ErrorAction Stop)[0].Path --% {1}"
                '}} *>&1 > $null'
            ) -join $LF
        }
    }

    $OsShellMap = @{
        bash = 'Linux'
        pwsh = 'Windows'
    }

    $_ | Where-Object {
        ($_.telemetry).target.Keys -match '^(env|exec)$'
    } | ForEach-Object {
        '# {0}' -f $_.name
        '# {0}' -f $_.links.main

        $_.telemetry | Where-Object {
            $_.target.Keys -match '^(env|exec)$'
        } | ForEach-Object {
            if ($_.target.Keys -contains 'env'){
                $Env = if ($_.target.env.path.default) {
                    $_.target.env.path.default
                } else {
                    $_.target.env.path.($OsShellMap.$Shell)
                }

                $ShellCmdMap.$Shell.env -f $Env, $_.target.env.value.opt_out
            } elseif ($_.target.Keys -contains 'exec') {
                $Exec = if ($_.target.exec.path.default) {
                    $_.target.exec.path.default
                } else {
                    $_.target.exec.path.($OsShellMap.$Shell)
                }

                $ShellCmdMap.$Shell.exec -f $Exec, $_.target.exec.value.opt_out
            }

            Add-Newline
        }
    }
}
