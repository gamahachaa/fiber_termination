package front.move;

import fees._InputDates;
import front.capture.CheckContractorVTI;
import front.capture._TransferToWB;
import tickets._CreateTicketSixForOne;
import tstool.process.Process;
import tstool.process.Triplet;
import tstool.process.TripletMultipleInput;
import tstool.salt.Agent;
import tstool.utils.Constants;
import tstool.utils.DateToolsBB;
import tstool.utils.ExpReg;
//import layout.LoginCan;
import tstool.MainApp;
import tstool.process.Triplet;

/**
 * ...
 * @author bb
 */
class IsAdressElligible extends TripletMultipleInput
{

	inline static var ZIP = "Zip";
	inline static var STREET = "Street";
	inline static var NUMBER = "Number";
	inline static var CITY = "City";
	public function new ()
	{
		super(
			[
		{
			ereg: new EReg(ExpReg.ZIP,"i"),
			input:{
				width: 60,
				prefix: ZIP,
				debug: "1020",
				position: [bottom, left],
				mustValidate: [Yes, Mid]
			}
		},
		{
			ereg: new EReg(ExpReg.CITY,"i"),
			input:{
				width: 120,
				prefix: CITY,
				buddy: ZIP,
				debug: "Renens",
				position: [bottom, left],
				mustValidate: [Yes, Mid]
			}
		},
		{
			ereg: new EReg(ExpReg.STREET,"i"),
			input:{
				width: 240,
				prefix: STREET,
				buddy: CITY,
				debug: "Rue du Caudray",
				position: [bottom, left],
				mustValidate: [Yes, Mid]
			}
		}
		,
		{
			ereg: new EReg(ExpReg.ADRESS_NUMBER,"i"),
			input:{
				width: 80,
				prefix: NUMBER,
				buddy: STREET,
				debug: "4",
				position: [bottom, left],
				mustValidate: [Yes, Mid]
			}
		}
			]
		);
	}
	override public function onYesClick():Void
	{
		this._nexts = [{step: _InputMoveDate, params: []}];
		super.onYesClick();
	}
	override public function onNoClick():Void
	{
		this._nexts = [{step: _InputDates, params: []}];
		super.onNoClick();
	}
	override public function onMidClick():Void
	{

		this._nexts = [{step: getNext(), params: []}];
		super.onMidClick();
	}
	inline function getNext():Class<Process>
	{
		var isGigabox = Main.HISTORY.isClassInteractionInHistory(CheckContractorVTI, Mid);
		var isWB = MainApp.agent.isMember(Agent.WINBACK_GROUP_NAME);
		var now = Date.now();
		var canTranfer = !DateToolsBB.isBankHolidayString(Constants.FIBER_WINBACK_BANK_HOLIDAYS) && DateToolsBB.isWithinDaysString(Constants.FIBER_WINBACK_DAYS_OPENED_RANGE, now) && DateToolsBB.isWithinHours(Constants.FIBER_WINBACK_OPEN_UTC, Constants.FIBER_WINBACK_CLOSE_UTC, now);
		return if (isGigabox)
		{
			//trace("giga");
			_InputMoveDate;
		}
		else if (isWB)
		{
			//trace("wb");
			_InputDates;
		}
		else if (canTranfer)
		{
			_TransferToWB;
		}
		else{
			//trace("else", DateToolsBB.isUTCDayTimeFloatInRanges(Constants.FIBER_WINBACK_DAYS_OPENED_RANGE, Main.FIBER_WINBACK_UTC_RANGES));
			!DateToolsBB.isBankHolidayString(Constants.FIBER_WINBACK_BANK_HOLIDAYS)&& DateToolsBB.isUTCDayTimeFloatInRanges(Constants.FIBER_WINBACK_DAYS_OPENED_RANGE, Main.FIBER_WINBACK_UTC_RANGES) ? _TransferToWB: _WinbackIsClosed;
		}
	}

}