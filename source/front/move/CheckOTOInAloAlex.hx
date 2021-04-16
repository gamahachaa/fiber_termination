package front.move;

import tickets._CreateTwoOneThree;
import tstool.process.Descision;

/**
 * ...
 * @author bb
 */
class CheckOTOInAloAlex extends Descision 
{

	override public function onYesClick():Void
	{
		this._nexts = [{step:_CreateTwoOneThree, params: []}];
		super.onYesClick();
	}
	override public function onNoClick():Void
	{
		this._nexts = [{step: _ProceedWithMoveAndApplyCharges, params: []}];
		super.onNoClick();
	}
	
}