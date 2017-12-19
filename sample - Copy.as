
package l1917Heymath{

	import flash.display.MovieClip;
	import flash.events.*;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.*;


	private var myAnsThisVals:Array=new Array;
	private var mainMov;
	public var bool:Boolean = false;
	public var i:int=0;

	public class l1917RadioCheckYesNo extends MovieClip
	{

		private function eventsFun1():void{
			/// sample dummy code
			txt1.addEventListener(FocusEvent.FOCUS_IN,focusIn_fn);
			txt2.addEventListener(FocusEvent.FOCUS_OUT,focusOut_fn);
			btn.addEventListener(MouseEvent.CLICK,showAnswer_fn);
		}

		private function showAnswer_fn(e:MouseEvent){

		}

		private function check_fn(e:Event) {

		}

		private function propertiesFun(e:TextEvent):Boolean {
			/// code
			mc._visible = false;
			mc._alpha = 50;
			msg_clp.gotoAndStop(1);
			msg_clp.gotoAndPlay(2);

			mc.enabled = false;
			//mc.x 

			mainMov.root.stopSound();
			mainMov.root.stopFbSound();
			mainMov.root.stopSnapSound();

			mainMov.root.playFbSound("fillBoxes");
			mainMov.root.playSnapSound("ting");
			mainMov.root.playSound("ques1");
		}
	}
}