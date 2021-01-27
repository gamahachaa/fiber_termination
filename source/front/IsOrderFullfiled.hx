package front;

import tstool.process.Descision;

/**
 * ...
 * @author bb
 */
class IsOrderFullfiled extends Descision 
{

	override public function create()
	{
		this._nextNoProcesses = [new _ChargeNoticePeriodAndETF()];
		this._nextYesProcesses = [new _ChargeNoticePeriodAndETF()];
		super.create();
	}
	
}