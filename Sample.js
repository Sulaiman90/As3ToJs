function MainFillSimple() {
		 var mainAct;
		 var finalAns=[];
		 var solution=[];
		 var wrng=0;
		 var obj;
		 var wrongOut=0;
		 var pointer=1;
		 var totalQuest=0;
		 var intx;
		 var inty;
		 var allDone=false;

		 this.MainFillSimple = function(mv,ans,sol) {
			trace("innn23");
			mainAct=mv;
			finalAns=ans;
			solution=sol;
			totalQuest=finalAns.length;
			(mainAct.parent).complete = 0;
			trace(mv.name);
			for (var i=1; i<=totalQuest; i++) {
				trace("innn " + mainAct["q"+i]);
				mainAct["q"+i].visible=false;
				var txt=mainAct["q"+i].txt;
				setTextFormat(txt,finalAns[i-1]);
				txt.addEventListener("change", checkBeforeAdding);
				txt.addEventListener("focusin",onSetFocusFn);
				txt.addEventListener("focusout",onKillFocusFn);
				mainAct["q"+i].tick.gotoAndStopFrame(3);
				mainAct["q"+i].tick.gotoAndStop("none");
				mainAct["q"+i].attempCnt=0;
				mainAct["q"+i].chkAlpha=1;
				mainAct["q"+i].solutionVisible=false;
				mainAct["q"+i].chkEnable=true;
			}
			trace("innn2");
			mainAct.next_btn.mouseChildren=false;
			mainAct.next_btn.cursor="pointer";
			mainAct.prev_btn.mouseChildren=false;
			mainAct.prev_btn.cursor="pointer";
			mainAct.check_btn.mouseChildren=false;
			mainAct.check_btn.cursor="pointer";
			mainAct.solution_btn.mouseChildren=false;
			mainAct.solution_btn.cursor="pointer";
			trace("innn3");
			//
			mainAct.next_btn.addEventListener("click",nextFn);
			mainAct.prev_btn.addEventListener("click",prevFn);
			mainAct.q1.visible=true;
			mainAct.solution_mc.visible=false;
			mainAct.solution_btn.visible=false;
			mainAct.check_btn.addEventListener("click",checkFn);
			mainAct.solution_btn.addEventListener("click",solutionFn);
			mainAct.solution_mc.drager.addEventListener("mousedown",solutionDragFn);
			mainAct.solution_mc.close_btn.addEventListener("click",closeSolutionFn);
			//
			//mainAct.solution_mc.solloader.mc.scrollDrag=true;
			//
			mainAct.next_btn.alpha=1;
			mainAct.prev_btn.alpha=.5;
			mainAct.next_btn.mouseEnabled=true;
			mainAct.prev_btn.mouseEnabled=false;
			//
			mainAct.solution_mc.px=mainAct.solution_mc.x;
			mainAct.solution_mc.py=mainAct.solution_mc.y;
			intx=mainAct.solution_mc.getRect(mainAct.parent).x;
			inty=mainAct.solution_mc.getRect(mainAct.parent).y;
			intx=mainAct.solution_mc.x-intx;
			inty=mainAct.solution_mc.y-inty;
			trace("intx "+ intx +  " inty"+ inty);
			(mainAct.parent).result_mc.gotoAndStopFrame(5)
		}
		
		function checkBeforeAdding(evt) {
			if(evt.text == "." && evt.target.text.indexOf(".") != -1) {
				evt.preventDefault();
			} else {
				// continue as usual
			}
		}
		
		 function stageRemovedFn(e) {
			try{
				//mainAct.solution_mc.solloader.mc.scrollDrag=false;
			}catch(e){
			}
		}
		 function closeSolutionFn(evt) {
			mainAct.solution_mc.visible=false;
			mainAct.solution_btn.mouseEnabled = true;
			//mainAct.solution_btn.mouseEnabled = true;
		}
		 function solutionDragFn(evt) {
			var mov=(evt.currentTarget.parent);
			var rect=new Rectangle(intx,inty,800-mov.width,430-mov.height);
			mainAct.solution_mc.drager.stage.addEventListener("pressup",solutionDropFn);
			mov.startDrag(false,rect);
		}
		 function solutionDropFn(evt) {
			var mov=mainAct.solution_mc;
			mov.stopDrag();
			//mainAct.solution_mc.solloader.mc.scrollDrag=false;
			mainAct.solution_mc.drager.stage.removeEventListener("pressup",solutionDropFn);
		}
		 function hideQuestionFn() {
			for (var i=1; i<=totalQuest; i++) {
				mainAct["q"+i].visible=false;
			}
		}
		 function nextFn(evt) {						
			if (pointer<totalQuest) {
				hideQuestionFn();
				pointer++;
				mainAct["q"+pointer].visible=true;
				mainAct._txt.text=pointer+" / "+totalQuest;
				setActivityPropsFn(mainAct["q"+pointer]);
				mainAct.solution_mc.solloader.mc.source=dummy;
			}
			(mainAct["q"+pointer].parent.parent.parent).pnter=pointer
			if((mainAct["q"+pointer].parent.parent.parent).introPlaying==true){
				if(!allDone){
stopSound();
stopFbSound();
stopSnapSound();
				}
				if(mainAct.check_btn.alpha==1){
playSoundArray([/*"q"+pointer,*/"Q"+pointer+"_"+(mainAct["q"+pointer].parent.parent.parent).thisNum]);
				}
			}
			mainAct.prev_btn.alpha=1;
			mainAct.prev_btn.mouseEnabled=true;
			mainAct.solution_btn.mouseEnabled = true
			if (pointer==totalQuest) {
				mainAct.next_btn.alpha=.5;
				mainAct.next_btn.mouseEnabled=false;
			}
		}
		 function prevFn(evt) {			
			if (pointer>1) {
				hideQuestionFn();
				pointer--;
				mainAct["q"+pointer].visible=true;
				mainAct._txt.text=pointer+" / "+totalQuest;
				setActivityPropsFn(mainAct["q"+pointer]);
				mainAct.solution_mc.solloader.mc.source=dummy;
			}
			(mainAct["q"+pointer].parent.parent.parent).pnter=pointer;
			if((mainAct["q"+pointer].parent.parent.parent).introPlaying==true){
				if(!allDone){
stopSound();
stopFbSound();
stopSnapSound();
				}
				if(mainAct.check_btn.alpha==1){
playSoundArray([/*"q"+pointer,*/"Q"+pointer+"_"+(mainAct["q"+pointer].parent.parent.parent).thisNum]);
				}
			}
			mainAct.next_btn.alpha=1;
			mainAct.next_btn.mouseEnabled=true;
			mainAct.solution_btn.mouseEnabled = true
			if (pointer==1) {
				mainAct.prev_btn.alpha=.5;
				mainAct.prev_btn.mouseEnabled=false;
			}
		}
		 function setActivityPropsFn(mov) {
			mainAct.check_btn.alpha=mov.chkAlpha;
			mainAct.check_btn.mouseEnabled=mov.chkEnable;
			mainAct.solution_btn.visible=mov.solutionVisible;
			mainAct.solution_mc.visible=false;
		}
		 function setTextFormat(txt,ansTxt) {
			var txtChk = String(ansTxt).split("&&")
			var len
			if(txtChk.length > 1)
			{
				if(String(txtChk[0]).length>String(txtChk[1]).length)
				{
					len = String(txtChk[0]).length 
				}else
				{
					len = String(txtChk[1]).length 
				}
				
			}else
			{
			len=String(ansTxt).length+1;
			}
			//trace(len)
			var tf= new TextFormat();
			tf.font="Arial";
			tf.size=15;
			tf.align="center";
			tf.bold="true";
			if (! isNaN(ansTxt)) {
				txt.restrict="0-9\\.\\";
			} else {
				txt.restrict="0-9 a-z A-Z\\.()/+\\-\\";
			}
			txt.setStyle("textFormat", tf);
			txt.text="?";
			txt.maxChars=2;
			if (len>2) {
				txt.maxChars=len;
			}
		}
		 function removeWhiteSpace(originalstring) {
			var original=originalstring.split(" ");
			return (original.join(""));
		}
		 function checkFn(evt) {
			var mov=mainAct["q"+pointer];
			var txt=mov.txt;
			var pls=mov.plstxt;
			mov.tick.visible=false;
			
			var tempTxt = String(finalAns[pointer-1]).split("&&")
			var resultChk
			if(tempTxt.length > 1)
			{
				if(tempTxt.length==4){
					resultChk = (removeWhiteSpace(txt.text).toLowerCase()==removeWhiteSpace(tempTxt[0]).toLowerCase() || removeWhiteSpace(txt.text).toLowerCase()==removeWhiteSpace(tempTxt[1]).toLowerCase() || removeWhiteSpace(txt.text).toLowerCase()==removeWhiteSpace(tempTxt[2]).toLowerCase() || removeWhiteSpace(txt.text).toLowerCase()==removeWhiteSpace(tempTxt[3]).toLowerCase() )
				}else if(tempTxt.length==3){
					resultChk = (removeWhiteSpace(txt.text).toLowerCase()==removeWhiteSpace(tempTxt[0]).toLowerCase() || removeWhiteSpace(txt.text).toLowerCase()==removeWhiteSpace(tempTxt[1]).toLowerCase() || removeWhiteSpace(txt.text).toLowerCase()==removeWhiteSpace(tempTxt[2]).toLowerCase() )
				}else{
					resultChk = (removeWhiteSpace(txt.text).toLowerCase()==removeWhiteSpace(tempTxt[0]).toLowerCase() || removeWhiteSpace(txt.text).toLowerCase()==removeWhiteSpace(tempTxt[1]).toLowerCase()  )
				}
			}else
			{				
				resultChk = (removeWhiteSpace(txt.text).toLowerCase()==String(finalAns[pointer-1]).toLowerCase())
			}
			//trace(txt.text," == ",finalAns[pointer-1])
			//trace(resultChk)
			mov.plstxt.text="";
			(mainAct["q"+pointer].parent.parent.parent).introPlaying=true;
			if(!allDone){
stopFbSound();
stopSound();
stopSnapSound();
			}
			(mainAct.parent.parent.parent).introPlaying=true;
			if (resultChk) {	
				if(tempTxt.length>1){
					if(String(txt.text).toLowerCase()=="raffles"){
						txt.text="Raffles";
					}
					else if(String(txt.text).toLowerCase()=="raffles place"){
						txt.text="Raffles Place";
					}else if(txt.text==tempTxt[0]){
						txt.text=tempTxt[0];
					}else if(txt.text==tempTxt[1]){
						txt.text=tempTxt[1];
					}else if(txt.text==tempTxt[2]){
						txt.text=tempTxt[2];
					}else if(txt.text==".83" || txt.text==".77"){
						txt.text=Number(txt.text);
					}
		//(mov.parent.parent.parent).txt.text=" txt.text "+Number(txt.text);	
				}else{
					txt.text=tempTxt;
				}
				/*if(String(txt.text).toLowerCase()=="raffles"){
					txt.text="Raffles";
				}
				else if(String(txt.text).toLowerCase()=="raffles place"){
					txt.text="Raffles Place";
				}else{
		//txt.text=tempTxt;
				}*/								
				mov.tick.visible=true;
				mov.tick.gotoAndStopFrame(1);
				mov.mouseChildren=false;
				mov.chkAlpha=mainAct.check_btn.alpha;
				mov.solutionVisible=mainAct.solution_btn.visible;
				mainAct.check_btn.alpha=.5;
				mainAct.check_btn.mouseEnabled=false;
				mov.chkAlpha=mainAct.check_btn.alpha;
				mov.chkEnable=mainAct.check_btn.mouseEnabled;
				(mainAct.parent).count+=2
				(mainAct.parent.parent).image_mc.visible=true;
				trace((mainAct.parent).count + " ----CNT ");
				(mainAct.parent.parent).image_mc.inn.gotoAndStopFrame((mainAct.parent).count);
				(mainAct.parent).complete++
playFbSound("ting");
				finalDisplay();
			} else {
				if (removeWhiteSpace(txt.text)!=""&&removeWhiteSpace(txt.text)!="?") {
					mov.attempCnt++;
					mov.tick.visible=true;
playFbSound("wrong");
					mov.tick.gotoAndStopFrame(2);
					if (mov.attempCnt==2) {
						mov.mouseChildren=false;
						mainAct.check_btn.alpha=.5;
						mainAct.check_btn.mouseEnabled=false;
						mainAct.solution_btn.visible=true;
						mov.chkAlpha=mainAct.check_btn.alpha;
						mov.chkEnable=mainAct.check_btn.mouseEnabled;
						mov.solutionVisible=mainAct.solution_btn.visible;	
						(mainAct.parent).complete++
						finalDisplay();						
					}
				}else{
playFbSound("pleaseAnswer");
					mov.plstxt.text="Please Answer.";
					//(mov.parent.parent.parent).txt.text="please Answer";
				}
			}
			mainAct.stage.focus=(mainAct.parent).dummy_txt;			
		}
		 function solutionFn(evt) {
stopFbSound();
stopSound();
stopSnapSound();
			mainAct.solution_btn.mouseEnabled = false
			mainAct.solution_mc.visible=true;
			mainAct.solution_mc.solloader.mc.source=solution[pointer-1];
			mainAct.solution_mc.x=mainAct.solution_mc.px;
			mainAct.solution_mc.y=mainAct.solution_mc.py;
			//(mainAct.parent).complete++
			finalDisplay()
		}
		 function finalDisplay()
		{			
			var complete = (mainAct.parent).complete
			trace(complete + "Check Complete")
			var cnt = (mainAct.parent).count/2
			if(complete>=5)
			{
stopFbSound();
stopSound();
				//trace(cnt +" CHeck CNT")
				allDone=true;
				(mainAct.parent).result_mc.visible = true
				if(cnt == 0)
				{				
					if((mainAct.parent.parent).done==false){
						(mainAct.parent.parent).done=true;
playSoundArray(["empty","fb1"]);
					}
					(mainAct.parent).result_mc.gotoAndStopFrame(1)
				}else if(cnt <= 2)
				{					
					if((mainAct.parent.parent).done==false){
						(mainAct.parent.parent).done=true;
playSoundArray(["empty","fb2"]);
					}
					(mainAct.parent).result_mc.gotoAndStopFrame(2)
				}else if(cnt <=4)
				{					
					if((mainAct.parent.parent).done==false){
						(mainAct.parent.parent).done=true;
playSoundArray(["empty","fb3"]);
					}
					(mainAct.parent).result_mc.gotoAndStopFrame(3)
				}else
				{					
					if((mainAct.parent.parent).done==false){
						(mainAct.parent.parent).done=true;
playSoundArray(["empty","fb4"]);
					}
					(mainAct.parent).result_mc.gotoAndStopFrame(4)
				}
			}
		}
		 function onSetFocusFn(evt) {
			var txtMov=evt.currentTarget;
			(mainAct["q"+pointer]).plstxt.text="";
stopSnapSound();
stopFbSound();
			if (txtMov.text=="?" || txtMov.text !="") {
				txtMov.text="";
			}
			(txtMov.parent).tick.gotoAndStopFrame(3);
		}
		 function onKillFocusFn(evt) {
			var txtMov=evt.target;
			if (txtMov.text=="") {
				txtMov.text="?";
			}
			//(txtMov.parent).tick.gotoAndStopFrame(3);
		}
	}




