$acc = 0
$instructions = [IO.File]::ReadAllLines('.\2020\day8\input.txt')
$jumps = New-Object Collections.Generic.List[Int]
for ($i = 0; $i -lt $instructions.Count; $i++) {
    $instr,$value = $instructions[$i].split(" ")
    if($instr -eq "acc"){
        if($value[0] -eq "+"){
            $acc += [int]$value.substring(1)
        }else{
            $acc -= [int]$value.substring(1)
        }
    }
    if($instr -eq "jmp"){
        if($jumps.contains($i)){
            break
        }
        $jumps.add($i)
        if($value[0] -eq "+"){
            $i += [int]$value.substring(1) -1
        }else{
            $i -= [int]$value.substring(1) +1
        }
    }
}

Write-Host "Acc is: $acc"