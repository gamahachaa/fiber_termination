package fees;

import firetongue.Replace;
import tstool.layout.History.Interactions;
import tstool.process.Descision;

/**
 * ...
 * @author bb
 */
class HasMobileDiscount extends Descision 
{
    public static inline var MOBILE_DISCOUNT:Float = 39.95;
    public static inline var B2C_RC:Float = 49.95;
    public static inline var B2B_RC:Float = 59.95;
	override public function onYesClick():Void
	{
		this._nexts = [{step: IsDoorToDoor, params: []}];
		super.onYesClick();
	}
	override public function onNoClick():Void
	{
		this._nexts = [{step: IsDoorToDoor, params: []}];
		super.onNoClick();
	}
	override public function create():Void 
	{
		var domainInteraction: Interactions = if (Main.HISTORY.isClassInHistory(CaptureDomain))
			Main.HISTORY.findFirstStepsClassInHistory(CaptureDomain).interaction;
		else Exit;
		this._detailTxt = Replace.flags(this._detailTxt, ["<MOBILE_DISCOUNT>", "<NORMAL_RC>"], [Std.string(HasMobileDiscount.MOBILE_DISCOUNT), Std.string(domainInteraction== Yes ? HasMobileDiscount.B2B_RC:HasMobileDiscount.B2C_RC)]);
		super.create();
	}
	
}