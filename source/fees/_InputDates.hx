package fees;

import flow.End;
import Intro;
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
	/**
	 * @todo IOmplement update radio to fetch radio translations
	 *
	static public var ORDER_DATE:String = Main.tongue.get("$front.fees._InputDates1_TITLE", "values");
	static public var ACTIVATION_DATE:String = Main.tongue.get("$front.fees._InputDates2_TITLE", "values");
	static public var TERM_DATE:String = Main.tongue.get("$front.fees._InputDates3_TITLE", "values");
	static public var DATE_REG:String = "^[0-3]?[0-9]{1}.(0|1)?[0-9]{1}.20(1|2)[0-9]{1}$";
	*/	
	//static public inline var MOVE_ADMINFEES:String = "moveAdminFees";
	//static public inline var FULL_ETF:String = "FULL_ETF";
	static public inline var ORDER_DATE:String = "ORDER DATE";
	static public inline var ACTIVATION_DATE:String = "ACTIVATION DATE";
	static public inline var TERM_DATE:String = "TERM DATE";
	//static public inline var NOTICE_PERIODFEES:String = "noticePeriod";
	
	static var DATE_REG:String = ExpReg.DATE_REG;
	//var fullETF:Float;
	//var activationDateInput:String;
	//var terminationDateInput:String;
	var orderInputString:String;
	//var moveAdminFees:Float;
	//var noticePeriod:Float;

	var activationDate:Date;
	var termDate:Date;
	//var deltaDatesMonth:Int;
	//var whyLeave:Dynamic;
	//var noticePeriodInDays:Int;
	var deltaNowActivationMilli:Float;
	//var noticePeriodRespected:Bool;
	//var elligibleAtAdress:Bool;
	//static inline var IS_ELLIGIBLE_AT_NEW_ADDRESS:String = "elligibleAtAdress";
	
	
	
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
				prefix: TERM_DATE,
				buddy: ORDER_DATE,
				debug: "10.04.2021",
				position: [bottom, left]
			}
		},
		{
			ereg: new EReg(DATE_REG,"i"),
			input:{
				width: 250,
				prefix: ACTIVATION_DATE,
				buddy: TERM_DATE,
				debug: "01.01.2021",
				position: [bottom, left],
				mustValidate: [Yes]
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
		if (Main.HISTORY.findValueOfFirstClassInHistory(Intro, Intro.WHY_LEAVE ).value == Intro.PLUG_IN_USE)
		this.btnYes.visible = false;
	}
	//inline function getNext():Class<Process>{
		//return CHANGEME;
	//}
	/*
	override public function validateYes():Bool
	{
		return true;
	}
	*/
	/**
	override public function validateNo():Bool
	{
		if(Main.HISTORY.findValueOfFirstClassInHistory(Intro, Intro.WHY_LEAVE ).value == Intro.PLUG_IN_USE)
		return true;
	}
	**/
	
	//override public function onClick():Void
	//{
		//if (validate())
		//{
			//parseDates();
			//this._nexts = [{step: getNext(), params: []}];
			//super.onClick();
		//}
	//}
	inline function getNext():Class<Process>
	{
		//return if ( deltaNowActivationMilli > ONE_MONTH )
		return if ( Main.HISTORY.findValueOfFirstClassInHistory(Intro, Intro.WHY_LEAVE ).value == Intro.MOVE_CAN_KEEP )
		{
			_TotalFees;
		}
		else{
			IsDoorToDoor;
		}	
	}
	//function parseDates()
	//{
		//var activationDateInput = this.multipleInputs.inputs.get(ACTIVATION_DATE).getInputedText();
		//var activationDateArray = activationDateInput.split(".");
		//activationDate = new Date(Std.parseInt(activationDateArray[2]), Std.parseInt(activationDateArray[1])-1, Std.parseInt(activationDateArray[0]), 0, 0, 0);
		//
		//var nowRoundMilli = Date.now().getTime() - (Date.now().getTime() % Constants.ONE_DAY_MILLI);
		//deltaNowActivationMilli = nowRoundMilli - activationDate.getTime();
		//
//
	//}
	//function computeFees()
	//{
		//fullETF = Math.max(0, 198 - (deltaDatesMonth * 6));
		//moveAdminFees = (whyLeave == Intro.MOVE_CAN_KEEP) ? 49.95 : 0;
		//noticePeriod = (noticePeriodRespected )? 0 :(whyLeave == Intro.NO_MORE || whyLeave == Intro.PLUG_IN_USE )? 59.95; 39.95;
	//}
	
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