package Heymath{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	public class AdditionWithoutCarryOver extends Main
	{
		var mainMov:MovieClip;
		var addend1=[];
		var addend2=[];
		var carry=[];
		var answerRow=[];
		var carryOver=1;
		var pageNumber=0;
		var digLength=7;
		var answer=0;
		var hintLen=0;
		var hintPosX=0;
		var textFormat1:TextFormat=new TextFormat  ;
		var textFormat2:TextFormat=new TextFormat  ;
		//
		public function AdditionWithoutCarryOver(mc) {
			mainMov=mc;
			mainMov.next_btn.addEventListener(MouseEvent.CLICK,next_fn);
			mainMov.nextDummy_btn.addEventListener(MouseEvent.CLICK,setQuestion);
			mainMov.check_btn.addEventListener(MouseEvent.CLICK,check_fn);
			mainMov.hint_mc.hide_btn.addEventListener(MouseEvent.CLICK,hideHint_fn);
			mainMov.hint_mc.show_btn.addEventListener(MouseEvent.CLICK,showHint_fn);
			mainMov.activity.hint_mc.carry_mc.visible=false;
			mainMov.activity.hint_mc.done_btn.addEventListener(MouseEvent.CLICK,done_fn);
			mainMov.activity.hint_mc.next_btn.addEventListener(MouseEvent.CLICK,hintNext_fn);
			mainMov.hintPosX=mainMov.activity.hint_mc.x;
			textFormat1.color=0xCCCCCC;
			textFormat2.color=0x000000;
			for (var i=1; i<=digLength+1; i++) {
				mainMov.activity["a"+i].text="?";
				mainMov.activity["a"+i].maxChars=1;
				mainMov.activity["a"+i].restrict="0-9";
				mainMov.activity["a"+i].addEventListener(FocusEvent.FOCUS_IN,onSetFocus_fn);
				mainMov.activity["a"+i].addEventListener(FocusEvent.FOCUS_OUT,onKillFocus_fn);
				mainMov.activity["a"+i].defaultTextFormat=textFormat1;
			}
			if (carryOver==1) {
				for (i=1; i<=digLength; i++) {
					mainMov.activity["c"+i].text="";
					mainMov.activity["c"+i].maxChars=1;
					mainMov.activity["c"+i].restrict="0-9";
					mainMov.activity["c"+i].addEventListener(FocusEvent.FOCUS_IN,onSetFocusCarry_fn);
					mainMov.activity["c"+i].addEventListener(FocusEvent.FOCUS_OUT,onKillFocusCarry_fn);
				}
			}
			setQuestion();
		}
		//
		private function done_fn(evt:Event) {
			mainMov.hint_mc.hide_btn.visible=false;
			mainMov.hint_mc.show_btn.visible=true;
			mainMov.activity.hint_mc.visible=false;
			mainMov.activity.hint_mc.x=mainMov.hintPosX;
			mainMov.stage.focus=mainMov.activity.dummy_txt;
		}
		//
		private function hintNext_fn(evt:Event) {
			hintLen++;
			var ansLen=String(answer).length;
			trace("innn ",hintLen,"  ",ansLen);
			if (hintLen<ansLen) {
				trace("enterd");
				if (hintLen==ansLen-1) {
					mainMov.activity.hint_mc.next_btn.visible=false;
					mainMov.activity.hint_mc.done_btn.visible=true;
				}
				mainMov.activity.hint_mc.x-=50;
				checkCarry();
			}
			mainMov.stage.focus=mainMov.activity.dummy_txt;
		}
		//
		private function checkCarry() {
			var ansLen=String(answer).length;
			trace(carry[ansLen-hintLen] + " ---- "+(ansLen-hintLen)+"----"+ansLen + "   "+ hintLen);
			sub=2;
			if (ansLen==digLength) {
				sub=1;
			}
			if (carry[ansLen-Number(hintLen+sub)]==1) {
				mainMov.activity.hint_mc.carry_mc.visible=true;
			} else {
				mainMov.activity.hint_mc.carry_mc.visible=false;
			}
		}
		//
		private function hideHint_fn(evt:Event) {
			mainMov.hint_mc.hide_btn.visible=false;
			mainMov.hint_mc.show_btn.visible=true;
			mainMov.activity.hint_mc.visible=false;
			mainMov.stage.focus=mainMov.activity.dummy_txt;
		}
		//
		private function showHint_fn(evt:Event) {
			mainMov.hint_mc.hide_btn.visible=true;
			mainMov.hint_mc.show_btn.visible=false;
			mainMov.activity.hint_mc.visible=true;
			mainMov.activity.hint_mc.next_btn.visible=true;
			mainMov.activity.hint_mc.done_btn.visible=false;
			hintLen=0;
			mainMov.activity.hint_mc.x=mainMov.hintPosX;
			mainMov.stage.focus=mainMov.activity.dummy_txt;
			checkCarry();
		}
		//
		private function onSetFocus_fn(evt:Event) {
			mainMov.stopFbSound();
			var txtMov=evt.target;
			txtMov.text="";
			mainMov.activity.tick.gotoAndStop(1);
			mainMov.activity.text_msg.gotoAndStop(1);
			txtMov.defaultTextFormat=textFormat2;
		}
		//
		private function onKillFocus_fn(evt:Event) {
			var txtMov=evt.target;
			if (txtMov.text=="") {
				txtMov.text="?";
				txtMov.setTextFormat(textFormat1);
			}
		}
		//
		private function onSetFocusCarry_fn(evt:Event) {
			var txtMov=evt.target;
			txtMov.text="";
		}
		//
		private function onKillFocusCarry_fn(evt:Event) {
			var txtMov=evt.target;
			if (txtMov.text=="") {
				txtMov.text="";
			}
		}
		//
		private function check_fn(evt:Event) {
			mainMov.stopSound();
			mainMov.stopFbSound();
			mainMov.stage.focus=mainMov.activity.dummy_txt;
			//
			var ansLength=String(answer).length;
			var InPutAnswer:Array=[];
			//
			for (var i=8; i>=1; i--) {
				InPutAnswer.push(mainMov.activity["a"+i].text);
			}
			//
			trace(InPutAnswer +" inputans ")
			
			var finAnswer=InPutAnswer.join("");
			
			trace(finAnswer + " Entered "+ answer);
			//
			if (finAnswer=="????????"||finAnswer=="???????"||finAnswer=="??????"||finAnswer=="?????") {
				//do nothing....
				mainMov.activity.tick.gotoAndStop(1);
				mainMov.activity.text_msg.gotoAndStop("planswer");
				mainMov.playFbSound("plzAnswer");
			} else if (finAnswer==answer) {
				mainMov.playFbSound("right");
				mainMov.playFbSound("wellDone");
				mainMov.hint_mc.visible=false;
				mainMov.next_btn.visible=true;
				mainMov.activity.tick.gotoAndStop("correct");
				mainMov.activity.text_msg.gotoAndStop(1);
				mainMov.check_btn.mouseEnabled=false;
				for (i=1; i<=8; i++) {
					if(mainMov.activity["a"+i].text=="?")
					{
						mainMov.activity["a"+i].text="";
					}
					mainMov.activity["a"+i].mouseEnabled=false;
					if (i<=7) {
						mainMov.activity["c"+i].mouseEnabled=false;
					}
				}
				mainMov.activity.hint_mc.visible = false;
				mainMov.answer_btn.visible=false;
				mainMov.answer_btn.alpha=.15;
				mainMov.answer_btn.mouseEnabled=false;
				mainMov.answer_btn.removeEventListener(MouseEvent.CLICK,showAnswer_fn);
			} else {
				mainMov.answer_btn.visible=true;
				mainMov.answer_btn.alpha=1;
				mainMov.answer_btn.mouseEnabled=true;
				mainMov.answer_btn.addEventListener(MouseEvent.CLICK,showAnswer_fn);
				mainMov.activity.tick.gotoAndStop("incorrect");
				mainMov.activity.text_msg.gotoAndStop("tryagain");
				mainMov.playFbSound("tryAgain");
				mainMov.playFbSound("wrong");
			}
		}
		//
		private function getFrameEnd(evt:Event) {
			var mov=evt.currentTarget;
			if (mov.currentFrame==mov.totalFrames) {
				mov.removeEventListener(Event.ENTER_FRAME,getFrameEnd);
				reset_fn();
				setQuestion();
			}
		}
		//

		private function next_fn(evt:Event=null) {
			mainMov.playSnapSound("paperFlip");
			mainMov.activity.notebook.gotoAndPlay(2);
			mainMov.activity.notebook.addEventListener(Event.ENTER_FRAME,getFrameEnd);
			mainMov.next_btn.mouseEnabled=false;
			mainMov.stopFbSound();
			
		}
		//
		private function setQuestion(evt:Event=null) {
			try {
				reset_fn();
				pageNumber++;
				mainMov.activity.pgNo_txt.text=pageNumber;
				if (pageNumber>1000) {
					pageNumber=1;
				}
				answer=10000;
				carryOver = randomBetween(1,2)
				trace("innn " + carryOver)
				if (carryOver==1) {
					//do {
					addend1[0]=Math.round(1000000+Math.random()*8999999);
					addend2[0]=Math.round(1000000+Math.random()*8999999);
					answer=Number(addend1[0])+Number(addend2[0]);
					var len=String(answer).length;
					//} while (len >digLength);
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
					len=String(answer).length;
				}
				trace(answer)
				//
				//trace(addend1[0]+ "  " + addend2[0] +"   " + answer+" answer "+digLength);
				//
				for (i=1; i<=digLength+1; i++) {
					if (i>len) {
						mainMov.activity["a"+i].text="";
						mainMov.activity["a"+i].selectable=false;
						mainMov.activity["a"+i].mouseEnabled=false;
					} else {
						mainMov.activity["a"+i].text="?";
						mainMov.activity["a"+i].selectable=true;
						mainMov.activity["a"+i].mouseEnabled=true;
					}
				}
				
				//
				for (num=1; num<=2; num++) {
					this["addend"+num][1]=Math.floor(this["addend"+num][0]/1000000);
					this["addend"+num][0]-=this["addend"+num][1]*1000000;
					this["addend"+num][2]=Math.floor(this["addend"+num][0]/100000);
					this["addend"+num][0]-=this["addend"+num][2]*100000;
					this["addend"+num][3]=Math.floor(this["addend"+num][0]/10000);
					this["addend"+num][0]-=this["addend"+num][3]*10000;
					this["addend"+num][4]=Math.floor(this["addend"+num][0]/1000);
					this["addend"+num][0]-=this["addend"+num][4]*1000;
					this["addend"+num][5]=Math.floor(this["addend"+num][0]/100);
					this["addend"+num][0]-=this["addend"+num][5]*100;
					this["addend"+num][6]=Math.floor(this["addend"+num][0]/10);
					this["addend"+num][0]-=this["addend"+num][6]*10;
					this["addend"+num][7]=Math.floor(this["addend"+num][0]/1);
					this["addend"+num][0]-=this["addend"+num][7]*1;
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
									this["addend"+num1][4]="";
									if (this["addend"+num1][5]==0) {
										this["addend"+num1][5]="";
										if (this["addend"+num1][6]==0) {
											//trace("Oh dear, addend"+num1+"=0000. That's not meant to happen.");
											setQuestion();
										}
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

			} catch (e:Error) {
				trace(e);
			}
			//
			setAnswer();
		}
		//
		private function reset_fn(evt:Event=null) {
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
					mainMov.activity.answer_mc["carryDigit"+Number(i-1)].gotoAndStop(1);
				}
				mainMov.activity["a"+i].mouseEnabled=true;
			}
			mainMov.activity.tick.gotoAndStop(1);
			mainMov.activity.text_msg.gotoAndStop(1);
			mainMov.hint_mc.visible=true;
			mainMov.next_btn.visible=false;
			mainMov.next_btn.mouseEnabled=true;
			mainMov.answer_btn.visible=false;
			mainMov.answer_btn.mouseEnabled=false;
			mainMov.answer_btn.alpha=.15;
			mainMov.answer_btn.removeEventListener(MouseEvent.CLICK,showAnswer_fn);
			mainMov.activity.answer_mc.visible=false;
			mainMov.hint_mc.hide_btn.visible=false;
			mainMov.hint_mc.show_btn.visible=true;
			mainMov.activity.hint_mc.visible=false;
			mainMov.activity.hint_mc.done_btn.visible=false;
			mainMov.activity.hint_mc.next_btn.visible=true;
			mainMov.check_btn.mouseEnabled=true;
			mainMov.activity.hint_mc.x=mainMov.hintPosX;
			hintLen=0;
		}
		//
		private function showAnswer_fn(evt:Event) {
			for (var i=1; i<=digLength; i++) {
				mainMov.activity["a"+i].mouseEnabled=false;
				mainMov.activity["c"+i].mouseEnabled=false;
			}
			mainMov.activity["a"+8].mouseEnabled = false;//sss
			mainMov.activity.hint_mc.visible = false;//sss
			
			mainMov.activity.answer_mc.visible=true;
			mainMov.hint_mc.visible=false;
			mainMov.next_btn.visible=true;
			mainMov.check_btn.mouseEnabled=false;
			mainMov.stopFbSound();
			mainMov.activity.text_msg.gotoAndStop(1);
			mainMov.answer_btn.visible=false;
			mainMov.answer_btn.alpha=.15;
			mainMov.answer_btn.mouseEnabled=false;
			mainMov.answer_btn.removeEventListener(MouseEvent.CLICK,showAnswer_fn);
			mainMov.stage.focus=mainMov.activity.dummy_txt;
			
		}
		//
		private function setAnswer() {
			for (digit=0; digit<=digLength; digit++) {
				if (digit==1) {
					mainMov.activity.answer_mc["answerDigit"+digit].gotoAndStop(answerRow[digit]+2);
					if (carry[digit]==1) {
						mainMov.activity.answer_mc["carryDigit"+digit].gotoAndStop(carry[digit]+2);
					}
				}else {
					mainMov.activity.answer_mc["answerDigit"+digit].gotoAndStop(answerRow[digit]+2);
					if (carry[digit]==1) {
						mainMov.activity.answer_mc["carryDigit"+digit].gotoAndStop(carry[digit]+2);
					}
				}
				if (mainMov.activity.answer_mc["answerDigit"+0].currentFrame==2) {
					mainMov.activity.answer_mc["answerDigit"+0].gotoAndStop(1);
				}
			}
		}
		//
	}
}
//