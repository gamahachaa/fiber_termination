package front.fees;

/**
 * ...
 * @author bb
 */
class _ChargeCancelationFees 
{

	override public function onClick():Void
	{
		this._nexts = [{step: _RefundActivationFees, params: []}];
		super.onClick();
	}
	
}