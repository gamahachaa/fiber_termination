package front.move;

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