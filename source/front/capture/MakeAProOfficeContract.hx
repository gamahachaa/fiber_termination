package front.capture;

import regex.ExpReg;
import tickets._MigrationTicket;
import tstool.process.DescisionMultipleInput;
import tstool.process.Process;
import tstool.utils.Constants;

/**
 * ...
 * @author bb
 */
class MakeAProOfficeContract extends DescisionMultipleInput 
{

	public function new() 
	{
		super([
		   {
			ereg:new EReg(ExpReg.MINIMAL_3WORDS, "i"),
			
			input:{
				width:500,
				debug: "One two three",
				prefix: Constants.JUSTIFICATION,
				position: [bottom, left],
				mustValidate: [No]
			}
		}
		]);
		
	}
	
	
	/****************************
	* Needed for validation
	*****************************/
	override public function onYesClick():Void
	{
		if (validateYes()){
			this._nexts = [{step: getNext(), params: []}];
			super.onYesClick();
		}	
	}
	override public function onNoClick():Void
	{
		if (validateNo()){
			this._nexts = [{step: getNext(), params: []}];
			super.onNoClick();
		}
	}
	inline function getNext():Class<Process>{
		return _MigrationTicket;
	}
	/*
	override public function validateYes():Bool
	{
		return true;
	}
	*/
	/*
	override public function validateNo():Bool
	{
		return true;
	}
	*/
	
}