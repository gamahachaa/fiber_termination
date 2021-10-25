package flow;


import tstool.process.EndAction;

/**
 * ...
 * @author bbaudry
 */
class End extends EndAction 
{
	
	override public function create()
	{
		super.create();
		if (Intro.WINBACKS.indexOf(Main.HISTORY.findValueOfFirstClassInHistory(Intro, Intro.WHY_LEAVE).value)>-1)
		{
			ui.script.visible = false;
			this.details.text = "";
		}
	}
}