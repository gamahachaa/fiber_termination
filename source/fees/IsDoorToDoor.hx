package fees;

import tstool.process.Descision;
import tstool.process.Process;
import tstool.utils.Constants;

/**
 * ...
 * @author bb
 */
class IsDoorToDoor extends Descision 
{
	
	override public function onYesClick():Void
	{
		
		this._nexts = [{step: getNext(true), params: []}];
		super.onYesClick();
	}
	override public function onNoClick():Void
	{
		this._nexts = [{step: getNext(false), params: []}];
		super.onNoClick();
	}
	
	function getNext( isDoorToDoor:Bool ):Class<Process>
	{
		var inputDates = Main.HISTORY.findFirstStepsClassInHistory(_InputDates);
		var isActivated =  inputDates.interaction == Yes;
		var orderDateInput = inputDates.values.get(_InputDates.ORDER_DATE);
		var terminationDateInput = inputDates.values.get(_InputDates.TERM_DATE);
		//orderInputString = inputDateValues.get(_InputDates.ORDER_DATE);
		var dateSeparator = orderDateInput.indexOf(".") > -1 ? ".": "/";
		var orderDateTab = orderDateInput.split(dateSeparator);
		var orderDate = new Date(Std.parseInt(orderDateTab[2]), Std.parseInt(orderDateTab[1])-1, Std.parseInt(orderDateTab[0]), 0, 0, 0);
		
		dateSeparator = terminationDateInput.indexOf(".") > -1 ? ".": "/";
		var termDateTab = terminationDateInput.split( dateSeparator );
		var termDate = new Date(Std.parseInt(termDateTab[2]), Std.parseInt(termDateTab[1]) - 1, Std.parseInt(termDateTab[0]), 0, 0, 0);
		//var nowRoundMilli:Float = Date.now().getTime() - (Date.now().getTime() % Constants.ONE_DAY_MILLI);
		//isActivatedLessThanMonth = (nowRoundMilli - activationDate.getTime() < Constants.ONE_MONTH_MILLI);
		var isDoorToDoorGrace = (termDate.getTime() - orderDate.getTime()) < Constants.ONE_DAY_MILLI * 30;
		#if debug
		trace("fees.IsDoorToDoor::getNext::isDoorToDoor", isDoorToDoor );
		trace("fees.IsDoorToDoor::getNext::isDoorToDoorGrace", isDoorToDoorGrace );
		trace("fees.IsDoorToDoor::getNext::isActivated", isActivated );
		#end
		return if (isDoorToDoor && isDoorToDoorGrace){
			IsActivationFeesPaid;
		}
		else{
			if (isActivated){
				_TotalFees;
			}
			else{
				IsBoxAlreadySent;
			}
		}
		//deltaDatesMonth = Math.floor(deltaTerminationActivationMilli / _InputDates.ONE_MONTH);
		//noticePeriodInDays = isTerminationStandard? 60 : 30;
		//var normalNoticePeriodMilli = nowRoundMilli + (noticePeriodInDays * ONE_DAY);
		
		//noticePeriodRespected = termDate.getTime() > normalNoticePeriodMilli;
	}
}