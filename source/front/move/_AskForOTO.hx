package front.move;

import flow.End;
import tstool.process.ActionMultipleInput;
import tstool.process.Process;
import tstool.utils.ExpReg;

/**
 * ...
 * @author bb
 */
class _AskForOTO extends ActionMultipleInput 
{

	public function new ()
	{
		super(
		[{
			ereg: new EReg(ExpReg.OTO_REG,"i"),
			input:{
				width:250,
				prefix:"OTO_ID",
				position: [bottom, left]
			}
		}]
		);
	}
	
	
	override public function onClick():Void
	{
		if (validate())
		{
			this._nexts = [{step: getNext(), params: []}];
			super.onClick();
		}
	}
	inline function getNext():Class<Process>{
		return CanAgentApplyCharges;
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