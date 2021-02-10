package fees;

import tstool.process.Descision;
import tstool.process.Process;

/**
 * ...
 * @author bb
 */
class IsBoxAlreadySent extends Descision 
{

	override public function onYesClick():Void
	{
		this._nexts = [{step: _TotalFees, params: []}];
		super.onYesClick();
	}
	override public function onNoClick():Void
	{
		this._nexts = [{step: IsActivationFeesPaid, params: []}];
		super.onNoClick();
	}
	
}