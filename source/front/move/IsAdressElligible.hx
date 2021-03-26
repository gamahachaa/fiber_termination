package front.move;

import fees._InputDates;
import front.capture._TransferToWB;
import tickets._CreateTicketSixForOne;
import tstool.process.Triplet;
import tstool.salt.Agent;
import tstool.utils.Constants;
import tstool.utils.DateToolsBB;
//import layout.LoginCan;
import tstool.MainApp;
import tstool.process.Triplet;

/**
 * ...
 * @author bb
 */
class IsAdressElligible extends Triplet 
{

override public function onYesClick():Void
	{
		this._nexts = [{step: _InputDates, params: []}];
		super.onYesClick();
	}
	override public function onNoClick():Void
	{
		this._nexts = [{step: _InputDates, params: []}];
		super.onNoClick();
	}
	override public function onMidClick():Void
	{
		var now = Date.now();
		var canTranfer = DateToolsBB.isWithinDaysString(Constants.FIBER_WINBACK_DAYS_OPENED_RANGE, now) && DateToolsBB.isWithinHours(Constants.FIBER_WINBACK_OPEN_UTC, Constants.FIBER_WINBACK_CLOSE_UTC, now);
		this._nexts = [{step: MainApp.agent.isMember(Agent.WINBACK_GROUP_NAME) ? _InputDates: canTranfer? _TransferToWB : _CreateTicketSixForOne, params: []}];
		super.onMidClick();
	}
	
}