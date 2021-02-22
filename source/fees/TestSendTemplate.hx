package fees;

import flow.End;
import tstool.process.Process;
import tstool.process.TripletTemplate;
import tstool.salt.SOTemplate;

/**
 * ...
 * @author bb
 */
class TestSendTemplate extends TripletTemplate 
{

	public function new ()
	{
		super(SOTemplate.FIX_566);
	}
	
	override inline function getNext():Class<Process>{
		return End;
	}
}