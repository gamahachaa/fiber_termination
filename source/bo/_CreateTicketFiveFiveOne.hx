package bo;

import tstool.process.ActionTicket;
import tstool.salt.SOTickets;

/**
 * ...
 * @author bb
 */
class _CreateTicketFiveFiveOne extends ActionTicket 
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