package fees;

import firetongue.Replace;
import front.move.IsAdressElligible;
import front.move._AskForOTO;
import haxe.Json;
import tickets._CreateTwoOneTwo;
import tstool.layout.History.Interactions;
import tstool.process.Action;
import tstool.utils.Constants;
import winback.CheckFWAElligibility;

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
	var noticePeriodMinimalDate:Date;
	var valuesToStore:Map<String, Dynamic>;
	override public function create():Void
	{
		valuesToStore = [];
		whyLeave = Main.HISTORY.findValueOfFirstClassInHistory(Intro, Intro.WHY_LEAVE).value;
		#if debug
		trace("create::whyLeave", whyLeave );
		#end
		//elligibleAtAdress = Main.HISTORY.isClassInteractionInHistory(IsAdressElligible, Yes);
		
		notElligibleAtAdress = ((whyLeave == Intro.NOT_ELLIGIBLE && Main.HISTORY.isClassInteractionInHistory(CheckFWAElligibility, Mid))|| Main.HISTORY.isClassInteractionInHistory(IsAdressElligible, No));
		#if debug
		trace("create::notElligibleAtAdress", notElligibleAtAdress );
		#end
		
		isTerminationStandard =  !(whyLeave == Intro.MOVE_LEAVE_CH || notElligibleAtAdress);
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
		
		parseDates( Main.HISTORY.findFirstStepsClassInHistory(_InputDates).values );
		computeFees();
		buildDetailReport();
		super.create();
		this.details.text = _detailTxt;
		//this.question.text = _titleTxt;
	}
	
	function buildDetailReport()
	{
		var jsonDetails = Json.parse(_detailTxt);
		//var jsonTitle = Json.parse(_titleTxt);
		
		var moveKeep_txt = jsonDetails.moveKeep;
		var standard_txt = jsonDetails.standard;
		var nonStandard_txt = jsonDetails.nonStandard;
		var capETF_txt = jsonDetails.capETF;
		var fullETF_txt = jsonDetails.fullETF;
		var noticeNotRepected_txt = jsonDetails.noticeNotRepected;
		var cancellationFees_txt = jsonDetails.cancellationFees;
		var waiveETF_txt = jsonDetails.waiveETF;
		
		var gracePeriod_txt = jsonDetails.gracePeriod;
		var boxSent_txt = jsonDetails.boxSent;
		var lineActivated_txt = jsonDetails.lineActivated;
		//var refundActivation_txt = jsonDetails.refundActivation;
		//var main_txt = jsonTitle.main;
		var totalFees_txt = jsonDetails.totalFees;
		var refundActivation_txt = jsonDetails.refundActivation;
		
		var finalDetailTxt = "";
		//var finalTitleTxt = main_txt + "\n" + Replace.flags(totalFees_txt, ["<TOTAL_FEES>"], [Std.string(totalFees)]);
		
		if (moveAdminFees == 0)
		{
			
			if (waiveETF)
			{
				valuesToStore.set("Refund Activation Fees", refundActivationFees);
				valuesToStore.set("Waive ETF", true);
				if (isTelesales){
					valuesToStore.set("Telessales or Door 2 door", true);
					finalDetailTxt += gracePeriod_txt + "\n";
					finalDetailTxt += waiveETF_txt+ "\n";
					finalDetailTxt += refundActivationFees? refundActivation_txt:"";
				}
				else if (cancelationFees > 0){
					finalDetailTxt += waiveETF_txt+ "\n";
					finalDetailTxt += Replace.flags(cancellationFees_txt, ["<CANCELATION_FEES>"], [Std.string(cancelationFees)]);
					finalDetailTxt += refundActivationFees? "\n" + refundActivation_txt:"";

				}
				else{
					#if debug
					finalDetailTxt += "COMPUTER FAILED !!! ";
					#end
				}
				
			}
			else{
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
					valuesToStore.set("Termination is standard", true);
					valuesToStore.set("ETF", finalETF);
					
				}
				else{
					valuesToStore.set("Termination is standard", false);
					valuesToStore.set("ETF", finalETF);
					finalDetailTxt += Replace.flags(nonStandard_txt, ["<DATE_ACTIVATION>", "<DATE_TERMINATION>"], ['${activationDate.getDate()}.${activationDate.getMonth()+1}.${activationDate.getFullYear()}', '${termDate.getDate()}.${termDate.getMonth()+1}.${termDate.getFullYear()}']);
					finalDetailTxt += "\n" + Replace.flags(capETF_txt, ["<FINAL_ETF>", "<FULL_ETF>"], [Std.string(finalETF), Std.string(fullETF)]);
				}
				if (!noticePeriodRespected)
				{
					var notice = Std.string(noticePeriodMinimalDate.getDate()) +"." + Std.string(noticePeriodMinimalDate.getMonth() + 1) + "." + Std.string(noticePeriodMinimalDate.getFullYear());
					finalDetailTxt += "\n" + Replace.flags(noticeNotRepected_txt, ["<NOTICE_DAYS>", "<NOTICE_DATE>", "<NOTICE_FEES>"], ['$noticePeriodInDays', notice, '$noticePeriodFees']);
					valuesToStore.set("Minimum notice date", notice);
					valuesToStore.set("Notice period", noticePeriodInDays);
					valuesToStore.set("Notice non respected fees", noticePeriodFees);
				}
			}
			
		}else{
			finalDetailTxt = Replace.flags(moveKeep_txt, ["<FEES>"], [Std.string(moveAdminFees)]);
			valuesToStore.set("Move administration fees", moveAdminFees);
		}
		valuesToStore.set("TOTAL TO PAY", totalFees);
		
		_detailTxt = finalDetailTxt;
		//_titleTxt = finalTitleTxt;
	}
	override public function onClick():Void
	{
		//this._nexts = [{step: Main.HISTORY.isClassInteractionInHistory(IsAdressElligible, Yes)? TestSendTemplate: _CreateTwoOneTwo , params: []}];
		this._nexts = [{step: Main.HISTORY.isClassInteractionInHistory(IsAdressElligible, Yes)? _AskForOTO: _CreateTwoOneTwo , params: []}];
		super.onClick();
	}
	function parseDates( values:Map<String,Dynamic> )
	{
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
		var nowRoundMilli:Float = Date.now().getTime() - (Date.now().getTime() % Constants.ONE_DAY_MILLI);
		//isActivatedLessThanMonth = (nowRoundMilli - activationDate.getTime() < Constants.ONE_MONTH_MILLI);
		
		deltaTerminationActivationMilli = termDate.getTime() - activationDate.getTime();
		deltaDatesMonth = Math.floor(deltaTerminationActivationMilli / _InputDates.ONE_MONTH);
		#if debug
		trace("parseDates::deltaDatesMonth", deltaDatesMonth );
		#end
		noticePeriodInDays = isTerminationStandard? 60 : 30;
		#if debug
		trace("parseDates::noticePeriodInDays", noticePeriodInDays );
		#end
		var normalNoticePeriodMilli = nowRoundMilli + (noticePeriodInDays * ONE_DAY);
		noticePeriodMinimalDate = Date.fromTime(normalNoticePeriodMilli);
		noticePeriodRespected = termDate.getTime() > normalNoticePeriodMilli;
		#if debug
		trace("parseDates::noticePeriodRespected ", noticePeriodRespected  );
		#end
	}
	function computeFees()
	{
		//parseDates();
		
		moveAdminFees = (whyLeave == Intro.MOVE_CAN_KEEP) ? 49.95 : 0;
		fullETF = Math.max(0, 198 - (deltaDatesMonth * 6));
		finalETF = waiveETF ? 0 : (isTerminationStandard? fullETF : Math.min(99.95, fullETF));
		
		noticePeriodFees = (noticePeriodRespected )? 0 : (isTerminationStandard ? 59.95: 39.95);
		cancelationFees = isBoxNOTSent ? 199.95 : 0;
		totalFees = moveAdminFees>0 ? moveAdminFees: finalETF + noticePeriodFees + cancelationFees;
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