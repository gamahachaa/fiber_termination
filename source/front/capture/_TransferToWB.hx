package front.capture;

import flixel.FlxSubState;
import flow.End;
import tickets._CreateTicketSixForOne;
import tstool.process.Descision;
//import tstool.process.Action;
//import tstool.process.ActionMemo;

/**
 * ...
 * @author bb
 */
class _TransferToWB extends Descision 
{

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