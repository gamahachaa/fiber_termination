package front.capture;

import flow.End;
import tstool.process.ActionTicket;
import tstool.salt.SOTickets;


/**
 * ...
 * @author bb
 */
class _TransferToWB extends ActionTicket 
{
	
	//var canTranfer:Bool;
	public function new() 
	{
		
		var issue = Main.HISTORY.findValueOfFirstClassInHistory(Intro, Intro.WHY_LEAVE).value;
		var ticket = if (
							issue == Intro.PRODUCTTECHSPECS || 
							issue == Intro.NOT_ELLIGIBLE || 
							issue == Intro.TECH_ISSUES ||
							issue == Intro.PRODUCTAPPLETV ||
							issue == Intro.PRODUCTVOIP 
							
						){
			SOTickets.FIX_641_TECH;
		}
		else if (issue == Intro.PROMO || issue == Intro.GIBABOX_TEST)
		{
			SOTickets.FIX_641_NONTECH_PROMO;
		}
		else{	
			SOTickets.FIX_641_NONTECH;
		}
		#if debug
		trace("front.capture._TransferToWB::_TransferToWB");
		#end
		super(ticket,true);
	}
	override public function create():Void
	{
		super.create();
		ui.script.visible = false;
	}
	override public function onClick():Void
	{
		this._nexts = [{step: End, params: []}];
		super.onClick();
	}
	
}