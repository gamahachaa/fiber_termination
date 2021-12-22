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
import front.move._InputNewHomeContractDetails;
import haxe.Json;
import haxe.PosInfos;
import tstool.utils.DateToolsBB.Opennings;
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
	//var xapiHelper:XapiHelper;
	
	//public static var LIB_FOLDER:String;
	public static inline var LIB_FOLDER_LOGIN:String = "/commonlibs/";
	//public static var MAIL_WRAPPER_URL:String = LIB_FOLDER + "php/mail/index.php";
	
	public static var HISTORY:History;
	public static var adminFile:tstool.utils.Csv;
	public static var tongue:Translator;
	public static var customer:Customer;
	#if debug
	public static var trackH:tstool.utils.XapiHelper;
	#else
	public static var track:XapiTracker;
	#end
	public static var VERSION:String;
	public static var VERSION_TRACKER:VersionTracker;
	public static var LOCATION:Location;
	public static var DEBUG:Bool;
	public static var FIBER_WINBACK_UTC_RANGES:Array<Opennings>;
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
				cookie:"fibercmt_20210902.user",
				scriptName:"fiber_cmt",
				libFolder: LIB_FOLDER_LOGIN
				
		});
		var opennings = Json.parse(Assets.getText("assets/data/opennings.json"));
		#if debug
		trace("Main::Main::opennings", opennings );
		FIBER_WINBACK_UTC_RANGES = opennings.test;
		trace("Main::Main::opennings", opennings.test );
		#else
		FIBER_WINBACK_UTC_RANGES = opennings.prod;
		#end
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
		//xapiHelper = new XapiHelper( "https://qook.test.salt.ch/commonlibs/" );
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

	
    static public function MOVE_ON(?old:Bool=false, ?pos:PosInfos)
	{
		 #if debug
		trace('CALLED FROM ${pos.className} ${pos.methodName} ${pos.fileName} ${pos.lineNumber}');
		#end
		var next:Process = new Intro();
		
		var tuto:Process = new Tuto();
		MainApp.setUpSystemDefault(true);
		#if !debug
		//Main.track.setActor();
		#end
		#if debug
			/**
			 * USe this  to debug a slide
			 */
			next = new Intro();
			//next = new _InputNewHomeContractDetails();
			//next = new _AskForOTO();
			//next = new _TransferToWB();
			
			//next = new _InputDates();
		#end
		#if debug
		trace("Main::MOVE_ON::MOVE_ON", MOVE_ON );
		#end
		MainApp.translator.initialize(MainApp.agent.mainLanguage, ()->(FlxG.switchState( old ? next : tuto)) );
	}
	/*function testXAPI()
	{
		xapiHelper.setActor(new Agent("bruno.baudry@salt.ch", "bbaudry"));
		xapiHelper.setVerb(Verb.asked);
	xapiHelper.setActivityObject("TESTING", ["en"=>"TESTING"],["en" => "blah blah"],"Activity",["https://qook.salt.ch/def" => "YO MAN"]);
		xapiHelper.setContext(new Agent("tutor@salt.ch"),null,"qoof",MainApp.translator.locale,["https://qook.salt.ch/def" => "YO MAN"]);
		xapiHelper.addStatementRef(new StatementRef("c0d0b6f6-7d10-4336-9ad7-515abaa15cbf"));
		xapiHelper.send();
	}*/
}