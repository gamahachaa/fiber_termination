package front.capture;

import flow.End;
import tstool.process.Action;

/**
 * ...
 * @author bb
 */
class _ChangeWishDate extends Action 
{

	override public function onClick():Void
	{
		this._nexts = [{step: End}];
		super.onClick();
	}
	
}