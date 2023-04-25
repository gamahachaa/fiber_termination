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
		var statusIntro = Main.HISTORY.findValueOfFirstClassInHistory(Intro, Intro.WHY_LEAVE).value;
		var ticket = statusIntro == Intro.MIGRATE_TO_HOME ? SOTickets.FIX_2110_TO_HOME: SOTickets.FIX_2110_TOPROOFFICE;
		super(ticket);
	}
	override public function onClick():Void
	{
		this._nexts = [{step: _AddMemoVti}];
		super.onClick();
	}
}