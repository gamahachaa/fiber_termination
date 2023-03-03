package tickets;

//import End;
import flow._AddMemoVti;
import tstool.process.ActionTicket;
import tstool.salt.SOTickets;

/**
 * ...
 * @author bb
 */
class _CreateTwoOneThree extends ActionTicket
{

	public function new()
	{
		var ticket = SOTickets.FIX_213;
		if (Main.customer.contract.service == Office)
		{
			ticket.queue = SOTickets.FIBER_SOHO_MOVE_SO;
		}
		super(ticket);
	}
	override public function onClick():Void
	{
		this._nexts = [{step: _AddMemoVti, params: []}];
		super.onClick();
	}
}