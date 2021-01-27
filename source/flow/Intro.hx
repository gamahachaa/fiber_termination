package flow;

import bo.WhichSOTicket;
import front.WhatTypeOfRequest;
import js.Browser;
import tstool.process.CheckUpdateSub;
import tstool.process.Descision;
import tstool.process.DescisionMultipleInput;
import tstool.process.MultipleInput.ValidatedInputs;
import tstool.process.Process;
import tstool.process.Triplet;

/**
 * ...
 * @author bb
 */
class Intro extends Descision 
{

	override public function create():Void
	{
		
		Process.INIT();
		//trace(Main.user.isAdmin);
		
		//trace("WTF"); 
		//var next = new CheckContractorVTI();
		this._nextYesProcesses = [new WhichSOTicket()];
		this._nextNoProcesses = [ new WhatTypeOfRequest() ];
		
		
 		super.create();
		//details.tf.htmlText = "<h1>YA</h1><b>yo</b><br/><a>yiiii</a>";
		//#if !debug
		//Main.VERSION_TRACKER.scriptChangedSignal.add(onNewVersion);
		//Main.VERSION_TRACKER.request();
		//openSubState(new CheckUpdateSub(Main.THEME.bg));
		//#end
			
	}
	
	function onNewVersion(needsUpdate:Bool):Void 
	{
		if (needsUpdate)
		{
			Browser.location.reload(true);
		}
		else{
			closeSubState();
		}
	}
	
}