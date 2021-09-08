package front.move.vti;

import tickets._CreateTwoOneThree;
import tstool.process.Action;
import tstool.process.DescisionTemplate;
import tstool.salt.SOTemplate;

/**
 * ...
 * @author bb
 */
class _SendCheckOTOTEmplate extends DescisionTemplate 
{
    public function new()
	{
		super(SOTemplate.FIX_334, EMAIL);
	}
	override public function onYesClick():Void
	{
		this._nexts = [{step: _CreateTwoOneThree, params: []}];
		super.onYesClick();
	}
	override public function onNoClick():Void
	{
		this._nexts = [{step: _CreateTwoOneThree, params: []}];
		super.onNoClick();
	}
	
}
//onNoClick [object Object]