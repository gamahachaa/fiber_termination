package bo;

import tstool.process.Action;

/**
 * ...
 * @author bb
 */
class _RelocationProcess extends Action 
{

	override public function create()
	{
		this._nextProcesses = [new IsElligibleAtNewAdress()];
		super.create();
	}
	
}