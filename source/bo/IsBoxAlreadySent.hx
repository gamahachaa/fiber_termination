package bo;

//import tstool.layout.History;
import tstool.process.Descision;

/**
 * ...
 * @author bb
 */
class IsBoxAlreadySent extends Descision 
{

	override public function create()
	{
		if(Main.HISTORY.isInHistory("bo.HowWasOrderMade", No))
			this._nextNoProcesses = [new _SendReimbursmentForm()];
		else
			this._nextNoProcesses = [new _SendCancelationConfirm()];
		this._nextYesProcesses = [new _CreateTicketFiveFiveOne()];
		super.create();
	}
	
}