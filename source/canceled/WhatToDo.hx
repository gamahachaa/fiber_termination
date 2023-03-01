package canceled;


import front.capture.CheckContractorVTI;
import tstool.process.Descision;

/**
 * ...
 * @author bb
 */
class WhatToDo extends Descision 
{

	override public function onYesClick():Void
	{
		// cancel termination
		//this._nexts = [{step: WhishToBeCalledBAck, params: []}];
		//this._nexts = [{step: CaptureTerminationOperator, params: []}];
		this._nexts = [{step: CheckContractorVTI, params: []}];
		super.onYesClick();
	}
	override public function onNoClick():Void
	{
		// change term date
		//this._nexts = [{step: InputTermDates, params: []}];
		this._nexts = [{step: CheckContractorVTI, params: []}];
		super.onNoClick();
	}
	
}