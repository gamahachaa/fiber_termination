package fees;

import tstool.process.Descision;

/**
 * ...
 * @author bb
 */
class HasMobileDiscount extends Descision 
{

	override public function onYesClick():Void
	{
		this._nexts = [{step: IsDoorToDoor, params: []}];
		super.onYesClick();
	}
	override public function onNoClick():Void
	{
		this._nexts = [{step: IsDoorToDoor, params: []}];
		super.onNoClick();
	}
	
}