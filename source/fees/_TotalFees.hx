package fees;

import firetongue.Replace;
import flow._AddMemoVti;
import front.move.IsAdressElligible;
import front.move.MoveHow;
import front.move._AskForOTO;
import front.move.vti._SubmitMove;
import haxe.Json;
import tickets._CreateTwoOneThree;
import tickets._CreateTwoOneTwo;
import tstool.MainApp;
import tstool.layout.History.Interactions;
import tstool.process.Action;
import tstool.process.Process;
import tstool.salt.Agent as SaltAgent;
import tstool.utils.Constants;
//import winback.OkForForFWA;

/**
 * ...
 * @author bb
 */
class _TotalFees extends Action
{
	static inline var ONE_DAY:Float = Constants.ONE_DAY_MILLI;
	var whyLeave:String;
	//var elligibleAtAdress:Bool;
	var deltaDatesMonth:Float;
	var noticePeriodRespected:Bool;
	var moveAdminFees:Float;
	var noticePeriodFees:Float;
	var deltaTerminationActivationMilli:Float;
	var termDate:Date;
	var activationDate:Date;
	var waiveETF:Bool;
	var refundActivationFees:Bool;
	var isTerminationStandard:Bool;
	var isBoxNOTSent:Bool;
	var cancelationFees:Float;
	var finalETF:Float;
	var fullETF:Float;
	var noticePeriodInDays:Float;
	var totalFees:Float;
	//var isActivatedLessThanMonth:Bool;
	var notElligibleAtAdress:Bool;
	var isActivated:Bool;
	var isTelesales:Bool;
	var noticePeriodEndOfContractDate:Date;
	var valuesToStore:Map<String, Dynamic>;
	var finalTitleTxt:String;
	var totalFees_txt:String;
	static inline var RefundActivationFees:String = "Refund Activation Fees";
	static inline var WaiveETF:String = "Waive ETF";
	static inline var TelessalesorDoor2door:String = "Telessales or Door 2 door";
	public static inline var Terminationisstandard:String = "Termination is standard";
	static inline var ETF:String = "ETF";
	static inline var Minimumnoticedate:String = "Minimum notice date";
	public static inline var Noticeperiod:String = "Notice period";
	public static inline var Noticenonrespectedfees:String = "Notice non respected fees";
	static inline var Moveadministrationfees:String = "Move administration fees";
	static inline var TOTALTOPAY:String = "TOTAL TO PAY";
	var hasMobileDiscount:Bool;
	var reducedETF:Bool;
	var byebyeCH:Bool;
	var moveToaHomeContractedHome:Bool;
	static inline var TOTAL_FEES_FLAG:String = "<TOTAL_FEES>";
	static inline var CANCELATION_FEES_FLAG:String = "<CANCELATION_FEES>";
	static inline var DATE_ACTIVATION_FLAG:String = "<DATE_ACTIVATION>";
	static inline var DATE_TERMINATION_FLAG:String = "<DATE_TERMINATION>";
	static inline var FULL_ETF_FLAG:String = "<FULL_ETF>";
	static inline var MONTH_LEFT_FLAG:String = "<MONTH_LEFT>";
	static inline var FINAL_ETF_FLAG:String = "<FINAL_ETF>";
	static inline var NOTICE_DAYS_FLAG:String = "<NOTICE_DAYS>";
	static inline var NOTICE_DATE_FLAG:String = "<NOTICE_DATE>";
	static inline var NOTICE_FEES_FLAG:String = "<NOTICE_FEES>";
	static inline var FEES_FLAG:String = "<FEES>";
	
	override public function create():Void
	{
		
		valuesToStore = [];
		/****************************************************
		/****************************************************
		 **** Fetch needed inputs from previous steps *******
		/****************************************************/
		whyLeave = Main.HISTORY.findValueOfFirstClassInHistory(Intro, Intro.WHY_LEAVE).value;
		hasMobileDiscount = Main.HISTORY.isClassInteractionInHistory(HasMobileDiscount, Yes);
		notElligibleAtAdress = Main.HISTORY.isClassInteractionInHistory(IsAdressElligible, No);
		// leaving CH
        byebyeCH = whyLeave == Intro.MOVE_CAN_KEEP && Main.HISTORY.isClassInteractionInHistory(MoveHow, Yes);
		moveToaHomeContractedHome = whyLeave == Intro.MOVE_CAN_KEEP && Main.HISTORY.isClassInteractionInHistory(MoveHow, Mid);
		// outstanding or usual termination
		isTerminationStandard =  !(byebyeCH || notElligibleAtAdress || whyLeave == Intro.NOT_ELLIGIBLE || moveToaHomeContractedHome);
		waiveETF = Main.HISTORY.isClassInHistory(IsActivationFeesPaid);
		refundActivationFees = Main.HISTORY.isClassInteractionInHistory(IsActivationFeesPaid, Yes);
		isBoxNOTSent = Main.HISTORY.isClassInteractionInHistory(IsBoxAlreadySent, No);
		isActivated =  Main.HISTORY.isClassInteractionInHistory(_InputDates, Yes);
        // telesales or door-to-door
		isTelesales = Main.HISTORY.isClassInteractionInHistory(IsDoorToDoor, Yes);
		
		if (Main.HISTORY.isClassInHistory(_InputDates)){
			
			parseDates( Main.HISTORY.findFirstStepsClassInHistory(_InputDates).values );
		}
		computeFees();
		buildDetailReport();
		//
		super.create();
		this.details.text = _detailTxt;
		if (moveAdminFees == 0)
			this.question.text += Constants.SIMPLE_CR + Replace.flags(totalFees_txt, [TOTAL_FEES_FLAG], [Std.string(totalFees)]);
		else 
			this.question.text = Constants.SIMPLE_CR + Replace.flags(totalFees_txt, [TOTAL_FEES_FLAG], [Std.string(totalFees)]);
	}

	function buildDetailReport()
	{
		// split text parts
		var jsonDetails = Json.parse(_detailTxt);
		var returnAppleTV_txt = jsonDetails.returnAppleTV;
		var return_gears_txt = jsonDetails.return_gears;
		var moveKeep_txt = jsonDetails.moveKeep;
		var standard_txt = jsonDetails.standard;
		var nonStandard_txt = jsonDetails.nonStandard;
		var capETF_txt = jsonDetails.capETF;
		var leaveCHF_txt = jsonDetails.leaveCHF;
		var moveToaHomeContractedHome_txt = jsonDetails.moveToaHomeContractedHome;
		var fullETF_txt = jsonDetails.fullETF;
		var noticeNotRepected_txt = jsonDetails.noticeNotRepected;
		var noticeRepected_txt = jsonDetails.noticeRepected;
		var cancellationFees_txt = jsonDetails.cancellationFees;
		var waiveETF_txt = jsonDetails.waiveETF;
		var gracePeriod_txt = jsonDetails.gracePeriod;
		var boxSent_txt = jsonDetails.boxSent;
		var lineActivated_txt = jsonDetails.lineActivated;
		var refundActivation_txt = jsonDetails.refundActivation;
		totalFees_txt = jsonDetails.totalFees;
		
		

		var finalDetailTxt = "";

		if (moveAdminFees == 0)
		{

			if (waiveETF)
			{
				valuesToStore.set(RefundActivationFees, refundActivationFees);
				valuesToStore.set(WaiveETF, true);
				if (isTelesales)
				{
					valuesToStore.set(TelessalesorDoor2door, true);
					finalDetailTxt += gracePeriod_txt + Constants.SIMPLE_CR;
					finalDetailTxt += waiveETF_txt+ Constants.SIMPLE_CR;
					finalDetailTxt += refundActivationFees? refundActivation_txt:"";
				}
				else if (MainApp.agent.isMember(SaltAgent.WINBACK_GROUP_NAME) && cancelationFees > 0)
				{
					finalDetailTxt += waiveETF_txt+ Constants.SIMPLE_CR;
					finalDetailTxt += Replace.flags(cancellationFees_txt, [CANCELATION_FEES_FLAG], [Std.string(cancelationFees)]);
					finalDetailTxt += refundActivationFees? Constants.SIMPLE_CR + refundActivation_txt:"";

				}
				else
				{
					#if debug
					finalDetailTxt += "COMPUTER FAILED !!! ";
					#end
				}

			}
			else
			{
				if (isActivated)
				{
					finalDetailTxt += lineActivated_txt + Constants.SIMPLE_CR;
				}
				else
				{
					finalDetailTxt += boxSent_txt + Constants.SIMPLE_CR;
				}
				if (isTerminationStandard)
				{

					finalDetailTxt += Replace.flags(standard_txt, [DATE_ACTIVATION_FLAG, DATE_TERMINATION_FLAG], ['${activationDate.getDate()}.${activationDate.getMonth()+1}.${activationDate.getFullYear()}', '${termDate.getDate()}.${termDate.getMonth()+1}.${termDate.getFullYear()}']);
					finalDetailTxt += Constants.SIMPLE_CR + Replace.flags(fullETF_txt, [FULL_ETF_FLAG, MONTH_LEFT_FLAG], [Std.string(finalETF), Std.string(deltaDatesMonth)]);
					valuesToStore.set(Terminationisstandard, true);
					valuesToStore.set(ETF, finalETF);

				}
				else
				{
					valuesToStore.set(Terminationisstandard, false);
					valuesToStore.set(ETF, finalETF);
					finalDetailTxt += Replace.flags(nonStandard_txt, [DATE_ACTIVATION_FLAG, DATE_TERMINATION_FLAG], ['${activationDate.getDate()}.${activationDate.getMonth()+1}.${activationDate.getFullYear()}', '${termDate.getDate()}.${termDate.getMonth()+1}.${termDate.getFullYear()}']);
					if ( reducedETF ){
						finalDetailTxt += Constants.DOUBLE_CR + Replace.flags(capETF_txt, [FINAL_ETF_FLAG, FULL_ETF_FLAG], [Std.string(finalETF), Std.string(fullETF)]);
						if(byebyeCH)
							finalDetailTxt += Constants.SIMPLE_CR + leaveCHF_txt;
						else if(moveToaHomeContractedHome) finalDetailTxt += Constants.SIMPLE_CR + moveToaHomeContractedHome_txt; 
						
					}
					else{
						finalDetailTxt += Constants.DOUBLE_CR + Replace.flags(fullETF_txt, [FULL_ETF_FLAG, MONTH_LEFT_FLAG], [Std.string(finalETF), Std.string(deltaDatesMonth)]);
					}
					
				}

			}
			var notice = Std.string(noticePeriodEndOfContractDate.getDate()) +"." + Std.string(noticePeriodEndOfContractDate.getMonth() + 1) + "." + Std.string(noticePeriodEndOfContractDate.getFullYear());
			if (!noticePeriodRespected && !moveToaHomeContractedHome)
			{	
				finalDetailTxt += Constants.DOUBLE_CR + Replace.flags(noticeNotRepected_txt, [NOTICE_DAYS_FLAG, NOTICE_DATE_FLAG, NOTICE_FEES_FLAG], ['$noticePeriodInDays', notice, '$noticePeriodFees']);
				valuesToStore.set(Minimumnoticedate, notice);
				valuesToStore.set(Noticeperiod, noticePeriodInDays);
				valuesToStore.set(Noticenonrespectedfees, noticePeriodFees);
			}
			else if (noticePeriodRespected)
			{
				finalDetailTxt += Constants.DOUBLE_CR + Replace.flags(noticeRepected_txt, [NOTICE_DAYS_FLAG, NOTICE_DATE_FLAG], ['$noticePeriodInDays', notice]);
				valuesToStore.set(Minimumnoticedate, notice);
				valuesToStore.set(Noticeperiod, noticePeriodInDays);
			}
			finalDetailTxt += Constants.DOUBLE_CR + return_gears_txt;
			if (deltaDatesMonth < 13)
			{
				finalDetailTxt += returnAppleTV_txt;
			}
		}
		else
		{
			finalDetailTxt = Replace.flags(moveKeep_txt, [FEES_FLAG], [Std.string(moveAdminFees)]);
			valuesToStore.set(Moveadministrationfees, moveAdminFees);
		}
		valuesToStore.set(TOTALTOPAY, totalFees);
		_detailTxt = finalDetailTxt;
	}
	override public function onClick():Void
	{
		this._nexts = [{step: getNexts(), params: []}];
		super.onClick();
	}
	inline function getNexts():Class<Process>
	{
		return if (Main.HISTORY.isClassInHistory(_AskForOTO))
		{
			 Main.HISTORY.isClassInHistory(_SubmitMove)? _AddMemoVti : _CreateTwoOneThree;
		}
		else{
			_CreateTwoOneTwo;
		}
	}
	/**
	 * @todo split function calc
	 * @param	values
	 * @param	Dynamic
	 */
	function parseDates( values:Map<String,Dynamic> )
	{
		var now = Date.now();
		var thisYear = now.getFullYear();
		var isThisYerBi = (thisYear - 2000) % 4 == 0;
		var monthEnd = isThisYerBi ? [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]: [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
		var activationDateInput = values.get(_InputDates.ACTIVATION_DATE);
		var terminationDateInput = values.get(_InputDates.TERM_DATE);
		var dateSeparator = activationDateInput.indexOf(".") > -1 ? ".": "/";
		var activDateTab = activationDateInput.split(dateSeparator);
		activationDate = new Date(Std.parseInt(activDateTab[2]), Std.parseInt(activDateTab[1])-1, Std.parseInt(activDateTab[0]), 0, 0, 0);
			
		dateSeparator = terminationDateInput.indexOf(".") > -1 ? ".": "/";
		var termDateTab = terminationDateInput.split( dateSeparator );
		termDate = new Date(Std.parseInt(termDateTab[2]), Std.parseInt(termDateTab[1]) - 1, Std.parseInt(termDateTab[0]), 0, 0, 0);
		deltaTerminationActivationMilli = termDate.getTime() - activationDate.getTime();
		deltaDatesMonth = Math.floor(deltaTerminationActivationMilli / _InputDates.ONE_MONTH);
		noticePeriodInDays = isTerminationStandard? 60 : 30;
		var noticePeriodDate:Date =  Date.fromTime(now.getTime() + (noticePeriodInDays * ONE_DAY));
		noticePeriodEndOfContractDate = new Date(noticePeriodDate.getFullYear(), noticePeriodDate.getMonth(), monthEnd[noticePeriodDate.getMonth()], 0, 0, 0);
		noticePeriodRespected = noticePeriodEndOfContractDate.getTime() <= termDate.getTime() ;
	}
	function computeFees()
	{
		// check if B2B
		var domainInteraction: Interactions = if (Main.HISTORY.isClassInHistory(CaptureDomain))
			Main.HISTORY.findFirstStepsClassInHistory(CaptureDomain).interaction;
		else Exit; 
		moveAdminFees = (whyLeave == Intro.MOVE_CAN_KEEP && isTerminationStandard) ? 49.95 : 0;
		fullETF = Math.max(0, 198 - (deltaDatesMonth * 6));
		finalETF = if (waiveETF){
			0;
		}else if (isTerminationStandard){
			fullETF;
		} else if (moveToaHomeContractedHome)
		{
			fullETF / 2;
		}
		else {
			Math.min(99.95, fullETF);
		}
        reducedETF = fullETF != finalETF;
		if (moveToaHomeContractedHome) noticePeriodFees = 0;
		else noticePeriodFees = (noticePeriodRespected )? 0 : (isTerminationStandard ? 2: 1) * (hasMobileDiscount? HasMobileDiscount.MOBILE_DISCOUNT: domainInteraction == Yes ? 59.95: 49.95);
		cancelationFees = isBoxNOTSent ? 199.95 : 0;
		totalFees = moveAdminFees > 0 ? moveAdminFees: finalETF + noticePeriodFees + (MainApp.agent.isMember(SaltAgent.WINBACK_GROUP_NAME)?cancelationFees:0);
		totalFees = Math.fround(totalFees * 100) / 100;
	}

	override public function pushToHistory(buttonTxt:String, interactionType:Interactions,?values:Map<String,Dynamic>=null):Void
	{
		super.pushToHistory(buttonTxt, interactionType, valuesToStore);
	}
}