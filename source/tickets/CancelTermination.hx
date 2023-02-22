package tickets;

import flow._AddMemoVti;
import tstool.process.ActionTicket;
import tstool.salt.SOTickets;

/**
 * ...
 * @author bb
 */
class CancelTermination extends ActionTicket 
{

	public function new() 
	{
		super(SOTickets.FIX_641_CANCEL);
	}
	
	override public function onClick():Void
	{
		this._nexts = [{step: _AddMemoVti, params: []}];
		super.onClick();
	}
	
}