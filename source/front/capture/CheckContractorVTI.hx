package front.capture;

using tstool.utils.StringUtils;

import Intro;
import Main;
import fees._InputDates;
import front.capture._DeathWording;
import front.capture._TransferToWB;
import front.move.IsAdressElligible;
import front.move.MoveHow;
import front.move._AskForOTO;
import front.move._InputNewHomeContractDetails;
import tstool.MainApp;
import tstool.layout.History.Interactions;
import tstool.process.MultipleInput.ValidatedInputs;
import tstool.process.Process;
import tstool.process.TripletMultipleInput;
import tstool.salt.Agent;
import tstool.salt.Balance;
import tstool.salt.Contractor;
import tstool.salt.Role;
import tstool.utils.Constants;
import tstool.utils.ExpReg;
import tstool.utils.VTIdataParser;
import winback.OkForForFWA;
import winback.RetainWithSalesSpeech;

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


	public function new()
	{
		status = Main.HISTORY.findValueOfFirstClassInHistory(Intro, Intro.WHY_LEAVE).value;
		isForWinBack = Intro.WINBACKS.indexOf(status) >-1;
		
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
			Process.STORAGE.set(Constants.STORAGE_CONTRACTOR, Main.customer.contract.contractorID );
			if (Main.customer.contract.service != Gigabox) 
			{
				Process.STORAGE.set(Constants.STORAGE_VOIP, displayVoip );
			}
			Process.STORAGE.set(Constants.STORAGE_OWNER, owner );
			if (isForWinBack)
			{
				Process.STORAGE.set(Constants.STORAGE_CONTACT, mobile );
			}
			
			Process.STORAGE.set(Constants.CUST_DATA_PRODUCT_BOX, is_sagem? Constants.CUST_DATA_PRODUCT_BOX_SAGEM:  (Main.customer.contract.service == Gigabox ? Std.string(Gigabox) : Constants.CUST_DATA_PRODUCT_BOX_ARCADYAN) );
			
          
			/**
			 * @TODO keep clipboard trick to fill clipboard with data
			 */
			//Browser.document.addEventListener("copy", function(e){e.clipboardData.setData('text/plain', Main.customer.voIP);e.preventDefault();});
	}
	function onVtiAccountParsed(profile:Map<String, Map<String, String>>):Void 
	{
		#if debug
			//trace("onVtiAccountParsed");
			//trace(profile);
		#end
		if (!profile.exists("meta") || !profile.exists("plan")) return;
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
			(profile.get("plan").exists("plan") ? (profile.get("plan").get("plan").indexOf("Giga")>-1?Gigabox:Fiber):Fiber)
		);
		}
		
		#if debug
			trace(Main.customer);
		#end
		//question.text = question.text + " <em>" + Main.customer.contract.owner.name + "<em>";
		//question.applyMarkup(question.text, [UI.THEME.basicEmphasis]);
		//question.drawFrame();
		positionThis();
		multipleInputs.setInputDefault(CONTRACTOR_ID , Main.customer.contract.contractorID);
		multipleInputs.setInputDefault(VOIP_NUM, Main.customer.contract.voip);
		if(!isForWinBack) multipleInputs.setInputDefault(CONTACT_NUM,Main.customer.contract.mobile);
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
		
		//prepareXAPIMainActivity();
		
		
		super.create();
		parser = new VTIdataParser(account);
		parser.signal.add( onVtiAccountParsed );
	}
	
	override public function onYesClick():Void
	{
		//var contractorID = vtiContractorUI.getInputedText();
		if (validate(Next))
		{
			this._nexts = [{step: getNext()}];
			setUpData(Yes);
			super.onYesClick();
		}
		
	}
	override public function onNoClick():Void
	{
		//var contractorID = vtiContractorUI.getInputedText();
		if (validate(Next))
		{
			this._nexts = [{step: getNext()}];
			setUpData(No);
			super.onNoClick();
		}
		
	}
	override public function onMidClick():Void
	{
		//var contractorID = vtiContractorUI.getInputedText();
		if (validate(Next))
		{
			this._nexts = [{step: getNext()}];
			setUpData(Mid);
			super.onMidClick();
		}
		
	}
	
	inline function getNext():Class<Process>
	{

		//var canTranfer = DateToolsBB.isUTCDayTimeFloatInRange(Constants.FIBER_WINBACK_DAYS_OPENED_RANGE, Constants.FIBER_WINBACK_OPEN_UTC_FLOAT, Constants.FIBER_WINBACK_CLOSE_UTC_FLOAT);
		//var canTranfer = DateToolsBB.isUTCDayTimeFloatInRanges(Constants.FIBER_WINBACK_DAYS_OPENED_RANGE, Constants.FIBER_WINBACK_UTC_RANGES);
		#if debug
		//trace("front.capture.CheckContractorVTI::getNext::status", status );
		//trace("front.capture.CheckContractorVTI::getNext::Agent.WINBACK_GROUP_NAME", Agent.WINBACK_GROUP_NAME );
		//trace("front.capture.CheckContractorVTI::getNext:: MainApp.agent.isMember(Agent.WINBACK_GROUP_NAME)", MainApp.agent.isMember(Agent.WINBACK_GROUP_NAME) );
		//trace("front.capture.CheckContractorVTI::getNext:: AGENT", MainApp.agent );
		#end
		
		/*return switch (status)
		{	

			case Intro.DEATH: _DeathWording; 
			case _:_InputDates;
		}*/
		return 
		if (status == Intro.MOVE_CAN_KEEP)
		{
			if ( Main.HISTORY.isClassInteractionInHistory(MoveHow, Yes) ) // abroad 
			    _InputDates;
			else if ( Main.HISTORY.isClassInteractionInHistory(MoveHow, Mid))    //and to already Home contracted place
				_InputNewHomeContractDetails;
			else IsAdressElligible;
			//else MainApp.agent.isMember(Agent.CSR2_GROUP_NAME)? _AskForOTO : IsAdressElligible;
		}
		else if (status == Intro.PLUG_IN_USE)
		{
			WhyWantToKeepProvider;
		}
		else if (status == Intro.NOT_ELLIGIBLE)
		{
			MainApp.agent.isMember(Agent.WINBACK_GROUP_NAME)? OkForForFWA: _InputDates;
		}
		else if (status == Intro.DEATH)
		{
			_DeathWording; 
		}
		else if (isForWinBack)
		{
			MainApp.agent.isMember(Agent.WINBACK_GROUP_NAME)? RetainWithSalesSpeech: _TransferToWB;
		}
		else{
			_InputDates;
		}
	}
	
	function setUpData(what:Interactions)
	{
		this.parser.destroy();

		Main.customer.contract.contractorID = multipleInputs.getText(CONTRACTOR_ID);
		Main.customer.contract.fix =  multipleInputs.getText(VOIP_NUM);		
		//Main.customer.contract.voip = "0" + Main.customer.contract.fix.substr(2);
		Main.customer.contract.voip = Main.customer.contract.fix.intlToLocalMSISDN();
		Main.customer.iri = (what == No || what == Mid) ? Main.customer.contract.contractorID : Main.customer.contract.voip;
		if(!isForWinBack) Main.customer.contract.mobile = multipleInputs.getText(CONTACT_NUM);
		
		Main.customer.dataSet.set(Constants.CUST_DATA_PRODUCT, [Constants.CUST_DATA_PRODUCT_BOX => switch(what){case Yes: Constants.CUST_DATA_PRODUCT_BOX_ARCADYAN; case No:Constants.CUST_DATA_PRODUCT_BOX_SAGEM; case Mid:Constants.CUST_DATA_PRODUCT_BOX_FWA; case _:Constants.CUST_DATA_PRODUCT_BOX_ARCADYAN; }]);
		setReminder();
		
	}

	function canITrack(go:Bool)
	{
		if (go)
		{
			Main.track.initKeepActor();
			Main.track.setActivity(Intro.GET_VTI_ACTIVITY(status));
			Main.track.setVerb("initialized");
			//Main.track.setStatementRef(null);
			Main.track.setCustomer();
			Main.track.setResolution();
			Main.track.send();
			//Main.track.setVerb("resolved");// will be overridden by ticket creation
		}

	}
	/*function isWinBackCall()
	{
		return switch (status)
		{	
			case Intro.TECH_ISSUES: true;
			case Intro.BILLINGUNDERSTANDING: true;
			case Intro.BILLINGFEES: true;
			case Intro.PRODUCTTECHSPECS: true;
			case Intro.BETTER_OFFER: true;
			case Intro.OTHER: true;
			case Intro.PLUG_IN_USE: true;
			case Intro.CANCEL_TO_REACTIVATE: true;
			case _: false;
		}
	}*/
	/*
	function prepareXAPIMainActivity()
	{
		Main.track.setActivity("TRANSFER_WB");
		if (status == Intro.NO_MORE){ Main.track.setActivity("TRANSFER_WB");} 
		else if (status == Intro.DEATH){ Main.track.setActivity("DEATH"); }
		else if (status == Intro.PLUG_IN_USE){Main.track.setActivity("PLUG_IN_USE");}
		else if (status == Intro.MOVE_CAN_KEEP){Main.track.setActivity("MOVE_CAN_KEEP");}
		else if (status == Intro.MOVE_CANNOT_KEEP){Main.track.setActivity("MOVE_CANNOT_KEEP");}
		else {Main.track.setActivity("TRANSFER_WB"); };
	} */
	
}