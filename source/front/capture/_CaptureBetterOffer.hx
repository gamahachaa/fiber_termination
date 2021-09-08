package front.capture;

//import tickets._CreateTicketSixForOne;
import tickets._CreateTicketSixForOne_close;
import tickets._CreateTicketSixForOne_open;
import tstool.process.ActionMultipleInput;
import tstool.process.Process;
import tstool.utils.Constants;
import tstool.utils.DateToolsBB;

/**
 * ...
 * @author bb
 */
class _CaptureBetterOffer extends ActionMultipleInput 
{
	static inline var PROVIDER:String = "Provider";
	static inline var TECHNO:String = "Technology";
	static inline var DETAILS:String = "Details";
	static inline var PRICE:String = "price";

	public function new ()
	{
		super(
		[
			{
				ereg: new EReg("[\\s\\S]*","i"),
				input:{
					width:250,
					prefix:PROVIDER,
					position: [bottom, left]
				}
			},
			{
				ereg: new EReg("[\\s\\S]*","i"),
				input:{
					
					width:250,
					prefix:TECHNO,
					buddy: PROVIDER,
					position: [bottom, left]
				}
			},
			{
				ereg: new EReg("[\\s\\S]*","i"),
				input:{
					width:500,
					prefix:DETAILS,
					buddy: TECHNO,
					position: [bottom, left]
				}
			},
			{
				ereg: new EReg("[\\s\\S]*","i"),
				input:{
					width:80,
					prefix:PRICE,
					buddy: DETAILS,
					position: [bottom, left]
				}
			}
		
		]
		);
	}
	
	
	override public function onClick():Void
	{
		if (validate())
		{
			this._nexts = [{step: getNext(), params: []}];
			super.onClick();
		}
	}
	inline function getNext():Class<Process>{
		var canTranfer = DateToolsBB.isUTCDayTimeFloatInRange(Constants.FIBER_WINBACK_DAYS_OPENED_RANGE, Constants.FIBER_WINBACK_OPEN_UTC_FLOAT, Constants.FIBER_WINBACK_CLOSE_UTC_FLOAT);
			
		return canTranfer ? _CreateTicketSixForOne_open: _CreateTicketSixForOne_close;;
	}
	/****************************
	* Needed only for validation
	*****************************/
	/*
	override public function validate():Bool
	{
		return true;
	}
	*/
	
}