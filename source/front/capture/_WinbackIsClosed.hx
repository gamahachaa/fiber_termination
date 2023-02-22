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
		var jsonTitle = Json.parse(this._titleTxt);
		var jsonDetail = Json.parse(this._detailTxt);
		//title
		var title_main = jsonTitle.title_main;
		var title_today_opened = jsonTitle.title_today_opened;
		var title_call_back = jsonTitle.title_call_back;
		var langRangeNow = jsonTitle.r1;
		var langRangeCallUsBack = jsonTitle.r2;
		var joinRangeNow = jsonTitle.join1;
		var joinRangeCallUsBack = jsonTitle.join2;		
		// details
		var details_today = jsonDetail.details_today;
		var details_bankholiday = jsonDetail.details_bankholiday;
		var details_nextclosing_days = jsonDetail.details_nextclosing_days;
		

		var todaysRanges = "";
		var regularOpeningRange = "";
		var t1 = [];
		var t2 = [];
		var regularRanges = DateToolsBB.filterRegularRanges(Main.FIBER_WINBACK_UTC_RANGES);
		//var delta = DateToolsBB.getSeasonDelta();
		for (i in Main.FIBER_WINBACK_UTC_RANGES) 
		{
			if (DateToolsBB.isRangeExcluded(i)) continue;
			t1.push(Replace.flags(langRangeNow, ["<START>", "<END>"], [StringUtils.roundedFloat(i.open), StringUtils.roundedFloat(i.close)]));
		}
		for (i in regularRanges)
		{
			t2.push(Replace.flags(langRangeCallUsBack, ["<START>", "<END>"], [StringUtils.roundedFloat(i.open), StringUtils.roundedFloat(i.close)]));
		}
		todaysRanges = t1.join(joinRangeNow);
		regularOpeningRange = t2.join(joinRangeCallUsBack);
		
		
		var wkDays = DateToolsBB.weekDaysMap.get(MainApp.translator.locale);
		
		var wbOpRng = Main.FIBER_WINBACK_DAYS_OPENED_RANGE.split(",");
		
		title_today_opened = Replace.flags(title_today_opened, ["<R1>"], [todaysRanges]);
		
		title_call_back = Replace.flags(title_call_back, ["<R2>", "<FROM>", "<TO>"], 
			[regularOpeningRange, 
			wkDays[Std.parseInt(wbOpRng[0])],
			wkDays[Std.parseInt(wbOpRng[wbOpRng.length-1])]]);
		_titleTxt = title_main;
		#if debug
		trace("front.capture._WinbackIsClosed::create::details_nextclosing_days", details_nextclosing_days );
		#end
		var closingDays = DateToolsBB.getNextClosedDays(Main.FIBER_WINBACK_BANK_HOLIDAYS).join("\n");

		var todayIsBankHoliday = DateToolsBB.isBankHolidayString(Main.FIBER_WINBACK_BANK_HOLIDAYS, DateToolsBB.SWISS_TIME);
		
		
		if(!todayIsBankHoliday){
			_titleTxt += "\n" + title_today_opened;
		}
		this._titleTxt += "\n" + title_call_back;
		
		this._detailTxt = "";
		if(closingDays !="")
			this._detailTxt += Replace.flags(details_nextclosing_days, ["<CLOSED>"], [closingDays]);
		this._detailTxt += (this._detailTxt==""?"":"\n") + formatStringDate(wkDays[DateToolsBB.SWISS_TIME.getDay()] , details_today);
		if (todayIsBankHoliday){
			this._detailTxt += details_bankholiday;
		}
		super.create();
		
	}
	inline function formatStringDate(weekDay:String, ?init:String="")
	{
		return init + weekDay + DateTools.format(DateToolsBB.SWISS_TIME, " %e.%m @ %Hh%M (Biel/Bienne).");
	}
}