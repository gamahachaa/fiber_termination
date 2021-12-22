package front.move;

import fees._TotalFees;
//import tickets._CreateTwoOneThree;
import tstool.process.Descision;

/**
 * ...
 * @author bb
 */
class CheckOTOInAloAlex extends Descision 
{

	override public function onYesClick():Void
	{
		this._nexts = [{step:_TotalFees, params: []}];
		super.onYesClick();
	}
	override public function onNoClick():Void
	{
		this._nexts = [{step: _ProceedWithMoveAndApplyCharges, params: []}];
		super.onNoClick();
	}
	
}