function AdditionWithoutCarryOver(mc) {
		var mainMov;
		var addend1=[];
		var addend2=[];
		var carry=[];
		var answerRow=[];
		var carryOver=1;
		var pageNumber=0;
		var digLength=5;
		var answer=0;
		var hintLen=0;
		var hintPosX=0;
		var textFormat1  ;
		var textFormat2  ;
		
		//
		 this.AdditionWithoutCarryOver = function(mc) {
			mainMov=mc;
			mainMov.next_btn.addEventListener("click",next_fn);
			mainMov.nextDummy_btn.addEventListener("click",setQuestion);
			mainMov.check_btn.addEventListener("click",check_fn);
			mainMov.answer_btn.addEventListener("click",showAnswer_fn);
			mainMov.hint_mc.hide_btn.addEventListener("click",hideHint_fn);
			mainMov.hint_mc.show_btn.addEventListener("click",showHint_fn);
			mainMov.activity.hint_mc.carry_mc.visible=false;
			mainMov.activity.hint_mc.done_btn.addEventListener("click",done_fn);
			mainMov.activity.hint_mc.next_btn.addEventListener("click",hintNext_fn);
			mainMov.hintPosX=mainMov.activity.hint_mc.x;
			textFormat1.color=0xCCCCCC;
			textFormat2.color=0x000000;
			for (var i=1; i<=digLength+1; i++) {
				mainMov.activity["a"+i].text="?";
				mainMov.activity["a"+i].maxChars=1;
				mainMov.activity["a"+i].restrict="0-9";
				mainMov.activity["a"+i].addEventListener("focusin",onSetFocus_fn);
				mainMov.activity["a"+i].addEventListener("focusout",onKillFocus_fn);
				mainMov.activity["a"+i].defaultTextFormat=textFormat1;
			}
			if (carryOver==1) {
				for (i=1; i<=digLength; i++) {
					mainMov.activity["c"+i].text="";
					mainMov.activity["c"+i].maxChars=1;
					mainMov.activity["c"+i].restrict="0-9";
					mainMov.activity["c"+i].addEventListener("focusin",onSetFocusCarry_fn);
					mainMov.activity["c"+i].addEventListener("focusout",onKillFocusCarry_fn);
				}
			}
			setQuestion();
		}
		//
		 function done_fn(evt) {
			mainMov.hint_mc.hide_btn.visible=false;
			mainMov.hint_mc.show_btn.visible=true;
			mainMov.activity.hint_mc.visible=false;
			mainMov.activity.hint_mc.x=mainMov.hintPosX;
		}
		//
		 function hintNext_fn(evt) {
			hintLen++;
			var ansLen=String(answer).length;
			trace("innn ",hintLen,"  ",ansLen)
			if (hintLen<ansLen) {
				trace("enterd")
				if (hintLen==ansLen-1) {
					mainMov.activity.hint_mc.next_btn.visible=false;
					mainMov.activity.hint_mc.done_btn.visible=true;
				}
				mainMov.activity.hint_mc.x-=50;
				checkCarry();
			}
		}
		//
		 function checkCarry() {
			var ansLen=String(answer).length;
			trace(carry[ansLen-hintLen] + " ---- "+(ansLen-hintLen)+"----"+ansLen + "   "+ hintLen);
			sub=2;
			if (ansLen==5) {
				sub=1;
			}
			if (carry[ansLen-Number(hintLen+sub)]==1) {
				mainMov.activity.hint_mc.carry_mc.visible=true;
			} else {
				mainMov.activity.hint_mc.carry_mc.visible=false;
			}
		}
		//
		 function hideHint_fn(evt) {
			mainMov.hint_mc.hide_btn.visible=false;
			mainMov.hint_mc.show_btn.visible=true;
			mainMov.activity.hint_mc.visible=false;
		}
		//
		 function showHint_fn(evt) {
			mainMov.hint_mc.hide_btn.visible=true;
			mainMov.hint_mc.show_btn.visible=false;
			mainMov.activity.hint_mc.visible=true;
			mainMov.activity.hint_mc.next_btn.visible=true;
			mainMov.activity.hint_mc.done_btn.visible=false;
			hintLen=0;
			mainMov.activity.hint_mc.x=mainMov.hintPosX;
			checkCarry();
		}
		//
		 function onSetFocus_fn(evt) {
			var txtMov=evt.target;
			txtMov.text="";
			mainMov.activity.tick.gotoAndStopFrame(1);
			txtMov.defaultTextFormat=textFormat2;
			
		}
		//
		 function onKillFocus_fn(evt) {
			var txtMov=evt.target;
			if (txtMov.text=="") {
				txtMov.text="?";
				txtMov.setTextFormat(textFormat1);
			}
		}
		//
		 function onSetFocusCarry_fn(evt) {
			var txtMov=evt.target;
			txtMov.text="";
		}
		//
		 function onKillFocusCarry_fn(evt) {
			var txtMov=evt.target;
			if (txtMov.text=="") {
				txtMov.text="";
			}
		}
		//
		 function check_fn(evt) {
			mainMov.stage.focus=mainMov.activity.dummy_txt;
var ansLength=String(answer).length;
			var res="";
			var res1 = "";
			var getQmarks = "";
			var flg = 0;
			//
			trace(answer +" inn " +ansLength)
for (var i=digLength; i>=1; i--) {
				res+=""+mainMov.activity["a"+i].text;
				getQmarks +="?";
				if (mainMov.activity["a"+i].text!="?" || flg==1) {
					res1 += ""+mainMov.activity["a"+i].text;
					flg = 1;
				}
			}
			if (res!=getQmarks) {
				var finAnswer = Number(res1);
				if (finAnswer==0) {
					finAnswer = -1;
				}
			} else {
				finAnswer = "";
			}
			trace(finAnswer + " Entered");
			//
			if (finAnswer=="") {
				//do nothing....
playSound("planswer");
				mainMov.activity.tick.gotoAndStopFrame(4);
			} else if (finAnswer==answer) {
				mainMov.hint_mc.visible=false;
				//mainMov.activity.notebook.play();
				//mainMov.activity.notebook.addEventListener(Event.ENTER_FRAME,getFrameEnd);
				//addEventListener(Event.ENTER_FRAME,getFrameEnd);
				//stage.addEventListener(Event.ENTER_FRAME,getFrameEnd);
				mainMov.next_btn.visible=true;
				mainMov.activity.tick.gotoAndStopFrame(3);
playSound("welldone");
				mainMov.check_btn.mouseEnabled=false;
				mainMov.check_btn.alpha=.15
				for (i=1; i<=ansLength; i++) {
					mainMov.activity["a"+i].mouseEnabled=false;
					if (i<=digLength) {
						mainMov.activity["c"+i].mouseEnabled=false;
					}
				}
				mainMov.activity.hint_mc.visible = false;//ss
			} else {
				mainMov.answer_btn.alpha=1;
				mainMov.answer_btn.mouseEnabled=true;
				mainMov.activity.tick.gotoAndStopFrame(2);
playSound("tryagain");
			}
		}
		 function getFrameEnd(evt) {
			var mov=evt.currentTarget;
			if (mov.currentFrame==mov.totalFrames) {
				mov.removeEventListener(Event.ENTER_FRAME,getFrameEnd);
				reset_fn();
				setQuestion();
			}
		}
		//
		 function next_fn(evt=null) {
			mainMov.activity.notebook..gotoAndPlayFrame(13);
			mainMov.activity.notebook.addEventListener(Event.ENTER_FRAME,getFrameEnd);
			mainMov.next_btn.mouseEnabled=false;
playSound("pageturn")
			//mainMov.panel.notebook.gotoAndPlayFrame(27);
			//main.mouseEnabled=false;
			////trace(this);
		}
		//
		 function setQuestion(evt=null) {
			try {
				reset_fn();
				pageNumber++;
				mainMov.activity.pgNo_txt.text=pageNumber;
				if (pageNumber>1000) {
					pageNumber=1;
				}
				answer=10000;
				if (carryOver==1) {
					do {
						addend1[0]=Math.round(10000+Math.random()*89999);
						addend2[0]=Math.round(10000+Math.random()*89999);
						answer=Number(addend1[0])+Number(addend2[0]);
						var len=String(answer).length;
					} while (len >5);
				} else {
					var val1="";
					var val2="";
					for (var i=1; i<=digLength; i++) {
						if (i==1) {
							var m1=randomBetween(1,9);
						} else {
							m1=randomBetween(0,9);
						}
						var m2=randomBetween(0,9-m1);
						m3=m1-m2;
						val1+=m1;
						val2+=m2;
					}
					addend1[0]=val1;
					addend2[0]=val2;
					answer=Number(addend1[0])+Number(addend2[0]);
				}
				//

				//
				//trace(addend1[0]+ "  " + addend2[0] +"   " + answer+" answer "+digLength);
				//
				for (i=1; i<=6; i++) {
					if (i>len) {
						mainMov.activity["a"+i].text="";
						mainMov.activity["a"+i].selectable=false;
						mainMov.activity["a"+i].mouseEnabled = false
					} else {
						mainMov.activity["a"+i].text="?";
						mainMov.activity["a"+i].selectable=true;
						mainMov.activity["a"+i].mouseEnabled = true
					}
				}
				//
				for (num=1; num<=2; num++) {
					this["addend"+num][1]=Math.floor(this["addend"+num][0]/10000);
					this["addend"+num][0]-=this["addend"+num][1]*10000;
					this["addend"+num][2]=Math.floor(this["addend"+num][0]/1000);
					this["addend"+num][0]-=this["addend"+num][2]*1000;
					this["addend"+num][3]=Math.floor(this["addend"+num][0]/100);
					this["addend"+num][0]-=this["addend"+num][3]*100;
					this["addend"+num][4]=Math.floor(this["addend"+num][0]/10);
					this["addend"+num][0]-=this["addend"+num][4]*10;
					this["addend"+num][5]=Math.floor(this["addend"+num][0]/1);
					this["addend"+num][0]-=this["addend"+num][5]*1;
					if (this["addend"+num][0]!=0) {
						//trace("Error in addend "+num);
					}
				}
				//
				for (digit=len+1; digit>=0; digit--) {
					carry[digit-1]=0;
					//trace(this.addend1[digit]+" llllllllll "+this.addend2[digit]+" ----- "+carry[digit-1]);
					answerRow[digit]=this.addend1[digit]+this.addend2[digit]+carry[digit];
					//trace(answerRow[digit]);
					if (answerRow[digit]>9) {
						answerRow[digit]-=10;
						carry[digit-1]+=1;
					}
				}
				trace("innn");
				//
				for (var num1=1; num1<=2; num1++) {
					if (this["addend"+num1][1]==0) {
						this["addend"+num1][1]="";
						if (this["addend"+num1][2]==0) {
							this["addend"+num1][2]="";
							if (this["addend"+num1][3]==0) {
this["addend"+num1][3]="";
if (this["addend"+num1][4]==0) {
	this["addend"+num1][5]="";
	if (this["addend"+num1][5]==0) {
		//trace("Oh dear, addend"+num1+"=0000. That's not meant to happen.");
		setQuestion();
	}
}
							}
						}
					}
					for (digit=1; digit<=digLength; digit++) {
						mainMov.activity["r"+num1+""+digit].text=this["addend"+num1][digit];
						mainMov.activity.answer_mc["r"+num1+""+digit].text=this["addend"+num1][digit];
					}
				}
			} catch (e) {
				trace(e);
			}
			setAnswer();
		}
		//
		 function reset_fn(evt=null) {
			for (var i=1; i<=digLength+1; i++) {
				mainMov.activity["a"+i].text="?";
				mainMov.activity["a"+i].defaultTextFormat=textFormat1;
				if (i<=digLength) {
					for (var j=1; j<=2; j++) {
						mainMov.activity["r"+j+""+i].text="?";
					}
				}
				if (i<=digLength) {
					mainMov.activity["c"+i].text="";
					mainMov.activity["c"+i].mouseEnabled=true;
				}
				if (i<=digLength) {
					mainMov.activity.answer_mc["carryDigit"+Number(i-1)].gotoAndStopFrame(1);
				}
				mainMov.activity["a"+i].mouseEnabled=true;
			}
			mainMov.activity.tick.gotoAndStopFrame(1);
			mainMov.hint_mc.visible=true;
			mainMov.answer_btn.visible=true;
			mainMov.next_btn.visible=false;
			mainMov.next_btn.mouseEnabled=true;
			mainMov.answer_btn.mouseEnabled=false;
			mainMov.answer_btn.alpha=.15;
			mainMov.activity.answer_mc.visible=false;
			mainMov.hint_mc.hide_btn.visible=false;
			mainMov.hint_mc.show_btn.visible=true;
			mainMov.activity.hint_mc.visible=false;
			mainMov.activity.hint_mc.done_btn.visible=false;
			mainMov.activity.hint_mc.next_btn.visible=true;
			mainMov.check_btn.mouseEnabled=true;
			mainMov.check_btn.alpha=1
			mainMov.activity.hint_mc.x=mainMov.hintPosX;
			hintLen =0
			if(mainMov.contentPlayer_mc!=null){
stopFbSound();
			}
			mainMov.activity.hint_mc.visible=false;
		}
		//
		 function showAnswer_fn(evt) {
			for (var i=1; i<=digLength; i++) {
				mainMov.activity["a"+i].mouseEnabled=false;
				mainMov.activity["c"+i].mouseEnabled=false;
			}
mainMov.activity["a"+(digLength+1)].mouseEnabled = false;//ss
			mainMov.activity.hint_mc.visible = false;//ss
mainMov.activity.answer_mc.visible=true;
			mainMov.hint_mc.visible=false;
			mainMov.next_btn.visible=true;
			mainMov.answer_btn.visible=false;
			mainMov.check_btn.mouseEnabled=false;
			mainMov.check_btn.alpha=.15
			mainMov.stage.focus=mainMov.activity.dummy_txt;
			mainMov.activity.tick.gotoAndStopFrame(1);
stopFbSound();
		}
		//
		 function setAnswer() {
			////trace(digLength);
			for (digit=0; digit<=digLength; digit++) {
				if (digit==1) {
					if (answerRow[digit]!=0) {
						mainMov.activity.answer_mc["answerDigit"+digit].gotoAndStopFrame(answerRow[digit]+2);
						if (carry[digit]==1) {
							mainMov.activity.answer_mc["carryDigit"+digit].gotoAndStopFrame(carry[digit]+2);
						}
					}
				} else {
					mainMov.activity.answer_mc["answerDigit"+digit].gotoAndStopFrame(answerRow[digit]+2);
					if (carry[digit]==1) {
						mainMov.activity.answer_mc["carryDigit"+digit].gotoAndStopFrame(carry[digit]+2);
					}
				}
				//
				/*if (digit==0&&answerRow[digit]==0) {
		}*/
				mainMov.activity.answer_mc["answerDigit"+0].gotoAndStopFrame(1);
			}
		}
		//
	 
 this.AdditionWithoutCarryOver(mc); 
}

//




