package front.capture;

import firetongue.Replace;
import flixel.FlxSubState;
import flow.End;
import tickets._CreateTicketSixForOne;
import tstool.process.Descision;
import tstool.utils.Constants;
import tstool.utils.DateToolsBB;
//import tstool.process.Action;
//import tstool.process.ActionMemo;

/**
 * ...
 * @author bb
 */
class _TransferToWB extends Descision 
{
	override public function create():Void{
		
		
		this._detailTxt = Replace.flags(_detailTxt, ["<START>", "<END>"], [Std.string(Constants.FIBER_WINBACK_OPEN_UTC + 1), Std.string(Constants.FIBER_WINBACK_OPEN_UTC + 1)]);
		super.create();
	}
	override public function onYesClick():Void
	{
		this._nexts = [{step: End}];
		super.onYesClick();
	}
	override public function onNoClick():Void
	{
		this._nexts = [{step: _CreateTicketSixForOne}];
		super.onNoClick();
	}
}