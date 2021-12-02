package front.move;

import fees._InputDates;
import tstool.process.ActionMultipleInput;
import tstool.process.DescisionMultipleInput;
import tstool.utils.ExpReg;

/**
 * ...
 * @author bb
 */
class _InputNewHomeContractDetails extends DescisionMultipleInput
{

	static inline var CONTRACTOR_ID:String = "CONTRACTOR ID";
	static inline var FIRST_NAME:String = "First name";
	static inline var LAST_NAME:String = "Last name";
	inline static var ZIP = "Zip";
	inline static var STREET = "Street";
	inline static var NUMBER = "Number";
	inline static var CITY = "City";
	public function new()
	{
		super(
			[
		{
			ereg: new EReg(ExpReg.CONTRACTOR_EREG,"i"),
			input:{
				width:140,
				prefix:CONTRACTOR_ID,
				position: [bottom, left]
			}
		},
		{
			ereg: new EReg(ExpReg.NAME_MINIMAL,"i"),
			input:{
				width: 120,
				prefix: FIRST_NAME,
                buddy: CONTRACTOR_ID,
				debug: "Georges",
				position: [bottom, left],
				mustValidate: [Yes, Mid]
			}
		},
		{
			ereg: new EReg(ExpReg.NAME_MINIMAL,"i"),
			input:{
				width: 120,
				prefix: LAST_NAME,
                buddy: FIRST_NAME,
				debug: "CLOONEY",
				position: [top, right],
				mustValidate: [Yes, Mid]
			}
		},
		{
			ereg: new EReg(ExpReg.STREET,"i"),
			input:{
				width: 240,
				prefix: STREET,
				buddy: FIRST_NAME,
				debug: "Rue du Caudray",
				position: [bottom, left],
				mustValidate: [Yes, Mid]
			}
		}
		,
		{
			ereg: new EReg(ExpReg.ADRESS_NUMBER,"i"),
			input:{
				width: 80,
				prefix: NUMBER,
				buddy: STREET,
				debug: "4",
				position: [top, right],
				mustValidate: [Yes, Mid]
			}
		},
		{
			ereg: new EReg(ExpReg.ZIP,"i"),
			input:{
				width: 60,
				prefix: ZIP,
                buddy: STREET, 
				debug: "1020",
				position: [bottom, left],
				mustValidate: [Yes, Mid]
			}
		},
		{
			ereg: new EReg(ExpReg.CITY,"i"),
			input:{
				width: 120,
				prefix: CITY,
				buddy: ZIP,
				debug: "Renens",
				position: [top, right],
				mustValidate: [Yes, Mid]
			}
		}
			]
		);

	}
	override public function onYesClick():Void
	{
		if (validateYes())
		{
			this._nexts = [{step: _InputDates, params: []}];
			super.onYesClick();
		}
	}
	override public function onNoClick():Void
	{
		this._nexts = [{step: _InputDates, params: []}];
		super.onNoClick();
	}
    override public function validateYes()
	{
		var contractorID = this.multipleInputs.getText(CONTRACTOR_ID) != "";
		var first = this.multipleInputs.getText(FIRST_NAME) != ""; 
		var last = this.multipleInputs.getText(LAST_NAME) != ""; 
		var street = this.multipleInputs.getText(STREET) != ""; 
		var nb = this.multipleInputs.getText(NUMBER) != ""; 
		var zip = this.multipleInputs.getText(ZIP) != ""; 
		var city = this.multipleInputs.getText(CITY) != "";
		if ( contractorID || (first && last && street && nb && zip && city) ) 
			return true;
		else {
			if (!contractorID)  this.multipleInputs.inputs.get(CONTRACTOR_ID).blink(true);
			else{
				if(!first) this.multipleInputs.inputs.get(FIRST_NAME).blink(true);
				if(!last)this.multipleInputs.inputs.get(LAST_NAME).blink(true);
				if(!street)this.multipleInputs.inputs.get(STREET).blink(true);
				if(!nb)this.multipleInputs.inputs.get(NUMBER).blink(true);
				if(!zip)this.multipleInputs.inputs.get(ZIP).blink(true);
				if(!city)this.multipleInputs.inputs.get(CITY).blink(true);
			}
				
			return false;
		}
	}
	override public function validateNo()
	{
		return true;
	}
	
}