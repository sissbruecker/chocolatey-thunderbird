$installerVersion="16.0.1"
$installerLanguage="en-US"
$baseUrl = "https://download.mozilla.org/?product=thunderbird-{0}&os=win&lang={1}"

# Split optional installer arguments into hashtable
$argumentMap = ConvertFrom-StringData $installArguments

foreach($key in $argumentMap.keys){
    
	# Check for language parameter
	if("l", "lang", "language" -contains $key) {
		$installerLanguage = $argumentMap.item($key)
		Write-Host "Found language override: $installerLanguage" -BackgroundColor Blue -ForegroundColor White
	}
	
	# Check for version parameter
	if("v", "version" -contains $key) {
		$installerVersion = $argumentMap.item($key)
		Write-Host "Found version override: $installerVersion" -BackgroundColor Blue -ForegroundColor White
	}
}

$installerUrl = [string]::Format($baseUrl, $installerVersion, $installerLanguage)

Write-Host "Downloading from: $installerUrl" -BackgroundColor Blue -ForegroundColor White

Install-ChocolateyPackage 'thunderbird' 'exe' '/S' $installerUrl -validExitCodes @(0)
