package front.capture;

import tickets._CreateTwoOneSix;
import tstool.process.Action;

/**
 * ...
 * @author bb
 */
class _DeathWording extends Action 
{

	override public function onClick():Void
	{
		this._nexts = [{step: _CreateTwoOneSix, params: []}];
		super.onClick();
	}
	
}