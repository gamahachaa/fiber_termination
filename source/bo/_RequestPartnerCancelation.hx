package bo;

import tstool.process.Action;

/**
 * ...
 * @author bb
 */
class _RequestPartnerCancelation extends Action 
{

	override public function create()
	{
		this._nextProcesses = [new _RefundAndWaveETF()];
		super.create();
	}
	
}