package action_Heymath{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.*;


	public class input_NumeratorType_Heymath {
		private var mainMov;
		private var i=0;
		private var thisTextNum=0;
		private var thisSubTextNum=0;
		private var totalCount=0;
		private var riteCount=0;
		private var rongCount=0;
		private var playedCount=0;
		private var totalPairs=0;
		private var txtBoxNameWithOutPair:Array=new Array  ;
		private var txtBoxNameNumerator:Array=new Array  ;
		private var txtBoxNameDenominator:Array=new Array  ;
		private var txtBoxName:Array=new Array  ;
		private var myAnsTick1:Array=new Array  ;
		private var myAnsTick2:Array=new Array  ;
		private var myAns0:Array=new Array  ;
		private var myAns1:Array=new Array  ;
		private var myAns2:Array=new Array  ;
		private var txtbxno;
		private var myDropDown;
		private var fractionInputStatus;//this is to chk if there is fraction input then true and some fraction and normal input then false....
		//below is for removing front zeros..
		private var inTxt;
		private var indexOfZero1;
		private var indexOfZero2;
		private var indexOfZero3;
		private var indexOfZero4;
		private var indexOfZero5;
		//below is for limiting one minus..
		private var myTextNegative;
		private var hh;
		private var hh1;
		private var oldtxt;
		//

		public function input_NumeratorType_Heymath(mov,notxt,NegativeTxt,myDDName,fractionNumber) {
			fractionInputStatus=fractionNumber;
			myTextNegative=NegativeTxt;
			myDropDown=myDDName;
			mainMov=mov;
			txtbxno=notxt;
			trace("Heymath AS_file for input numerator type loaded...  ");
			init();
		}

		private function init() {
			switch (myDropDown) {
				case "dd1" :
					//how many pair...
					totalPairs=5;
					//collect all text box names...
					txtBoxName=["txt1a","txt2a","txt2b","txt3a","txt3b","txt4a","txt4b","txt5a"];
					//for single input...
					txtBoxNameWithOutPair=[,"txt1a","txt5a"];
					myAns0=[,0,3];
					myAnsTick1=[,1,5];
					//for paired input...
					txtBoxNameNumerator=[,"txt2a","txt3a","txt4a"];
					txtBoxNameDenominator=[,"txt2b","txt3b","txt4b"];
					myAns1=[,2,5,7];
					myAns2=[,3,3,3];
					myAnsTick2=[,2,3,4];
					break;
				case "dd3" :
					//how many pair...
					totalPairs=6;
					//collect all text box names...
					txtBoxName=["txt1a","txt1b","txt2a","txt2b","txt3a","txt3b","txt4a","txt4b","txt5a","txt5b","txt6a","txt6b"];
					//for single input...
					txtBoxNameWithOutPair=[];
					myAns0=[];
					myAnsTick1=[];
					//for paired input...
					txtBoxNameNumerator=[,"txt1a","txt2a","txt3a","txt4a","txt5a","txt6a"];
					txtBoxNameDenominator=[,"txt1b","txt2b","txt3b","txt4b","txt5b","txt6b"];
					myAns1=[,1,2,3,4,5,6];
					myAns2=[,1,2,3,4,5,6];
					myAnsTick2=[,1,2,3,4,5,6];
					break;
			}
			//
			for (i=0; i<=Number(txtBoxName.length-1); i++) {
				mainMov[txtBoxName[i]].text="?";
				mainMov[txtBoxName[i]].type="input";
				mainMov[txtBoxName[i]].mouseEnabled=true;
				//mainMov[txtBoxName[i]].maxChars=2;
				//mainMov[txtBoxName[i]].restrict="0-9";
				mainMov[txtBoxName[i]].addEventListener(FocusEvent.FOCUS_IN,focusIn_fn);
				mainMov[txtBoxName[i]].addEventListener(FocusEvent.FOCUS_OUT,focusOut_fn);
			}
			mainMov.tabChildren=false;
			mainMov.msg_clp.gotoAndStop("none");
			mainMov.chk_clp.check_btn.visible=true;
			mainMov.chk_clp.check_btn.addEventListener(MouseEvent.CLICK,check_fn);
		}

		private function check_fn(e:Event) {
			mainMov.root.ab=e.target.parent.parent.name
			mainMov.root.stopSound();
			mainMov.root.stopFbSound();
			mainMov.root.stopSnapSound();
			mainMov.stage.focus=mainMov.focusClip;
			totalCount=0;
			riteCount=0;
			rongCount=0;
			playedCount=0;
			for (i=0; i<=Number(txtBoxName.length-1); i++) {
				if (mainMov[txtBoxName[i]].text=="?"||mainMov[txtBoxName[i]].text==""||mainMov[txtBoxName[i]].text=="-"||mainMov[txtBoxName[i]].text==".") {
					mainMov[txtBoxName[i]].text="?";
					playedCount++;
				}
			}
			for (i=1; i<=totalPairs; i++) {
				if (mainMov["tick"+i].currentLabel!="tick") {
					totalCount++;
				}
			}
			if (playedCount>0) {
				if (totalCount==1) {
					mainMov.msg_clp.gotoAndStop("plsanswer1");
					mainMov.root.playFbSound("fillBox")
				} else {
					mainMov.msg_clp.gotoAndStop("plsanswer");
					mainMov.root.playFbSound("fillBoxes")
				}
			}
			if (playedCount==0) {
				//playedCount validation starts here.....
				for (i=1; i<=Number(txtBoxNameWithOutPair.length-1); i++) {
					trace(txtBoxNameWithOutPair[i]+"  correctAns  no pair "+myAns0[i]);
					if (fractionInputStatus==false) {
						if (mainMov[txtBoxNameWithOutPair[i]].text==myAns0[i]) {
							mainMov["tick"+myAnsTick1[i]].gotoAndStop("tick");
							mainMov[txtBoxNameWithOutPair[i]].removeEventListener(FocusEvent.FOCUS_IN,focusIn_fn);
							mainMov[txtBoxNameWithOutPair[i]].removeEventListener(FocusEvent.FOCUS_OUT,focusOut_fn);
							mainMov[txtBoxNameWithOutPair[i]].type="dynamic";
							mainMov[txtBoxNameWithOutPair[i]].mouseEnabled=false;
							riteCount++;

						}
						if (mainMov[txtBoxNameWithOutPair[i]].text!=myAns0[i]) {
							mainMov["tick"+myAnsTick1[i]].gotoAndStop("cross");
							rongCount++;
						}
					}
				}
				for (i=1; i<=Number(txtBoxNameNumerator.length-1); i++) {
					trace(txtBoxNameNumerator[i]+"     numerator  "+myAns1[i]);
					trace(txtBoxNameDenominator[i]+"  denominator "+myAns2[i]);
					if (mainMov[txtBoxNameNumerator[i]].text==myAns1[i]&&mainMov[txtBoxNameDenominator[i]].text==myAns2[i]) {
						mainMov["tick"+myAnsTick2[i]].gotoAndStop("tick");
						mainMov[txtBoxNameNumerator[i]].mouseEnabled=false;
						mainMov[txtBoxNameDenominator[i]].mouseEnabled=false;
						mainMov[txtBoxNameNumerator[i]].type="dynamic";
						mainMov[txtBoxNameDenominator[i]].type="dynamic";
						mainMov[txtBoxNameNumerator[i]].removeEventListener(FocusEvent.FOCUS_IN,focusIn_fn);
						mainMov[txtBoxNameNumerator[i]].removeEventListener(FocusEvent.FOCUS_OUT,focusOut_fn);
						mainMov[txtBoxNameDenominator[i]].removeEventListener(FocusEvent.FOCUS_IN,focusIn_fn);
						mainMov[txtBoxNameDenominator[i]].removeEventListener(FocusEvent.FOCUS_OUT,focusOut_fn);
						riteCount++;

					}
					if (mainMov[txtBoxNameNumerator[i]].text!=myAns1[i]||mainMov[txtBoxNameDenominator[i]].text!=myAns2[i]) {
						mainMov["tick"+myAnsTick2[i]].gotoAndStop("cross");
						rongCount++;
					}
				}
				chkMyAnswer();
				//playedCount validation ends here.....
			}
		}

		//function to reset the input box if you get a rong answer.....
		private function focusIn_fn(e:Event) {
			if(mainMov.root.ab==e.target.parent.name)
			{
			mainMov.root.stopFbSound();
			mainMov.root.stopSnapSound();
			}
			thisSubTextNum=e.target.name.slice(3,5);
			thisTextNum=e.target.name.slice(3,4);
			trace(thisTextNum+"  textbox  "+thisSubTextNum);
			if (mainMov["txt"+thisSubTextNum].selectable==true) {
				mainMov["txt"+thisSubTextNum].text="";
				mainMov["tick"+thisTextNum].gotoAndStop("none");
				mainMov.msg_clp.gotoAndStop("none");
				mainMov.addEventListener(Event.ENTER_FRAME,enterFunction);
			}
		}
		//focus out function for the text box ....
		private function focusOut_fn(e:Event) {
			thisSubTextNum=e.target.name.slice(3,5);
			thisTextNum=e.target.name.slice(3,4);
			trace(thisTextNum+"  textbox  "+thisSubTextNum);
			if (mainMov["txt"+thisSubTextNum].selectable==true&&(mainMov["txt"+thisSubTextNum].text==""||mainMov["txt"+thisSubTextNum].text=="-"||mainMov["txt"+thisSubTextNum].text==".")) {
				mainMov["txt"+thisSubTextNum].text="?";
			} else {
				removeFrontZero(mainMov["txt"+thisSubTextNum]);
			}
			mainMov.removeEventListener(Event.ENTER_FRAME,enterFunction);
		}
		//function to show different message according to the user input....
		private function chkMyAnswer() {
			trace("riteCount "+riteCount+"        rongCount  "+rongCount+"      totalCount  "+totalCount);
			if (riteCount==0&&rongCount>0) {
				//try again..
				mainMov.msg_clp.gotoAndStop("tryagain");
				mainMov.root.multiSndCount=0;
				mainMov.root.multiSnd_A=["wrong","tryAgain"];
	            mainMov.root.playMultiSound();
				trace("chk1");
			} else if (riteCount>0&&riteCount<totalPairs&&rongCount>0) {
				if (totalCount==1) {
					trace("chk2");
					if (rongCount==totalCount) {
						mainMov.msg_clp.gotoAndStop("trythis");
						mainMov.root.multiSndCount=0;
						mainMov.root.multiSnd_A=["wrong","tryThis"];
	                    mainMov.root.playMultiSound();
					}
				} else if (totalCount>1) {
					trace("chk3");
					if (rongCount==totalCount) {
						mainMov.msg_clp.gotoAndStop("trythese");
						mainMov.root.multiSndCount=0;
						mainMov.root.multiSnd_A=["wrong","tryThese"];
	                    mainMov.root.playMultiSound();
					} else if (rongCount==1) {
						mainMov.msg_clp.gotoAndStop("goodtryotherone");
						mainMov.root.multiSndCount=0;
						mainMov.root.multiSnd_A=["right","goodOtherOne"];
	                    mainMov.root.playMultiSound();
					} else if (rongCount>1&&rongCount<totalCount) {
						mainMov.msg_clp.gotoAndStop("goodtryother");
						mainMov.root.multiSndCount=0;
						mainMov.root.multiSnd_A=["right","goodOtherOnes"];
	                    mainMov.root.playMultiSound();
					}
				}
			} else if (riteCount==totalPairs&&rongCount==0) {
				//welldone..
				mainMov.stage.focus=mainMov.focusClip;
				mainMov.msg_clp.gotoAndStop("welldone");
				mainMov.root.multiSndCount=0;
				mainMov.root.multiSnd_A=["right","wellDone"];
	            mainMov.root.playMultiSound();
				mainMov.chk_clp.check_btn.removeEventListener(MouseEvent.CLICK,check_fn);
				mainMov.chk_clp.check_btn.visible=false;
			}
		}//function to remove the front zeros..
		private function removeFrontZero(MyTxt) {
			if (Number(MyTxt.text)==0) {
				MyTxt.text=0;
			} else if (MyTxt.text!=0) {
				inTxt=MyTxt.text;
				indexOfZero1=inTxt.slice(0,1);
				indexOfZero2=inTxt.slice(1,2);
				indexOfZero3=inTxt.slice(2,3);
				indexOfZero4=inTxt.slice(3,4);
				indexOfZero5=inTxt.slice(4,5);
				trace(indexOfZero1+"  "+indexOfZero2+"  "+indexOfZero3+"  "+indexOfZero4+"  "+indexOfZero5);
				if (indexOfZero1==0&&indexOfZero2==0&&indexOfZero3==0&&indexOfZero4==0&&indexOfZero5==0) {
					inTxt=inTxt.slice(5,Number(inTxt.length));
				} else if (indexOfZero1==0&&indexOfZero2==0&&indexOfZero3==0&&indexOfZero4==0) {
					inTxt=inTxt.slice(4,Number(inTxt.length));
				} else if (indexOfZero1==0&&indexOfZero2==0&&indexOfZero3==0) {
					inTxt=inTxt.slice(3,Number(inTxt.length));
				} else if (indexOfZero1==0&&indexOfZero2==0) {
					inTxt=inTxt.slice(2,Number(inTxt.length));
				} else if (indexOfZero1==0) {
					inTxt=inTxt.slice(1,Number(inTxt.length));
				}
				MyTxt.text=inTxt;
			}
		}
		//for puting the minus in the begaining only once...
		private function enterFunction(evt:Event) {
			switch (myTextNegative) {
				case true :
					switch (fractionInputStatus) {
						case 0 ://if there is both normal and fraction input txt...
						case 1 ://if there is only fraction input txt...
							hh=mainMov["txt"+thisSubTextNum].text.split("-");
							hh1=mainMov["txt"+thisSubTextNum].text.split("");
							if (hh.length>=2&&hh1[0]!="-") {
								mainMov["txt"+thisSubTextNum].text=oldtxt;
							} else if (hh.length>2) {
								mainMov["txt"+thisSubTextNum].text=oldtxt;
							} else if (hh1[0] != "-" || hh1.length>1) {
								if (mainMov["txt"+thisSubTextNum].text!="") {
									mainMov["txt"+thisSubTextNum].text=mainMov["txt"+thisSubTextNum].text;
								}
							}
							oldtxt=mainMov["txt"+thisSubTextNum].text;
							break;
						case 2 ://if there is only normal input txt...
							hh=mainMov["txt"+thisTextNum].text.split("-");
							hh1=mainMov["txt"+thisTextNum].text.split("");
							if (hh.length>=2&&hh1[0]!="-") {
								mainMov["txt"+thisTextNum].text=oldtxt;
							} else if (hh.length>2) {
								mainMov["txt"+thisTextNum].text=oldtxt;
							} else if (hh1[0] != "-" || hh1.length>1) {
								if (mainMov["txt"+thisTextNum].text!="") {
									mainMov["txt"+thisTextNum].text=mainMov["txt"+thisTextNum].text;
								}
							}
							oldtxt=mainMov["txt"+thisTextNum].text;
					}
					break;
				case false :
					switch (fractionInputStatus) {
						case 0 ://if there is both normal and fraction input...
						case 1 ://if there is only fraction input...
						case 2 ://if there is only normal input...
							break;
					}
					break;
			}
		}

	}
}