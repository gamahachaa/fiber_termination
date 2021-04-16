package front.move;

//import flixel.util.FlxColor.TriadicHarmony;
import flow.End;
import tstool.process.TripletMultipleInput;
//import tstool.process.ActionMultipleInput;
//import tstool.process.Descision;
//import tstool.process.DescisionMultipleInput;
import tstool.process.Process;
import tstool.utils.ExpReg;

/**
 * ...
 * @author bb
 */
class _AskForOTO extends TripletMultipleInput
{
	
	static inline var OTO_ID:String = "OTO_ID";
	static inline var APT_ID:String = "APT_ID";

	public function new ()
	{
		super(
		[{
			ereg: new EReg(ExpReg.OTO_REG,"i"),
			input:{
				width:250,
				prefix:OTO_ID,
				position: [bottom, left],
				mustValidate: [Yes]
			}
		},
		{
			ereg: new EReg(ExpReg.ALL,"i"),
			input:{
				width:250,
				prefix:APT_ID,
				buddy: OTO_ID,
				position: [bottom, left],
				mustValidate: [No]
			}
		}]
		);
	}
	
	
	
	/****************************
	* Needed for validation
	*****************************/
	override public function onYesClick():Void
	{
		if (validateYes())
		{
			this._nexts = [{step: getNext(), params: []}];
			super.onYesClick();
		}
	}
	/*
	override public function validateYes():Bool
	{
		return true;
	}
	*/
	
	override public function onNoClick():Void
	{
		if (validateNo())
		{
			this._nexts = [{step: getNext(), params: []}];
			super.onNoClick();
		}
	}
	/*
	override public function validateNo():Bool
	{
		return true;
	}
	*/
	override public function onMidClick():Void
	{
		if (validateMid())
		{
			this._nexts = [{step: getNext(), params: []}];
			super.onMidClick();
		}
	}	
	inline function getNext():Class<Process>{
		return CanAgentApplyCharges;
	}
	/****************************
	* Needed only for validation
	*****************************/
	/**/
	//override public function validate():Bool
	//{
		//if(this.multipleInputs.getText(OTO_ID).toLowerCase()=="no oto yet")
			//return true;
		//else {
			//return super.validate();
		//}
	//}
	/**/
	
}