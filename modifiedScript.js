function l1917SimpleCheck()   {
		 var ans_ar=[];
		 var mc;
		 var prevcorr=0;
		 var trials;
		 var mainStage;
		 function l1917SimpleCheck(mov,a) {
			trace(a,mov);
			ans_ar=a;
			mc=mov;
			mainStage = mc.parent;
			init();
			

		}
		 function init() {
 trials=0
              //  mc.feedback_mc.gotoAndStopFrame(1);
			 trace("here",ans_ar.length);
			for (var i=1; i<=ans_ar.length; i++) {
				
				mc["txt"+i].addEventListener("focusin",focus_fn);

				mc["txt"+i].maxChars=3;
				mc["txt"+i].restrict="0-9";
				mc["txt"+i].text="";
				
				mc["tickcross"+i].gotoAndStop("none");
			}
              mc.ans_mc.visible=false;
			   mc.feedback_mc.gotoAndStop("none");
            mc.showans_btn.visible=false
			
			mc.check_btn.addEventListener("click",check_fn);
			mc.showans_btn.addEventListener("click",showans_fn);


		}
		/* function checkMouseOver_fn(e) {
			e.currentTarget.gotoAndStopFrame(2);
		}
		 function checkMouseOut_fn(e) {
			e.currentTarget.gotoAndStopFrame(1);
		}
*/
		 function check_fn(e) {
			mc.stage.focus=mc.dummy;
			var pls=0;
			var corr=0;
			var wr=0;
stopSound();
stopFbSound();
			for (var i=1; i<=ans_ar.length; i++) {
				if (mc["txt"+i].text=="") {
					pls++;
					mc["tickcross"+i].gotoAndStop("none");
				} else if (mc["txt"+i].text==ans_ar[i-1]) {
					corr++;
					mc["tickcross"+i].gotoAndStop("tick");
					mc["txt"+i].mouseEnabled=false;
				} else {
					wr++;
					mc["tickcross"+i].gotoAndStop("cross");
				}
			}
			if (corr==ans_ar.length) {
				mc.feedback_mc.gotoAndStop("welldone");
				mc.showans_btn.visible=false
				mc.parent.parent.showPlay();
playFbSound("right");
				mc.check_btn.visible = false;

			} else if (corr>prevcorr) {
playFbSound("right");
				if (corr==ans_ar.length-1) {
					mc.feedback_mc.gotoAndStop("trythis");
				} else {
					mc.feedback_mc.gotoAndStop("trythese");
				}
			} else if (wr>0) {
playFbSound("wrong");
				mc.feedback_mc.gotoAndStop("tryagain");
				trials++
				if(trials>2)
			    mc.showans_btn.visible=true
				
			} else {
				mc.feedback_mc.gotoAndStop("please");

			}
playFbSound(mc.feedback_mc.currentLabel);
			prevcorr=corr;
		}
		 function focus_fn(e) {
stopFbSound();
			e.target.text="";
			var i= e.target.name.substr(3,1)
			mc.feedback_mc.gotoAndStop("none");
			mc["tickcross"+i].gotoAndStop("none");
		}
        function showans_fn(e) {
stopSound();
stopFbSound();
			mc.ans_mc.visible=true
			disableAll()
			e.target.visible=false
			mc.feedback_mc.gotoAndStop("none");
			for (var i=1; i<=ans_ar.length; i++) {
				mc["tickcross"+i].gotoAndStop("none");
			}
			mc.parent.parent.showPlay()
			
		}

		 function disableAll() {
			for (var i=1; i<=ans_ar.length; i++) {
				mc["txt"+i].mouseEnabled=false;
				mc.check_btn.visible=false;
			}
		}


	}


