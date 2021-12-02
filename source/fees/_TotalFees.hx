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
import tstool.salt.Agent;
import tstool.utils.Constants;
import winback.OkForForFWA;

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
	static inline var Terminationisstandard:String = "Termination is standard";
	static inline var ETF:String = "ETF";
	static inline var Minimumnoticedate:String = "Minimum notice date";
	static inline var Noticeperiod:String = "Notice period";
	static inline var Noticenonrespectedfees:String = "Notice non respected fees";
	static inline var Moveadministrationfees:String = "Move administration fees";
	static inline var TOTALTOPAY:String = "TOTAL TO PAY";
	var hasMobileDiscount:Bool;
	var reducedETF:Bool;
	var byebyeCH:Bool;
	var moveToaHomeContractedHome:Bool;
	override public function create():Void
	{
		valuesToStore = [];
		whyLeave = Main.HISTORY.findValueOfFirstClassInHistory(Intro, Intro.WHY_LEAVE).value;
		#if debug
		trace("create::whyLeave", whyLeave );
		#end
		hasMobileDiscount = Main.HISTORY.isClassInteractionInHistory(HasMobileDiscount, Yes);
		//elligibleAtAdress = Main.HISTORY.isClassInteractionInHistory(IsAdressElligible, Yes);

		//notElligibleAtAdress = ((whyLeave == Intro.NOT_ELLIGIBLE && Main.HISTORY.isClassInteractionInHistory(CheckFWAElligibility, Mid))|| Main.HISTORY.isClassInteractionInHistory(IsAdressElligible, No));
		//notElligibleAtAdress = (whyLeave == Intro.FWA_ELLIGIBLE || Main.HISTORY.isClassInteractionInHistory(IsAdressElligible, No));
		notElligibleAtAdress = Main.HISTORY.isClassInteractionInHistory(IsAdressElligible, No);
		#if debug
		trace("create::notElligibleAtAdress", notElligibleAtAdress );
		#end
        //byebyeCH = whyLeave == Intro.MOVE_LEAVE_CH ;
        byebyeCH = whyLeave == Intro.MOVE_CAN_KEEP && Main.HISTORY.isClassInteractionInHistory(MoveHow, Yes);
		moveToaHomeContractedHome = whyLeave == Intro.MOVE_CAN_KEEP && Main.HISTORY.isClassInteractionInHistory(MoveHow, Mid);
		isTerminationStandard =  !(byebyeCH || notElligibleAtAdress || whyLeave == Intro.NOT_ELLIGIBLE || moveToaHomeContractedHome);
		#if debug
		trace("create::isTerminationStandard", isTerminationStandard );
		#end

		waiveETF = Main.HISTORY.isClassInHistory(IsActivationFeesPaid);
		#if debug
		trace("create::waiveETF", waiveETF );
		#end

		refundActivationFees = Main.HISTORY.isClassInteractionInHistory(IsActivationFeesPaid, Yes);
		#if debug
		trace("create::refundActivationFees", refundActivationFees );
		#end

		isBoxNOTSent = Main.HISTORY.isClassInteractionInHistory(IsBoxAlreadySent, No);
		#if debug
		trace("create::isBoxSent", isBoxNOTSent );
		#end

		isActivated =  Main.HISTORY.isClassInteractionInHistory(_InputDates, Yes);
		#if debug
		trace("create::isActivated ", isActivated  );
		#end

		isTelesales = Main.HISTORY.isClassInteractionInHistory(IsDoorToDoor, Yes);
		#if debug
		trace("create::isTelesales", isTelesales );
		#end
        //var cancelationDates = Main.HISTORY.findFirstStepsClassInHistory(_InputDates);
		if (Main.HISTORY.isClassInHistory(_InputDates)){
			
			parseDates( Main.HISTORY.findFirstStepsClassInHistory(_InputDates).values );
		}
		computeFees();
		buildDetailReport();
		super.create();
		this.details.text = _detailTxt;
		if (moveAdminFees == 0)
			this.question.text += "\n" + Replace.flags(totalFees_txt, ["<TOTAL_FEES>"], [Std.string(totalFees)]);
		else 
			this.question.text = "\n" + Replace.flags(totalFees_txt, ["<TOTAL_FEES>"], [Std.string(totalFees)]);
	}

	function buildDetailReport()
	{
		var jsonDetails = Json.parse(_detailTxt);
		//var jsonTitle = Json.parse(_titleTxt);

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
		var cancellationFees_txt = jsonDetails.cancellationFees;
		var waiveETF_txt = jsonDetails.waiveETF;

		var gracePeriod_txt = jsonDetails.gracePeriod;
		var boxSent_txt = jsonDetails.boxSent;
		var lineActivated_txt = jsonDetails.lineActivated;
		//var refundActivation_txt = jsonDetails.refundActivation;
		//var main_txt = jsonTitle.main;
		totalFees_txt = jsonDetails.totalFees;
		var refundActivation_txt = jsonDetails.refundActivation;

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
					finalDetailTxt += gracePeriod_txt + "\n";
					finalDetailTxt += waiveETF_txt+ "\n";
					finalDetailTxt += refundActivationFees? refundActivation_txt:"";
				}
				else if (MainApp.agent.isMember(Agent.WINBACK_GROUP_NAME) && cancelationFees > 0)
				{
					finalDetailTxt += waiveETF_txt+ "\n";
					finalDetailTxt += Replace.flags(cancellationFees_txt, ["<CANCELATION_FEES>"], [Std.string(cancelationFees)]);
					finalDetailTxt += refundActivationFees? "\n" + refundActivation_txt:"";

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
					finalDetailTxt += lineActivated_txt + "\n";
				}
				else
				{
					finalDetailTxt += boxSent_txt + "\n";
				}
				if (isTerminationStandard)
				{

					finalDetailTxt += Replace.flags(standard_txt, ["<DATE_ACTIVATION>", "<DATE_TERMINATION>"], ['${activationDate.getDate()}.${activationDate.getMonth()+1}.${activationDate.getFullYear()}', '${termDate.getDate()}.${termDate.getMonth()+1}.${termDate.getFullYear()}']);
					finalDetailTxt += "\n" + Replace.flags(fullETF_txt, ["<FULL_ETF>", "<MONTH_LEFT>"], [Std.string(finalETF), Std.string(deltaDatesMonth)]);
					valuesToStore.set(Terminationisstandard, true);
					valuesToStore.set(ETF, finalETF);

				}
				else
				{
					valuesToStore.set(Terminationisstandard, false);
					valuesToStore.set(ETF, finalETF);
					finalDetailTxt += Replace.flags(nonStandard_txt, ["<DATE_ACTIVATION>", "<DATE_TERMINATION>"], ['${activationDate.getDate()}.${activationDate.getMonth()+1}.${activationDate.getFullYear()}', '${termDate.getDate()}.${termDate.getMonth()+1}.${termDate.getFullYear()}']);
					if ( reducedETF ){
						finalDetailTxt += "\n\n" + Replace.flags(capETF_txt, ["<FINAL_ETF>", "<FULL_ETF>"], [Std.string(finalETF), Std.string(fullETF)]);
						if(byebyeCH)
							finalDetailTxt += "\n" + leaveCHF_txt;
						else if(moveToaHomeContractedHome) finalDetailTxt += "\n" + moveToaHomeContractedHome_txt; 
						
					}
					else{
						finalDetailTxt += "\n\n" + Replace.flags(fullETF_txt, ["<FULL_ETF>", "<MONTH_LEFT>"], [Std.string(finalETF), Std.string(deltaDatesMonth)]);
					}
					
				}

			} 
			if (!noticePeriodRespected && !moveToaHomeContractedHome)
			{
				var notice = Std.string(noticePeriodEndOfContractDate.getDate()) +"." + Std.string(noticePeriodEndOfContractDate.getMonth() + 1) + "." + Std.string(noticePeriodEndOfContractDate.getFullYear());
				finalDetailTxt += "\n\n" + Replace.flags(noticeNotRepected_txt, ["<NOTICE_DAYS>", "<NOTICE_DATE>", "<NOTICE_FEES>"], ['$noticePeriodInDays', notice, '$noticePeriodFees']);
				valuesToStore.set(Minimumnoticedate, notice);
				valuesToStore.set(Noticeperiod, noticePeriodInDays);
				valuesToStore.set(Noticenonrespectedfees, noticePeriodFees);
			}
			finalDetailTxt += "\n\n" + return_gears_txt;
			if (deltaDatesMonth < 13)
			{
				finalDetailTxt += returnAppleTV_txt;
			}
		}
		else
		{
			finalDetailTxt = Replace.flags(moveKeep_txt, ["<FEES>"], [Std.string(moveAdminFees)]);
			valuesToStore.set(Moveadministrationfees, moveAdminFees);
		}
		valuesToStore.set(TOTALTOPAY, totalFees);
		//finalTitleTxt += "\n\n" + Replace.flags(totalFees_txt, ["<TOTAL_FEES>"], [Std.string(totalFees)]);
		_detailTxt = finalDetailTxt;
		//_titleTxt += finalTitleTxt;
	}
	override public function onClick():Void
	{
		//this._nexts = [{step: Main.HISTORY.isClassInteractionInHistory(IsAdressElligible, Yes)? TestSendTemplate: _CreateTwoOneTwo , params: []}];
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
	function parseDates( values:Map<String,Dynamic> )
	{
		var now = Date.now();
		#if debug
		trace("fees._TotalFees::parseDates::now", now );
		#end
		var thisYear = now.getFullYear();
		#if debug
		trace("fees._TotalFees::parseDates::thisYear ", thisYear  );
		#end
		var isThisYerBi = (thisYear - 2000) % 4 == 0;
		#if debug
		trace("fees._TotalFees::parseDates::isThisYerBi ", isThisYerBi  );
		#end
		var monthEnd = isThisYerBi ? [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]: [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
		#if debug
		trace("fees._TotalFees::parseDates::monthEnd ", monthEnd  );
		#end
		var activationDateInput = values.get(_InputDates.ACTIVATION_DATE);
		var terminationDateInput = values.get(_InputDates.TERM_DATE);
		//orderInputString = inputDateValues.get(_InputDates.ORDER_DATE);
		var dateSeparator = activationDateInput.indexOf(".") > -1 ? ".": "/";
		var activDateTab = activationDateInput.split(dateSeparator);
		activationDate = new Date(Std.parseInt(activDateTab[2]), Std.parseInt(activDateTab[1])-1, Std.parseInt(activDateTab[0]), 0, 0, 0);
			#if debug
			trace("parseDates::activationDate", activationDate );
			#end
		dateSeparator = terminationDateInput.indexOf(".") > -1 ? ".": "/";
		var termDateTab = terminationDateInput.split( dateSeparator );
		termDate = new Date(Std.parseInt(termDateTab[2]), Std.parseInt(termDateTab[1]) - 1, Std.parseInt(termDateTab[0]), 0, 0, 0);
			#if debug
			trace("parseDates::termDate", termDate );
			#end
		//var nowRoundMilli:Float = Date.now().getTime() - (Date.now().getTime() % Constants.ONE_DAY_MILLI);
        //var now = Date.now();
		
		//trace(new Date(Date.now().getFullYear(), Date.now().getMonth() + 1, 0, 0, 0, 0));
		deltaTerminationActivationMilli = termDate.getTime() - activationDate.getTime();
		deltaDatesMonth = Math.floor(deltaTerminationActivationMilli / _InputDates.ONE_MONTH);
			#if debug
			trace("parseDates::deltaDatesMonth", deltaDatesMonth );
			#end
		noticePeriodInDays = isTerminationStandard? 60 : 30;
			#if debug
			trace("parseDates::noticePeriodInDays", noticePeriodInDays );
			#end
		var noticePeriodDate:Date =  Date.fromTime(now.getTime() + (noticePeriodInDays * ONE_DAY));
		#if debug
		trace("fees._TotalFees::parseDates::noticePeriodDate", noticePeriodDate );
		#end
		//var normalNoticePeriodMilli = nowRoundMilli + (noticePeriodInDays * ONE_DAY);
		noticePeriodEndOfContractDate = new Date(noticePeriodDate.getFullYear(), noticePeriodDate.getMonth(), monthEnd[noticePeriodDate.getMonth()], 0, 0, 0);
		//var normalNoticePeriodMilli = endOfTheMonth.getTime() + (noticePeriodInDays * ONE_DAY);
		#if debug
		trace("fees._TotalFees::parseDates::noticePeriodEndOfContractDate", noticePeriodEndOfContractDate );
		#end
		noticePeriodRespected = termDate.getTime() > noticePeriodEndOfContractDate.getTime();
		#if debug
		trace("parseDates::noticePeriodRespected ", noticePeriodRespected  );
		#end
	}
	function computeFees()
	{
		//parseDates();

		//moveAdminFees = (whyLeave == Intro.MOVE_CAN_KEEP && !notElligibleAtAdress) ? 49.95 : 0;
		moveAdminFees = (whyLeave == Intro.MOVE_CAN_KEEP && isTerminationStandard) ? 49.95 : 0;
		fullETF = Math.max(0, 198 - (deltaDatesMonth * 6));
		//finalETF = waiveETF ? 0 : (isTerminationStandard? fullETF : Math.min(99.95, fullETF));
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
		else noticePeriodFees = (noticePeriodRespected )? 0 : (isTerminationStandard ? 2: 1) * (hasMobileDiscount? 39.95:49.95);
		cancelationFees = isBoxNOTSent ? 199.95 : 0;
		totalFees = moveAdminFees > 0 ? moveAdminFees: finalETF + noticePeriodFees + (MainApp.agent.isMember(Agent.WINBACK_GROUP_NAME)?cancelationFees:0);
		//totalFees = moveAdminFees > 0 ? moveAdminFees: finalETF + noticePeriodFees; //removed cancelation fees
		totalFees = Math.fround(totalFees * 100) / 100;
			#if debug
			trace("computeFees::fullETF", fullETF );
			trace("computeFees::finalETF", finalETF );
			trace("computeFees::moveAdminFees", moveAdminFees );
			trace("computeFees::noticePeriodFees", noticePeriodFees );
			trace("computeFees::cancelationFees", cancelationFees );
			trace("computeFees::totalFees", totalFees );
			#end
	}

	override public function pushToHistory(buttonTxt:String, interactionType:Interactions,?values:Map<String,Dynamic>=null):Void
	{

		//super.pushToHistory(buttonTxt, interactionType, [
		//"refundActivationFees" => refundActivationFees,
		//"isTerminationStandard" => isTerminationStandard,
		//"cancelationFees" => cancelationFees,
		//"noticePeriodInDays" => noticePeriodInDays,
		//"noticePeriodFees" => noticePeriodFees,
		//"moveAdminFees" => moveAdminFees,
		//"fullETF" => fullETF,
		//"finalETF" => finalETF,
		//"waiveETF" => waiveETF
		//]);
		super.pushToHistory(buttonTxt, interactionType, valuesToStore);
	}
}