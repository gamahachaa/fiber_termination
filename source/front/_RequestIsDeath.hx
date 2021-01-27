package front;

import tstool.process.Action;

/**
 * ...
 * @author bb
 */
class _RequestIsDeath extends Action 
{

	override public function create()
	{
		this._nextProcesses = [new _CreateTwoOneThirteen()];
		super.create();
	}
	
}