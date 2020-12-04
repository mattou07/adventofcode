#cid is not required
$required = "ecl","pid","eyr","hcl","byr","iyr","hgt"
$valid = 0
$input = Get-Content '.\2020\day4\passports.txt' | Out-String
$nl = [System.Environment]::NewLine
# Split our input by new line. Each passport now has its own position array
$passports = ($input -split "$nl$nl")
foreach($line in $passports){
    <#
    First split data where there is a space then split where there is a new line.
    We use the Where not equal to "" to remove any empty string elements
    For each element split by the : and pick the left side of the split
    This formats our data so only the labels remain. We do not need the data for this puzzle. 
    #>
    $passport = $line.Split(" ").Split("$nl").Where({"" -ne $_}) | foreach {
        Write-Output $_.split(":")[0]
    }
    <# 
    Use compare object to compare our passport array against the required lables. Returns the differences.
    Should be empty or contain cid to be valid
    #>
    $c = Compare-Object -ReferenceObject $passport -DifferenceObject $required -PassThru
    <#
    Ensure that $c either contains nothing or just cid
    #>
    if($c.Count -ge 1){
        if($c.Count -eq 1 -and $c.Contains("cid")){
            $valid++
        }
    }else {
        $valid++
    }
}
Write-Host "$valid"