package;


import front.capture.CheckContractorVTI;
import front.capture._WinbackIsClosed;
import front.move.MoveHow;
//import haxe.Json;
//import haxe.ds.StringMap;
//import tstool.layout.UI;
import tstool.process.TripletRadios;
import tstool.salt.Agent as SaltAgent;
import tstool.utils.Constants;
import tstool.utils.DateToolsBB;
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
	
	static var ACTIVITY_MAP:Map<String,String> = [
			MOVE_LEAVE_CH  => "leaving_location_noteligible",
			DEATH  => "death",
			MOVE_CANNOT_KEEP  => "leaving_location_noteligible",
			PLUG_IN_USE => "cancel_offre_betterelsewhere"
		];
		var canTranfer:Bool;
		var isWBCall:Bool;
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
					DOUBLE_ORDER
				],labels: [
					 translate("Intro", TECH_ISSUES, "headers"),
					 translate("Intro", BILLINGUNDERSTANDING, "headers"),
					 translate("Intro", BILLINGFEES, "headers"),
					 translate("Intro", BETTER_OFFER, "headers"),
					 translate("Intro", PRODUCTAPPLETV, "headers"),
					 translate("Intro", PRODUCTSALTTV, "headers"),
					 translate("Intro", PRODUCTTECHSPECS, "headers"),
					 translate("Intro", PRODUCTVOIP, "headers"),
					translate("Intro", DEATH, "headers"),
					translate("Intro", PLUG_IN_USE, "headers"),
					translate("Intro", MOVE_CAN_KEEP, "headers"),
					translate("Intro", NOT_ELLIGIBLE, "headers"),
					translate("Intro", CANCEL_TO_REACTIVATE, "headers"),
					translate("Intro", PROMO, "headers"),
					translate("Intro", DOUBLE_ORDER, "headers")
				],
				titleTranslation: translate("Intro", WHY_LEAVE, "headers")
			}
		]
		);
		
	}
	
	override function changeListener(radioID:String, value:String)
	{
		super.changeListener(radioID, value);
		this.btnNo.visible = true;
		this.btnYes.visible = true;
		this.btnMid.visible = true;
		switch(value)
		{
			case NOT_ELLIGIBLE : this.btnYes.visible = this.btnMid.visible = false;
			case _ : this.btnYes.visible = true;
		}
		isWBCall = WINBACKS.indexOf(value) >-1;
	}
	override public function onYesClick():Void
	{
		// FRONT
		if(validate()){
			if (status.get(WHY_LEAVE) == NOT_ELLIGIBLE)
			{
				this.rds[0].blink(true);
			}
			else{
				Process.STORAGE.set("agent", "CSR1");
				MainApp.agent.addGroupAsMemberOf(SaltAgent.CSR1_GROUP_NAME);
				this._nexts = [{step:  getNexts(false), params: []}];
				super.onYesClick();
			}
		}
	}
	override public function onNoClick():Void
	{
		//WINBACK
		if(validate()){
			Process.STORAGE.set("agent","WINBACK");
			MainApp.agent.addGroupAsMemberOf(SaltAgent.WINBACK_GROUP_NAME);
			
			this._nexts = [{step: getNexts(true), params: []}];
			super.onNoClick();
		}
	}
	override public function onMidClick():Void
	{
		//CSR2
		if(validate()){
			Process.STORAGE.set("agent","CSR2");
			MainApp.agent.addGroupAsMemberOf(SaltAgent.CSR2_GROUP_NAME);
			
			this._nexts = [{step:  getNexts(false) , params: []}];
			super.onMidClick();
		}
	}
	inline function getNexts(isWB:Bool):Class<Process>
	{
		var whyLeave = status.get(WHY_LEAVE);
		var ismove = whyLeave == MOVE_CAN_KEEP;
		return if (isWB)
		{
			ismove? MoveHow: CheckContractorVTI;
		}
		else if (whyLeave == PLUG_IN_USE) CheckContractorVTI;
		else !canTranfer && isWBCall ? _WinbackIsClosed : ismove? MoveHow: CheckContractorVTI;
	}
	override public function create():Void
	{
		
		Process.INIT();
		MainApp.agent.removeAllTSToolGroups();
		
		super.create();
		
		canTranfer = !DateToolsBB.isBankHolidayString(Constants.FIBER_WINBACK_BANK_HOLIDAYS) && DateToolsBB.isUTCDayTimeFloatInRanges(Constants.FIBER_WINBACK_DAYS_OPENED_RANGE, Main.FIBER_WINBACK_UTC_RANGES);
		
		Main.VERSION_TRACKER.scriptChangedSignal.add(onNewVersion);
		Main.VERSION_TRACKER.request();
		#if !debug
		openSubState(new CheckUpdateSub(UI.THEME.bg));
		#end
			
	}
	
	function onNewVersion(needsUpdate:Bool):Void 
	{
		if (needsUpdate)
		{
			Browser.location.reload(true);
		}
		else{
			closeSubState();
		}
	}
	public static function GET_VTI_ACTIVITY(s:String)
	{
		if (ACTIVITY_MAP.exists(s)) return ACTIVITY_MAP.get(s);
		else return s;
	}
}