package tickets;

import firetongue.Replace;
import flow._AddMemoVti;
import front.capture._TransferToWB;
import haxe.Json;
import lime.system.Clipboard;
import tstool.layout.History;
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
	var canTranfer:Bool;
	public function new() 
	{
		#if debug
		super(SOTickets.FIX_641_NONTECH); 
		#else
		var issue = Main.HISTORY.findValueOfFirstClassInHistory(Intro, Intro.WHY_LEAVE).value;
		var ticket = if (issue == Intro.PRODUCTTECHSPECS || issue == Intro.NOT_ELLIGIBLE || issue == Intro.TECH_ISSUES){
			SOTickets.FIX_641_TECH;
		}else{
			SOTickets.FIX_641_NONTECH;
		}
		
		super(ticket); 
		#end
		var detailTextObj:Dynamic = Json.parse(_detailTxt);
		var titleTextObj:Dynamic = Json.parse(_titleTxt);
		var start =    Constants.FIBER_WINBACK_OPEN_UTC_FLOAT +1;
		var end = Constants.FIBER_WINBACK_CLOSE_UTC_FLOAT +1;
		canTranfer = DateToolsBB.isUTCDayTimeFloatInRange(Constants.FIBER_WINBACK_DAYS_OPENED_RANGE, start, end );
		
		var startString = prepareHourFromFloat(start);
		var endString = prepareHourFromFloat(end);
				
	}
	override public function onClick():Void
	{

		this._nexts = [{step: canTranfer ? _TransferToWB: _AddMemoVti, params: []}];
		//Clipboard.text = History.stripTags(this.text,["\t", "\n"]);
		//Clipboard.text = Main.HISTORY.prepareClipboard( "WINBACK-TRANSFER\n" + this.memoTxtArea.getInputedText() );
		super.onClick();
	}
	inline function prepareHourFromFloat(f:Float)
	{
		var s = Std.string(f);
		var o ="";
		if (s.indexOf(".")>-1)
		{
			  o = s.split(".").join("h");
		}
		else{
			o = s + "h0";
		}
		return o + "0";
	}
	
}