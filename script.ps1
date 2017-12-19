$source = "sample.as"
$dest = "modifiedScript.js"

(Get-Content $source) | ForEach-Object {
		 $_ -creplace "private" , "" `
		 	-creplace "public" , "" `
		 	-replace ":Array = new Array" , "=[]" `
		 	-creplace ":MovieClip" , "" `
		 	-creplace "MovieClip" , "" `
			-replace ":.*?(=)", '='	`
			-creplace ":Boolean" , "" `
			-creplace ":void" , "" `
			-creplace ":Number" , "" `
			-creplace ":String" , "" `
			-creplace ":Array" , "" `
		 	-creplace "FocusEvent.FOCUS_IN" , '"focusin"' `
		 	-creplace "FocusEvent.FOCUS_OUT" , '"focusout"' `
		 	-creplace 'gotoAndStop', 'gotoAndStopFrame' `
		 	-creplace "gotoAndPlay" , "gotoAndPlayFrame" `
		 	-creplace "MouseEvent.CLICK" , '"click"' `
			-creplace "MouseEvent.MOUSE_DOWN" , '"mousedown"' `
			-creplace "MouseEvent.MOUSE_UP" , '"pressup"' `
			-creplace ":Event" , "" `
			-creplace ":MouseEvent" , ""  `
			-creplace ":TextEvent" , ""  `
			-replace '.*stopSound', "stopSound" `
		 	-creplace '.*stopFbSound', "stopFbSound" `
		 	-creplace '.*stopSnapSound', "stopSnapSound" `
		 	-creplace '.*playSound', "playSound" `
		 	-creplace '.*playFbSound', "playFbSound" `
		 	-creplace '.*playSnapSound', 'playSnapSound' `
		 	-creplace "enabled" , "mouseEnabled" `
		 	-creplace "currentFrameLabel" , "currentLabel" `
		 	-replace "buttonMode=true", 'cursor="pointer"' `
		 	-replace "buttonMode=false", 'cursor="null"' `
		 	-replace "extends", "" `
		 	-replace '.*import(.+)', '' `
		 	-replace '.*package(.+)', '' 
		} | Set-Content $dest

$raw = Get-Content -Path $dest | Out-String
[void]($raw -match "(?m)^(\s+)class")
$leadingSpacesToRemove = $Matches[1].Length
$raw -replace "(?sm).*?class (\w+)(.*)}",'function $1()$2' -replace "(?m)^\s{$leadingSpacesToRemove}" | Set-Content $dest

(Get-Content $dest) -creplace 'gotoAndStopFrame\("', 'gotoAndStop("' | Set-Content $dest
