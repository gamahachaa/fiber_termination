package fees;

import tickets._CreateTwoOneTwo;
import tstool.process.Descision;

/**
 * ...
 * @author bb
 */
class IsActivationFeesPaid extends Descision 
{
	
	override public function onYesClick():Void
	{
		this._nexts = [{step: _TotalFees, params: []}];
		super.onYesClick();
	}
	override public function onNoClick():Void
	{
		this._nexts = [{step: _TotalFees, params: []}];
		super.onNoClick();
	}

	
}