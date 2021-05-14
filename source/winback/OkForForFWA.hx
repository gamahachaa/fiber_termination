package winback;


import fees._InputDates;
//import tstool.process.Descision;
import tstool.process.Triplet;
//import tstool.process.Triplet;

/**
 * ...
 * @author bb
 */
class OkForForFWA extends Triplet 
//class OkForForFWA extends Descision
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
	/**/
	override public function onMidClick():Void
	{
		this._nexts = [{step: _InputDates, params: []}];
		super.onMidClick();
	}
	/**/
}