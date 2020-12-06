$nl = [System.Environment]::NewLine
$answers = ((Get-Content '.\2020\day6\input.txt' | Out-String) -split "$nl$nl")
$final = 0
foreach ($group in $answers){
    #Use hashset to store our data. Hashsets don't store duplicates   
    $allUniqueAnswers = New-Object System.Collections.Generic.HashSet[string]
    #Tidy up our data by removing new lines and empty array entries
    #We are still able to maintain peoples individual answers via $group
    $group = $group.Split(" ").Split("$nl").Where({"" -ne $_})
    $currentAnswers = $group.ToCharArray()
    foreach($answer in $currentAnswers){
        $t = $allUniqueAnswers.Add($answer)
    }

    $groupAnswers = New-Object Collections.Generic.List[System.Collections.Generic.HashSet[string]]

    foreach($answer in $group){
        $set = New-Object System.Collections.Generic.HashSet[string]
        #Answers for a single person in a group
        $person = $answer.ToCharArray()
        [array]::sort($person)
        foreach($a in $person){
            $t= $set.Add($a)
            
        }
        $groupAnswers.Add($set)
    }
    $matches = 0

    foreach($uniqueAnswer in $allUniqueAnswers){
        $match = $true
        foreach($groupAnswer in $groupAnswers){
            if(!($groupAnswer.contains($uniqueAnswer))){
                $match = $false
            }
        }
        if($match){
            $matches++
        }
    }
    $final += $matches
}

Write-Host "Final Answer: $final"