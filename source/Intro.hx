package;

//using tstool.utils.StringUtils;

import front.capture.CheckContractorVTI;
import haxe.Json;
import haxe.ds.StringMap;
import tstool.layout.UI;
import tstool.process.TripletRadios;
import tstool.salt.Agent;
import tstool.utils.Constants;
import tstool.utils.DateToolsBB;
//import layout.LoginCan;
import lime.system.Clipboard;
import tstool.process.ActionRadios;
import tstool.process.CheckUpdateSub;
//import tstool.process.Descision;
//import tstool.process.DescisionRadios;
//import tstool.process.DescisionRadios;
import tstool.process.Process;
//import front.capture._CompareWishAndTermDates;
//import front.capture._DeathWording;
//import front.capture._TransferToWB;
//import front.fees._InputDates;
import js.Browser;
import tstool.MainApp;
//import tstool.process.ActionRadios;
//import tstool.process.Process;
//import tstool.process.Triplet;

/**
 * ...
 * @author bb
 */
class Intro extends TripletRadios
{
	/**
	 * @todo implement update radio to fetch Tongue 
	 *
	static public var WHY_LEAVE:String = Main.tongue.get("$flow.Intro_TITLE", "values");
	static public var NO_MORE = Main.tongue.get("$flow.Intro_v1", "values");
	static public var DEATH = Main.tongue.get("$flow.Intro_v2", "values");
	static public var PLUG_IN_USE = Main.tongue.get("$flow.Intro_v3", "values");
	static public var MOVE_CAN_KEEP = Main.tongue.get("$flow.Intro_v4", "values");
	static public var MOVE_CANNOT_KEEP = Main.tongue.get("$flow.Intro_v5", "values");
	*/
	static public inline var WHY_LEAVE:String = "WHY LEAVE";
	static public inline var TECH_ISSUES = "technical_modem_connection";// TECHISSUES |technical_modem_connection ; Technical: modem connection
	static public inline var BILLINGUNDERSTANDING = "billing_bill_understanding";// BILLINGUNDERSTANDING | billing_bill_understanding ; Billing: understanding the bill
	static public inline var BILLINGFEES = "billing_reminder";// BILLINGFEES | billing_reminder ; Billing: reminder or suspension fees
	
	static public inline var BETTER_OFFER = "offre_betterelsewhere";//BETTER_OFFER |offre_betterelsewhere ; Better offer
	
	static public inline var PRODUCTAPPLETV = "product_appletv";// PRODUCTAPPLETV | product_appletv ; Product: apple tv
	static public inline var PRODUCTSALTTV = "product_salttv";// PRODUCTSALTTV | product_salttv ; Product: salt tv
	static public inline var PRODUCTTECHSPECS = "product_tech_specs";// PRODUCTTECHSPECS | product_tech_specs ; Product: technical characteristics 
	static public inline var PRODUCTVOIP = "product_voip";// PRODUCTVOIP | product_voip ; Product: voip
	static public inline var OTHER = "user_terminate";//user_terminate ; Other: personal/unknown
	static public inline var DEATH = "DEATH";
	static public inline var PLUG_IN_USE = "WANTS TO STAY WITH CURRENT PROVIDER"; //PLUG_IN_USE | WANTSTOSTAYWITHCURRENTPROVIDER
	static public inline var MOVE_CAN_KEEP = "leaving_location";//MOVE_CAN_KEEP | MOVEHOUSEKEEPFIBER | leaving_location ; Move: terminated by the customer
	static public inline var MOVE_CANNOT_KEEP = "MOVE CANT KEEP";      // MOVE_CANNOT_KEEP | MOVECANTKEEP
	static public inline var NOT_ELLIGIBLE = "leaving_location_not_eligible"; // NOTELLIGIBLEATNEWADRESS | leaving_location_not_eligible ; Move: not eligible
	static public inline var MOVE_LEAVE_CH = "BYE BYE SWITZERLAND";
	static public inline var CANCEL_TO_REACTIVATE = "CANCEL_TO_REACTIVATE";
	static var ACTIVITY_MAP:Map<String,String> = [
			MOVE_LEAVE_CH  => "leaving_location_noteligible",
			DEATH  => "death",
			MOVE_CANNOT_KEEP  => "leaving_location_noteligible",
			PLUG_IN_USE => "cancel_offre_betterelsewhere"
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
					MOVE_CANNOT_KEEP,
					MOVE_LEAVE_CH,
					NOT_ELLIGIBLE,
					CANCEL_TO_REACTIVATE
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
					translate("Intro", MOVE_CANNOT_KEEP, "headers"),
					translate("Intro", MOVE_LEAVE_CH, "headers"),
					translate("Intro", NOT_ELLIGIBLE, "headers"),
					translate("Intro", CANCEL_TO_REACTIVATE, "headers")
				],
				titleTranslation: translate("Intro", WHY_LEAVE, "headers")
			}
		]
		);
		
	}
	
	override function changeListener(radioID:String, value:String)
	{
		#if debug
		trace("Intro::changeListener::radioID", radioID );
		trace("Intro::changeListener::value", value );
		#end
		super.changeListener(radioID, value);
		this.btnNo.visible = true;
		this.btnYes.visible = true;
		switch(value)
		{
			case NOT_ELLIGIBLE : this.btnYes.visible = false;
			case _ : this.btnYes.visible = true;
		}
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
				MainApp.agent.addGroupAsMemberOf(Agent.CSR1_GROUP_NAME);
				this._nexts = [{step: CheckContractorVTI, params: []}];
				super.onYesClick();
			}
		}
	}
	override public function onNoClick():Void
	{
		//WINBACK
		if(validate()){
			Process.STORAGE.set("agent","WINBACK");
			MainApp.agent.addGroupAsMemberOf(Agent.WINBACK_GROUP_NAME);
			this._nexts = [{step: CheckContractorVTI, params: []}];
			super.onNoClick();
		}
	}
	override public function onMidClick():Void
	{
		//WINBACK
		if(validate()){
			Process.STORAGE.set("agent","CSR2");
			MainApp.agent.addGroupAsMemberOf(Agent.CSR2_GROUP_NAME);
			this._nexts = [{step: CheckContractorVTI, params: []}];
			super.onNoClick();
		}
	}
	override public function create():Void
	{
		
		Process.INIT();
		MainApp.agent.removeGroupAsMember(Agent.WINBACK_GROUP_NAME);
		
		#if debug
		var date:Date = Date.now();
		var hoursMinUTC:Float = date.getUTCHours() + (date.getUTCMinutes() / 100);
		var hoursMin:Float = date.getHours() + (date.getMinutes() / 100);
		
		this._titleTxt += "\n\nUTC = " + hoursMinUTC;
		this._titleTxt += "\n\nDELTA = " + DateToolsBB.getSeasonDelta();
		#end
		
		super.create();
		var canTranfer = DateToolsBB.isUTCDayTimeFloatInRange(Constants.FIBER_WINBACK_DAYS_OPENED_RANGE, Constants.FIBER_WINBACK_OPEN_UTC_FLOAT , Constants.FIBER_WINBACK_CLOSE_UTC_FLOAT );
		#if debug
		trace("Intro::create::canTranfer", canTranfer );
		#end
		//#if !debug
		Main.VERSION_TRACKER.scriptChangedSignal.add(onNewVersion);
		Main.VERSION_TRACKER.request();
		#if debug
		if (Main.DEBUG){
			trace("Main.DEBUG OPEN ROBOT");
			//openSubState(new CheckUpdateSub(UI.THEME.bg));
		}
		else{
			trace("LOCAL.DEBUG does not OPEN ROBOT");
		}
		
		#else
		//trace("PROD does OPEN ROBOT");
		openSubState(new CheckUpdateSub(UI.THEME.bg));
		#end
			
	}
	
	function onNewVersion(needsUpdate:Bool):Void 
	{
		#if debug
		trace("Intro::onNewVersion::needsUpdate", needsUpdate );
		#end
		if (needsUpdate)
		{
			Browser.location.reload(true);
		}
		else{
			closeSubState();
		}
		//closeSubState();
		#if debug
		trace("Intro::onNewVersion::SHOULD HAVE CLOSED");
		#end
	}
	public static function GET_VTI_ACTIVITY(s:String)
	{
		if (ACTIVITY_MAP.exists(s)) return ACTIVITY_MAP.get(s);
		else return s;
	}
}