package front;

import tstool.process.Action;

/**
 * ...
 * @author bb
 */
class _RefundActivationFees extends Action 
{

	override public function create()
	{
		this._nextProcesses = [new _CreateTwoOneFive()];
		super.create();
	}
	
}