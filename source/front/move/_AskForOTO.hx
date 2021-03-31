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
	static inline var OTO_ID:String = "OTO_ID";

	public function new ()
	{
		super(
		[{
			ereg: new EReg(ExpReg.OTO_REG,"i"),
			input:{
				width:250,
				prefix:OTO_ID,
				position: [bottom, left]
			}
		}]
		);
	}
	
	
	override public function onClick():Void
	{
		if (validate() || this.multipleInputs.getText(OTO_ID).toLowerCase()=="no oto yet" )
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