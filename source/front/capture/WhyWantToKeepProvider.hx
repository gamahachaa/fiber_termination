package front.capture;

import tstool.process.Descision;
import tstool.utils.Constants;
import tstool.utils.DateToolsBB;

/**
 * ...
 * @author bb
 */
class WhyWantToKeepProvider extends Descision 
{
	override public function onYesClick():Void
	{
		this._nexts = [{step: _ChangeWishDate, params: []}];
		super.onYesClick();
	}
	override public function onNoClick():Void
	{
		var canTranfer = DateToolsBB.isUTCDayTimeFloatInRanges(Constants.FIBER_WINBACK_DAYS_OPENED_RANGE, Main.FIBER_WINBACK_UTC_RANGES);
		this._nexts = [{step: canTranfer? _TransferToWB : _WinbackIsClosed, params: []}];
		super.onNoClick();
	}
}