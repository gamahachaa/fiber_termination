package;

import flixel.FlxG;
import flixel.FlxState;
import flow.End;
import haxe.PosInfos;
import date.DateToolsBB.Opennings;
import tstool.process.Process;
import tstool.MainApp;
import js.html.Location;
import tstool.layout.History;
import tstool.salt.Customer;
import tstool.utils.Csv;
import tstool.utils.Translator;
import tstool.utils.VersionTracker;
import tstool.utils.XapiTracker;

/**
 * ...
 * @author bb
 */


class Main extends MainApp
{

	public static inline var TMP_FILTER_ASSET_PATH:String = "assets/data/tmp/";
	
	public static var HISTORY:History;
	public static var adminFile:tstool.utils.Csv;
	public static var tongue:Translator;
	public static var customer:Customer;
	public static var trackH:tstool.utils.XapiTracker;
	public static var VERSION:String;
	public static var STORAGE_DISPLAY:Array<String> = [];
	
	public static var VERSION_TRACKER:VersionTracker;
	public static var LOCATION:Location;
	public static var DEBUG:Bool;
	//public static var _mainDebug:Bool;
	public static var FIBER_WINBACK_UTC_RANGES:Array<Opennings>;
	public static var GREENWICH:Int;
	public static inline var DEBUG_LEVEL:Int = 0;
	//public static var LANGS:Array<String> = ["fr-FR","de-DE","en-GB","it-IT"];
	public static inline var LAST_STEP:Class<FlxState> = End;
	public static inline var START_STEP:Class<Process> = MainIntro;
	
	static public var FIBER_WINBACK_BANK_HOLIDAYS:Array<String>;
	static public inline var FIBER_WINBACK_DAYS_OPENED_RANGE:String = "1,2,3,4,5";
	
	/**
	 * FORMAT COLOR
	 * */
	
	public function new() 
	{
		super();

		HISTORY = MainApp.stack;
		trackH =  MainApp.xapiHelper;

		DEBUG = MainApp.debug;
		//_mainDebug = MainApp.debug;
		VERSION_TRACKER = MainApp.versionTracker;
		customer = MainApp.cust;

		initScreen();
	}

	
    static public function MOVE_ON(?old:Bool=false, ?pos:PosInfos)
	{

		//var next:Process = new Intro();
		var next:Process;
		var tuto:Process = new Tuto();
		MainApp.setUpSystemDefault(true);
		#if debug
			/**
			 * USe this  to debug a slide
			 */
			next = new MainIntro();
        #else
			next = Type.createInstance(START_STEP,[]);
		#end
		

		MainApp.translator.initialize(MainApp.agent.mainLanguage, ()->(FlxG.switchState( old ? next : tuto)) );
	}
	
}