$value = 2020
[string[]]$reportList = Get-Content -Path 'report.txt'

function findLastTwo(){
    param( [int]$limit, [int]$report )
    [string[]]$allowList = @()
    foreach ($x in $reportList){
        if([int]$x -lt $limit){
            $allowList += $x
        }
        
    }

    foreach($i in $allowList){
        $guess = $limit - $i
        if($allowList.Contains($guess.ToString())){
            Write-Host "Found number: "+ $guess + " and " + $i
            Write-Host "Last Number is "+ $report
            Write-Host "Final Answer: " +(([int]$report*[int]$guess)*[int]$i)
            exit
        }
    }
}

foreach($report in $reportList){
    $limit = $value - $report
    findLastTwo -limit $limit -report $report
}