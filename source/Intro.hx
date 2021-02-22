package;


import front.capture.CheckContractorVTI;
import haxe.Json;
import haxe.ds.StringMap;
import layout.LoginCan;
import lime.system.Clipboard;
import tstool.process.ActionRadios;
import tstool.process.Descision;
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
class Intro extends ActionRadios
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
	static public var WHY_LEAVE:String = "WHY_LEAVE";
	static public var NO_MORE = "TECH ISSUES";
	static public var DEATH = "DEATH";
	static public var PLUG_IN_USE = "WANTS TO STAY WITH CURRENT PROVIDER";
	static public var MOVE_CAN_KEEP = "MOVE HOUSE KEEP FIBER";
	static public var MOVE_CANNOT_KEEP = "MOVE CAN'T KEEP";
	static public var NOT_ELLIGIBLE = "NOT ELLIGIBLE AT NEW ADRESS";
	static public var MOVE_LEAVE_CH = "BYE BYE SWITZERLAND";
	public function new() 
	{
		super(
		[
			{
				title: WHY_LEAVE,
				values: MainApp.agent.isMember(LoginCan.WINBACK_GROUP_NAME) ?
				[
					NO_MORE,
					NOT_ELLIGIBLE
				] :[
					NO_MORE,
					DEATH,
					PLUG_IN_USE,
					MOVE_CAN_KEEP,
					MOVE_CANNOT_KEEP,
					MOVE_LEAVE_CH
				]
			}
		]
		);
		
	}
	override public function onClick():Void
	{
		
		if(validate()){
			this._nexts = [{step: CheckContractorVTI}];
			super.onClick();
		}
	}
	override public function create():Void
	{
		
		Process.INIT();
		super.create();
		
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