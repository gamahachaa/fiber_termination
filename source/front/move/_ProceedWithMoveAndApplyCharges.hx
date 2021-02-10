package front.move;

import flow.End;
import flow._AddMemoVti;
import tstool.process.Action;

/**
 * ...
 * @author bb
 */
class _ProceedWithMoveAndApplyCharges extends Action 
{

	override public function onClick():Void
	{
		this._nexts = [{step: _AddMemoVti, params: []}];
		super.onClick();
	}
	
}