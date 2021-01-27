package front;

import tstool.process.Action;

/**
 * ...
 * @author bb
 */
class _EtfWillBeWaived extends Action 
{
	override public function create()
	{
		this._nextProcesses = [ new _RefundActivationFees()];
		super.create();
	}
	
}