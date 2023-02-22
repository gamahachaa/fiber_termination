package front.capture;

import date.WorldTimeAPI;
import date.WorldTimeAPI.TimeZone;
import fees._InputDates;
import haxe.Json;
import thx.DateTimeUtc;
import tstool.MainApp;
import tstool.layout.PageLoader;
import tstool.layout.UI;
import tstool.process.Descision;
import tstool.process.Process;
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
		var isGigabox : Bool = Main.customer.dataSet.get(Constants.CUST_DATA_PRODUCT).get(Constants.CUST_DATA_PRODUCT_BOX) == Constants.CUST_DATA_PRODUCT_BOX_FWA;
		this._nexts = [{step: isGigabox  ? _InputDates: _ChangeWishDate, params: []}];
		super.onYesClick();
	}
	override public function onNoClick():Void
	{
		var canTranfer = DateToolsBB.isServiceOpened(
			Main.FIBER_WINBACK_BANK_HOLIDAYS,
			Main.FIBER_WINBACK_DAYS_OPENED_RANGE,
			Main.FIBER_WINBACK_UTC_RANGES,
			DateToolsBB.SWISS_TIME
		);
		//canTranfer = true;
		this._nexts = [{step: Process.STORAGE.get(Intro.AGENT) == Intro.WINBACK || canTranfer? _TransferToWB : _WinbackIsClosed, params: []}];
		super.onNoClick();
	}
	override public function create():Void
	{
		super.create();
		DateToolsBB.SWISS_TIME = DateToolsBB.CLONE_DateTimeUtc( Main.GREENWICH );
		//openSubState(new PageLoader(UI.THEME.bg));
		
		//MainApp.WORD_TIME.onTimeZone = init;
		//MainApp.WORD_TIME.onError = this.onError;
		//MainApp.WORD_TIME.getTimeZone();
		//
	}

	function init(data:String)
	{
		var z:TimeZone = Json.parse(data);
		//trace(z);
		try{
		 DateToolsBB.SWISS_TIME = DateTimeUtc.fromString(z.datetime).toDate();
		}
		catch (e){
			trace(e);
			onError(e.message);
		}
		closeSubState();
	}
	function onError(e:String)
	{
		DateToolsBB.SWISS_TIME = DateToolsBB.CLONE_DateTimeUtc( Main.GREENWICH );
		closeSubState();
	}
}