package flow;

import tstool.process.Action;

/**
 * ...
 * @author bb
 */
class _AddMemoVti extends Action 
{

	override public function onClick():Void
	{
		this._nexts = [{step: End, params: []}];
		super.onClick();
	}
	
}