package;

import tstool.process.Triplet;

/**
 * ...
 * @author bb
 */
class CaptureDomain extends Triplet
{

	override public function onYesClick():Void
	{
		this._nexts = [{step: Intro, params: []}];
		super.onYesClick();
	}

	override public function onNoClick():Void
	{
		this._nexts = [{step: Intro, params: []}];
		super.onNoClick();
	}

	override public function onMidClick():Void
	{
		this._nexts = [{step: Intro, params: []}];
		super.onMidClick();
	}

}