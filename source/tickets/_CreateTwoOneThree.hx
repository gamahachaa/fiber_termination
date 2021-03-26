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
			super(SOTickets.FIX_213);
		}
	override public function onClick():Void
	{
		this._nexts = [{step: _AddMemoVti, params: []}];
		super.onClick();
	}
}