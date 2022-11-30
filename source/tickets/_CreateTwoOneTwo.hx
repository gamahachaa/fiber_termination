package tickets;

import flow._AddMemoVti;
import tstool.MainApp;
import tstool.process.ActionTicket;
import tstool.salt.Agent;
import tstool.salt.SOTickets;

/**
 * ...
 * @author bb
 */
class _CreateTwoOneTwo extends ActionTicket 
{

	public function new() 
	{
		var t =  SOTickets.FIX_212;
		//var status = Main.HISTORY.findValueOfFirstClassInHistory(Intro, Intro.WHY_LEAVE).value;
		//var isForWinBack = Intro.WINBACKS.indexOf(Main.HISTORY.findValueOfFirstClassInHistory(Intro, Intro.WHY_LEAVE).value) >-1;
		if (MainApp.agent.isMember(Agent.WINBACK_GROUP_NAME) && Intro.WINBACKS.indexOf(Main.HISTORY.findValueOfFirstClassInHistory(Intro, Intro.WHY_LEAVE).value) >-1)
		{
			t.queue = "FIBER_WINBACK_SO";
		}
		super(t);
		
	}
	override public function onClick():Void
	{
		this._nexts = [{step: _AddMemoVti, params: []}];
		super.onClick();
	}
}