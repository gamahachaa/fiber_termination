package winback;

import flow._AddMemoVti;
import fees._InputDates;
import tstool.process.Descision;

/**
 * ...
 * @author bb
 */
class RetainWithSalesSpeech extends Descision 
{
	override public function onYesClick():Void
	{
		this._nexts = [{step: _AddMemoVti, params: []}];
		super.onYesClick();
	}
	override public function onNoClick():Void
	{
		this._nexts = [{step: _InputDates, params: []}];
		super.onNoClick();
	}
}