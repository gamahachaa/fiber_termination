package front;

import tstool.process.Descision;

/**
 * ...
 * @author bb
 */
class HowWasOrderMade extends Descision 
{

	override public function create()
	{
		this._nextNoProcesses = [new IsBoxAlreadySent()];
		this._nextYesProcesses = [new _EtfWillBeWaived()];
		super.create();
	}
}