










var myAnsThisVals=new Array;
var mainMov;
var bool= false;
var i=0;

class l1917RadioCheckYesNo extends MovieClip
{

	function eventsFun1(){
			/// sample dummy code
			txt1.addEventListener("focusin",focusIn_fn);
			txt2.addEventListener("focusout",focusOut_fn);
			btn.addEventListener("click",showAnswer_fn);
	}

	function showAnswer_fn(e){

	}

	function check_fn(e) {

	}

	function propertiesFun(e) {
		/// code
		mc._visible = false;
		mc._alpha = 50;
		msg_clp.gotoAndStopFrame(1);
		msg_clp.gotoAndPlayFrame(2);

		mc.mouseEnabled = false;
		//mc.x 

		stopSound();
		stopFbSound();
		stopSnapSound();

		playFbSound("fillBoxes");
		playSnapSound("ting");
		playSound("ques1");
	}
}

