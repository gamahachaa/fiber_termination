package front.capture;

using string.StringUtils;

import Intro;
import Main;
import canceled.CaptureTerminationOperator;
import canceled.InputTermDates;
import canceled.WhatToDo;
import date.WorldTimeAPI.TimeZone;
import fees._InputDates;
import front.capture._DeathWording;
import front.capture._TransferToWB;
import front.move.IsAdressElligible;
import front.move.MoveHow;
import haxe.Json;
import js.Browser;
import thx.DateTimeUtc;
import tstool.layout.PageLoader;
import tstool.layout.UI;
import tstool.process.CheckUpdateSub;
//import js.Browser;
//import front.move._AskForOTO;
import front.move._InputNewHomeContractDetails;
import tickets._CreateTwoOneTwo;
import tstool.MainApp;
import tstool.layout.History.Interactions;
import tstool.process.MultipleInput.ValidatedInputs;
import tstool.process.Process;
import tstool.process.TripletMultipleInput;
import tstool.salt.Balance;
import tstool.salt.Contractor;
import tstool.salt.Role;
import tstool.utils.Constants;
import date.DateToolsBB;
import regex.ExpReg;
import tstool.utils.VTIdataParser;
import winback.OkForForFWA;
import winback.RetainWithSalesSpeech;
import xapi.Verb;
import tstool.salt.SaltAgent;

/**
 * ...
 * @author
 */
class CheckContractorVTI extends TripletMultipleInput
{
	var parser:tstool.utils.VTIdataParser;
	var sagem:String;
	static inline var CONTRACTOR_ID:String = "Contractor ID";
	static inline var VOIP_NUM:String = "VoIP Number";
	static inline var CONTACT_NUM:String = "Contact Number";
	var status:String;
	var is_sagem:Bool;
	var isForWinBack:Bool;
	var what:Interactions;
	var isModification:Bool;
	var isCancelation:Bool;
	//var isProOffice:Bool;
	var domainInteraction:Interactions;

	public function new()
	{
		status = Main.HISTORY.findValueOfFirstClassInHistory(Intro, Intro.WHY_LEAVE).value;
		isForWinBack = Intro.WINBACKS.indexOf(status) >-1;
		if (Main.HISTORY.isClassInHistory(CaptureDomain))
			domainInteraction = Main.HISTORY.findFirstStepsClassInHistory(CaptureDomain).interaction;
		else domainInteraction = Exit;
		//isProOffice = Main.HISTORY.isClassInteractionInHistory(CaptureDomain, Yes);
		var fileds:Array<ValidatedInputs> = [
		{
			ereg:new EReg(ExpReg.CONTRACTOR_EREG,"i"),
			input:{
				width:200,
				debug: Constants.TEST_CONTRACTOR,
				prefix:CONTRACTOR_ID,
				position: [bottom, left]
			}
		},
		{
			ereg: new EReg(ExpReg.MISIDN_INTL,"i"),
			input:{
				buddy: CONTRACTOR_ID,
				width:200,
				debug: Constants.TEST_VOIP,
				prefix:VOIP_NUM,
				mustValidate: [Yes,No],
				position:[top, right]
			}
		}
		];
		if (!isForWinBack)
		{
			fileds.push(
			{
				ereg: new EReg(ExpReg.MISIDN_INTL,"i"),
				input:{
					buddy: CONTRACTOR_ID,
					width:200,
					debug: Constants.TEST_MSISDN,
					prefix:CONTACT_NUM,
					position:[bottom, left]
				}
			});
		}
		super(fileds);
		//sagem = Assets.getText("assets/data/sagem_fut.txt");

		this.yesValidatedSignal.add(canITrack);
		this.noValidatedSignal.add(canITrack);
		this.midValidatedSignal.add(canITrack);
	}
	function setReminder()
	{

		var displayVoip = Main.customer.voIP.phonSpaces();
		var owner = Main.customer.getOwner();
		var mobile = Main.customer.contract.mobile == "" ? "": "(" + Main.customer.contract.mobile + ")";
		var iri  = Main.customer.iri == "" ? "" : "(" + Main.customer.iri + ")";
		Main.STORAGE_DISPLAY.push(Constants.STORAGE_CONTRACTOR);
		Main.STORAGE_DISPLAY.push(Constants.STORAGE_VOIP);
		Main.STORAGE_DISPLAY.push(Constants.STORAGE_OWNER);
		Main.STORAGE_DISPLAY.push(Constants.STORAGE_CONTACT);
		Main.STORAGE_DISPLAY.push(Constants.CUST_DATA_PRODUCT_BOX);

		Process.STORE(Constants.STORAGE_CONTRACTOR, Main.customer.contract.contractorID );
		if (Main.customer.contract.service != Gigabox)
		{
			Process.STORE(Constants.STORAGE_VOIP, displayVoip );
		}
		Process.STORE(Constants.STORAGE_OWNER, owner );
		if (isForWinBack)
		{
			Process.STORE(Constants.STORAGE_CONTACT, mobile );
		}

		Process.STORE(Constants.CUST_DATA_PRODUCT_BOX, is_sagem? Constants.CUST_DATA_PRODUCT_BOX_SAGEM:  (Main.customer.contract.service == Gigabox ? Std.string(Gigabox) : Constants.CUST_DATA_PRODUCT_BOX_ARCADYAN) );

		/**
		 * @TODO keep clipboard trick to fill clipboard with data
		 */
		//Browser.document.addEventListener("copy", function(e){e.clipboardData.setData('text/plain', Main.customer.voIP);e.preventDefault();});
	}
	function onVtiAccountParsed(profile:Map<String, Map<String, String>>):Void
	{
		#if debug
		trace("onVtiAccountParsed");
		trace(profile);
		#end
		if (!profile.exists("meta") || !profile.exists("plan"))
		{
			if(!profile.exists("meta"))
				trace('missing META');
			if(!profile.exists("plan"))
				trace('missing plan');
			return;
		}
		else{
			var voip = profile.get("plan").exists("vtiVoip")? profile.get("plan").get("vtiVoip"): "";
			is_sagem = voip.indexOf("-") > -1;
			Main.customer.contract = new Contractor(
				profile.get("meta").exists("vtiContractor")? profile.get("meta").get("vtiContractor"):"",
				is_sagem ? StringTools.replace(voip, "- ",""):voip,
				profile.get("plan").exists("vtiFix")? profile.get("plan").get("vtiFix"):"",
				profile.get("plan").exists("vtiMobile")? profile.get("plan").get("vtiMobile"):"",
				profile.get("plan").exists("vtiAdress")? profile.get("plan").get("vtiAdress"):"",
				profile.exists("owner")? new Role(owner,profile.get("owner").get("vtiOwner"),profile.get("owner").get("vtiOwnerEmail")):null,
				profile.exists("payer")? new Role(payer,profile.get("payer").get("vtiPayer"),profile.get("payer").get("vtiPayerEmail")):null,
				new Role(user, profile.get("plan").get("vtiUser"), profile.get("plan").get("vtiUserEmail")),
				profile.exists("owner")? StringTools.trim(profile.get("owner").get("vtiOwnerEmailValidated").toLowerCase()) == "ok":false,
				profile.exists("balance")?new Balance( profile.get("balance").get("vtiBalance"), profile.get("balance").get("vtiOverdue"), profile.get("balance").get("vtiOverdueDate")):null,
				domainInteraction == Yes ? Office : (profile.get("plan").exists("plan") && profile.get("plan").get("plan").indexOf("Giga") >-1)? Gigabox : Fiber
			);
		}

		#if debug
		trace(Main.customer);
		#end
		//question.text = question.text + " <em>" + Main.customer.contract.owner.name + "<em>";
		//question.applyMarkup(question.text, [UI.THEME.basicEmphasis]);
		//question.drawFrame();
		//positionThis();
		multipleInputs.setInputDefault(CONTRACTOR_ID, Main.customer.contract.contractorID);
		multipleInputs.setInputDefault(VOIP_NUM, Main.customer.contract.voip);
		if (!isForWinBack) multipleInputs.setInputDefault(CONTACT_NUM,Main.customer.contract.mobile);
		var p = multipleInputs.positionThis();
		positionButtons(p);
		positionBottom(p);

	}
	override public function update(elapsed)
	{
		super.update(elapsed);
	}
	override public function create():Void
	{
		Main.customer.reset();

		super.create();
		parser = new VTIdataParser(account);
		parser.signal.add( onVtiAccountParsed );
		DateToolsBB.SWISS_TIME = DateToolsBB.CLONE_DateTimeUtc( Main.GREENWICH );
		if (domainInteraction == Mid)
		{
			this.btnMid.visible = true;
			this.btnNo.visible = false;
			this.btnYes.visible = false;

		}
		else if (domainInteraction == Yes)
		{
			// Pro Office
			this.btnMid.visible = false;
			this.btnNo.visible = true;
			this.btnYes.visible = false;
		}
		else if (domainInteraction == No)
		{
			// Pro Office
			this.btnMid.visible = false;
			this.btnNo.visible = true;
			this.btnYes.visible = true;
		}
		else{
			this.btnMid.visible = true;
			this.btnNo.visible = true;
			this.btnYes.visible = true;
		}
	}

	/*function onTimeChecked(data:String)
	{
		var z:TimeZone = Json.parse(data);
		//trace(z);
		try{
		 DateToolsBB.SWISS_TIME = DateTimeUtc.fromString(z.datetime).toDate();
		}
		catch (e){
			trace(e);
			onError(e.message);
		}
	    //DateToolsBB.SWISS_TIME = DateToolsBB.CLONE_DateTimeUtc( 0, DateTimeUtc.fromString(z.datetime) );
		closeSubState();
		moveOn();

	}
	function onError(e:String)
	{
		DateToolsBB.SWISS_TIME = DateToolsBB.CLONE_DateTimeUtc( Main.GREENWICH );
		#if debug
		trace('Intro::onError::DateToolsBB.SWISS_TIME ${DateToolsBB.SWISS_TIME}');
		#end

		closeSubState();
		moveOn();
	}*/
	function moveOn()
	{
		this._nexts = [ {step: getNext()}];
		switch (what)
		{
			case Yes: super.onYesClick();
			case No: super.onNoClick();
			case Mid: super.onMidClick();
			case _ : trace("front.capture.CheckContractorVTI");
		}
	}
	override public function onYesClick():Void
	{
		//var contractorID = vtiContractorUI.getInputedText();
		if (validate(Next))
		{
			//this._nexts = [ {step: getNext()}];
			setUpData(Yes);
			moveOn();
			//super.onYesClick();
		}

	}
	override public function onNoClick():Void
	{
		//var contractorID = vtiContractorUI.getInputedText();
		if (validate(Next))
		{
			//this._nexts = [ {step: getNext()}];
			setUpData(No);
			moveOn();
			//super.onNoClick();
		}

	}
	override public function onMidClick():Void
	{
		//var contractorID = vtiContractorUI.getInputedText();
		if (validate(Next))
		{
			//this._nexts = [ {step: getNext()}];
			setUpData(Mid);
			moveOn();
			//super.onMidClick();
		}

	}
	inline function getNext():Class<Process>
	{
		isModification = Main.HISTORY.isClassInHistory(WhatToDo);

		return
		if (isModification)
		{
			isCancelation = Main.HISTORY.isClassInteractionInHistory( WhatToDo, Yes );
			if (isCancelation)
			{
				CaptureTerminationOperator;
			}
			else
			{
				InputTermDates;
			}
		}
		else if (status == Intro.MOVE_CAN_KEEP)
		{
			if ( Main.HISTORY.isClassInteractionInHistory(MoveHow, Yes) ) // abroad
				_InputDates;
			else if ( Main.HISTORY.isClassInteractionInHistory(MoveHow, Mid))    //and to already Home contracted place
				_InputNewHomeContractDetails;
			else IsAdressElligible;
		}
		else if (status == Intro.DOUBLE_ORDER || status == Intro.GIGA_BOX_DEFEKT)
		{
			_CreateTwoOneTwo;
		}
		else if (status == Intro.PLUG_IN_USE)
		{
			WhyWantToKeepProvider;
		}
		else if (status == Intro.NOT_ELLIGIBLE)
		{
			MainApp.agent.isMember(SaltAgent.WINBACK_GROUP_NAME)? OkForForFWA: _InputDates;
		}
		else if (status == Intro.DEATH)
		{
			_DeathWording;
		}
		else if (status == Intro.MIGRATE_TO_HOME || status == Intro.MIGRATE_TO_PROOFFICE)
		{
			_MigrationCheckList;
		}
		else if (domainInteraction == Yes)
		{
			_InputDates;
		}
		else if (isForWinBack)
		{
			MainApp.agent.isMember(SaltAgent.WINBACK_GROUP_NAME)? RetainWithSalesSpeech: _TransferToWB;
		}
		else{
			_InputDates;
		}
	}

	function setUpData(what:Interactions)
	{
		this.what = what;
		this.parser.destroy();

		Main.customer.contract.contractorID = multipleInputs.getText(CONTRACTOR_ID);
		Main.customer.contract.fix =  multipleInputs.getText(VOIP_NUM);
		//Main.customer.contract.voip = "0" + Main.customer.contract.fix.substr(2);
		Main.customer.contract.voip = Main.customer.contract.fix.intlToLocalMSISDN();
		Main.customer.contract.service = switch (domainInteraction)
		{
			case Yes : Office;
			case No : Fiber;
			case _ : Gigabox;
		}
		Main.customer.iri = (what == No || what == Mid) ? Main.customer.contract.contractorID : Main.customer.contract.voip;
		if (!isForWinBack) Main.customer.contract.mobile = multipleInputs.getText(CONTACT_NUM);

	Main.customer.dataSet.set(Constants.CUST_DATA_PRODUCT, [Constants.CUST_DATA_PRODUCT_BOX => switch(what) {case Yes: Constants.CUST_DATA_PRODUCT_BOX_ARCADYAN; case No:Constants.CUST_DATA_PRODUCT_BOX_SAGEM; case Mid:Constants.CUST_DATA_PRODUCT_BOX_FWA; case _:Constants.CUST_DATA_PRODUCT_BOX_ARCADYAN; }]);
		setReminder();
		
		Main.STORAGE_DISPLAY.push(Constants.SERVICE);
		Process.STORAGE.set( Constants.SERVICE, Std.string(Main.customer.contract.service));
		
	}

	function canITrack(go:Bool)
	{
		if (go)
		{

			Main.trackH.setActor(new xapi.Agent( MainApp.agent.iri, MainApp.agent.sAMAccountName));
			Main.trackH.setVerb(Verb.initialized);

			var extensions:Map<String,Dynamic> = [];
			extensions.set("https://vti.salt.ch/contractor/", Main.customer.contract.contractorID);
			extensions.set("https://vti.salt.ch/voip/", Main.customer.voIP);
			extensions.set(Browser.location.origin +"/troubleshooting/script_version/", Main.VERSION);

			if (isModification)
			{
				if (isCancelation)
				{
					Main.trackH.setActivityObject("cancel_termination",null,null,"http://activitystrea.ms/schema/1.0/process",extensions);
				}
				else
				{
					Main.trackH.setActivityObject("modify_termination",null,null,"http://activitystrea.ms/schema/1.0/process",extensions);
				}
			}
			else Main.trackH.setActivityObject(status.removeWhite(),null,null,"http://activitystrea.ms/schema/1.0/process",extensions);

			Main.trackH.send();
			Main.trackH.setVerb(Verb.resolved);
		}

	}

}