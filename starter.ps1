$webUrl = "http://169.254.169.254/latest/user-data"

$webResult = ''
$wc = New-Object system.Net.WebClient;
$webResult = $wc.downloadString($webUrl)
if ($webResult -notlike '*=*'){
    Write-Host "Error: Result from webservice came back empty" -ForegroundColor Red
    exit;
}

#Looping through results of webservice
$lines = $webResult.Split("`n")
$lines | Foreach-Object{
   $var = $_.Split('=')
   [Environment]::SetEnvironmentVariable($var[0],$var[1], "Process")
}