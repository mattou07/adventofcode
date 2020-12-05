function verifyData {
    param (
        $passport
    )
    if(!($passport["byr"] -In 1920..2002 -and $passport["iyr"] -In 2010..2020 -and $passport["eyr"] -In 2020..2030)){
        return $false
        #Write-Host "Not valid byr"
    }
    #if(!($passport["hgt"] -match "((1[5-8][0-9]|19[0-3])(cm))|((59|6[0-9]|7[0-6])(in))")){
        #return $false
        #Write-Host "Not valid hgt"
    #}
    #$hgt = [string]$passport["hgt"]
    if($passport["hgt"].endswith("cm")){
        $hgt = [string]$passport["hgt"] -replace ".{2}$"
        if(!($hgt -In 150..193)){
            return $false
        }
    }

    if($passport["hgt"].endswith("in")){
        $hgt = [string]$passport["hgt"] -replace ".{2}$"
        if(!($hgt -In 59..76)){
            return $false
        }
    }

    if(!($passport["hcl"] -match "#[0-9 | a-f]{6}")){
        return $false
        #Write-Host "Not valid hcl"
    }
    if(!($passport["ecl"] -match "^(amb|blu|brn|gry|grn|hzl|oth){1}$")){
        $test = $passport["pid"].ToString()
        #Write-Host "Not valid ecl for $test"
        return $false
        
    }
    if(!($passport["pid"] -match "[0-9]{9}")){
        return $false
        #Write-Host "Not valid pid"
    }
    return $true
}


#cid is not required
$required = "ecl","pid","eyr","hcl","byr","iyr","hgt"
$validPassports = 0
$data = Get-Content '.\2020\day4\passports.txt' | Out-String
#$data = Get-Content '.\2020\day4\smaller-input.txt' | Out-String
$nl = [System.Environment]::NewLine
# Split our input by new line. Each passport now has its own position array
$passports = ($data -split "$nl$nl")
foreach($line in $passports){
    #Write-Host "Start passport ....."
    $valid = $true
    <#
    First split data where there is a space then split where there is a new line.
    We use the Where not equal to "" to remove any empty string elements
    For each element split by the : and pick the left side of the split
    This formats our data so only the labels remain. We do not need the data for this puzzle. 
    #>
    $labels = $line.Split(" ").Split("$nl").Where({"" -ne $_}) | foreach {
        Write-Output $_.split(":")[0]
    }
    $passport = @{}

    $line.Split(" ").Split("$nl").Where({"" -ne $_}) | foreach {
        $passport += @{$_.split(":")[0] = $_.split(":")[1]}
    }
    <# 
    Use compare object to compare our passport array against the required lables. Returns the differences.
    Should be empty or contain cid to be valid
    #>
    $c = Compare-Object -ReferenceObject $labels -DifferenceObject $required -PassThru
    <#
    Ensure that $c either contains nothing or just cid
    #>
    if($c.Count -ge 1){
        if($c.Count -eq 1 -and $c.Contains("cid")){
            $valid = $true
        }
        else {
            $valid = $false
        }
    }
    else {
        $valid = $true
    }
    if($valid){
        $valid =  verifyData -passport $passport
    }
    if($valid){
        $validPassports++
    }
}
Write-Host "Valid passports are this: $validPassports subtract 2"