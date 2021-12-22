package front.move.vti;

import tstool.process.Descision;

/**
 * ...
 * @author bb
 */
class IsFiberStatusPlugInUse extends Descision 
{

	override public function onYesClick():Void
	{
		this._nexts = [{step: _SubmitMove, params: []}];
		super.onYesClick();
	}
	override public function onNoClick():Void
	{
		this._nexts = [{step: _InformMailWillBeSent, params: []}];
		super.onNoClick();
	}
	
}