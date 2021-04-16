package;


import front.capture.CheckContractorVTI;
import haxe.Json;
import haxe.ds.StringMap;
import tstool.layout.UI;
import tstool.salt.Agent;
import tstool.utils.DateToolsBB;
//import layout.LoginCan;
import lime.system.Clipboard;
import tstool.process.ActionRadios;
import tstool.process.CheckUpdateSub;
import tstool.process.Descision;
import tstool.process.DescisionRadios;
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
class Intro extends DescisionRadios
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
	static public inline var NO_MORE = "TECH ISSUES";
	static public inline var DEATH = "DEATH";
	static public inline var PLUG_IN_USE = "WANTS TO STAY WITH CURRENT PROVIDER";
	static public inline var MOVE_CAN_KEEP = "MOVE HOUSE KEEP FIBER";
	static public inline var MOVE_CANNOT_KEEP = "MOVE CANT KEEP";
	static public inline var FWA_ELLIGIBLE = "NOT ELLIGIBLE AT NEW ADRESS";
	static public inline var MOVE_LEAVE_CH = "BYE BYE SWITZERLAND";
	public function new() 
	{
		super(
		[
			{
				title: WHY_LEAVE,
				hasTranslation:true,
				widthMultiplier:1,
				values: [
					NO_MORE,
					DEATH,
					PLUG_IN_USE,
					MOVE_CAN_KEEP,
					MOVE_CANNOT_KEEP,
					MOVE_LEAVE_CH,
					FWA_ELLIGIBLE
				],labels: [
					 translate("Intro", NO_MORE, "headers"),
					translate("Intro", DEATH, "headers"),
					translate("Intro", PLUG_IN_USE, "headers"),
					translate("Intro", MOVE_CAN_KEEP, "headers"),
					translate("Intro", MOVE_CANNOT_KEEP, "headers"),
					translate("Intro", MOVE_LEAVE_CH, "headers"),
					translate("Intro", FWA_ELLIGIBLE, "headers")
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
			case FWA_ELLIGIBLE : this.btnYes.visible = false;
			case _ : this.btnYes.visible = true;
		}
	}
	override public function onYesClick():Void
	{
		// FRONT
		if(validate()){
			if (status.get(WHY_LEAVE) == FWA_ELLIGIBLE)
			{
				this.rds[0].blink(true);
			}
			else{
				Process.STORAGE.set("agent","FRONT");
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
	override public function create():Void
	{
		
		Process.INIT();
		MainApp.agent.removeGroupAsMember(Agent.WINBACK_GROUP_NAME);
		super.create();
		//-	8h-17h Monday to Friday 
		//var summer = new Date(2021, 2, 28, 0, 0, 0);
		//var dummy = new Date(2021, 2, 29, 0, 0, 0);
		//var dummy2 = new Date(2021, 2, 27, 10, 0, 0);
		//var dummy3 = new Date(2021, 2, 26, 17, 0, 0);
		//var dummy4 = new Date(2021, 2, 25, 17, 29, 0);
		//var lastHourCH = 18;
		//var firstHourCH = 8;
		
		var nowLocale = Date.now();
		//var isSummer = DateToolsBB.isSummerTime(nowLocale);
		//var lastHourUTC = lastHourCH - (isSummer ? 2 : 1) ;
		var lastHourUTC = 17;
		//var firstHourUTC = firstHourCH - (isSummer ? 2 : 1) ;
		var firstHourUTC = 7;
		var daysClosed = [0, 6];
		
		
		//trace("---");
		//trace(DateToolsBB.isWithinHours(firstHourUTC, lastHourUTC, nowLocale));
		//trace("---");
		
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
}