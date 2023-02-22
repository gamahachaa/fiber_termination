package canceled;

import date.DateToolsBB;
import firetongue.Replace;
import haxe.Json;
import js.Browser;
import thx.DateTime;
import tickets.ModifyDateTicket;
//import tickets.ModifyDateTicket;
import tstool.process.Action;
import tstool.utils.VTIdataParser;
import fees._InputDates;
import fees._TotalFees;

/**
 * ...
 * @author bb
 */
class ComputeAdditionalFees extends Action
{
	var fees:Float;
	var newWhishedDate:DateTime;
	var isStandardTerm:Bool;
	var dateInitialTermRequest:thx.DateTime;
	public function new()
	{
		super();
		var data = Main.HISTORY.findAllValuesOffOfFirstClassInHistory(InputTermDates);
		//var newWhishedDateTab = data.get(ModifyTermDate.NEW_WISHED_TERM_DATE).split(".");
		newWhishedDate = DateToolsBB.DATETIME_THX_FROM_MINUS_REVERSE_STRING(data.get(InputTermDates.NEW_WISHED_TERM_DATE));
		//var dateInitialTermRequestTab = data.get(ModifyTermDate.DAY_TERM_WAS_REQUESTED).split(".");
		dateInitialTermRequest = DateToolsBB.DATETIME_THX_FROM_MINUS_REVERSE_STRING(data.get(InputTermDates.DAY_TERM_WAS_REQUESTED));
		isStandardTerm = data.get(InputTermDates.NOTICE_PERIOD) == "60";

		#if debug
		trace("canceled.ComputeAdditionalFees::ComputeAdditionalFees::isStandardTerm", isStandardTerm );
		trace("canceled.ComputeAdditionalFees::ComputeAdditionalFees::newWhishedDate", newWhishedDate );
		trace("canceled.ComputeAdditionalFees::ComputeAdditionalFees::dateInitialTermRequest", dateInitialTermRequest );
		trace("canceled.ComputeAdditionalFees::ComputeAdditionalFees::fees", fees );
		#end

	}
	override public function create():Void
	{
		var jsonTitle = Json.parse(this._titleTxt);
		var jsonDetail = Json.parse(this._detailTxt);
		var noticeNotRespected:Bool = false;

		var noticePeriod = dateInitialTermRequest.nextMonth();
		if ( isStandardTerm )
		{
			noticePeriod = noticePeriod.nextMonth();
		}
		noticeNotRespected = newWhishedDate.toString() < noticePeriod.toString();

		#if debug
		trace("canceled.ComputeAdditionalFees::create::noticeNotRespected", noticeNotRespected );
		trace("canceled.ComputeAdditionalFees::create::noticePeriod", noticePeriod );
		#end

		if (noticeNotRespected)
		{
			this._detailTxt = jsonDetail.notice_not_respected;
			this._titleTxt = jsonTitle.notice_not_respected;
			var nbMonth = isStandardTerm ? 2 : 1;
			this._detailTxt = Replace.flags(this._detailTxt, ["<NBMONTH>"], [Std.string(nbMonth)]);
			this._titleTxt = Replace.flags(this._titleTxt, ["<NBMONTH>"], [Std.string(nbMonth)]);
		}
		else{
			this._detailTxt = jsonDetail.notice_respected;
			this._titleTxt = jsonTitle.notice_respected;
		}
		super.create();
		#if debug
		trace("canceled.ComputeAdditionalFees::create::noticeNotRespected", noticeNotRespected );
		#end
		//var parser = new VTIdataParser(super_office_termination);
		//parser.signal.add( onVtiAccountParsed );
		//Browser.document.addEventListener("paste", onPaste);
	}
	//
	//function onPaste(e):Void
	//{
	//var content = e.clipboardData.getData("text/plain");
	//var previousSO:Map<String,Map<String,String>> = parseSOTermination(content);
	//#if debug
	//trace("canceled.ComputeAdditionalFees::onPaste::previousSO", previousSO );
	//#end
	//}
	//function parseSOTermination(content:String):Map<String,Map<String,String>>
	//{
	////trace(content);
	//var t:Array<String> = content.split("\n");
	//var previousSO:Map<String,Map<String,String>> = [];
	//previousSO.set("dates", []);
	//previousSO.set("data", []);
	//var swissTimeEreg:EReg = new EReg('(${Intro.SWISS_TIME}) ... (20[0-9]{2}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2})',"gi");
	//var orderDateEreg:EReg = new EReg('(${_InputDates.ORDER_DATE}) ... ([0-9]{2}\\.[0-9]{2}\\.20[0-9]{2})',"gi");
	//var termDateEreg:EReg = new EReg('(${_InputDates.TERM_DATE}) ... ([0-9]{2}\\.[0-9]{2}\\.20[0-9]{2})',"gi");
	//var noticePeriodEreg:EReg = new EReg('(${_TotalFees.Noticeperiod}) ... (30|60)',"gi");
	//var noticeNonRespectedFees:EReg = new EReg('(${_TotalFees.Noticenonrespectedfees}) ... ([0-9.]+)',"gi");
	//var terminationIsStandard:EReg = new EReg('(${_TotalFees.Terminationisstandard}) ... (false|true)',"gi");
	//
	//for (i in t)
	//{
	//if (swissTimeEreg.match(i)) previousSO.get("dates").set(swissTimeEreg.matched(1), swissTimeEreg.matched(2));
	//if (orderDateEreg.match(i)) previousSO.get("dates").set(orderDateEreg.matched(1), orderDateEreg.matched(2));
	//if (termDateEreg.match(i)) previousSO.get("dates").set(termDateEreg.matched(1), termDateEreg.matched(2));
	//if (noticePeriodEreg.match(i)) previousSO.get("dates").set(noticePeriodEreg.matched(1), noticePeriodEreg.matched(2));
	//if (noticeNonRespectedFees.match(i)) previousSO.get("data").set(noticeNonRespectedFees.matched(1), noticeNonRespectedFees.matched(2));
	//if (terminationIsStandard.match(i)) previousSO.get("data").set(terminationIsStandard.matched(1), terminationIsStandard.matched(2));
	//}
	////#if debug
	////trace("tstool.utils.VTIdataParser::parseSOTermination::previousSO", previousSO );
	////#end
	//return previousSO;
	//}

	override public function onClick():Void
	{
		this._nexts = [{step: ModifyDateTicket, params: []}];

		super.onClick();
	}

}