package front.capture;

import firetongue.Replace;
import regex.ExpReg;
import tickets._MigrationTicket;
import tstool.process.ActionMultipleInput;
import tstool.process.Process;
using regex.ExpReg;

/**
 * ...
 * @author bb
 */
class _InputNewContractor extends ActionMultipleInput 
{
	static inline var TYPE_HOME:String = "B2C (Salt Home)";
	static inline var TYPE_PROOFFICE:String = "B2B (Pro Office)";

	public function new ()
	{
		super(
		[{
			ereg: ExpReg.CONTRACTOR_EREG.STRING_TO_REG(),
			input:{
				width:250,
				prefix:"Contractor",
				position: [bottom, left]
			}
		}]
		);
	}
	override public function create():Void 
	{
		var isProOffice:Bool = Main.HISTORY.isClassInteractionInHistory(CaptureDomain, Yes);
		this._titleTxt = Replace.flags(this._titleTxt, ["<TYPE>"], [ isProOffice ? TYPE_HOME:TYPE_PROOFFICE]);
		super.create();
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
		return _MigrationTicket;
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