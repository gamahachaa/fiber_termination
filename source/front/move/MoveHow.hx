package front.move;

import front.capture.CheckContractorVTI;
import tstool.process.Triplet;

/**
 * ...
 * @author bb
 */
class MoveHow extends Triplet 
{

	override public function onYesClick():Void
	{
		this._nexts = [{step: CheckContractorVTI, params: []}];
		super.onYesClick();
	}
	
	
	override public function onNoClick():Void
	{
		this._nexts = [{step: CheckContractorVTI, params: []}];
		super.onNoClick();
	}
	
	override public function onMidClick():Void
	{
		this._nexts = [{step:CheckContractorVTI , params: []}];
		super.onMidClick();
	}
	
}