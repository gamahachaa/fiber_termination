package front.capture;

//import flixel.FlxG;

import flow.End;
import Intro;
import front.move.IsAdressElligible;
import front.capture._CompareWishAndTermDates;
import front.capture._DeathWording;
import front.capture._TransferToWB;
import fees._InputDates;
import layout.LoginCan;
import lime.utils.Assets;
import tstool.MainApp;
import tstool.layout.UI;
import tstool.process.ActionMultipleInput;
import tstool.process.Process;
import tstool.salt.Balance;
import tstool.salt.Contractor;
import tstool.salt.Role;
import tstool.utils.VTIdataParser;
import tstool.process.DescisionMultipleInput;
import Main;
import winback.CheckFWAElligibility;
import winback.RetainWithSalesSpeech;
//import tstool.utils.XapiTracker;

/**
 * ...
 * @author
 */
class CheckContractorVTI extends ActionMultipleInput
{
	var parser:tstool.utils.VTIdataParser;
	var sagem:String;
	static inline var CONTRACTOR_ID:String = "Contractor ID";
	static inline var VOIP_NUM:String = "VoIP Number";
	static inline var CONTACT_NUM:String = "Contact Number";
	var status:String;
	public static inline var CUST_DATA_PRODUCT:String = "PRODUCTS";
	public static inline var CUST_DATA_PRODUCT_BOX:String = "BOX";
	public static inline var SAGEM:String = "Sagem";
	public static inline var ARCADYAN:String = "Arcadyan";

	public function new()
	{
		super(
			[
				{
					ereg:new EReg("^3\\d{7}$","i"),
					input:{
						width:150,
						debug: "30001047",
						prefix:CONTRACTOR_ID,
						position: [bottom, left]
					}
				},
				{
					ereg: new EReg("^41\\d{9}$","i"),
					input:{
						buddy: CONTRACTOR_ID,
						width:150,
						debug: "41212180513",
						prefix:VOIP_NUM,
						position:[top, right]
					}
				},
				{
					ereg: new EReg("^41\\d{9}$","i"),
					input:{
						buddy: CONTRACTOR_ID,
						width:150,
						debug: "41787878814",
						prefix:CONTACT_NUM,
						position:[bottom, left]
					}
				}
			]
		);
		sagem = Assets.getText("assets/data/sagem_fut.txt");
		
		this.nextValidatedSignal.add(canITrack);
	}
	function setReminder()
	{
		//081 304 10 13
			var voip = Main.customer.voIP.split("");
			voip.insert(8, " ");
			voip.insert(6, " ");
			voip.insert(3, " ");
			
			var displayVoip = voip.join("");
			var owner = Main.customer.contract.owner == null? "": Main.customer.contract.owner.name == null?"":Main.customer.contract.owner.name;
			var mobile = Main.customer.contract.mobile == "" ? "": "(" + Main.customer.contract.mobile + ")";
			var iri  = Main.customer.iri == "" ? "" : "(" + Main.customer.iri + ")";
			//Process.STORAGE.set("reminder", '$displayVoip $iri\n$owner $mobile' );
			Process.STORAGE.set("CONTRACTOR", Main.customer.contract.contractorID );
			Process.STORAGE.set("VOIP", displayVoip );
			Process.STORAGE.set("OWNER", owner );
			Process.STORAGE.set("CONTACT", mobile );
			

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
		if (!profile.exists("meta") || !profile.exists("plan")) return;
		else 
		Main.customer.contract = new Contractor(
			profile.get("meta").exists("vtiContractor")? profile.get("meta").get("vtiContractor"):"",
			profile.get("plan").exists("vtiVoip")? StringTools.replace(profile.get("plan").get("vtiVoip"), "- ",""):"",
			profile.get("plan").exists("vtiFix")? profile.get("plan").get("vtiFix"):"",
			profile.get("plan").exists("vtiMobile")? profile.get("plan").get("vtiMobile"):"",
			profile.get("plan").exists("vtiAdress")? profile.get("plan").get("vtiAdress"):"",
			profile.exists("owner")? new Role(owner,profile.get("owner").get("vtiOwner"),profile.get("owner").get("vtiOwnerEmail")):null,
			profile.exists("payer")? new Role(payer,profile.get("payer").get("vtiPayer"),profile.get("payer").get("vtiPayerEmail")):null,
			new Role(user, profile.get("plan").get("vtiUser"), profile.get("plan").get("vtiUserEmail")),
			profile.exists("owner")? StringTools.trim(profile.get("owner").get("vtiOwnerEmailValidated").toLowerCase()) == "ok":false,
			profile.exists("balance")?new Balance( profile.get("balance").get("vtiBalance"), profile.get("balance").get("vtiOverdue"), profile.get("balance").get("vtiOverdueDate")):null
		);
		#if debug
			trace(Main.customer);
		#end
		question.text = question.text + " <em>" + Main.customer.contract.owner.name + "<em>";
		question.applyMarkup(question.text, [UI.THEME.basicEmphasis]);
		question.drawFrame();
		positionThis();
		multipleInputs.inputs.get(CONTRACTOR_ID).inputtextfield.text = Main.customer.contract.contractorID;
		multipleInputs.inputs.get(VOIP_NUM).inputtextfield.text = Main.customer.contract.voip;
		multipleInputs.inputs.get(CONTACT_NUM).inputtextfield.text = Main.customer.contract.mobile;
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
		status = Main.HISTORY.findValueOfFirstClassInHistory(Intro, Intro.WHY_LEAVE).value;
		prepareXAPIMainActivity();
		
		super.create();
		parser = new VTIdataParser(account);
		parser.signal.add( onVtiAccountParsed );
	}
	
	override public function onClick():Void
	{
		//var contractorID = vtiContractorUI.getInputedText();
		if (validate())
		{
			this._nexts = [{step: getNext()}];
			setUpData();
			super.onClick();
		}
		
	}
	
	//override public function onNoClick():Void
	//{
		//if (validateNo())
		//{
			//this._nexts = [{step: getNext(false), params: []}];
			//setUpData();
			//super.onNoClick();
		//}
		//
	//}
	inline function getNext():Class<Process>
	{
		return if (!MainApp.agent.isMember(LoginCan.WINBACK_GROUP_NAME))
		{
			if (status == Intro.DEATH){_DeathWording; }
			else if (status == Intro.PLUG_IN_USE){_CompareWishAndTermDates;}
			else if (status == Intro.MOVE_CAN_KEEP){IsAdressElligible;}
			else if (status == Intro.MOVE_LEAVE_CH){_InputDates;}
			else { _TransferToWB; };
		}
		else{
			status == Intro.NOT_ELLIGIBLE ? CheckFWAElligibility : RetainWithSalesSpeech;
		}
		
	}	
	function setUpData()
	{
		this.parser.destroy();

		Main.customer.contract.contractorID = multipleInputs.inputs.get(CONTRACTOR_ID).getInputedText();
		Main.customer.contract.fix =  multipleInputs.inputs.get(VOIP_NUM).getInputedText();		
		Main.customer.contract.voip = "0" + Main.customer.contract.fix.substr(2);
		Main.customer.iri = isSagem(Main.customer.contract.contractorID) ? Main.customer.contract.contractorID : Main.customer.contract.voip;
		Main.customer.contract.mobile = multipleInputs.inputs.get(CONTACT_NUM).getInputedText();
		
		Main.customer.dataSet.set(CUST_DATA_PRODUCT, [CUST_DATA_PRODUCT_BOX => (isSagem(Main.customer.contract.contractorID)?SAGEM:ARCADYAN)]);
		setReminder();
	}

	//override function validateNo()
	//{
		//return true;
	//}
	function isSagem(contrator:String)
	{
		return sagem.indexOf(contrator) >-1;
	}
	function canITrack(go:Bool)
	{
		if (go)
		{
			Main.track.setVerb("initialized");
			Main.track.setStatementRef(null);
			Main.track.setCustomer();
			Main.track.send();
			Main.track.setVerb("resolved");
		}

	}
	
	function prepareXAPIMainActivity()
	{
		
		if (status == Intro.NO_MORE){ Main.track.setActivity("TRANSFER_WB");} 
		else if (status == Intro.DEATH){ Main.track.setActivity("DEATH"); }
		else if (status == Intro.PLUG_IN_USE){Main.track.setActivity("PLUG_IN_USE");}
		else if (status == Intro.MOVE_CAN_KEEP){Main.track.setActivity("MOVE_CAN_KEEP");}
		else if (status == Intro.MOVE_CANNOT_KEEP){Main.track.setActivity("MOVE_CANNOT_KEEP");}
		else {Main.track.setActivity("TRANSFER_WB"); };
	}
	
}