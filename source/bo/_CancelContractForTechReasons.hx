package bo;

import tstool.process.Action;

/**
 * ...
 * @author bb
 */
class _CancelContractForTechReasons extends Action 
{

	override public function create()
	{
		this._nextProcesses = [new HowWasOrderMade()];
		super.create();
	}
	
}