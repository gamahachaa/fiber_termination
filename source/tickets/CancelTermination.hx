package tickets;

import canceled.CaptureTerminationOperator;
import flow._AddMemoVti;
import tstool.process.ActionTicket;
import tstool.salt.SOTickets;
//using StringTools;

/**
 * ...
 * @author bb
 */
class CancelTermination extends ActionTicket 
{

	public function new() 
	{
		var ticket = SOTickets.FIX_641_CANCEL;
		var data = Main.HISTORY.findValueOfFirstClassInHistory(CaptureTerminationOperator, CaptureTerminationOperator.TEM_OPERATOR);
		#if debug
		trace("tickets.CancelTermination::CancelTermination::data", data );
		#end
		if (Main.HISTORY.isClassInteractionInHistory(CaptureTerminationOperator, Yes) && data.exists && StringTools.trim(data.value) !="" )
		{
			ticket.desc = " OPERATED BY " + data.value;
		}
		else{
			 ticket.desc = " NOT TREATED YET";
		}
		
		super(ticket);
		
	}
	
	override public function onClick():Void
	{
		this._nexts = [{step: _AddMemoVti, params: []}];
		super.onClick();
	}
	
}