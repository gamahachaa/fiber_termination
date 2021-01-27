package bo;

import bo.IsOrderFullfiled;
import tstool.process.Triplet;

/**
 * ...
 * @author bb
 */
class WhichSOTicket extends Triplet 
{

	override public function create()
	{
		this._nextNoProcesses = [new _CancelContractChangeOwner()];
		this._nextYesProcesses = [new _RelocationProcess()];
		this._nextMidProcesses= [new IsOrderFullfiled()];
		super.create();
	}
	
}