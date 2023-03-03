package tickets;

import flow._AddMemoVti;
import tstool.process.ActionTicket;
import tstool.salt.SOTickets;

/**
 * ...
 * @author bb
 */
class _MigrationTicket extends ActionTicket 
{

	public function new() 
	{
		var ticket = SOTickets.FIX_2110;
		super(ticket);
	}
	override public function onClick():Void
	{
		this._nexts = [{step: _AddMemoVti}];
		super.onClick();
	}
}