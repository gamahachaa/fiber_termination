package;

//import date.WorldTimeAPI;
//import date.WorldTimeAPI.TimeZone;
import front.capture.CheckContractorVTI;
import front.capture._WinbackIsClosed;
import front.move.MoveHow;
import haxe.Json;
import lime.utils.Assets;
import thx.DateTime;
import thx.DateTimeUtc;
import tstool.layout.History.Interactions;
import tstool.layout.PageLoader;
import tstool.layout.UI;
import tstool.process.CheckUpdateSub;
//import haxe.Json;
//import haxe.ds.StringMap;
//import tstool.layout.UI;
import tstool.process.TripletRadios;
import tstool.salt.Agent as SaltAgent;
import tstool.utils.Constants;
import date.DateToolsBB;
//import lime.system.Clipboard;
//import tstool.process.ActionRadios;
//import tstool.process.CheckUpdateSub;
import tstool.process.Process;
import js.Browser;
import tstool.MainApp;

/**
 * ...
 * @author bb
 */
class Intro extends TripletRadios
{
	/**
	 * @todo implement update radio to fetch Tongue
	 *
	*/
	static public inline var WHY_LEAVE:String = "WHY LEAVE";
	//////////////// WINBACKS ////////////////////////////
	static public inline var TECH_ISSUES = "technical_modem_connection";// TECHISSUES
	static public inline var BILLINGUNDERSTANDING = "billing_bill_understanding";// BILLINGUNDERSTANDING | billing_bill_understanding ; Billing: understanding the bill
	static public inline var BILLINGFEES = "billing_reminder";// BILLINGFEES | billing_reminder ; Billing: reminder or suspension fees

	static public inline var BETTER_OFFER = "offre_betterelsewhere";//BETTER_OFFER |offre_betterelsewhere ; Better offer

	static public inline var PRODUCTAPPLETV = "product_appletv";// PRODUCTAPPLETV | product_appletv ; Product: apple tv
	static public inline var PRODUCTSALTTV = "product_salttv";// PRODUCTSALTTV | product_salttv ; Product: salt tv
	static public inline var PRODUCTTECHSPECS = "product_tech_specs";// PRODUCTTECHSPECS | product_tech_specs ; Product: technical characteristics
	static public inline var PRODUCTVOIP = "product_voip";// PRODUCTVOIP | product_voip ; Product: voip
	static public inline var OTHER = "user_terminate";//user_terminate ; Other: personal/unknown
	static public inline var PLUG_IN_USE = "WANTS TO STAY WITH CURRENT PROVIDER"; //PLUG_IN_USE | WANTSTOSTAYWITHCURRENTPROVIDER
	static public inline var CANCEL_TO_REACTIVATE = "CANCEL_TO_REACTIVATE";

	static public inline var DEATH = "DEATH";
	static public inline var MOVE_CAN_KEEP = "leaving_location";//MOVE_CAN_KEEP | MOVEHOUSEKEEPFIBER | leaving_location ; Move: terminated by the customer
	static public inline var MOVE_CANNOT_KEEP = "MOVE CANT KEEP";      // MOVE_CANNOT_KEEP | MOVECANTKEEP
	static public inline var NOT_ELLIGIBLE = "leaving_location_not_eligible"; // NOTELLIGIBLEATNEWADRESS | leaving_location_not_eligible ; Move: not eligible
	static public inline var MOVE_LEAVE_CH = "BYE BYE SWITZERLAND";
	static public inline var PROMO = "PROMO";
	static public inline var DOUBLE_ORDER = "DOUBLE_ORDER";
	static public inline var GIGA_BOX_DEFEKT = "GIGA_BOX_DEFEKT";

	static var ACTIVITY_MAP:Map<String,String> = [
				MOVE_LEAVE_CH  => "leaving_location_noteligible",
				DEATH  => "death",
				MOVE_CANNOT_KEEP  => "leaving_location_noteligible",
				PLUG_IN_USE => "cancel_offre_betterelsewhere"
			];

	var isWBCall:Bool;
	var swissTime:Date;
	public static inline var CSR2:String = "CSR2";
	public static inline var WINBACK:String = "WINBACK";
	public static inline var AGENT:String = "agent";
	public static inline var CSR1:String = "CSR1";
	public static inline var FIX_LINE_GROUP:String = "CO Fixline Expert";
	//public static inline var FIX_LINE_GROUP:String = "CO Customer Operations Management";
	//public static inline var FIX_LINE_GROUP:String = "Microsoft - Teams Members - Standard";
	public static inline var SWISS_TIME:String = "SWISS_TIME";
	public static var WINBACKS:Array<String> = [
				TECH_ISSUES,
				BILLINGUNDERSTANDING,
				BILLINGFEES,
				BETTER_OFFER,
				PRODUCTAPPLETV,
				PRODUCTSALTTV,
				PRODUCTTECHSPECS,
				PRODUCTVOIP,
				OTHER,
				PLUG_IN_USE,
				CANCEL_TO_REACTIVATE,
				PROMO
			];
	public function new()
	{
		super(
			[
		{
			title: WHY_LEAVE,
			hasTranslation:true,
			widthMultiplier:1,
			values: [
				TECH_ISSUES,
				BILLINGUNDERSTANDING,
				BILLINGFEES,
				BETTER_OFFER,
				PRODUCTAPPLETV,
				PRODUCTSALTTV,
				PRODUCTTECHSPECS,
				PRODUCTVOIP,
				DEATH,
				PLUG_IN_USE,
				MOVE_CAN_KEEP,
				NOT_ELLIGIBLE,
				CANCEL_TO_REACTIVATE,
				PROMO,
				DOUBLE_ORDER,
				GIGA_BOX_DEFEKT
			],labels: [
				MainApp.translator.translate("",this._name, TECH_ISSUES, "headers"),
				MainApp.translator.translate("",this._name, BILLINGUNDERSTANDING, "headers"),
				MainApp.translator.translate("",this._name, BILLINGFEES, "headers"),
				MainApp.translator.translate("",this._name, BETTER_OFFER, "headers"),
				MainApp.translator.translate("",this._name, PRODUCTAPPLETV, "headers"),
				MainApp.translator.translate("",this._name, PRODUCTSALTTV, "headers"),
				MainApp.translator.translate("",this._name, PRODUCTTECHSPECS, "headers"),
				MainApp.translator.translate("",this._name, PRODUCTVOIP, "headers"),
				MainApp.translator.translate("",this._name, DEATH, "headers"),
				MainApp.translator.translate("",this._name, PLUG_IN_USE, "headers"),
				MainApp.translator.translate("",this._name, MOVE_CAN_KEEP, "headers"),
				MainApp.translator.translate("",this._name, NOT_ELLIGIBLE, "headers"),
				MainApp.translator.translate("",this._name, CANCEL_TO_REACTIVATE, "headers"),
				MainApp.translator.translate("",this._name, PROMO, "headers"),
				MainApp.translator.translate("",this._name, DOUBLE_ORDER, "headers"),
				MainApp.translator.translate("",this._name, GIGA_BOX_DEFEKT, "headers")
			],
			titleTranslation: MainApp.translator.translate("",this._name, WHY_LEAVE, "headers")
		}
			]
		);
		/**
		 * FETCH OPENNING HOURS on each update
		 */
        var opennings = Json.parse(Assets.getText("assets/data/opennings.json"));
		Main.FIBER_WINBACK_BANK_HOLIDAYS = opennings.wbBankHolidays;
		#if debug
			Main.FIBER_WINBACK_UTC_RANGES = opennings.test;
		//trace(Main.FIBER_WINBACK_UTC_RANGES);
		#else
			Main.FIBER_WINBACK_UTC_RANGES = opennings.prod;
		#end
	}

	override function changeListener(radioID:String, value:String)
	{
		super.changeListener(radioID, value);
		this.btnNo.visible = true;
		this.btnYes.visible = true;
		this.btnMid.visible = true;
		switch (value)
		{
			case NOT_ELLIGIBLE : this.btnYes.visible = this.btnMid.visible = false;
			case _ : this.btnYes.visible = true;
		}
		isWBCall = WINBACKS.indexOf(value) >-1;
	}
	override public function onYesClick():Void
	{
		// FRONT
		if (validate())
		{
			if (status.get(WHY_LEAVE) == NOT_ELLIGIBLE)
			{
				this.rds[0].blink(true);
			}
			else
			{
				Process.STORE(AGENT, CSR1);
				MainApp.agent.addGroupAsMemberOf(SaltAgent.CSR1_GROUP_NAME);
				this._nexts = [ {step:  getNexts(false), params: []}];
				super.onYesClick();
			}
		}
	}
	override public function onNoClick():Void
	{
		//WINBACK
		if (validate())
		{
			Process.STORE(AGENT,WINBACK);
			MainApp.agent.addGroupAsMemberOf(SaltAgent.WINBACK_GROUP_NAME);

			this._nexts = [ {step: getNexts(true), params: []}];
			super.onNoClick();
		}
	}
	override public function onMidClick():Void
	{
		//CSR2
		if (validate())
		{

			Process.STORE(AGENT,CSR2);
			MainApp.agent.addGroupAsMemberOf(SaltAgent.CSR2_GROUP_NAME);

			this._nexts = [ {step:  getNexts(false), params: []}];
			super.onMidClick();
		}
	}
	inline function getNexts(isWB:Bool):Class<Process>
	{
		var whyLeave = status.get(WHY_LEAVE);
		var ismove = whyLeave == MOVE_CAN_KEEP;
		var canTranfer = DateToolsBB.isServiceOpened(
			Main.FIBER_WINBACK_BANK_HOLIDAYS,
			Main.FIBER_WINBACK_DAYS_OPENED_RANGE,
			Main.FIBER_WINBACK_UTC_RANGES,
			DateToolsBB.SWISS_TIME
		);
		
		//canTranfer = true;
		return if (isWB)
		{
			ismove? MoveHow: CheckContractorVTI;
		}
		else if (whyLeave == PLUG_IN_USE) CheckContractorVTI;
		else !canTranfer && isWBCall ? _WinbackIsClosed : ismove? MoveHow: CheckContractorVTI;
	}
	override public function create():Void
	{
		super.create();
		#if debug
		trace("Intro::create::this.radiosMap", this.radiosMap );
		#end
		Main.STORAGE_DISPLAY.push(AGENT);
		//Process.INIT();
		MainApp.agent.removeAllTSToolGroups();
		#if debug
		trace("Intro::create::MainApp.agent", MainApp.agent );
		
		#end
		//init();
		//openSubState(new PageLoader(UI.THEME.bg));
		//var timeApi = new WorldTimeAPI();
		//timeApi.onTimeZone = init;
		//timeApi.getTimeZone();
	}
	override public function validate():Bool 
	{
		return if (status.get(WHY_LEAVE) == GIGA_BOX_DEFEKT && !MainApp.agent.isMember(FIX_LINE_GROUP))
		{
		    blinkItemFromTitle(WHY_LEAVE);
			false;
		} else super.validate();
	}
	/*function init()
	{
		Main.VERSION_TRACKER.scriptChangedSignal.add(onNewVersion);
		Main.VERSION_TRACKER.request();
		Main.trackH.reset(false);
		Main.trackH.setDefaultContext(MainApp.translator.locale, "fiber.tech.qtool@salt.ch");

		#if !debug
		openSubState(new CheckUpdateSub(UI.THEME.bg));
		#else
		if (Main.DEBUG)
		{
			openSubState(new CheckUpdateSub(UI.THEME.bg));
		}
		else
		{
			onNewVersion(false);
		}
		#end
	}
	function onNewVersion(needsUpdate:Bool):Void
	{
		#if debug
		trace("Intro::onNewVersion");
		#end
		if (needsUpdate)
		{
			Browser.location.reload(true);
		}
		else{
			closeSubState();
			MainApp.VERSION_TIMER_value = MainApp.VERSION_TIMER_DURATION;

			#if debug

			//openSubState(new PageLoader(UI.THEME.bg));
            DateToolsBB.SWISS_TIME = DateToolsBB.CLONE_DateTimeUtc( Main.GREENWICH );
			//MainApp.WORD_TIME.onTimeZone = onTimeChecked;
			//MainApp.WORD_TIME.onError = this.onError;
			//MainApp.WORD_TIME.getTimeZone();
			#else
				DateToolsBB.SWISS_TIME = DateToolsBB.CLONE_DateTimeUtc( Main.GREENWICH );
			#end
		}
	}*/

	//function onStatus(status:Int)
	//{
//
		//if (status != 200)
		//{
			//trace(status);
		//}
	//}
	//function onTimeChecked(data:String)
	//{
		//var z:TimeZone = Json.parse(data);
		////trace(z);
		////trace(z);
		//try
		//{
			//DateToolsBB.SWISS_TIME = DateTimeUtc.fromString(z.datetime).toDate();
		//}
		//catch (e)
		//{
			//trace(e);
			//onError(e.message);
		//}
		//DateToolsBB.SWISS_TIME = DateToolsBB.CLONE_DateTimeUtc( 0, DateTimeUtc.fromString(z.datetime) );
		//#if debug
		//trace("Intro::onTimeChecked::DateToolsBB.SWISS_TIME", DateToolsBB.SWISS_TIME );
		//#end
		//closeSubState();
	//}
	//function onError(e:String)
	//{
		////DateToolsBB.SWISS_TIME = Main.GREENWICH == 1 ? DateToolsBB.CLONE_DateTimeUtc( DateTimeUtc.now().nextHour()) : DateToolsBB.CLONE_DateTimeUtc( DateTimeUtc.now().nextHour().nextHour());
		//DateToolsBB.SWISS_TIME = DateToolsBB.CLONE_DateTimeUtc( Main.GREENWICH );
		//#if debug
		//trace("Intro::onError::DateToolsBB.SWISS_TIME ", DateToolsBB.SWISS_TIME  );
		//#end
//
		//closeSubState();
	//}
	public static function GET_VTI_ACTIVITY(s:String)
	{
		if (ACTIVITY_MAP.exists(s)) return ACTIVITY_MAP.get(s);
		else return s;
	}
	override function pushToHistory(buttonTxt:String, interactionType:Interactions, ?values:Map<String, Dynamic> = null)
	{
		var v = this.status;
		v.set(SWISS_TIME, DateToolsBB.SWISS_TIME.toString());
		super.pushToHistory(buttonTxt, interactionType, v);
	}
}