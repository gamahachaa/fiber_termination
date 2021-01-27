package front;
import tstool.process.Triplet;

/**
 * ...
 * @author bb
 */
class WhatTypeOfRequest extends Triplet
{
	override public function create()
	{
		this._nextNoProcesses = [new HowWasOrderMade()];
		this._nextYesProcesses = [new _RequestIsDeath()];
		this._nextMidProcesses= [new IsElligibleAtNewAdress()];
		super.create();
	}
}