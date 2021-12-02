package fees;

import flow.End;
import Intro;
import front.move.IsAdressElligible;
//import front.move.IsAdressElligible;
import tstool.layout.History.Interactions;
//import tstool.process.ActionMultipleInput;
import tstool.process.DescisionMultipleInput;
import tstool.process.Process;
import tstool.utils.Constants;
import tstool.utils.ExpReg;

/**
 * ...
 * @author bb
 */
class _InputDates extends DescisionMultipleInput
{
	static public inline var ORDER_DATE:String = "ORDER DATE";
	static public inline var ACTIVATION_DATE:String = "ACTIVATION DATE";
	static public inline var TERM_DATE:String = "TERM DATE";
	static var DATE_REG:String = ExpReg.DATE_REG;
	var orderInputString:String;
	var activationDate:Date;
	var termDate:Date;
	var deltaNowActivationMilli:Float;
	public static inline var ONE_MONTH:Float = Constants.ONE_MONTH_MILLI;

	public function new ()
	{
		super(
		[{
			ereg: new EReg(DATE_REG,"i"),
			input:{
				width: 250,
				prefix: ORDER_DATE,
				debug: "01.12.2020",
				position: [bottom, left]
			}
		},
		{
			ereg: new EReg(DATE_REG,"i"),
			input:{
				width: 250,
				prefix: ACTIVATION_DATE,
				buddy: ORDER_DATE,
				debug: "01.01.2021",
				position: [bottom, left],
				mustValidate: [Yes]
			}
		},
		{
			ereg: new EReg(DATE_REG,"i"),
			input:{
				width: 250,
				prefix: TERM_DATE,
				buddy: ACTIVATION_DATE,
				debug: "10.04.2022",
				position: [bottom, left]
			}
		}
		]
		);
	}
	
	
	/****************************
	* Needed for validation
	*****************************/
	override public function onYesClick():Void
	{
		if (validateYes()){
			this._nexts = [{step: getNext(), params: []}];
			super.onYesClick();
		}	
	}
	override public function onNoClick():Void
	{
		if (validateNo()){
			this._nexts = [{step: getNext(), params: []}];
			super.onNoClick();
		}
	}
	override public function create()
	{
		super.create();
		#if debug
		trace("fees._InputDates::create");
		#end
		if (Main.HISTORY.findValueOfFirstClassInHistory(Intro, Intro.WHY_LEAVE ).value == Intro.PLUG_IN_USE)
		this.btnYes.visible = false;
	}
	
	inline function getNext():Class<Process>
	{
		//return if ( deltaNowActivationMilli > ONE_MONTH )
		return if ( 
			Main.HISTORY.findValueOfFirstClassInHistory(Intro, Intro.WHY_LEAVE ).value == Intro.MOVE_CAN_KEEP &&
			Main.HISTORY.isClassInteractionInHistory(IsAdressElligible, Yes)
		)
		{
			_TotalFees;
		}
		else{
			//IsDoorToDoor;
			HasMobileDiscount;
		}	
	}
	
	
}