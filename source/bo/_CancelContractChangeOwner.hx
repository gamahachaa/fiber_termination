package bo;

import flow._AddMemoVti;
import tstool.process.Action;

/**
 * ...
 * @author bb
 */
class _CancelContractChangeOwner extends Action 
{

	override public function create()
	{
		this._nextProcesses = [new _AskCustomerReturnBox([new flow._AddMemoVti()])];
		super.create();
	}
	
}