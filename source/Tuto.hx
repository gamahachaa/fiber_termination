package;

import Intro;
import tstool.MainApp;
import tstool.process.Action;

/**
 * ...
 * @author bb
 */
class Tuto extends Action 
{
	override public function create():Void
	{
		#if debug
		trace("Tuto::create::create", create );
		#end
		super.create();
		this.question.text = "Hello " + MainApp.agent.firstName + ",\n\n" + this._titleTxt;
	}
	override public function onClick():Void
	{
		this._nexts = [{step: Intro, params: []}];
		super.onClick();
	}
	
}