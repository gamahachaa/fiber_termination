package front.move;

import tickets._CreateTwoOneThree;
import tstool.process.Descision;

/**
 * ...
 * @author bb
 */
class _CheckOTOInAloAlex extends Descision 
{

	override public function onYesClick():Void
	{
		this._nexts = [{step: _ProceedMoveAndChargesVTI, params: []}];
		super.onYesClick();
	}
	override public function onNoClick():Void
	{
		this._nexts = [{step: _CreateTwoOneThree, params: []}];
		super.onNoClick();
	}
	
}