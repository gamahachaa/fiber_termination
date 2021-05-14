package winback;

import flow._AddMemoVti;
import fees._InputDates;
import front.capture._CompareWishAndTermDates;
import tstool.process.Descision;
import tstool.process.Process;

/**
 * ...
 * @author bb
 */
class RetainWithSalesSpeech extends Descision 
{
	override public function onYesClick():Void
	{
		this._nexts = [{step: next(), params: []}];
		super.onYesClick();
	}
	override public function onNoClick():Void
	{
		this._nexts = [{step: _InputDates, params: []}];
		super.onNoClick();
	}
	inline function next():Class<Process>
	{
		return if (Main.HISTORY.findValueOfFirstClassInHistory(Intro, Intro.WHY_LEAVE).value == Intro.PLUG_IN_USE)
		{
			_CompareWishAndTermDates;
		}
		else{
			_AddMemoVti;
		}
	}
}