#Requires -Version 6

$LF = "`n"

$PadRegex = [regex]'(?m)^(.)'
$PadReplace = '  $1'

$ShellSwitchMap = @{
    bash = @(
        'case "$OSTYPE" in'
        '{0}'
        'esac'
    ) -join $LF
    pwsh = @(
        'switch (Get-OsMoniker) {{'
        '{0}'
        '}}'
    ) -join $LF

}

$ShellCaseMap = @{
    bash = @{
        default = @(
            '*)'
            '{0}'
            ';;'
        ) -join $LF
        linux   = @(
            'linux*)'
            '{0}'
            ';;'
        ) -join $LF
        windows = @(
            'msys*)'
            '{0}'
            ';;'
        ) -join $LF
        macos   = @(
            'darwin*)'
            '{0}'
            ';;'
        ) -join $LF
    }
    pwsh = @{
        default = @(
            'default {{'
            '{0}'
            '}}'
        ) -join $LF
        linux   = @(
            "'linux' {{"
            '{0}'
            '}}'
        ) -join $LF
        windows = @(
            "'windows' {{"
            '{0}'
            '}}'
        ) -join $LF
        macos   = @(
            "'macos' {{"
            '{0}'
            '}}'
        ) -join $LF
    }
}

$ShellCmdMap = @{
    bash = @{
        env  = "export {0}='{1}'"
        exec = @(
            "if command -v '{0}' >/dev/null 2>&1 >/dev/null"
            'then'
            "  '{0}' {1} >/dev/null 2>&1"
            'fi'
        ) -join $LF
    }
    pwsh = @{
        env  = "`${{env:{0}}} = '{1}'"
        exec = @(
            '. {{'
            "  & (Get-Command -Name '{0}' -CommandType Application -ErrorAction Stop)[0].Path --% {1}"
            '}} *>&1 > $null'
        ) -join $LF
    }
}

filter Select-LowestScope {
    foreach ($scope in 'process', 'user', 'machine') {
        if ($_.scope.Keys -contains $scope) {
            $_.scope.$scope
            break
        }
    }
}

filter Select-LowestImpact {
    foreach ($target in 'env', 'exec') {
        if ($_.Keys -contains $target) {
            @{ $target = $_.$target }
            break
        }
    }
}

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

    foreach ($telemetry in $_.telemetry) {

        $target = $telemetry.target | Select-LowestImpact

        $code = if ($target) {
            '# {0}' -f $telemetry.name
            if ($telemetry.links.main) { '# {0}' -f $telemetry.links.main }

            $target.GetEnumerator() | ForEach-Object {

                if ($_.Key -and $ShellCmdMap.$Shell.ContainsKey($_.Key)) {
                    $scope = $_.Value | Select-LowestScope

                    if ($scope.path | Test-IsDefaultOnly) {
                        $ShellCmdMap.$Shell.($_.Key) -f $scope.path.default, $scope.value.opt_out
                    }
                    else {
                        $cases = foreach ($kv in $scope.path.GetEnumerator() | Sort-Object { $_.Key }) {
                            $ShellCaseMap.$Shell.($kv.Key) -f (
                                ($ShellCmdMap.$Shell.($_.Key) -f $kv.Value, $scope.value.opt_out) -replace $PadRegex, $PadReplace
                            )
                        }

                        $ShellSwitchMap.$Shell -f (
                            ($cases -join $LF) -replace $PadRegex, $PadReplace
                        )

                    }
                    Add-Newline
                }
            }
        }

        if ($code) {
            '# {0}' -f $_.name
            '# {0}' -f $_.links.main
            Add-Newline
            $code
        }
    }
}