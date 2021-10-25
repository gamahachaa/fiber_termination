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
class _CreateTicketSixForOne_open extends ActionTicket 
{
	//var canTranfer:Bool;
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
				
	}
	override public function create():Void
	{
      var start =    Constants.FIBER_WINBACK_OPEN_UTC_FLOAT + DateToolsBB.getSeasonDelta();
		var end = Constants.FIBER_WINBACK_CLOSE_UTC_FLOAT + DateToolsBB.getSeasonDelta();
		var startString = DateToolsBB.prepareHourFromFloat(start);
		var endString = DateToolsBB.prepareHourFromFloat(end);
		
		_detailTxt = Replace.flags(_detailTxt, ["<START>", "<END>", "<NEXT>"], [startString, endString, _buttonTxt]);
		super.create();
		this.details.text = _detailTxt;
	}
	override public function onClick():Void
	{

		this._nexts = [{step: _TransferToWB, params: []}];
		Clipboard.text = Main.HISTORY.prepareClipboard( "WINBACK-TRANSFER\n" + this.memoTxtArea.getInputedText() );
		super.onClick();
	}
	
	override public function pushToHistory(buttonTxt:String, interactionType:Interactions,?values:Map<String,Dynamic>=null):Void
	{
		super.pushToHistory(buttonTxt, interactionType, ["winback" =>"opened"]);
	}
}