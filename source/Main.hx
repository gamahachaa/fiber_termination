package;

import firetongue.FireTongue;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.input.keyboard.FlxKey;
import flixel.text.FlxText.FlxTextFormat;
import flixel.text.FlxText.FlxTextFormatMarkerPair;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
import flow.Intro;
import flow.Tuto;
import js.Browser;
import js.html.Location;
import openfl.Assets;
import openfl.display.Sprite;
import tstool.salt.Agent;
import tstool.salt.Customer;
import tstool.layout.History;
import tstool.layout.Login;
import tstool.layout.SaltColor;
import tstool.utils.Csv;
import tstool.utils.VersionTracker;
import tstool.utils.XapiTracker;
//import flow.installation._EnsureCorrectPortPlug;

typedef BasicFormat =
{
	var font:String;
	var size:Int;
}
typedef ThemeColor =
{
	var title:FlxColor;
	var basic:FlxColor;
	var basicStrong:FlxTextFormatMarkerPair;
	var basicEmphasis:FlxTextFormatMarkerPair;
	var meta:FlxColor;
	var interaction:FlxColor;
	var bg:FlxColor;
}
typedef Ticket =
{
	var domain:String;
	var number:String;
	var queue:String;
	var desc:String;
	var email:String;
}
class Main extends Sprite
{
	public static var HISTORY:History = new History();
	public static var tongue:FireTongue = new FireTongue();
	public static var user:Agent;
	public static var customer:Customer;
	public static var track:XapiTracker;
	static inline var TITLE_FONT:String = "assets/fonts/Lato-Black.ttf";
	static inline var BASIC_FONT:String = "assets/fonts/Lato-Regular.ttf";

	public static var adminFile:tstool.utils.Csv;
	public static var TITLE_FMT:BasicFormat = {font:TITLE_FONT, size:24};
	public static var BASIC_FMT:BasicFormat = {font:BASIC_FONT, size:16};
	public static var META_FMT:BasicFormat = {font:TITLE_FONT, size:16};
	public static var INTERACTION_FMT:BasicFormat = {font:TITLE_FONT, size:20};

	public static var VERSION:String;
	public static var VERSION_TRACKER:VersionTracker;
	public static var LOCATION:Location;
	public static var DEBUG:Bool;
	/**
	 * FORMAT COLOR
	 * */
	public static var DARK_THEME :ThemeColor =
	{
		bg: SaltColor.BLACK_PURE,
		title:SaltColor.WHITE,
		basic:SaltColor.WHITE,
		basicStrong:new FlxTextFormatMarkerPair(new FlxTextFormat(SaltColor.ORANGE,true),"<b>"),
		basicEmphasis:new FlxTextFormatMarkerPair(new FlxTextFormat(SaltColor.ORANGE,false,true),"<em>"),
		meta:SaltColor.MUSTARD,
		interaction: SaltColor.WHITE

	};
	public static var WHITE_THEME :ThemeColor =
	{
		bg: SaltColor.WHITE,
		title:SaltColor.BLACK_PURE,
		basic:SaltColor.BLACK,
		basicStrong:new FlxTextFormatMarkerPair(new FlxTextFormat(SaltColor.RED,true),"<b>"),
		basicEmphasis:new FlxTextFormatMarkerPair(new FlxTextFormat(SaltColor.RED,false,true),"<em>"),
		meta:SaltColor.TUQUOISE,
		interaction: SaltColor.DARK_GRAY

	};

	public static var COOKIE: FlxSave;
	public static var THEME:ThemeColor;
	//public static var LRS:LearninLocker;
	public function new()
	{
		super();
		
		adminFile = new Csv(Assets.getText("assets/data/admins.txt"),",",false);
		//trace(adminFile);
		COOKIE = new FlxSave();
		COOKIE.bind("nointernet-20200421.user");

		LOCATION = Browser.location;
		track =  new XapiTracker();
		DEBUG = LOCATION.origin.indexOf("qook.test.salt.ch") > -1;
		VERSION_TRACKER = new VersionTracker( LOCATION.origin + LOCATION.pathname+ "php/version/index.php");
		THEME = DARK_THEME;
		
		
		Main.customer = new Customer();
		tongue.init("fr-FR",
					function()
		{
			#if debug
			trace(tongue.get("$flow.nointernet.vti.CheckContractorVTI_UI1", "meta"));
			#end
		},false,false,"assets/locales/","can_index.xml"
				   );
		#if debug
		Main.user = new Agent();
		//addChild(new FlxGame(1400, 880, Login, 1, 30, 30, true, true));
		addChild(new FlxGame(1400, 880, flow.Intro, 1, 30, 30, true, true));
		
		#else

		if ( DEBUG )
		{
			//trace(Browser.navigator.appCodeName);
			//trace(Browser.navigator.appName);
			//trace(Browser.navigator.appVersion);
			//trace(Browser.navigator.buildID);
			//trace(Browser.navigator.permissions);
			//trace(Browser.navigator.platform);
			//trace(Browser.navigator.plugins);
			//trace(Browser.navigator.product);
			//trace(Browser.navigator.productSub);
			//trace(Browser.navigator.userAgent);
			//trace(Browser.navigator.vendor);
			//trace(Browser.navigator.vendorSub);

		}
		if (Browser.navigator.userAgent.indexOf("Firefox") == -1)
		{
			Browser.window.alert("I know your browser is the best on this planet\n\n.But this tool is only fully tested with Firefox...\n\nIt should work with all major browsers but we cannot guarantee all functionalities @100%. \n\nThanks you to acknowledge this.");
		}

		addChild(new FlxGame(1400, 880, Intro, 1, 30, 30, true, true));

		#end
		//
	}

	public function onLRSdata(data:String)
	{
		trace(data);
	}

	static public function TOGGLE_MAIN_STYLE()
	{
		THEME = THEME == WHITE_THEME ? DARK_THEME: WHITE_THEME;
	}
	static public function setUpSystemDefault(?block:Bool = false )
	{
		FlxG.sound.soundTrayEnabled = false;
		FlxG.mouse.useSystemCursor = block;
		FlxG.keys.preventDefaultKeys = block ? [FlxKey.BACKSPACE, FlxKey.TAB] : [FlxKey.TAB];
		//FlxG.keys.preventDefaultKeys = [FlxKey.TAB];
	}
	static public function MOVE_ON(?old:Bool=false)
	{
		setUpSystemDefault(true);
		track.setActor();
		tongue.init(Main.user.mainLanguage, ()->(FlxG.switchState( old ? new flow.Intro():new flow.Tuto() )),false,false,"assets/locales/","can_index.xml" );
	}

}