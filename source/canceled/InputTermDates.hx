package canceled;

import regex.ExpReg;
import tstool.process.ActionMultipleInput;
import tstool.process.Process;

/**
 * ...
 * @author bb
 */
class InputTermDates extends ActionMultipleInput
{
	public static inline var DAY_TERM_WAS_REQUESTED:String = "Datetheterminationwasrequested";
	public static inline var ACTUAL_REQUESTED_TERM_DATE:String = "Previouscancelationdate";
	public static inline var NEW_WISHED_TERM_DATE:String = "Newwhishedcancelationdate";
    public static inline var NOTICE_PERIOD:String = "NoticePeriod";
	
	public function new ()
	{
		super(
			[
		{
			ereg: ExpReg.SIMPLE_REVERSE_MINUS_DATE,

			input:{
				width:250,
                debug: "2023-01-01",
				prefix: DAY_TERM_WAS_REQUESTED,
				position: [bottom, left]
			}
		},
		{
			ereg: ExpReg.SIMPLE_REVERSE_MINUS_DATE,
			input:{
				width:300,
                debug: "2023-04-01",
				prefix: ACTUAL_REQUESTED_TERM_DATE,
				buddy: DAY_TERM_WAS_REQUESTED,
				position: [top, right]
			}
		},
		{
			ereg: ~/(30|60)/,
			input:{
				width:150,
                debug: "30",
				prefix: NOTICE_PERIOD,
				buddy: ACTUAL_REQUESTED_TERM_DATE,
				position: [top, right]
			}
		},
		{
			ereg: ExpReg.SIMPLE_REVERSE_MINUS_DATE,
			input:{
				width:250,
                debug: "2023-03-01",
				prefix: NEW_WISHED_TERM_DATE,
				buddy: DAY_TERM_WAS_REQUESTED,
				position: [bottom, left]
			}
		}
			]
		);
	}
	inline function getNext():Class<Process>
	{
		return ComputeAdditionalFees;
	}
    override public function onClick():Void
	{
		if (validate())
		{
			this._nexts = [{step: getNext(), params: []}];
			super.onClick();
		}
	}
}