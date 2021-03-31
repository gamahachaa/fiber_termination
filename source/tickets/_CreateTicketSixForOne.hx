package tickets;

import firetongue.Replace;
import flow._AddMemoVti;
import tstool.process.ActionTicket;
import tstool.salt.SOTickets;
import tstool.utils.Constants;
import tstool.utils.DateToolsBB;

/**
 * ...
 * @author bb
 */
class _CreateTicketSixForOne extends ActionTicket 
{
	public function new() 
	{
		super(SOTickets.FIX_641);
	}
	override public function create():Void{
		
		this._detailTxt = Replace.flags(_detailTxt, ["<START>", "<END>"], [Std.string(Constants.FIBER_WINBACK_OPEN_UTC + 1), Std.string(Constants.FIBER_WINBACK_OPEN_UTC + 1)]);
		super.create();
	}
	override public function onClick():Void
	{
		this._nexts = [{step: _AddMemoVti, params: []}];
		super.onClick();
	}
	
}