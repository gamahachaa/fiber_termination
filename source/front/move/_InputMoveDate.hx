package front.move;

import fees._TotalFees;
import front.capture._TransferToWB;
import tstool.layout.History.Interactions;
//import tstool.process.ActionMultipleInput;
import tstool.process.DescisionMultipleInput;
import tstool.process.Process;
import tstool.utils.ExpReg;

/**
 * ...
 * @author bb
 */
class _InputMoveDate extends DescisionMultipleInput
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

	override public function onYesClick():Void
	{
		if (validateYes())
		{
			this._nexts = [ {step: getNext(), params: []}];
			super.onYesClick();
		}
	}
	override public function onNoClick():Void
	{
		if (validateNo())
		{
		this._nexts = [ {step: _TransferToWB, params: []}];
		super.onNoClick();
		}
		
	}
	inline function getNext():Class<Process>
	{
		return Main.HISTORY.isClassInHistory(_InputNewHomeContractDetails) ? _TotalFees: _AskForOTO;
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