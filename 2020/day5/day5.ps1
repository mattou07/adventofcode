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
}
Write-Host "Highest Seat ID: $answer"