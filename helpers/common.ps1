#Requires -Version 6

filter Add-Newline {
    if ($_) {
        $_
    }
    [string]::Empty
}

filter Test-IsDefaultOnly {
    if ($_.Keys -contains 'default' -and $_.Keys.Count -eq 1) {
        $true
    }
    else {
        $false
    }
}
