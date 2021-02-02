package front.fees;

import tstool.process.Descision;

/**
 * ...
 * @author bb
 */
class IsBoxAlreadySent extends Descision 
{

	override public function create()
	{
		this._nextNoProcesses = [new _RefundActivationFees()];
		this._nextYesProcesses = [new IsOrderFullfiled()];
		super.create();
	}
	
}