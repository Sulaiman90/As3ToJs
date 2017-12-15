(Get-Content sample.as) | ForEach-Object {
		 $_ -creplace "private" , "" `
		 	-creplace "public" , "" `
		 	-replace ":Array = new Array" , "=[]" `
		 	-creplace ":MovieClip" , "" `
			-replace ":.*?(=)", '='	`
			-replace ":.*?(void)", ''	`
			-creplace ":Boolean" , "" `
			-creplace ":Number" , "" `
			-creplace ":String" , "" `
		 	-creplace "FocusEvent.FOCUS_IN" , '"focusin"' `
		 	-creplace "FocusEvent.FOCUS_OUT" , '"focusout"' `
		 	-creplace "gotoAndStop" , "gotoAndStopFrame" `
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
		 	-replace "buttonMode=true", 'cursor="pointer"' `
		 	-replace "buttonMode=false", 'cursor="null"' `
		 	-replace '.*import(.+)', '' `
		 	-replace '.*package(.+)', '' 
		} | Set-Content modifiedScript.js

$dest = "modifiedScript.js"
$replaceCharacter = ''
$content = Get-Content $dest
$content[-1] = $content[-1] -replace '^(.*).$', "`$1$replaceCharacter"
$content | Set-Content $dest


