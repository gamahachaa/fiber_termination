package bo;

import tstool.process.Action;

/**
 * ...
 * @author bb
 */
class _RefundAndWaveETF extends Action 
{

	override public function create()
	{
		this._nextProcesses = [new IsBoxAlreadySent()];
		super.create();
	}
	
}