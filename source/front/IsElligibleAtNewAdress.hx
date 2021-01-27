package front;

import tstool.process.Descision;

/**
 * ...
 * @author bb
 */
class IsElligibleAtNewAdress extends Descision 
{

	override public function create()
	{
		this._nextNoProcesses = [ new _CreateTwoOneSix()];
		this._nextYesProcesses = [ new _CreateTwoOneSix() ];
		super.create();
	}
	
}