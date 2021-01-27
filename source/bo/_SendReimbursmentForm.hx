package bo;

import tstool.process.Action;

/**
 * ...
 * @author bb
 */
class _SendReimbursmentForm extends Action 
{

	override public function create()
	{
		this._nextProcesses = [new _SendCancelationConfirm()];
		super.create();
	}
	
}