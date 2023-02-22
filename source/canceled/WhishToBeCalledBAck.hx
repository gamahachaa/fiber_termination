package canceled;

import tickets.CancelTermination;
import tstool.process.Descision;

/**
 * ...
 * @author bb
 */
class WhishToBeCalledBAck extends Descision 
{

	override public function onYesClick():Void
	{
		this._nexts = [{step: CancelTermination, params: []}];
		super.onYesClick();
	}
	override public function onNoClick():Void
	{
		this._nexts = [{step: CancelTermination, params: []}];
		super.onNoClick();
	}
	
}