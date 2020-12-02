$value = 2020

[string[]]$reportList = Get-Content -Path 'report.txt'

foreach($report in $reportList){
    $guess = $value - $report
    if($reportList.Contains($guess.ToString())){
        Write-Host "Found number: "+ $guess + " and " + $report
        Write-Host "Final Answer is " +($guess*$report)
        exit
    }
}