package front.move.vti;

import fees._TotalFees;
import flow._AddMemoVti;
import tstool.process.Action;

/**
 * ...
 * @author bb
 */
class _SubmitMove extends Action 
{

	override public function onClick():Void
	{
		//this._nexts = [{step: _AddMemoVti, params: []}];
		this._nexts = [{step: _TotalFees, params: []}];
		super.onClick();
	}
	
}