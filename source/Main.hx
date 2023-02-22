package;

import fees.TestSendTemplate;
import fees._InputDates;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;
import flow.End;
import Intro;
import front.capture._TransferToWB;
import front.move._AskForOTO;
//import front.move._InputNewHomeContractDetails;
import haxe.Json;
import haxe.PosInfos;
import tstool.utils.Constants;
import date.DateToolsBB;
import date.DateToolsBB.Opennings;
import xapi.Agent;
import xapi.Verb;
import xapi.types.StatementRef;
//import layout.LoginCan;
import tstool.layout.Login;
import tstool.layout.UI;
import tstool.process.Process;
//import flixel.system.FlxAssets;
import flixel.text.FlxText.FlxTextFormat;
import flixel.text.FlxText.FlxTextFormatMarkerPair;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
import tstool.MainApp;

import js.Browser;
import js.html.Location;
import lime.utils.Assets;
//import openfl.display.Sprite;
import tstool.layout.History;
//import tstool.layout.Login;
//import tstool.layout.SaltColor;
//import tstool.salt.Agent;
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
	//var xapiHelper:XapiHelper;
	
	//public static var LIB_FOLDER:String;
	public static inline var LIB_FOLDER_LOGIN:String = "/commonlibs/";
	public static inline var TMP_FILTER_ASSET_PATH:String = "assets/data/tmp/";
	//public static var MAIL_WRAPPER_URL:String = LIB_FOLDER + "php/mail/index.php";
	
	public static var HISTORY:History;
	public static var adminFile:tstool.utils.Csv;
	public static var tongue:Translator;
	public static var customer:Customer;
	//#if debug
	public static var trackH:tstool.utils.XapiTracker;
	//#else
	//public static var track:XapiTracker;
	//#end
	public static var VERSION:String;
	public static var STORAGE_DISPLAY:Array<String> = [];
	
	public static var VERSION_TRACKER:VersionTracker;
	public static var LOCATION:Location;
	public static var DEBUG:Bool;
	public static var _mainDebug:Bool;
	public static var FIBER_WINBACK_UTC_RANGES:Array<Opennings>;
	public static var GREENWICH:Int;
	public static inline var DEBUG_LEVEL:Int = 0;
	public static var LANGS:Array<String> = ["fr-FR","de-DE","en-GB","it-IT"];
	public static inline var LAST_STEP:Class<FlxState> = End;
	public static inline var START_STEP:Class<Process> = MainIntro;
	public static inline var INTRO_PIC:String = "intro/favicon.png";
	static public var FIBER_WINBACK_BANK_HOLIDAYS:Array<String>;
	static public inline var FIBER_WINBACK_DAYS_OPENED_RANGE:String = "1,2,3,4,5";
	
	/**
	 * FORMAT COLOR
	 * */
	
	public function new() 
	{
		super({
				cookie:"fibercmt_20210902.user",
				scriptName:"fiber_cmt",
				libFolder: LIB_FOLDER_LOGIN
				
		});
		//var opennings = Json.parse(Assets.getText("assets/data/opennings.json"));
		//GREENWICH = DateToolsBB.isSummerTime(Date.now()) ?2:1;
		//FIBER_WINBACK_BANK_HOLIDAYS = opennings.wbBankHolidays;
		//#if debug
		//FIBER_WINBACK_UTC_RANGES = opennings.test;
		//#else
		//FIBER_WINBACK_UTC_RANGES = opennings.prod;
		//#end

		HISTORY = MainApp.stack;
		trackH =  MainApp.xapiHelper;

		DEBUG = MainApp.debug;
		_mainDebug = MainApp.debug;
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