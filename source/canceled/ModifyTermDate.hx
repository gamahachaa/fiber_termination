package canceled;

import fees._InputDates;
import fees._TotalFees;
import js.Browser;
import regex.ExpReg;
import tstool.process.ActionMultipleInput;
import tstool.process.Process;
using  regex.ExpReg;

/**
 * ...
 * @author bb
 */
class ModifyTermDate extends ActionMultipleInput 
{
	public static inline var ORDER_DATE:String = "Oderdate";
	public static inline var DAY_TERM_WAS_REQUESTED:String = "Datetheterminationwasrequested";
	public static inline var ACTUAL_REQUESTED_TERM_DATE:String = "Previouscancelationdate";
	public static inline var NEW_WISHED_TERM_DATE:String = "Newwhishedcancelationdate";
	public static inline var NOTICE_PERIOD:String = "NoticePeriod";
	public static inline var PREVIOUS_FEES:String = "Feesforshortnotice";
	static inline var DATES_DICT:String = "dates";
	static inline var DATA_DICT:String = "data";

	public function new ()
	{
		super(
		[
		{
			ereg: ExpReg.DATE_REG.STRING_TO_REG(),
			
			input:{
				width:250,
				
				prefix: ORDER_DATE,
				position: [bottom, left]
			}
		},
		{
			ereg: ExpReg.DATE_REG.STRING_TO_REG(),
			input:{
				width:300,
				
				prefix: DAY_TERM_WAS_REQUESTED,
				buddy: ORDER_DATE,
				position: [top, right]
			}
		},
		{
			ereg: ExpReg.DATE_REG.STRING_TO_REG(),
			input:{
				width:450,
				
				prefix: ACTUAL_REQUESTED_TERM_DATE,
				buddy: DAY_TERM_WAS_REQUESTED,
				position: [top, right]
			}
		}
		,
		{
			ereg: ~/(30|60)/, 
			input:{
				width:250,
				
				prefix: NOTICE_PERIOD,
				buddy: ORDER_DATE,
				position: [bottom, left]
			}
		},
		{
			ereg: ExpReg.FEES,
			input:{
				width:350,
				
				prefix: PREVIOUS_FEES,
				buddy: NOTICE_PERIOD,
				position: [top, right]
			}
		},
		{
			ereg: ExpReg.DATE_REG_START_END.STRING_TO_REG(), 
			input:{
				width:250,
				
				prefix:NEW_WISHED_TERM_DATE,
				buddy: NOTICE_PERIOD,
				position: [bottom, left]
			}
		}
		]
		);
	}
	
	
	override public function onClick():Void
	{
		if (validate())
		{
			Browser.document.removeEventListener("paste", onPaste);
			this._nexts = [{step: getNext(), params: []}];
			super.onClick();
		}
	}
	inline function getNext():Class<Process>{
		return ComputeAdditionalFees;
	}
	override public function create():Void 
	{
		super.create();
		//var parser = new VTIdataParser(super_office_termination);
		//parser.signal.add( onVtiAccountParsed );
		Browser.document.addEventListener("paste", onPaste);
	}
	
	function onPaste(e):Void 
	{
		var content = e.clipboardData.getData("text/plain");
		var previousSO:Map<String,Map<String,String>> = parseSOTermination(content);
		#if debug
		trace("canceled.ComputeAdditionalFees::onPaste::previousSO", previousSO );
		trace("canceled.ComputeAdditionalFees::onPaste::NOTICE_PERIOD", NOTICE_PERIOD, previousSO.get(DATA_DICT).get(_TotalFees.Noticeperiod) );
		trace("canceled.ComputeAdditionalFees::onPaste::PREVIOUS_FEES", PREVIOUS_FEES, previousSO.get(DATA_DICT).get(_TotalFees.Noticenonrespectedfees) );
		
		#end
		var feesForNoticePeriod = previousSO.get(DATA_DICT).get(_TotalFees.Noticenonrespectedfees) == null ? "0": previousSO.get(DATA_DICT).get(_TotalFees.Noticenonrespectedfees);
		var terminationWasStandard = previousSO.get(DATA_DICT).get(_TotalFees.Terminationisstandard) == "true";
		var dateOfRequestTab = previousSO.get(DATES_DICT).get(Intro.SWISS_TIME).split("-");
		var dayOfRequest = dateOfRequestTab[2].split(" ")[0];
		var dateOfRequest:String = '$dayOfRequest.${dateOfRequestTab[1]}.${dateOfRequestTab[0]}';
		#if debug
		trace("canceled.ModifyTermDate::onPaste::feesForNoticePeriod", feesForNoticePeriod );
		trace("canceled.ModifyTermDate::onPaste::terminationWasStandard", terminationWasStandard );
		#end
		multipleInputs.setInputDefault( ORDER_DATE, previousSO.get(DATES_DICT).get(_InputDates.ORDER_DATE) );
		multipleInputs.setInputDefault( DAY_TERM_WAS_REQUESTED, dateOfRequest);
		multipleInputs.setInputDefault( ACTUAL_REQUESTED_TERM_DATE, previousSO.get(DATES_DICT).get(_InputDates.TERM_DATE));
		multipleInputs.setInputDefault( NOTICE_PERIOD, previousSO.get(DATA_DICT).get(_TotalFees.Noticeperiod));
		multipleInputs.setInputDefault( PREVIOUS_FEES, feesForNoticePeriod);
		if (ExpReg.DATE_REG_START_END.STRING_TO_REG().match(multipleInputs.inputs.get(NEW_WISHED_TERM_DATE).getInputedText())){
			// clear field if pasted string in the field
			multipleInputs.inputs.get(NEW_WISHED_TERM_DATE).clearText();
		}
		
		
	}
	function parseSOTermination(content:String):Map<String,Map<String,String>> 
	{
		//trace(content);
		var t:Array<String> = content.split("\n");
		var previousSO:Map<String,Map<String,String>> = [];
		previousSO.set("dates", []);
		previousSO.set("data", []);
		var swissTimeEreg:EReg = new EReg('(${Intro.SWISS_TIME}) ... (20[0-9]{2}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2})',"gi");
		var orderDateEreg:EReg = new EReg('(${_InputDates.ORDER_DATE}) ... ([0-9]{2}\\.[0-9]{2}\\.20[0-9]{2})',"gi");
		var termDateEreg:EReg = new EReg('(${_InputDates.TERM_DATE}) ... ([0-9]{2}\\.[0-9]{2}\\.20[0-9]{2})',"gi");
		var noticePeriodEreg:EReg = new EReg('(${_TotalFees.Noticeperiod}) ... (30|60)',"gi");
		var noticeNonRespectedFees:EReg = new EReg('(${_TotalFees.Noticenonrespectedfees}) ... ([0-9.]+)',"gi");
		var terminationIsStandard:EReg = new EReg('(${_TotalFees.Terminationisstandard}) ... (false|true)',"gi");
		 
		for (i in t)
		{
			if (swissTimeEreg.match(i)) previousSO.get(DATES_DICT).set(Intro.SWISS_TIME, swissTimeEreg.matched(2));
			if (orderDateEreg.match(i)) previousSO.get(DATES_DICT).set(_InputDates.ORDER_DATE, orderDateEreg.matched(2));
			if (termDateEreg.match(i)) previousSO.get(DATES_DICT).set(_InputDates.TERM_DATE, termDateEreg.matched(2));
			if (noticePeriodEreg.match(i)) previousSO.get(DATA_DICT).set(_TotalFees.Noticeperiod, noticePeriodEreg.matched(2));
			if (noticeNonRespectedFees.match(i)) previousSO.get(DATA_DICT).set(_TotalFees.Noticenonrespectedfees, noticeNonRespectedFees.matched(2));
			if (terminationIsStandard.match(i)) previousSO.get(DATA_DICT).set(_TotalFees.Terminationisstandard, terminationIsStandard.matched(2));
		}
		//#if debug
		//trace("tstool.utils.VTIdataParser::parseSOTermination::previousSO", previousSO );
		//#end
		return previousSO;
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