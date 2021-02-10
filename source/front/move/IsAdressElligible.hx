package front.move;

import fees._InputDates;
import front.capture._TransferToWB;
import layout.LoginCan;
import tstool.MainApp;
import tstool.process.Descision;

/**
 * ...
 * @author bb
 */
class IsAdressElligible extends Descision 
{

override public function onYesClick():Void
	{
		this._nexts = [{step: _InputDates, params: []}];
		super.onYesClick();
	}
	override public function onNoClick():Void
	{
		this._nexts = [{step: MainApp.agent.isMember(LoginCan.WINBACK_GROUP_NAME) ? _InputDates:_TransferToWB, params: []}];
		super.onNoClick();
	}
}