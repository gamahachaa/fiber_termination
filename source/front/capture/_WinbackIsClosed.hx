package front.capture;

import firetongue.Replace;
import flow.End;
import haxe.Json;
import string.StringUtils;
import thx.DateTimeUtc;
import tstool.MainApp;
import tstool.process.Action;
import date.DateToolsBB;
import tstool.utils.Constants;

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
		//var swissTime:Date = DateTimeUtc.fromString( Main.HISTORY.findValueOfFirstClassInHistory(Intro, Intro.SWISS_TIME).value).toDate();
		
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
		//var delta = DateToolsBB.getSeasonDelta();
		for (i in Main.FIBER_WINBACK_UTC_RANGES) 
		{
			//var o = StringUtils.roundedFloat(i.open + delta);
			var o = StringUtils.roundedFloat(i.open);
			//var c = StringUtils.roundedFloat(i.close + delta);
			var c = StringUtils.roundedFloat(i.close);
			t1.push(Replace.flags(r1, ["<START>", "<END>"], [o, c]));
			t2.push(Replace.flags(r2, ["<START>", "<END>"], [o, c]));
		}
		r1Tx = t1.join(join1);
		r2Tx = t2.join(join2);
		
		#if debug
		trace("front.capture._WinbackIsClosed::create::MainApp.translator.locale", MainApp.translator.locale );
		#end
		var wkDays = DateToolsBB.weekDaysMap.get(MainApp.translator.locale);
		#if debug
		trace("front.capture._WinbackIsClosed::create::wkDays", wkDays );
		#end
		var wbOpRng = Constants.FIBER_WINBACK_DAYS_OPENED_RANGE.split(",");
		_titleTxt = Replace.flags(title, ["<R1>", "<R2>", "<FROM>", "<TO>"], 
			[r1Tx, r2Tx, 
			wkDays[Std.parseInt(wbOpRng[0])-1],
			wkDays[Std.parseInt(wbOpRng[wbOpRng.length-1])-1]]);
		#if debug
		trace("front.capture._WinbackIsClosed::create::_titleTxt", _titleTxt );
		#end
		//this.question.text = _titleTxt;
		//this._detailTxt = DateTools.format(swissTime, "Biel/Bienne = %Hh%M %d.%m.%Y") ;
		#if debug
		trace("front.capture._WinbackIsClosed::create::DateToolsBB.SWISS_TIME", DateToolsBB.SWISS_TIME );
		#end
		this._detailTxt = DateToolsBB.weekDaysMap.get(MainApp.translator.locale)[DateToolsBB.SWISS_TIME.getDay()]  + DateTools.format(DateToolsBB.SWISS_TIME, " %e.%m @ %Hh%M (Biel/Bienne)") ;
		super.create();
		
	}
}