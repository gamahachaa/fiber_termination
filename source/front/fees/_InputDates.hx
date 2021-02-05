package front.fees;

import flow.Intro;
import tstool.process.ActionMultipleInput;
import tstool.process.Process;

/**
 * ...
 * @author bb
 */
class _InputDates extends ActionMultipleInput 
{
	static inline var ORDER_DATE:String = Main.tongue.get("$front.fees._InputDates1_TITLE", "values");
	static inline var ACTIVATION_DATE:String = Main.tongue.get("$front.fees._InputDates2_TITLE", "values");
	static inline var TERM_DATE:String = Main.tongue.get("$front.fees._InputDates3_TITLE", "values");
	static inline var DATE_REG:String = "^[0-3]?[0-9]{1}.(0|1)?[0-9]{1}.20(1|2)[0-9]{1}$";
	public function new ()
	{
		super(
		[{
			ereg: new EReg(DATE_REG,"i"),
			input:{
				width:250,
				prefix:ORDER_DATE,
				debug: "01.01.2021",
				position: [bottom, left]
			}
		},
		{
			ereg: new EReg(DATE_REG,"i"),
			input:{
				width:250,
				prefix:ACTIVATION_DATE,
				buddy: ORDER_DATE,
				debug: "01.02.2021",
				position: [bottom, left]
			}
		},
		{
			ereg: new EReg(DATE_REG,"i"),
			input:{
				width:250,
				prefix:TERM_DATE,
				buddy: ACTIVATION_DATE,
				debug: "01.03.2021",
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
	inline function getNext():Class<Process>
	{
		return if (Main.HISTORY.findValueOfFirstClassInHistory(Intro,Intro.MOVE_CAN_KEEP){
			_InformChargeFortyNine;
		}
		
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