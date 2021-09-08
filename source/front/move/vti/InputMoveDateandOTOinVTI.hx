package front.move.vti;

import js.Browser;
import tstool.process.Action;
import tstool.process.Descision;

/**
 * ...
 * @author bb
 */
class InputMoveDateandOTOinVTI extends Descision 
{
    override public function create():Void
	{
		super.create();
		Browser.document.addEventListener("copy", function(e){e.clipboardData.setData('text/plain', Main.HISTORY.findValueOfFirstClassInHistory(_AskForOTO, _AskForOTO.OTO_ID).value);e.preventDefault();});
	}
	override public function onYesClick():Void
	{
		this._nexts = [{step: IsFiberStatusPlugInUse, params: []}];
		//this._nexts = [{step: DoesVTIYieldElligible, params: []}];
		super.onYesClick();
	}
	override public function onNoClick():Void
	{
		this._nexts = [{step: _SendCheckOTOTEmplate, params: []}];
		super.onNoClick();
	}
	
}