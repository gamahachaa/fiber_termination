package front.capture;

import firetongue.Replace;
import flow.End;
import flow._AddMemoVti;
//import tickets._CreateTicketSixForOne;
import tstool.process.Action;
import tstool.utils.Constants;

/**
 * ...
 * @author bb
 */
class _TransferToWB extends Action 
{
	//var scriptView:ScriptView;
	/*override public function create():Void{
		
		
		this._detailTxt = Replace.flags(_detailTxt, ["<START>", "<END>"], [Std.string(Constants.FIBER_WINBACK_OPEN_UTC_FLOAT + 1), Std.string(Constants.FIBER_WINBACK_CLOSE_UTC_FLOAT + 1)]);
		super.create();
		//scriptView = new ScriptView(Main.HISTORY.prepareListHistory());
		//scriptView.signal.add(sbStateListener);
		
		//ui.script.visible = true;
	}  */
	/*override public function onYesClick():Void
	{
		this._nexts = [{step: End}];
		super.onYesClick();
	}
	override public function onNoClick():Void
	{
		this._nexts = [{step: _CreateTicketSixForOne}];
		super.onNoClick();
	}*/
	/*function onScript() 
	{
		openSubState( scriptView );
	}*/
	/*override function listener(s:String):Void 
	{
		switch (s){
			case "en-GB" : switchLang("en-GB");
			case "it-IT" : switchLang("it-IT");
			case "de-DE" : switchLang("de-DE");
			case "fr-FR" : switchLang("fr-FR");
			case "onQook" : onQook();
			case "onScript" : onScript();
			case "onExit" : onExit();
			case "onBack" : onBack();
			case "onHowTo" : onHowTo();
			case "toogleTrainingMode" : toogleTrainingMode();
			case "onComment" : onComment();
			case "setStyle" : setStyle();
			case "openSubState" : openSubState(dataView);
		}
	}*/
	override public function onClick():Void
	{
		this._nexts = [{step: _AddMemoVti, params: []}];
		super.onClick();
	}
}