# Passwords begin with a space using this to get around the index starting at 1
[string[]]$passwordList = Get-Content -Path 'passwords.txt'
$occurences = 0
foreach($entry in $passwordList){
    $flag1 = $false
    $flag2 = $false
    
    $rule,$password = $entry.split(':')
    $min,$max = $rule.split('-')
    $max,$char = $max.split(' ')

    $password = $password.ToCharArray()

    if($password[$min] -eq [char]$char){
        $flag1 = $true
    }
    if($password[$max] -eq [char]$char){
        $flag2 = $true
    }

    $sum = [int]$flag1+[int]$flag2
    if($sum -eq 1){
        $occurences++
    }
}
Write-Host $occurences