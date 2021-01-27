package bo;

import tstool.process.ActionMail;
import tstool.salt.SOTickets;

/**
 * ...
 * @author bb
 */
class _CreateTicketFiveFiveOne extends ActionMail 
{

	public function new() 
		{
			super(SOTickets.FIX_551);
		}
		override public function create():Void
		{
			this._nextProcesses = [new _AskCustomerReturnBox([new _SendReimbursmentForm()])];
			super.create();
		}
	
}