package bo;

import tstool.process.Action;
import tstool.process.Process;

/**
 * ...
 * @author bb
 */
class _AskCustomerReturnBox extends Action 
{

	public function new(?nexts:Array<Process>) 
	{
		super();
		this._nextProcesses = nexts;
	}
	
}