package front.capture;

import regex.ExpReg;
import tickets._MigrationTicket;
import tstool.process.ActionMultipleInput;
import tstool.utils.Constants;

/**
 * ...
 * @author bb
 */
class InputWantedVoip extends ActionMultipleInput 
{
	
	
    inline static public var VOIP_NUMBER:String = "VoIPNumber";
	public function new() 
	{
		super([
		   {
			ereg:new EReg(ExpReg.VTI_VOIP_WITH_NOCHEATING,"i"),
			input:{
				width:200,
				debug: Constants.TEST_VOIP,
				prefix: VOIP_NUMBER,
				position: [bottom, left]
			}
		}
		]);
		
	}
	override public function onClick():Void 
	{
		if (validate())
		{
			this._nexts = [{step: _InputNewContractor}] ;
			//this._nexts = [{step: _MigrationTicket}] ;
			super.onClick();
		}
	}
	
}