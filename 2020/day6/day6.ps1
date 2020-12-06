$nl = [System.Environment]::NewLine
# Split our input by new line. Each passport now has its own position array
$answers = ((Get-Content '.\2020\day6\input.txt' | Out-String) -split "$nl$nl")
$final = 0
foreach ($group in $answers){
    #Use hashset to store our data. Hashsets don't store duplicates
    $set = New-Object System.Collections.Generic.HashSet[string]
    #Tidy up our data by removing new lines and empty array entries
    $group = $group.Split(" ").Split("$nl").Where({"" -ne $_})
    $group = $group.ToCharArray()
    foreach($answer in $group){
        $t = $set.Add($answer)
    }
    Write-Host $set.Count
    $final += $set.Count
}

Write-Host "Final Answer: $final"