package front.capture;

import haxe.Json;
import tickets._MigrationTicket;
import tstool.layout.History.Interactions;
import tstool.process.ActionCheck;

/**
 * ...
 * @author bb
 */
class _MigrationCheckList extends ActionCheck
{
	static public inline var WISH_DATE_INFO:String = "wishDateInfo";
	static public inline var UNIQUE_FEES_INFO:String = "uniqueFeesInfo";
	static public inline var INVOICE_CLEARED_INFO:String = "invoiceClearedInfo";
	static public inline var INFO_VOICEMAIL_OUT:String = "infoVoicemailOut";
	static public inline var INFO_FNP:String = "infoFnp";
	static public inline var WANTS_APPLE_TV:String = "wantsAppleTv";
	static public inline var INFO_NO_MORE_TV_SERVICE:String = "infoNoMoreTvService";
	static public inline var WANTS_TO_KEEP_A_VOIPNUM:String = "wantsToKeepAVoipnum";
	static public inline var WANTS_TO_KEEP_HIS_VOIPNUM:String = "wantsToKeepHisVoipnum";
	static public inline var INFO_FEES:String = "infoFeesChanges";
	var statusIntro:String;
	var domainInteraction:Interactions;

	public function new()
	{
		domainInteraction = Main.HISTORY.findFirstStepsClassInHistory(CaptureDomain).interaction;
		statusIntro = Main.HISTORY.findValueOfFirstClassInHistory(Intro, Intro.WHY_LEAVE).value;
		var cks: Array<String> = if (statusIntro == Intro.MIGRATE_TO_HOME)
		{
			[
				WISH_DATE_INFO,
				UNIQUE_FEES_INFO,
				INVOICE_CLEARED_INFO,
				INFO_VOICEMAIL_OUT,
				INFO_FNP,
				WANTS_TO_KEEP_A_VOIPNUM,
				WANTS_APPLE_TV
			];
		}
		else
		{
			if (domainInteraction == Mid)
			{
				// from Gigabox
				[
					WISH_DATE_INFO,
					UNIQUE_FEES_INFO,
					INVOICE_CLEARED_INFO,
					/*INFO_VOICEMAIL_OUT,
					INFO_FNP,
					WANTS_TO_KEEP_HIS_VOIPNUM,*/
					INFO_NO_MORE_TV_SERVICE
				];
			}
			else
			{
				[
					WISH_DATE_INFO,
					UNIQUE_FEES_INFO,
					INFO_FEES,
					INVOICE_CLEARED_INFO,
					INFO_VOICEMAIL_OUT,
					INFO_FNP,
					INFO_NO_MORE_TV_SERVICE,
					WANTS_TO_KEEP_HIS_VOIPNUM
					
				];
			}
		}
		var mustBeTrue =if (statusIntro == Intro.MIGRATE_TO_HOME)
		{
			[
				WISH_DATE_INFO,
				UNIQUE_FEES_INFO,
				INVOICE_CLEARED_INFO,
				INFO_VOICEMAIL_OUT,
				INFO_FNP
			];
		}
		else
		{
			if (domainInteraction == Mid)
			{
				// from Gigabox
				[
					WISH_DATE_INFO,
					UNIQUE_FEES_INFO,
					INVOICE_CLEARED_INFO,
					/*INFO_VOICEMAIL_OUT,
					INFO_FNP,*/
					INFO_NO_MORE_TV_SERVICE
				];
			}
			else
			{
				[
					WISH_DATE_INFO,
					UNIQUE_FEES_INFO,
					INFO_FEES,
					INVOICE_CLEARED_INFO,
					INFO_VOICEMAIL_OUT,
					INFO_FNP,
					INFO_NO_MORE_TV_SERVICE
				];
			}

		}
		var skip = if (statusIntro == Intro.MIGRATE_TO_HOME)
		{
			[
				WANTS_TO_KEEP_A_VOIPNUM,
				WANTS_APPLE_TV
			];
		}
		else
		{
			[
				WANTS_TO_KEEP_HIS_VOIPNUM
			];
		}
		super(cks, mustBeTrue, [], skip, 950);

	}
	override public function onClick():Void
	{
		if (validate())
		{
			this._nexts = if (statusIntro == Intro.MIGRATE_TO_HOME && this.status.get(WANTS_TO_KEEP_A_VOIPNUM))
				[ {step: InputWantedVoip}];
			else {
				if(domainInteraction == Mid)[ {step: MakeAProOfficeContract}];
				else [ {step: _InputNewContractor}];
				//else [ {step: _MigrationTicket}];
			}
			super.onClick();
		}
	}
	override public function create():Void
	{
		var jsonDetails = Json.parse( this._detailTxt );
		//var jsonTitle = Json.parse( this._titleTxt );
		this._detailTxt = if (statusIntro == Intro.MIGRATE_TO_HOME)
		{
			jsonDetails.mig_to_home;
		}
		else{
			if (domainInteraction == Mid)
			{
				jsonDetails.mig_to_pro_office_from_fwa;
			}
			else{
				jsonDetails.mig_to_pro_office;
			}
		}
		//this._titleTxt = if (domainInteraction == Mid)
		//{
			//jsonTitle.mig_no_choices;
		//}
		//else{
			//jsonTitle.mig_with_choice;
		//}

		super.create();
	}

}

/*
$front.capture._MigrationCheckList.wishDateInfo	Le service technique contactera pour préciser la date de migration qui interviendra dans les 2 mois.
$front.capture._MigrationCheckList.uniqueFeesInfo	Il y a des frais uniques de CHF 99.95
$front.capture._MigrationCheckList.invoiceClearedInfo	Les factures impayées doivent être réglées avant la migration.
$front.capture._MigrationCheckList.infoVoicemailOut	Le service de boîte vocale ne sera plus disponible.
$front.capture._MigrationCheckList.infoFnp	La migration n’aura lieu que lorsque le FNP en cours sur le contrat actif sera terminé.
$front.capture._MigrationCheckList.wantsToKeepAVoipnum	Le client souhaite conserver un numéro VoIP ?
$front.capture._MigrationCheckList.wantsToKeepHisVoipnum	Le client souhaite conserver son numéro VoIP ?
$front.capture._MigrationCheckList.wantsAppleTv	Le client souhaite commander une TV avec Salt Home?
$front.capture._MigrationCheckList.infoNoMoreTvService	Le service TV ne sera plus disponible !
*/