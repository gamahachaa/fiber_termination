package;

import fees.TestSendTemplate;
import fees._InputDates;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;
import flow.End;
import Intro;
import tstool.utils.Constants;
import tstool.utils.DateToolsBB;
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
import tstool.utils.XapiHelper;

/**
 * ...
 * @author bb
 */


class Main extends MainApp
{
	var xapiHelper:XapiHelper;
	public static var trackH:XapiHelper;
	//public static var LIB_FOLDER:String;
	public static inline var LIB_FOLDER_LOGIN:String = "/commonlibs/";
	//public static var MAIL_WRAPPER_URL:String = LIB_FOLDER + "php/mail/index.php";
	
	public static var HISTORY:History;
	public static var adminFile:tstool.utils.Csv;
	public static var tongue:Translator;
	public static var customer:Customer;
	public static var track:XapiTracker;
	public static var VERSION:String;
	public static var VERSION_TRACKER:VersionTracker;
	public static var LOCATION:Location;
	public static var DEBUG:Bool;
	public static inline var DEBUG_LEVEL:Int = 0;
	public static var LANGS:Array<String> = ["fr-FR","de-DE","en-GB","it-IT"];
	public static inline var LAST_STEP:Class<FlxState> = End;
	public static inline var START_STEP:Class<Process> = Intro;
	public static inline var INTRO_PIC:String = "intro/favicon.png";
	
	/**
	 * FORMAT COLOR
	 * */
	
	public function new() 
	{
		super({
				cookie:"fibercmt_20210407.user",
				scriptName:"fiber_cmt",
				libFolder: LIB_FOLDER_LOGIN
				
		});
		var d1 =  Date.fromString("2021-12-24");
		var d2 = new Date(2021, 11, 31,0,0,0);
		trace(DateToolsBB.isBankHolidayString(Constants.FIBER_WINBACK_BANK_HOLIDAYS));
		trace(DateToolsBB.isBankHolidayString(Constants.FIBER_WINBACK_BANK_HOLIDAYS, d1) );
		trace(DateToolsBB.isBankHolidayString(Constants.FIBER_WINBACK_BANK_HOLIDAYS, d2) ) ;
		 
		//tongue = MainApp.translator;
		//COOKIE = MainApp.save;
		HISTORY = MainApp.stack;
		//LOCATION = MainApp.location;
		#if debug
		trackH =  MainApp.xapiHelper;
		#else
		track =  MainApp.xapiTracker;
		#end
		//xapiHelper = new XapiHelper( Browser.location.origin + LIB_FOLDER_LOGIN );
		DEBUG = MainApp.debug;
		VERSION_TRACKER = MainApp.versionTracker;
		customer = MainApp.cust;
		//addChild(new FlxGame(1400, 880, Login, 1, 30, 30, true, true));
		//var now = Date.now();
		//trace(new Date(now.getFullYear(), now.getMonth() + 1, 0, 0, 0, 0));
		#if debug
		//testXAPI();
		#end
		initScreen();
	}

	
    static public function MOVE_ON(?old:Bool=false)
	{
		
		var next:Process = new Intro();
		var tuto:Process = new Tuto();
		MainApp.setUpSystemDefault(true);
		#if !debug
		Main.track.setActor();
		#end
		#if debug
			/**
			 * USe this  to debug a slide
			 */
			next = new Intro();
			//next = new _InputDates();
		#end
		#if debug
		trace("Main::MOVE_ON::MOVE_ON", MOVE_ON );
		#end
		MainApp.translator.initialize(MainApp.agent.mainLanguage, ()->(FlxG.switchState( old ? next : tuto)) );
	}
	/*
	function testXAPI()
	{
		xapiHelper.setActor(new Agent("bruno.baudry@salt.ch", "bbaudry"));
		xapiHelper.setVerb(Verb.asked);
	//xapiHelper.setActivityObject("TESTING", ["en"=>"TESTING"], ["en" => "blah blah"], "Activity", ["https://qook.salt.ch/def" => "YO MAN"]);
	xapiHelper.setActivityObject("TESTING", ["en"=>"TESTING"],null,"Activity");
		//xapiHelper.setContext(new Agent("tutor@salt.ch"), "https://qook.salt.ch/TOASTING", "qoom", "fr-FR", ["https://qook.salt.ch/duf" => "YO BRO"]);
		xapiHelper.addStatementRef(new StatementRef("c0d0b6f6-7d10-4336-9ad7-515abaa15cbf"));
		xapiHelper.send();
	} */
}