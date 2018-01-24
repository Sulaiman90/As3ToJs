package Heymath{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.geom.Rectangle;
	public class MainFillSimple extends MovieClip
	{
		private var mainAct:MovieClip;
		private var finalAns:Array = new Array();
		private var solution:Array = new Array();
		private var wrng=0;
		private var obj;
		private var wrongOut=0;
		private var pointer=1;
		private var totalQuest=0;
		private var intx;
		private var inty;
		private var allDone:Boolean=false;

		public function MainFillSimple(mv,ans,sol) {
			trace("innn23");
			mainAct=mv;
			finalAns=ans;
			solution=sol;
			totalQuest=finalAns.length;
			MovieClip(mainAct.parent).complete = 0;
			trace(mv.name);
			for (var i=1; i<=totalQuest; i++) {
				trace("innn " + mainAct["q"+i]);
				mainAct["q"+i].visible=false;
				var txt=mainAct["q"+i].txt;
				setTextFormat(txt,finalAns[i-1]);
				txt.addEventListener(TextEvent.TEXT_INPUT, checkBeforeAdding);
				txt.addEventListener(FocusEvent.FOCUS_IN,onSetFocusFn);
				txt.addEventListener(FocusEvent.FOCUS_OUT,onKillFocusFn);
				mainAct["q"+i].tick.gotoAndStop(3);
				mainAct["q"+i].tick.gotoAndStop("none");
				mainAct["q"+i].attempCnt=0;
				mainAct["q"+i].chkAlpha=1;
				mainAct["q"+i].solutionVisible=false;
				mainAct["q"+i].chkEnable=true;
			}
			trace("innn2");
			mainAct.next_btn.mouseChildren=false;
			mainAct.next_btn.buttonMode=true;
			mainAct.prev_btn.mouseChildren=false;
			mainAct.prev_btn.buttonMode=true;
			mainAct.check_btn.mouseChildren=false;
			mainAct.check_btn.buttonMode=true;
			mainAct.solution_btn.mouseChildren=false;
			mainAct.solution_btn.buttonMode=true;
			trace("innn3");
			//
			mainAct.next_btn.addEventListener(MouseEvent.CLICK,nextFn);
			mainAct.prev_btn.addEventListener(MouseEvent.CLICK,prevFn);
			mainAct.q1.visible=true;
			mainAct.solution_mc.visible=false;
			mainAct.solution_btn.visible=false;
			mainAct.check_btn.addEventListener(MouseEvent.CLICK,checkFn);
			mainAct.solution_btn.addEventListener(MouseEvent.CLICK,solutionFn);
			mainAct.solution_mc.drager.addEventListener(MouseEvent.MOUSE_DOWN,solutionDragFn);
			mainAct.solution_mc.close_btn.addEventListener(MouseEvent.CLICK,closeSolutionFn);
			//
			//mainAct.solution_mc.solloader.mc.scrollDrag=true;
			mainAct.solution_mc.solloader.mc.addEventListener(Event.REMOVED_FROM_STAGE, stageRemovedFn);
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
			MovieClip(mainAct.parent).result_mc.gotoAndStop(5)
		}
		
		function checkBeforeAdding(evt:TextEvent) {
			if(evt.text == "." && evt.target.text.indexOf(".") != -1) {
				evt.preventDefault();
			} else {
				// continue as usual
			}
		}
		
		private function stageRemovedFn(e:Event) {
			try{
				//mainAct.solution_mc.solloader.mc.scrollDrag=false;
			}catch(e:Error){
			}
		}
		private function closeSolutionFn(evt:Event) {
			mainAct.solution_mc.visible=false;
			mainAct.solution_btn.mouseEnabled = true;
			//mainAct.solution_btn.mouseEnabled = true;
		}
		private function solutionDragFn(evt:Event) {
			var mov=MovieClip(evt.currentTarget.parent);
			var rect:Rectangle=new Rectangle(intx,inty,800-mov.width,430-mov.height);
			mainAct.solution_mc.drager.stage.addEventListener(MouseEvent.MOUSE_UP,solutionDropFn);
			mov.startDrag(false,rect);
		}
		private function solutionDropFn(evt:Event) {
			var mov=mainAct.solution_mc;
			mov.stopDrag();
			//mainAct.solution_mc.solloader.mc.scrollDrag=false;
			mainAct.solution_mc.drager.stage.removeEventListener(MouseEvent.MOUSE_UP,solutionDropFn);
		}
		private function hideQuestionFn() {
			for (var i=1; i<=totalQuest; i++) {
				mainAct["q"+i].visible=false;
			}
		}
		private function nextFn(evt:Event) {						
			if (pointer<totalQuest) {
				hideQuestionFn();
				pointer++;
				mainAct["q"+pointer].visible=true;
				mainAct._txt.text=pointer+" / "+totalQuest;
				setActivityPropsFn(mainAct["q"+pointer]);
				mainAct.solution_mc.solloader.mc.source=dummy;
			}
			MovieClip(mainAct["q"+pointer].parent.parent.parent).pnter=pointer
			if(MovieClip(mainAct["q"+pointer].parent.parent.parent).introPlaying==true){
				if(!allDone){
					MovieClip(mainAct["q"+pointer].parent.parent.parent).stopSound();
					MovieClip(mainAct["q"+pointer].parent.parent.parent).stopFbSound();
					MovieClip(mainAct["q"+pointer].parent.parent.parent).stopSnapSound();
				}
				if(mainAct.check_btn.alpha==1){
					MovieClip(mainAct["q"+pointer].parent.parent.parent).playSoundArray([/*"q"+pointer,*/"Q"+pointer+"_"+MovieClip(mainAct["q"+pointer].parent.parent.parent).thisNum]);
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
		private function prevFn(evt:Event) {			
			if (pointer>1) {
				hideQuestionFn();
				pointer--;
				mainAct["q"+pointer].visible=true;
				mainAct._txt.text=pointer+" / "+totalQuest;
				setActivityPropsFn(mainAct["q"+pointer]);
				mainAct.solution_mc.solloader.mc.source=dummy;
			}
			MovieClip(mainAct["q"+pointer].parent.parent.parent).pnter=pointer;
			if(MovieClip(mainAct["q"+pointer].parent.parent.parent).introPlaying==true){
				if(!allDone){
					MovieClip(mainAct["q"+pointer].parent.parent.parent).stopSound();
					MovieClip(mainAct["q"+pointer].parent.parent.parent).stopFbSound();
					MovieClip(mainAct["q"+pointer].parent.parent.parent).stopSnapSound();
				}
				if(mainAct.check_btn.alpha==1){
					MovieClip(mainAct["q"+pointer].parent.parent.parent).playSoundArray([/*"q"+pointer,*/"Q"+pointer+"_"+MovieClip(mainAct["q"+pointer].parent.parent.parent).thisNum]);
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
		private function setActivityPropsFn(mov) {
			mainAct.check_btn.alpha=mov.chkAlpha;
			mainAct.check_btn.mouseEnabled=mov.chkEnable;
			mainAct.solution_btn.visible=mov.solutionVisible;
			mainAct.solution_mc.visible=false;
		}
		private function setTextFormat(txt,ansTxt) {
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
			var tf:TextFormat = new TextFormat();
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
		private function removeWhiteSpace(originalstring:String) {
			var original:Array=originalstring.split(" ");
			return (original.join(""));
		}
		private function checkFn(evt:Event) {
			var mov=mainAct["q"+pointer];
			var txt=mov.txt;
			var pls=mov.plstxt;
			mov.tick.visible=false;
			
			var tempTxt = String(finalAns[pointer-1]).split("&&")
			var resultChk:Boolean
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
			MovieClip(mainAct["q"+pointer].parent.parent.parent).introPlaying=true;
			if(!allDone){
				MovieClip(mov.parent.parent.parent).stopFbSound();
				MovieClip(mov.parent.parent.parent).stopSound();
				MovieClip(mainAct["q"+pointer].parent.parent.parent).stopSnapSound();
			}
			MovieClip(mainAct.parent.parent.parent).introPlaying=true;
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
					
					//MovieClip(mov.parent.parent.parent).txt.text=" txt.text "+Number(txt.text);	
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
				mov.tick.gotoAndStop(1);
				mov.mouseChildren=false;
				mov.chkAlpha=mainAct.check_btn.alpha;
				mov.solutionVisible=mainAct.solution_btn.visible;
				mainAct.check_btn.alpha=.5;
				mainAct.check_btn.mouseEnabled=false;
				mov.chkAlpha=mainAct.check_btn.alpha;
				mov.chkEnable=mainAct.check_btn.mouseEnabled;
				MovieClip(mainAct.parent).count+=2
				MovieClip(mainAct.parent.parent).image_mc.visible=true;
				trace(MovieClip(mainAct.parent).count + " ----CNT ");
				MovieClip(mainAct.parent.parent).image_mc.inn.gotoAndStop(MovieClip(mainAct.parent).count);
				MovieClip(mainAct.parent).complete++
				MovieClip(mov.parent.parent.parent).playFbSound("ting");
				finalDisplay();
			} else {
				if (removeWhiteSpace(txt.text)!=""&&removeWhiteSpace(txt.text)!="?") {
					mov.attempCnt++;
					mov.tick.visible=true;
					MovieClip(mov.parent.parent.parent).playFbSound("wrong");
					mov.tick.gotoAndStop(2);
					if (mov.attempCnt==2) {
						mov.mouseChildren=false;
						mainAct.check_btn.alpha=.5;
						mainAct.check_btn.mouseEnabled=false;
						mainAct.solution_btn.visible=true;
						mov.chkAlpha=mainAct.check_btn.alpha;
						mov.chkEnable=mainAct.check_btn.mouseEnabled;
						mov.solutionVisible=mainAct.solution_btn.visible;	
						MovieClip(mainAct.parent).complete++
						finalDisplay();						
					}
				}else{
					MovieClip(mov.parent.parent.parent).playFbSound("pleaseAnswer");
					mov.plstxt.text="Please Answer.";
					//MovieClip(mov.parent.parent.parent).txt.text="please Answer";
				}
			}
			mainAct.stage.focus=MovieClip(mainAct.parent).dummy_txt;			
		}
		private function solutionFn(evt:Event) {
			MovieClip(mainAct["q"+pointer].parent.parent.parent).stopFbSound();
			MovieClip(mainAct["q"+pointer].parent.parent.parent).stopSound();
			//MovieClip(mainAct["q"+pointer].parent.parent.parent).stopSnapSound();
			mainAct.solution_btn.mouseEnabled = false
			mainAct.solution_mc.visible=true;
			mainAct.solution_mc.solloader.mc.source=solution[pointer-1];
			mainAct.solution_mc.x=mainAct.solution_mc.px;
			mainAct.solution_mc.y=mainAct.solution_mc.py;
			//MovieClip(mainAct.parent).complete++
			finalDisplay()
		}
		public function finalDisplay()
		{			
			var complete = MovieClip(mainAct.parent).complete
			trace(complete + "Check Complete")
			var cnt = MovieClip(mainAct.parent).count/2
			if(complete>=5)
			{
				//MovieClip(mainAct["q"+pointer].parent.parent.parent).stopFbSound();
				//MovieClip(mainAct["q"+pointer].parent.parent.parent).stopSound();
				//trace(cnt +" CHeck CNT")
				allDone=true;
				MovieClip(mainAct.parent).result_mc.visible = true
				if(cnt == 0)
				{				
					if(MovieClip(mainAct.parent.parent).done==false){
						MovieClip(mainAct.parent.parent).done=true;
						MovieClip(mainAct.parent.parent).playSoundArray(["empty","fb1"]);
					}
					MovieClip(mainAct.parent).result_mc.gotoAndStop(1)
				}else if(cnt <= 2)
				{					
					if(MovieClip(mainAct.parent.parent).done==false){
						MovieClip(mainAct.parent.parent).done=true;
						MovieClip(mainAct.parent.parent).playSoundArray(["empty","fb2"]);
					}
					MovieClip(mainAct.parent).result_mc.gotoAndStop(2)
				}else if(cnt <=4)
				{					
					if(MovieClip(mainAct.parent.parent).done==false){
						MovieClip(mainAct.parent.parent).done=true;
						MovieClip(mainAct.parent.parent).playSoundArray(["empty","fb3"]);
					}
					MovieClip(mainAct.parent).result_mc.gotoAndStop(3)
				}else
				{					
					if(MovieClip(mainAct.parent.parent).done==false){
						MovieClip(mainAct.parent.parent).done=true;
						MovieClip(mainAct.parent.parent).playSoundArray(["empty","fb4"]);
					}
					MovieClip(mainAct.parent).result_mc.gotoAndStop(4)
				}
			}
		}
		public function onSetFocusFn(evt:Event) {
			var txtMov=evt.currentTarget;
			MovieClip(mainAct["q"+pointer]).plstxt.text="";
			MovieClip(mainAct["q"+pointer].parent.parent.parent).stopSnapSound();
			MovieClip(mainAct["q"+pointer].parent.parent.parent).stopFbSound();
			if (txtMov.text=="?" || txtMov.text !="") {
				txtMov.text="";
			}
			MovieClip(txtMov.parent).tick.gotoAndStop(3);
		}
		public function onKillFocusFn(evt:Event) {
			var txtMov=evt.target;
			if (txtMov.text=="") {
				txtMov.text="?";
			}
			//MovieClip(txtMov.parent).tick.gotoAndStop(3);
		}
	}
}