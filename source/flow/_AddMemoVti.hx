package flow;

import tstool.process.Action;

/**
 * ...
 * @author bb
 */
class _AddMemoVti extends Action 
{

	override public function create()
	{
		this._nextProcesses = [new flow.End()];
		super.create();
	}
	
}