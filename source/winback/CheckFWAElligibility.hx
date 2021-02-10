package winback;


import fees._InputDates;
import tstool.process.Triplet;

/**
 * ...
 * @author bb
 */
class CheckFWAElligibility extends Triplet 
{
	override public function onYesClick():Void
	{
		// elligible and accepts
		this._nexts = [{step: _WaveETFandOrderFWA, params: []}];
		super.onYesClick();
	}
	
	
	override public function onNoClick():Void
	{
		this._nexts = [{step: _InputDates, params: []}];
		super.onNoClick();
	}
	
	override public function onMidClick():Void
	{
		this._nexts = [{step: _InputDates, params: []}];
		super.onMidClick();
	}
}