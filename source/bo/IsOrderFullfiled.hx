package bo;

import tstool.process.Descision;

/**
 * ...
 * @author bb
 */
class IsOrderFullfiled extends Descision 
{

	override public function create()
	{
		this._nextNoProcesses = [ new _RequestPartnerCancelation()];
		this._nextYesProcesses = [new _CancelContractForTechReasons()];
		super.create();
	}
	
}