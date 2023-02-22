package;

import date.DateToolsBB;
import js.Browser;
import tstool.MainApp;
import tstool.layout.UI;
import tstool.process.CheckUpdateSub;
import tstool.process.Descision;
import tstool.process.Process;

/**
 * ...
 * @author bb
 */
class MainIntro extends Descision 
{
    override public function create():Void 
	{
		super.create();
		Process.INIT();
		init();
	}
	override public function onYesClick():Void
	{
		this._nexts = [{step: Intro, params: []}];
		super.onYesClick();
	}
	override public function onNoClick():Void
	{
		this._nexts = [{step: canceled.WhatToDo, params: []}];
		super.onNoClick();
	}
	 function init()
	{
		Main.VERSION_TRACKER.scriptChangedSignal.add(onNewVersion);
		Main.VERSION_TRACKER.request();
		Main.trackH.reset(false);
		Main.trackH.setDefaultContext(MainApp.translator.locale, "fiber.tech.qtool@salt.ch");

		#if !debug
		openSubState(new CheckUpdateSub(UI.THEME.bg));
		#else
		if (Main.DEBUG)
		{
			openSubState(new CheckUpdateSub(UI.THEME.bg));
		}
		else
		{
			onNewVersion(false);
		}
		#end
	}
	function onNewVersion(needsUpdate:Bool):Void
	{
		#if debug
		trace("Intro::onNewVersion");
		#end
		if (needsUpdate)
		{
			Browser.location.reload(true);
		}
		else{
			closeSubState();
			MainApp.VERSION_TIMER_value = MainApp.VERSION_TIMER_DURATION;

			#if debug

			//openSubState(new PageLoader(UI.THEME.bg));
            DateToolsBB.SWISS_TIME = DateToolsBB.CLONE_DateTimeUtc( Main.GREENWICH );
			//MainApp.WORD_TIME.onTimeZone = onTimeChecked;
			//MainApp.WORD_TIME.onError = this.onError;
			//MainApp.WORD_TIME.getTimeZone();
			#else
				DateToolsBB.SWISS_TIME = DateToolsBB.CLONE_DateTimeUtc( Main.GREENWICH );
			#end
		}
	}
}