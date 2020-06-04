#Requires -Version 6

filter Add-Newline {
    if ($_) {
        $_
    }
    [string]::Empty
}
