package front.capture;

import tstool.process.Action;

/**
 * ...
 * @author bb
 */
class Test extends Action 
{

	override public function onClick():Void
	{
		this._nexts = [{step: CHANGEME, params: []}];
		super.onClick();
	}
	
}