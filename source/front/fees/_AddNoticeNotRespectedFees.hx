package front.fees;

import firetongue.Replace;
import Intro;
import tickets._CreateTwoOneTwo;
import tstool.layout.History.Interactions;
import tstool.process.Action;

/**
 * ...
 * @author bb
 */
class _AddNoticeNotRespectedFees extends Action 
{
	var fees:Float;
	override public function create():Void
	{
		var whyLeave = Main.HISTORY.findValueOfFirstClassInHistory(Intro, Intro.WHY_LEAVE).value;
		fees = (whyLeave == Intro.MOVE_CANNOT_KEEP || whyLeave == Intro.MOVE_CAN_KEEP || whyLeave == Intro.MOVE_LEAVE_CH)? 59.95:39.95;
		this._titleTxt = Replace.flags(_titleTxt, ["<FEES>"], [Std.string(fees)]);
		super.create();
	}
	override public function onClick():Void
	{
		this._nexts = [{step: _CreateTwoOneTwo, params: []}];
		super.onClick();
	}
	override public function pushToHistory(buttonTxt:String, interactionType:Interactions,?values:Map<String,Dynamic>=null):Void
	{
		super.pushToHistory(buttonTxt, interactionType, ["Notice not respected fees"=>fees]);
	}
}