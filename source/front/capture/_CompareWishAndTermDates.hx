package front.capture;

import fees._InputDates;
import tstool.process.Descision;

/**
 * ...
 * @author bb
 */
class _CompareWishAndTermDates extends Descision 
{

	override public function onYesClick():Void
	{
		this._nexts = [{step: _ChangeWishDate, params: []}];
		super.onYesClick();
	}
	override public function onNoClick():Void
	{
		this._nexts = [{step: _InputDates, params: []}];
		super.onNoClick();
	}	
}