package layout;

import flixel.FlxG;
import flixel.addons.ui.FlxUICheckBox;
import flixel.text.FlxText.FlxTextFormat;
import flixel.ui.FlxButton;
import haxe.Exception;
import tstool.MainApp;
import tstool.layout.Login;
import tstool.salt.Agent;

/**
 * ...
 * @author bb
 */
class LoginCan extends Login 
{
	var submitButton_two:flixel.ui.FlxButton;
	var isWinBack:Bool;
	var init:Bool;
	var ck:flixel.addons.ui.FlxUICheckBox;
	public static inline var WINBACK_GROUP_NAME:String = "WINBACK - TEST";

	override public function create():Void
	{
		isWinBack = false;
		init = true;
		//submitButton_two = new FlxButton(0, 0, "WINBACK", onSubmit_two );
		ck = new FlxUICheckBox(0, 0,null,null,"WINBACK");
		
		ck.callback = ()->(isWinBack = !isWinBack);
		ck.screenCenter();

		//submitButton_two.y += 130;
		ck.y += 130;
		super.create();
		//add(submitButton_two);
		add(ck);
		
		
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (init)
		{
			ck.y = pwd.y + pwd.height + 16;
			ck.x = pwd.x;
			ck.getLabel().size = 14;
			ck.textY -= 6;
			submitButton.y += 30;
			init = false;
		}
		
	}
	override function createAgent(jsonAgent:Dynamic)
	{
		try{
			MainApp.agent = new Agent(jsonAgent);
			if (isWinBack)
			{
				if (!MainApp.agent.isMember(WINBACK_GROUP_NAME))
					MainApp.agent.memberOf.push(WINBACK_GROUP_NAME);
			}
			#if debug
			trace("layout.Login::createAgent::MainApp.agent", MainApp.agent );
			#end
		}
		catch (e: Exception)
		{
			trace(e.details,e.message,e.previous,e.native, e.stack);
		}
	}
}