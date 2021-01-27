package bo;


import tstool.process.Descision;

/**
 * ...
 * @author bb
 */
class HowWasOrderMade extends Descision 
{

	override public function create()
	{
		this._nextYesProcesses = [new _RefundAndWaveETF()];
		this._nextNoProcesses = [new _ChargeNoticePeriodAndETF()];
		super.create();
	}
}