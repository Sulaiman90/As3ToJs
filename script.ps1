Function Convert($FullName){
	
	$FileNameWithExt = $FullName -split '\.'

	$FileName = $FileNameWithExt[0]

	$source = $FullName
	$dest = $FileName+".js"

	#Get content from file
	$file = Get-Content $source | Out-String

	#Regex pattern to get the class name
	$pattern = "(?s)class(.*?){"

	#Perform the operation
	$resultStr = [regex]::Match($file,$pattern).Groups[1].Value.trim()

	#echo "name: $resultStr" 

	#split the line and get class name
	$className = $resultStr -split ' '

	#assign the class name
	$result = $className[0]

	#echo "name: $result" 

	#Replace the class constructor
	$file -replace "function $result\(" , "this.$result = function(" | Set-Content $dest

	(Get-Content $dest | Out-String) | ForEach-Object {
			 $_ -creplace "private" , "" `
			 	-creplace "public" , "" `
			 	-creplace "static" , "" `
			 	-creplace ":MovieClip" , "" `
			 	-creplace "MovieClip" , "" `
				-creplace ":Boolean" , "" `
				-creplace ":uint" , "" `
				-creplace ":int" , "" `
				-creplace "int" , "" `
				-creplace ":Number" , "" `
				-creplace ":String" , "" `
				-creplace ":Array" , "" `
				-creplace ":void" , "" `
				-replace ":.*?(=)", '='	`
				-creplace ":DisplayObject" , "" `
			 	-creplace "FocusEvent.FOCUS_IN" , '"focusin"' `
			 	-creplace "FocusEvent.FOCUS_OUT" , '"focusout"' `
			 	-creplace "focusIn" , "focusin" `
			 	-creplace "focusOut" , "focusout" `
			 	-creplace "TextEvent.TEXT_INPUT" , '"change"' `
			 	-creplace 'gotoAndStop', 'gotoAndStopFrame' `
			 	-creplace "gotoAndPlay" , "gotoAndPlayFrame" `
			 	-creplace "MouseEvent.CLICK" , '"click"' `
				-creplace "MouseEvent.MOUSE_DOWN" , '"mousedown"' `
				-creplace "MouseEvent.MOUSE_OVER" , '"mouseover"' `
				-creplace "MouseEvent.MOUSE_UP" , '"pressup"' `
				-creplace "MouseEvent.MOUSE_OUT" , '"mouseout"' `
				-creplace "TimerEvent.TIMER" , '"timer"' `
				-creplace "TimerEvent.TIMER_COMPLETE" , '"complete"' `
				-creplace ":Error" , "" `
				-creplace ":Event" , "" `
				-creplace ":MouseEvent" , ""  `
				-creplace ":TextEvent" , ""  `
				-creplace ":FocusEvent" , ""  `
				-creplace ":TimerEvent" , ""  `
				-replace '.*stopSound', "stopSound" `
			 	-creplace '.*stopFbSound', "stopFbSound" `
			 	-creplace '.*stopSnapSound', "stopSnapSound" `
			 	-creplace '.*playSound', "playSound" `
			 	-creplace '.*playFbSound', "playFbSound" `
			 	-creplace '.*playSnapSound', 'playSound' `
			 	-creplace '.*playBgSound', 'playBgSound' `
			 	-creplace '.*stopBgSound', 'stopBgSound' `
			 	-creplace "enabled" , "mouseEnabled" `
			 	-creplace "currentFrameLabel" , "currentLabel" `
			 	-replace 'buttonMode.*?true' , 'cursor="pointer"' `
			 	-replace 'buttonMode.*?false' , 'cursor="null"' `
			 	-replace '.*import(.+)', '' `
				-replace '(?s)extends.*?{' , '{' `
				-creplace "=new TextFormat" , "" `
				-creplace ".*addEventListener\(Event.ENTER_FRAME", 'createjs.Ticker.addEventListener("tick"' `
				-creplace ".*removeEventListener\(Event.ENTER_FRAME", 'createjs.Ticker.removeEventListener("tick"' `
				-creplace ":GlowFilter" , "" 
			} | Set-Content $dest

	$file2 = Get-Content -Path $dest | Out-String

	#Get the class constructor parameters
	$pattern2 = "(?s)function\((.*?)\)"

	#Perform the operation
	$constArgs = [regex]::Match($file2,$pattern2).Groups[1].Value.trim()

	echo "params: $constArgs" 
		
	$raw = Get-Content -Path $dest | Out-String
	[void]($raw -match "(?m)^(\s+)class")
	$leadingSpacesToRemove = $Matches[1].Length
	$raw -replace "(?sm).*?class (\w+)(.*)}","function `$1($constArgs)`$2" -replace "(?m)^\s{$leadingSpacesToRemove}" |
	Set-Content $dest

	$rawNew = Get-Content -Path $dest | Out-String

	$rawNew -creplace 'gotoAndStopFrame\("', 'gotoAndStop("' | Set-Content $dest 

	$finalRaw = Get-Content -Path $dest | Out-String

	if($constArgs){
		$finalRaw -replace "(?s)function (\w+)(.*)}", "function `$1`$2 `n this.$result($constArgs); `n}" | 
		Set-Content $dest 
	}
}

# Determine script location for PowerShell
$ScriptDir = Split-Path $script:MyInvocation.MyCommand.Path
 
# Write-Host "Current script directory is $ScriptDir"

# PowerShell script to list the files 
$Dir = get-childitem $ScriptDir

$ASFiles = $Dir | where {$_.extension -eq ".as"}

echo "name: $ASFiles" 

Foreach ($file in $ASFiles){
	Convert ($file)
}