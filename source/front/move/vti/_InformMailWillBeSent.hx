package front.move.vti;

import flow._AddMemoVti;
import tstool.process.Action;

/**
 * ...
 * @author bb
 */
class _InformMailWillBeSent extends Action 
{

	override public function onClick():Void
	{
		this._nexts = [{step: _AddMemoVti, params: []}];
		super.onClick();
	}
	
}