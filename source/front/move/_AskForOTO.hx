package front.move;
using StringTools;

//import flixel.util.FlxColor.TriadicHarmony;
import fees._TotalFees;
import flow.End;
import front.move.vti.InputMoveDateandOTOinVTI;
//import tickets._CreateTwoOneThree;
import tstool.MainApp;
import tstool.process.TripletMultipleInput;
import tstool.salt.SaltAgent;
import tstool.utils.Constants;

import tstool.process.Process;
import regex.ExpReg;

/**
 * ...
 * @author bb
 */
class _AskForOTO extends TripletMultipleInput
{

	static public inline var OTO_ID:String = "OTO_ID";
	static inline var APT_ID:String = "APT_ID";
	static inline var APT_FORMER_OCCUPANT:String = "APT_FORMER_OCCUPANT";
	static inline var APT_BUILDING_NB_FLOORS:String = "NB_FLAT_AT_THIS_FLOOR";
	static inline var APT_FLOOR_NB:String = "APT_FLOOR_NB";

	public function new ()
	{
		super(
			[
		{
			ereg: new EReg(ExpReg.OTO_REG,"i"),
			input:{
				width:250,
				prefix:OTO_ID,
				position: [bottom, left],
				debug:Constants.TEST_OTO,
				mustValidate: [Yes]
			}
		}
		,
		{
			ereg: new EReg(ExpReg.ALL,"i"),
			input:{
				width:100,
				prefix:APT_ID,
				debug:Constants.TEST_APT_ID,
				buddy: OTO_ID,
				position: [bottom, left],
				mustValidate: [No]
			}
		},
		{
			ereg: new EReg(ExpReg.NAME_MINIMAL,"i"),
			input:{
				width:600,
				prefix:APT_FORMER_OCCUPANT,
				debug:Constants.TEST_APT_FORMER,
				buddy: APT_ID,
				position: [bottom, left],
				mustValidate: [No]
			}
		},
		{
			ereg: new EReg(ExpReg.NUMBEB_ONLY,"i"),
			input:{
				width:100,
				prefix:APT_BUILDING_NB_FLOORS,
				debug:Constants.TEST_APT_FLOOR_NB,
				buddy: APT_FORMER_OCCUPANT,
				position: [bottom, left],
				mustValidate: [No]
			}
		},
		{
			ereg: new EReg(ExpReg.NUMBEB_ONLY,"i"),
			input:{
				width:100,
				prefix:APT_FLOOR_NB,
				debug:Constants.TEST_APT_FLOOR_NB,
				buddy: APT_BUILDING_NB_FLOORS,
				position: [top, right],
				mustValidate: [No]
			}
		}
			]
		);
	}

	/****************************
	* Needed for validation
	*****************************/
	override public function onYesClick():Void
	{
		if (validateYes())
		{
			this._nexts = [ {step: getNext(), params: []}];
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
			this._nexts = [ {step:_TotalFees, params: []}];
			super.onNoClick();
		}
	}

	override public function validateNo():Bool
	{
		var aptid = this.multipleInputs.inputs.get(APT_ID);
		var aptidTxt = aptid.getInputedText().trim();
		var former = this.multipleInputs.inputs.get(APT_FORMER_OCCUPANT);
		var formerTxt = former.getInputedText().trim();
		var nbFloors = this.multipleInputs.inputs.get(APT_BUILDING_NB_FLOORS);
		var nbFloorsTxt = nbFloors.getInputedText().trim();
		var floor = this.multipleInputs.inputs.get(APT_FLOOR_NB);
		var floorTxt = floor.getInputedText().trim();
		aptid.blink(false);
		former.blink(false);
		nbFloors.blink(false);
		floor.blink(false);
		if ( aptidTxt == "" && formerTxt == "" && nbFloorsTxt == "" && floorTxt == "")
		{
			aptid.blink(true);
			former.blink(true);
			nbFloors.blink(true);
			floor.blink(true);
			return false;
		}
		else if ( aptidTxt != "")
		{
			return true;
		}
		else {
			var r = true;
			if ( formerTxt == "" )
			{
				former.blink(true);
				r = r ? false : r;
			}
			if ( nbFloorsTxt == "" )
			{
				nbFloors.blink(true);
				r = r ? false : r;
			}
			if ( floorTxt == "" )
			{
				floor.blink(true);
				r = r ? false : r;
			}
			if ( !r) return false;

		}
		return true;
	}
	override public function onMidClick():Void
	{
		if (validateMid())
		{
			this._nexts = [ {step:_TotalFees, params: []}];
			super.onMidClick();
		}
	}
	inline function getNext():Class<Process>
	{
		#if debug
		trace("front.move._AskForOTO::getNext::MainApp.agent.isMember(SaltAgent.CSR2_GROUP_NAME)", MainApp.agent.isMember(SaltAgent.CSR2_GROUP_NAME) );
		#end
		return MainApp.agent.isMember(SaltAgent.CSR2_GROUP_NAME)?  InputMoveDateandOTOinVTI : _TotalFees;
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