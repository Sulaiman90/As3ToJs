

package l1917Heymath{
	import flash.display.MovieClip;
	import flash.events.*;



	public class l1917SimpleCheck extends MovieClip {
		private var ans_ar=[];
		private var mc;
		private var prevcorr=0;
		private var trials;
		private var mainStage;
		public function l1917SimpleCheck(mov:MovieClip,a:Array):void {
			trace(a,mov);
			ans_ar=a;
			mc=mov;
			mainStage = mc.parent;
			init();
			

		}
		private function init() {
			
              trials=0
              //  mc.feedback_mc.gotoAndStop(1);
			 trace("here",ans_ar.length);
			for (var i=1; i<=ans_ar.length; i++) {
				
				mc["txt"+i].addEventListener(FocusEvent.FOCUS_IN,focus_fn);

				mc["txt"+i].maxChars=3;
				mc["txt"+i].restrict="0-9";
				mc["txt"+i].text="";
				
				mc["tickcross"+i].gotoAndStop("none");
			}
              mc.ans_mc.visible=false;
			   mc.feedback_mc.gotoAndStop("none");
            mc.showans_btn.visible=false
			
			mc.check_btn.addEventListener(MouseEvent.CLICK,check_fn);
			mc.showans_btn.addEventListener(MouseEvent.CLICK,showans_fn);


		}
		/*private function checkMouseOver_fn(e:Event) {
			e.currentTarget.gotoAndStop(2);
		}
		private function checkMouseOut_fn(e:Event) {
			e.currentTarget.gotoAndStop(1);
		}
*/
		private function check_fn(e:Event) {
			mc.stage.focus=mc.dummy;
			var pls=0;
			var corr=0;
			var wr=0;
			mainStage.stopSound();
			mainStage.stopFbSound();
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
				mainStage.playFbSound("right");
				mc.check_btn.visible = false;

			} else if (corr>prevcorr) {
				mainStage.playFbSound("right");
				if (corr==ans_ar.length-1) {
					mc.feedback_mc.gotoAndStop("trythis");
				} else {
					mc.feedback_mc.gotoAndStop("trythese");
				}
			} else if (wr>0) {
				mainStage.playFbSound("wrong");
				mc.feedback_mc.gotoAndStop("tryagain");
				trials++
				if(trials>2)
			    mc.showans_btn.visible=true
				
			} else {
				mc.feedback_mc.gotoAndStop("please");

			}
			mainStage.playFbSound(mc.feedback_mc.currentFrameLabel);
			prevcorr=corr;
		}
		private function focus_fn(e:Event) {
			mainStage.stopFbSound();
			e.target.text="";
			var i= e.target.name.substr(3,1)
			mc.feedback_mc.gotoAndStop("none");
			mc["tickcross"+i].gotoAndStop("none");
		}
       private function showans_fn(e:Event) {
		   mainStage.stopSound();
			mainStage.stopFbSound();
			mc.ans_mc.visible=true
			disableAll()
			e.target.visible=false
			mc.feedback_mc.gotoAndStop("none");
			for (var i=1; i<=ans_ar.length; i++) {
				mc["tickcross"+i].gotoAndStop("none");
			}
			mc.parent.parent.showPlay()
			
		}

		private function disableAll() {
			for (var i=1; i<=ans_ar.length; i++) {
				mc["txt"+i].mouseEnabled=false;
				mc.check_btn.visible=false;
			}
		}


	}
}