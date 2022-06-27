package front.capture;

import firetongue.Replace;
import flow.End;
import haxe.Json;
import string.StringUtils;
import tstool.process.Action;
import tstool.utils.DateToolsBB;

/**
 * ...
 * @author bb
 */
class _WinbackIsClosed extends Action 
{

	override public function onClick():Void
	{
		this._nexts = [{step: End, params: []}];
		super.onClick();
	}
	override public function create():Void{
		super.create();
		#if debug
		trace("front.capture._WinbackIsClosed::create::this._titleTxt", this._titleTxt );
		#end
		var jsonTitle = Json.parse(this._titleTxt);
		var title = jsonTitle.title;
		var r1 = jsonTitle.r1;
		var r2 = jsonTitle.r2;
		var join1 = jsonTitle.join1;
		var join2 = jsonTitle.join2;
		var r1Tx = "";
		var r2Tx = "";
		var t1 = [];
		var t2 = [];
		var delta = DateToolsBB.getSeasonDelta();
		for (i in Main.FIBER_WINBACK_UTC_RANGES) 
		{
			var o = StringUtils.roundedFloat(i.open + delta);
			var c = StringUtils.roundedFloat(i.close + delta);
			t1.push(Replace.flags(r1, ["<START>", "<END>"], [o, c]));
			t2.push(Replace.flags(r2, ["<START>", "<END>"], [o, c]));
		}
		r1Tx = t1.join(join1);
		r2Tx = t2.join(join2);
		
		_titleTxt = Replace.flags(title, ["<R1>", "<R2>"], [r1Tx, r2Tx]);
		#if debug
		trace("front.capture._WinbackIsClosed::create::_titleTxt", _titleTxt );
		#end
		this.question.text = _titleTxt;
	}
}