function spacePartition {
    param (
        $code,
        $lowerDivde,
        $higherDivide,
        $max
    )
    $min = 0
    foreach ($c in $code) {
        if($c -eq $lowerDivde){
            $max = (($min + $max)/2)
        } elseif ($c -eq $higherDivide) {
            $min = (($min + $max)/2)
        }
    }
    return $min
}
$seatList = New-Object Collections.Generic.List[Int]
$answer = 0
$seats = [IO.File]::ReadAllLines('.\2020\day5\seats.txt')

foreach($seat in $seats){
    $rowCode = $seat[0..6]
    $columnCode = $seat[7..9]
    $row = spacePartition -code $rowCode -lowerDivde "F" -higherDivide "B" -max 128
    $column = spacePartition -code $columnCode -lowerDivde "L" -higherDivide "R" -max 8
    $seatID = ($row*8)+$column
    if($seatID -gt $answer){
        $answer = $seatID
    }
    $seatList.Add($seatID)
}

for ($i = 0; $i -lt $answer; $i++) {
    $low = $i - 1
    $high = $i + 1
    if ($seatList.Contains($low) -and $seatList.Contains($high) -and !$seatList.Contains($i)){
        Write-Host "Your Seat is: $i"
    }

}
Write-Host "Highest Seat ID: $answer"