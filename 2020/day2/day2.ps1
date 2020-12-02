[string[]]$passwordList = Get-Content -Path 'passwords.txt'
$occurences = 0
foreach($entry in $passwordList){
    $rule,$password = $entry.split(':')
    $min,$max = $rule.split('-')
    $max,$char = $max.split(' ')

    $charCount = ($password.ToCharArray() | Where-Object {$_ -eq $char} | Measure-Object).Count

    if(($charCount -ge $min) -and ($charCount -le $max)){
        $occurences++
    }

}

Write-Host $occurences