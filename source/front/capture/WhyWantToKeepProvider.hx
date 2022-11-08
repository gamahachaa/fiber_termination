package front.capture;

import date.WorldTimeAPI;
import date.WorldTimeAPI.TimeZone;
import haxe.Json;
import thx.DateTimeUtc;
import tstool.process.Descision;
import tstool.utils.Constants;
import date.DateToolsBB;

/**
 * ...
 * @author bb
 */
class WhyWantToKeepProvider extends Descision 
{
	override public function onYesClick():Void
	{
		this._nexts = [{step: _ChangeWishDate, params: []}];
		super.onYesClick();
	}
	override public function onNoClick():Void
	{
		var canTranfer = DateToolsBB.isServiceOpened(
			Constants.FIBER_WINBACK_BANK_HOLIDAYS,
			Constants.FIBER_WINBACK_DAYS_OPENED_RANGE, 
			Main.FIBER_WINBACK_UTC_RANGES,
			DateToolsBB.SWISS_TIME
		);
		this._nexts = [{step: canTranfer? _TransferToWB : _WinbackIsClosed, params: []}];
		super.onNoClick();
	}
	override public function create():Void 
	{
		var timeApi = new WorldTimeAPI();
		timeApi.onTimeZone = init;

		timeApi.getTimeZone();
		super.create();
	}
	
	function init(data:String)
	{
		var z:TimeZone = Json.parse(data);
		DateToolsBB.SWISS_TIME = DateTimeUtc.fromString(z.datetime).toDate();
		super.create();
	}
}