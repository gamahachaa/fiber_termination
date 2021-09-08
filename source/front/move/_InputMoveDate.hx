package front.move;

import tstool.layout.History.Interactions;
import tstool.process.ActionMultipleInput;
import tstool.process.Process;
import tstool.utils.ExpReg;

/**
 * ...
 * @author bb
 */
class _InputMoveDate extends ActionMultipleInput
{
	static inline var MOVE_DATE:String = "MoveDate";

	public function new ()
	{
		super(
			[
		{
			ereg: new EReg(ExpReg.DATE_REG,"i"),
			input:{
				width:250,
				prefix:MOVE_DATE,
				position: [bottom, left]
			}
		}]
		);
	}

	override public function onClick():Void
	{
		if (validate())
		{
			this._nexts = [ {step: getNext(), params: []}];
			super.onClick();
		}
	}
	inline function getNext():Class<Process>
	{
		return _AskForOTO;
	}
	override public function pushToHistory(buttonTxt:String, interactionType:Interactions,?values:Map<String,Dynamic>=null):Void
	{
		var date = multipleInputs.getText(MOVE_DATE);
		var reverseDate = "";
		var t = [];
		if (date.indexOf(".") == -1)
		{
			t = date.split("/");
		}
		else{
			t = date.split(".");
		}
		t.reverse();
		reverseDate = t.join("-");
		date = '$date ( $reverseDate in VTI move )';
		#if debug
		trace("front.move._InputMoveDate::pushToHistory::date", date );
		#end
		super.pushToHistory(buttonTxt, interactionType, [ MOVE_DATE => date]);
	}
	/****************************
	* Needed only for validation
	*****************************/
	/*
	override public function validate():Bool
	{
		return true;
	}
	*/

}