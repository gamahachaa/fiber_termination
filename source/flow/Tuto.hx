package flow;

import flow.Intro;
import tstool.process.Action;

/**
 * ...
 * @author bb
 */
class Tuto extends Action 
{

	override public function create()
	{
		this._nextProcesses = [new flow.Intro()];
		super.create();
	}
	
}