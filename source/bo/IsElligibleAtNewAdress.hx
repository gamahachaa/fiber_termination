package bo;

import flow._AddMemoVti;
import tstool.process.Descision;

/**
 * ...
 * @author bb
 */
class IsElligibleAtNewAdress extends Descision 
{

	override public function create()
	{
		this._nextNoProcesses = [new flow._AddMemoVti()];
		this._nextYesProcesses = [new flow._AddMemoVti()];
		super.create();
	}
	
}