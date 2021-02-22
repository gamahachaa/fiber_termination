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
		override public function create():Void
		{
			this._nextProcesses = [new flow._AddMemoVti()];
			super.create();
		}
}