package flow;


import front.capture.CheckContractorVTI;
import tstool.process.Process;
//import front.capture._CompareWishAndTermDates;
//import front.capture._DeathWording;
//import front.capture._TransferToWB;
//import front.fees._InputDates;
import js.Browser;
import tstool.MainApp;
import tstool.process.ActionRadios;
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
	static public var NO_MORE = "NO_MORE";
	static public var DEATH = "DEATH";
	static public var PLUG_IN_USE = "OTO PLUG IS IN USE";
	static public var MOVE_CAN_KEEP = "MOVE HOUSE KEEP FIBER";
	static public var MOVE_CANNOT_KEEP = "MOVE CAN'T KEEP";
	static public var MOVE_LEAVE_CH = "BYE BYE SWITZERLAND";
	public function new() 
	{
		super(
		[
			{
				title: WHY_LEAVE,
				values: [
					NO_MORE,
					DEATH,
					PLUG_IN_USE,
					MOVE_CAN_KEEP,
					MOVE_CANNOT_KEEP
				]
			}
		]
		);
		
	}
	override public function onClick():Void
	{
		this._nexts = [{step: CheckContractorVTI}];
		super.onClick();
	}
	//inline function getNext():Class<Process>
	//{
		//return switch (status.get(WHY_LEAVE))
		//{
			//case NO_MORE : _TransferToWB;
			//case DEATH : _DeathWording;
			//case PLUG_IN_USE : _CompareWishAndTermDates;
			//case MOVE_CAN_KEEP : IsAdressElligible;
			//case MOVE_CANNOT_KEEP : _InputDates;
			//default :;
		//}
	//}
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