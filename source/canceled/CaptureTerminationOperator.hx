package canceled;

import tstool.process.DescisionMultipleInput;
import tstool.process.Process;

/**
 * ...
 * @author bb
 */
class CaptureTerminationOperator extends DescisionMultipleInput 
{
	public static inline var TEM_OPERATOR:String = "TERMOPERATOR";

	public function new ()
	{
		super(
		[{
			ereg: new EReg("^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð-]+ [a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ - ]+$","i"),
			input:{
				width:250,
				prefix:TEM_OPERATOR,
				debug: "Nicolas Hess",
				position: [bottom, left],
				mustValidate: [Yes]
			}
		}]
		);
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
		return WhishToBeCalledBAck;
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