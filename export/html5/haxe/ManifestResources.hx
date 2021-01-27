package;


import haxe.io.Bytes;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

		}

		if (rootPath == null) {

			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif console
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_jetbrainsmono_bold_italic_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_jetbrainsmono_bold_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_jetbrainsmono_extrabold_italic_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_jetbrainsmono_extrabold_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_jetbrainsmono_italic_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_jetbrainsmono_medium_italic_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_jetbrainsmono_medium_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_jetbrainsmono_regular_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_lato_black_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_lato_regular_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end

		var data, manifest, library, bundle;

		#if kha

		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);

		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");

		#else

		data = '{"name":null,"assets":"aoy4:pathy26:assets%2Fdata%2Fadmins.txty4:sizei35y4:typey4:TEXTy2:idR1y7:preloadtgoR2i145004R3y4:FONTy9:classNamey51:__ASSET__assets_fonts_jetbrainsmono_bold_italic_ttfR5y46:assets%2Ffonts%2FJetBrainsMono-Bold-Italic.ttfR6tgoR2i138692R3R7R8y44:__ASSET__assets_fonts_jetbrainsmono_bold_ttfR5y39:assets%2Ffonts%2FJetBrainsMono-Bold.ttfR6tgoR2i145672R3R7R8y56:__ASSET__assets_fonts_jetbrainsmono_extrabold_italic_ttfR5y51:assets%2Ffonts%2FJetBrainsMono-ExtraBold-Italic.ttfR6tgoR2i139168R3R7R8y49:__ASSET__assets_fonts_jetbrainsmono_extrabold_ttfR5y44:assets%2Ffonts%2FJetBrainsMono-ExtraBold.ttfR6tgoR2i141572R3R7R8y46:__ASSET__assets_fonts_jetbrainsmono_italic_ttfR5y41:assets%2Ffonts%2FJetBrainsMono-Italic.ttfR6tgoR2i144528R3R7R8y53:__ASSET__assets_fonts_jetbrainsmono_medium_italic_ttfR5y48:assets%2Ffonts%2FJetBrainsMono-Medium-Italic.ttfR6tgoR2i138276R3R7R8y46:__ASSET__assets_fonts_jetbrainsmono_medium_ttfR5y41:assets%2Ffonts%2FJetBrainsMono-Medium.ttfR6tgoR2i136708R3R7R8y47:__ASSET__assets_fonts_jetbrainsmono_regular_ttfR5y42:assets%2Ffonts%2FJetBrainsMono-Regular.ttfR6tgoR2i114588R3R7R8y36:__ASSET__assets_fonts_lato_black_ttfR5y31:assets%2Ffonts%2FLato-Black.ttfR6tgoR2i120196R3R7R8y38:__ASSET__assets_fonts_lato_regular_ttfR5y33:assets%2Ffonts%2FLato-Regular.ttfR6tgoR0y45:assets%2Fimages%2FCustomPreload%2Fdefault.pngR2i37490R3y5:IMAGER5R29R6tgoR0y29:assets%2Fimages%2Fdefault.pngR2i210155R3R30R5R31R6tgoR0y35:assets%2Fimages%2Fui%2Fall-good.pngR2i4661R3R30R5R32R6tgoR0y31:assets%2Fimages%2Fui%2Fback.pngR2i4038R3R30R5R33R6tgoR0y36:assets%2Fimages%2Fui%2FclipBoard.pngR2i2456R3R30R5R34R6tgoR0y32:assets%2Fimages%2Fui%2Fclose.pngR2i4989R3R30R5R35R6tgoR0y34:assets%2Fimages%2Fui%2Fcomment.pngR2i3964R3R30R5R36R6tgoR0y29:assets%2Fimages%2Fui%2Fde.pngR2i3550R3R30R5R37R6tgoR0y31:assets%2Fimages%2Fui%2Fdown.pngR2i4015R3R30R5R38R6tgoR0y29:assets%2Fimages%2Fui%2Fen.pngR2i3502R3R30R5R39R6tgoR0y31:assets%2Fimages%2Fui%2Fexit.pngR2i4639R3R30R5R40R6tgoR0y29:assets%2Fimages%2Fui%2Ffr.pngR2i3603R3R30R5R41R6tgoR0y31:assets%2Fimages%2Fui%2Fhelp.pngR2i7180R3R30R5R42R6tgoR0y32:assets%2Fimages%2Fui%2Fhowto.pngR2i8937R3R30R5R43R6tgoR0y29:assets%2Fimages%2Fui%2Fit.pngR2i1994R3R30R5R44R6tgoR0y31:assets%2Fimages%2Fui%2Fleft.pngR2i4011R3R30R5R45R6tgoR0y32:assets%2Fimages%2Fui%2Flight.pngR2i7477R3R30R5R46R6tgoR0y31:assets%2Fimages%2Fui%2Fmail.pngR2i21955R3R30R5R47R6tgoR0y32:assets%2Fimages%2Fui%2Fright.pngR2i3928R3R30R5R48R6tgoR0y34:assets%2Fimages%2Fui%2FshowPwd.pngR2i8423R3R30R5R49R6tgoR0y39:assets%2Fimages%2Fui%2FtrainingMode.pngR2i6934R3R30R5R50R6tgoR0y41:assets%2Fimages%2Fui%2FtutoKeyboardDE.pngR2i170223R3R30R5R51R6tgoR0y41:assets%2Fimages%2Fui%2FtutoKeyboardEN.pngR2i167807R3R30R5R52R6tgoR0y41:assets%2Fimages%2Fui%2FtutoKeyboardFR.pngR2i169989R3R30R5R53R6tgoR0y41:assets%2Fimages%2Fui%2FtutoKeyboardIT.pngR2i169484R3R30R5R54R6tgoR0y34:assets%2Fimages%2Fui%2Fversion.pngR2i33131R3R30R5R55R6tgoR0y37:assets%2Fimages%2Fvti%2Faddnotede.pngR2i22078R3R30R5R56R6tgoR0y37:assets%2Fimages%2Fvti%2Faddnoteen.pngR2i19767R3R30R5R57R6tgoR0y37:assets%2Fimages%2Fvti%2Faddnotefr.pngR2i20102R3R30R5R58R6tgoR0y37:assets%2Fimages%2Fvti%2Faddnoteit.pngR2i17157R3R30R5R59R6tgoR0y17:assets%2Flime.svgR2i2895R3R4R5R60R6tgoR0y32:assets%2Flocales%2Fcan_index.xmlR2i2788R3R4R5R61R6tgoR0y41:assets%2Flocales%2Fde-DE%2Fcan_all_de.txtR2i289R3R4R5R62R6tgoR0y40:assets%2Flocales%2Fde-DE%2Fcan_bo_de.txtR2i1605R3R4R5R63R6tgoR0y43:assets%2Flocales%2Fde-DE%2Fcan_front_de.txtR2i1174R3R4R5R64R6tgoR0y38:assets%2Flocales%2Fde-DE%2Fmeta_de.txtR2i458R3R4R5R65R6tgoR0y41:assets%2Flocales%2Fen-GB%2Fcan_all_en.txtR2i289R3R4R5R66R6tgoR0y40:assets%2Flocales%2Fen-GB%2Fcan_bo_en.txtR2i1605R3R4R5R67R6tgoR0y43:assets%2Flocales%2Fen-GB%2Fcan_front_en.txtR2i1174R3R4R5R68R6tgoR0y38:assets%2Flocales%2Fen-GB%2Fmeta_en.txtR2i414R3R4R5R69R6tgoR0y41:assets%2Flocales%2Ffr-FR%2Fcan_all_fr.txtR2i289R3R4R5R70R6tgoR0y40:assets%2Flocales%2Ffr-FR%2Fcan_bo_fr.txtR2i1605R3R4R5R71R6tgoR0y43:assets%2Flocales%2Ffr-FR%2Fcan_front_fr.txtR2i1174R3R4R5R72R6tgoR0y38:assets%2Flocales%2Ffr-FR%2Fmeta_fr.txtR2i474R3R4R5R73R6tgoR0y41:assets%2Flocales%2Fit-IT%2Fcan_all_it.txtR2i289R3R4R5R74R6tgoR0y40:assets%2Flocales%2Fit-IT%2Fcan_bo_it.txtR2i1605R3R4R5R75R6tgoR0y43:assets%2Flocales%2Fit-IT%2Fcan_front_it.txtR2i1174R3R4R5R76R6tgoR0y38:assets%2Flocales%2Fit-IT%2Fmeta_it.txtR2i455R3R4R5R77R6tgoR2i2114R3y5:MUSICR5y26:flixel%2Fsounds%2Fbeep.mp3y9:pathGroupaR79y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i39706R3R78R5y28:flixel%2Fsounds%2Fflixel.mp3R80aR82y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i5794R3y5:SOUNDR5R81R80aR79R81hgoR2i33629R3R84R5R83R80aR82R83hgoR2i15744R3R7R8y35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R7R8y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i519R3R30R5R89R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i3280R3R30R5R90R6tgoR0y34:flixel%2Fflixel-ui%2Fimg%2Fbox.pngR2i912R3R30R5R91R6tgoR0y37:flixel%2Fflixel-ui%2Fimg%2Fbutton.pngR2i433R3R30R5R92R6tgoR0y48:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_down.pngR2i446R3R30R5R93R6tgoR0y48:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_left.pngR2i459R3R30R5R94R6tgoR0y49:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_right.pngR2i511R3R30R5R95R6tgoR0y46:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_up.pngR2i493R3R30R5R96R6tgoR0y42:flixel%2Fflixel-ui%2Fimg%2Fbutton_thin.pngR2i247R3R30R5R97R6tgoR0y44:flixel%2Fflixel-ui%2Fimg%2Fbutton_toggle.pngR2i534R3R30R5R98R6tgoR0y40:flixel%2Fflixel-ui%2Fimg%2Fcheck_box.pngR2i922R3R30R5R99R6tgoR0y41:flixel%2Fflixel-ui%2Fimg%2Fcheck_mark.pngR2i946R3R30R5R100R6tgoR0y37:flixel%2Fflixel-ui%2Fimg%2Fchrome.pngR2i253R3R30R5R101R6tgoR0y42:flixel%2Fflixel-ui%2Fimg%2Fchrome_flat.pngR2i212R3R30R5R102R6tgoR0y43:flixel%2Fflixel-ui%2Fimg%2Fchrome_inset.pngR2i192R3R30R5R103R6tgoR0y43:flixel%2Fflixel-ui%2Fimg%2Fchrome_light.pngR2i214R3R30R5R104R6tgoR0y44:flixel%2Fflixel-ui%2Fimg%2Fdropdown_mark.pngR2i156R3R30R5R105R6tgoR0y41:flixel%2Fflixel-ui%2Fimg%2Ffinger_big.pngR2i1724R3R30R5R106R6tgoR0y43:flixel%2Fflixel-ui%2Fimg%2Ffinger_small.pngR2i294R3R30R5R107R6tgoR0y38:flixel%2Fflixel-ui%2Fimg%2Fhilight.pngR2i129R3R30R5R108R6tgoR0y36:flixel%2Fflixel-ui%2Fimg%2Finvis.pngR2i128R3R30R5R109R6tgoR0y41:flixel%2Fflixel-ui%2Fimg%2Fminus_mark.pngR2i136R3R30R5R110R6tgoR0y40:flixel%2Fflixel-ui%2Fimg%2Fplus_mark.pngR2i147R3R30R5R111R6tgoR0y36:flixel%2Fflixel-ui%2Fimg%2Fradio.pngR2i191R3R30R5R112R6tgoR0y40:flixel%2Fflixel-ui%2Fimg%2Fradio_dot.pngR2i153R3R30R5R113R6tgoR0y37:flixel%2Fflixel-ui%2Fimg%2Fswatch.pngR2i185R3R30R5R114R6tgoR0y34:flixel%2Fflixel-ui%2Fimg%2Ftab.pngR2i201R3R30R5R115R6tgoR0y39:flixel%2Fflixel-ui%2Fimg%2Ftab_back.pngR2i210R3R30R5R116R6tgoR0y44:flixel%2Fflixel-ui%2Fimg%2Ftooltip_arrow.pngR2i18509R3R30R5R117R6tgoR0y39:flixel%2Fflixel-ui%2Fxml%2Fdefaults.xmlR2i1263R3R4R5R118R6tgoR0y53:flixel%2Fflixel-ui%2Fxml%2Fdefault_loading_screen.xmlR2i1953R3R4R5R119R6tgoR0y44:flixel%2Fflixel-ui%2Fxml%2Fdefault_popup.xmlR2i1848R3R4R5R120R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

		#end

	}


}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_admins_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_jetbrainsmono_bold_italic_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_jetbrainsmono_bold_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_jetbrainsmono_extrabold_italic_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_jetbrainsmono_extrabold_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_jetbrainsmono_italic_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_jetbrainsmono_medium_italic_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_jetbrainsmono_medium_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_jetbrainsmono_regular_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_lato_black_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_lato_regular_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_custompreload_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_all_good_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_back_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_clipboard_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_close_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_comment_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_de_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_down_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_en_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_exit_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_fr_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_help_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_howto_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_it_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_left_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_light_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_mail_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_right_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_showpwd_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_trainingmode_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_tutokeyboardde_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_tutokeyboarden_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_tutokeyboardfr_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_tutokeyboardit_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ui_version_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_vti_addnotede_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_vti_addnoteen_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_vti_addnotefr_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_vti_addnoteit_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_lime_svg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_locales_can_index_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_locales_de_de_can_all_de_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_locales_de_de_can_bo_de_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_locales_de_de_can_front_de_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_locales_de_de_meta_de_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_locales_en_gb_can_all_en_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_locales_en_gb_can_bo_en_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_locales_en_gb_can_front_en_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_locales_en_gb_meta_en_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_locales_fr_fr_can_all_fr_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_locales_fr_fr_can_bo_fr_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_locales_fr_fr_can_front_fr_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_locales_fr_fr_meta_fr_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_locales_it_it_can_all_it_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_locales_it_it_can_bo_it_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_locales_it_it_can_front_it_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_locales_it_it_meta_it_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_box_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_down_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_left_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_right_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_up_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_thin_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_toggle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_check_box_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_check_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_flat_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_inset_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_light_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_dropdown_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_finger_big_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_finger_small_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_hilight_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_invis_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_minus_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_plus_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_radio_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_radio_dot_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_swatch_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tab_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tab_back_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tooltip_arrow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_defaults_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_default_loading_screen_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_default_popup_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("assets/data/admins.txt") @:noCompletion #if display private #end class __ASSET__assets_data_admins_txt extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/JetBrainsMono-Bold-Italic.ttf") @:noCompletion #if display private #end class __ASSET__assets_fonts_jetbrainsmono_bold_italic_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/JetBrainsMono-Bold.ttf") @:noCompletion #if display private #end class __ASSET__assets_fonts_jetbrainsmono_bold_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/JetBrainsMono-ExtraBold-Italic.ttf") @:noCompletion #if display private #end class __ASSET__assets_fonts_jetbrainsmono_extrabold_italic_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/JetBrainsMono-ExtraBold.ttf") @:noCompletion #if display private #end class __ASSET__assets_fonts_jetbrainsmono_extrabold_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/JetBrainsMono-Italic.ttf") @:noCompletion #if display private #end class __ASSET__assets_fonts_jetbrainsmono_italic_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/JetBrainsMono-Medium-Italic.ttf") @:noCompletion #if display private #end class __ASSET__assets_fonts_jetbrainsmono_medium_italic_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/JetBrainsMono-Medium.ttf") @:noCompletion #if display private #end class __ASSET__assets_fonts_jetbrainsmono_medium_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/JetBrainsMono-Regular.ttf") @:noCompletion #if display private #end class __ASSET__assets_fonts_jetbrainsmono_regular_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/Lato-Black.ttf") @:noCompletion #if display private #end class __ASSET__assets_fonts_lato_black_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/Lato-Regular.ttf") @:noCompletion #if display private #end class __ASSET__assets_fonts_lato_regular_ttf extends lime.text.Font {}
@:keep @:image("assets/images/CustomPreload/default.png") @:noCompletion #if display private #end class __ASSET__assets_images_custompreload_default_png extends lime.graphics.Image {}
@:keep @:image("assets/images/default.png") @:noCompletion #if display private #end class __ASSET__assets_images_default_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ui/all-good.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_all_good_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ui/back.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_back_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ui/clipBoard.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_clipboard_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ui/close.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_close_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ui/comment.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_comment_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ui/de.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_de_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ui/down.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_down_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ui/en.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_en_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ui/exit.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_exit_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ui/fr.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_fr_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ui/help.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_help_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ui/howto.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_howto_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ui/it.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_it_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ui/left.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_left_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ui/light.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_light_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ui/mail.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_mail_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ui/right.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_right_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ui/showPwd.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_showpwd_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ui/trainingMode.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_trainingmode_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ui/tutoKeyboardDE.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_tutokeyboardde_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ui/tutoKeyboardEN.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_tutokeyboarden_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ui/tutoKeyboardFR.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_tutokeyboardfr_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ui/tutoKeyboardIT.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_tutokeyboardit_png extends lime.graphics.Image {}
@:keep @:image("assets/images/ui/version.png") @:noCompletion #if display private #end class __ASSET__assets_images_ui_version_png extends lime.graphics.Image {}
@:keep @:image("assets/images/vti/addnotede.png") @:noCompletion #if display private #end class __ASSET__assets_images_vti_addnotede_png extends lime.graphics.Image {}
@:keep @:image("assets/images/vti/addnoteen.png") @:noCompletion #if display private #end class __ASSET__assets_images_vti_addnoteen_png extends lime.graphics.Image {}
@:keep @:image("assets/images/vti/addnotefr.png") @:noCompletion #if display private #end class __ASSET__assets_images_vti_addnotefr_png extends lime.graphics.Image {}
@:keep @:image("assets/images/vti/addnoteit.png") @:noCompletion #if display private #end class __ASSET__assets_images_vti_addnoteit_png extends lime.graphics.Image {}
@:keep @:file("assets/lime.svg") @:noCompletion #if display private #end class __ASSET__assets_lime_svg extends haxe.io.Bytes {}
@:keep @:file("assets/locales/can_index.xml") @:noCompletion #if display private #end class __ASSET__assets_locales_can_index_xml extends haxe.io.Bytes {}
@:keep @:file("assets/locales/de-DE/can_all_de.txt") @:noCompletion #if display private #end class __ASSET__assets_locales_de_de_can_all_de_txt extends haxe.io.Bytes {}
@:keep @:file("assets/locales/de-DE/can_bo_de.txt") @:noCompletion #if display private #end class __ASSET__assets_locales_de_de_can_bo_de_txt extends haxe.io.Bytes {}
@:keep @:file("assets/locales/de-DE/can_front_de.txt") @:noCompletion #if display private #end class __ASSET__assets_locales_de_de_can_front_de_txt extends haxe.io.Bytes {}
@:keep @:file("assets/locales/de-DE/meta_de.txt") @:noCompletion #if display private #end class __ASSET__assets_locales_de_de_meta_de_txt extends haxe.io.Bytes {}
@:keep @:file("assets/locales/en-GB/can_all_en.txt") @:noCompletion #if display private #end class __ASSET__assets_locales_en_gb_can_all_en_txt extends haxe.io.Bytes {}
@:keep @:file("assets/locales/en-GB/can_bo_en.txt") @:noCompletion #if display private #end class __ASSET__assets_locales_en_gb_can_bo_en_txt extends haxe.io.Bytes {}
@:keep @:file("assets/locales/en-GB/can_front_en.txt") @:noCompletion #if display private #end class __ASSET__assets_locales_en_gb_can_front_en_txt extends haxe.io.Bytes {}
@:keep @:file("assets/locales/en-GB/meta_en.txt") @:noCompletion #if display private #end class __ASSET__assets_locales_en_gb_meta_en_txt extends haxe.io.Bytes {}
@:keep @:file("assets/locales/fr-FR/can_all_fr.txt") @:noCompletion #if display private #end class __ASSET__assets_locales_fr_fr_can_all_fr_txt extends haxe.io.Bytes {}
@:keep @:file("assets/locales/fr-FR/can_bo_fr.txt") @:noCompletion #if display private #end class __ASSET__assets_locales_fr_fr_can_bo_fr_txt extends haxe.io.Bytes {}
@:keep @:file("assets/locales/fr-FR/can_front_fr.txt") @:noCompletion #if display private #end class __ASSET__assets_locales_fr_fr_can_front_fr_txt extends haxe.io.Bytes {}
@:keep @:file("assets/locales/fr-FR/meta_fr.txt") @:noCompletion #if display private #end class __ASSET__assets_locales_fr_fr_meta_fr_txt extends haxe.io.Bytes {}
@:keep @:file("assets/locales/it-IT/can_all_it.txt") @:noCompletion #if display private #end class __ASSET__assets_locales_it_it_can_all_it_txt extends haxe.io.Bytes {}
@:keep @:file("assets/locales/it-IT/can_bo_it.txt") @:noCompletion #if display private #end class __ASSET__assets_locales_it_it_can_bo_it_txt extends haxe.io.Bytes {}
@:keep @:file("assets/locales/it-IT/can_front_it.txt") @:noCompletion #if display private #end class __ASSET__assets_locales_it_it_can_front_it_txt extends haxe.io.Bytes {}
@:keep @:file("assets/locales/it-IT/meta_it.txt") @:noCompletion #if display private #end class __ASSET__assets_locales_it_it_meta_it_txt extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,7,0/assets/sounds/beep.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,7,0/assets/sounds/flixel.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,7,0/assets/sounds/beep.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,7,0/assets/sounds/flixel.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/nokiafc22.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/monsterrat.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,7,0/assets/images/ui/button.png") @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,7,0/assets/images/logo/default.png") @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/box.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_box_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/button.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/button_arrow_down.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_down_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/button_arrow_left.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_left_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/button_arrow_right.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_right_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/button_arrow_up.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_up_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/button_thin.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_thin_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/button_toggle.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_toggle_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/check_box.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_check_box_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/check_mark.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_check_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/chrome.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/chrome_flat.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_flat_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/chrome_inset.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_inset_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/chrome_light.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_light_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/dropdown_mark.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_dropdown_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/finger_big.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_finger_big_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/finger_small.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_finger_small_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/hilight.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_hilight_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/invis.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_invis_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/minus_mark.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_minus_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/plus_mark.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_plus_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/radio.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_radio_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/radio_dot.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_radio_dot_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/swatch.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_swatch_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/tab.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tab_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/tab_back.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tab_back_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/images/tooltip_arrow.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tooltip_arrow_png extends lime.graphics.Image {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/xml/defaults.xml") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_defaults_xml extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/xml/default_loading_screen.xml") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_default_loading_screen_xml extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,2/assets/xml/default_popup.xml") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_default_popup_xml extends haxe.io.Bytes {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__assets_fonts_jetbrainsmono_bold_italic_ttf') @:noCompletion #if display private #end class __ASSET__assets_fonts_jetbrainsmono_bold_italic_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/JetBrainsMono-Bold-Italic"; #else ascender = 970; descender = -270; height = 1240; numGlyphs = 825; underlinePosition = -142; underlineThickness = 45; unitsPerEM = 1000; #end name = "JetBrains Mono Bold Italic"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_jetbrainsmono_bold_ttf') @:noCompletion #if display private #end class __ASSET__assets_fonts_jetbrainsmono_bold_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/JetBrainsMono-Bold"; #else ascender = 970; descender = -270; height = 1240; numGlyphs = 825; underlinePosition = -142; underlineThickness = 45; unitsPerEM = 1000; #end name = "JetBrains Mono Bold"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_jetbrainsmono_extrabold_italic_ttf') @:noCompletion #if display private #end class __ASSET__assets_fonts_jetbrainsmono_extrabold_italic_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/JetBrainsMono-ExtraBold-Italic"; #else ascender = 970; descender = -270; height = 1240; numGlyphs = 825; underlinePosition = -142; underlineThickness = 45; unitsPerEM = 1000; #end name = "JetBrains Mono ExtraBold Italic"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_jetbrainsmono_extrabold_ttf') @:noCompletion #if display private #end class __ASSET__assets_fonts_jetbrainsmono_extrabold_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/JetBrainsMono-ExtraBold"; #else ascender = 970; descender = -270; height = 1240; numGlyphs = 825; underlinePosition = -142; underlineThickness = 45; unitsPerEM = 1000; #end name = "JetBrains Mono ExtraBold"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_jetbrainsmono_italic_ttf') @:noCompletion #if display private #end class __ASSET__assets_fonts_jetbrainsmono_italic_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/JetBrainsMono-Italic"; #else ascender = 970; descender = -270; height = 1240; numGlyphs = 825; underlinePosition = -142; underlineThickness = 45; unitsPerEM = 1000; #end name = "JetBrains Mono Italic"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_jetbrainsmono_medium_italic_ttf') @:noCompletion #if display private #end class __ASSET__assets_fonts_jetbrainsmono_medium_italic_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/JetBrainsMono-Medium-Italic"; #else ascender = 970; descender = -270; height = 1240; numGlyphs = 825; underlinePosition = -142; underlineThickness = 45; unitsPerEM = 1000; #end name = "JetBrains Mono Medium Italic"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_jetbrainsmono_medium_ttf') @:noCompletion #if display private #end class __ASSET__assets_fonts_jetbrainsmono_medium_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/JetBrainsMono-Medium"; #else ascender = 970; descender = -270; height = 1240; numGlyphs = 825; underlinePosition = -142; underlineThickness = 45; unitsPerEM = 1000; #end name = "JetBrains Mono Medium"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_jetbrainsmono_regular_ttf') @:noCompletion #if display private #end class __ASSET__assets_fonts_jetbrainsmono_regular_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/JetBrainsMono-Regular"; #else ascender = 970; descender = -270; height = 1240; numGlyphs = 825; underlinePosition = -142; underlineThickness = 45; unitsPerEM = 1000; #end name = "JetBrains Mono Regular"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_lato_black_ttf') @:noCompletion #if display private #end class __ASSET__assets_fonts_lato_black_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/Lato-Black"; #else ascender = 1974; descender = -426; height = 2400; numGlyphs = 277; underlinePosition = -200; underlineThickness = 194; unitsPerEM = 2000; #end name = "Lato Black"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_lato_regular_ttf') @:noCompletion #if display private #end class __ASSET__assets_fonts_lato_regular_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/Lato-Regular"; #else ascender = 1974; descender = -426; height = 2400; numGlyphs = 277; underlinePosition = -200; underlineThickness = 120; unitsPerEM = 2000; #end name = "Lato Regular"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22"; #else ascender = 2048; descender = -512; height = 2816; numGlyphs = 172; underlinePosition = -640; underlineThickness = 256; unitsPerEM = 2048; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat"; #else ascender = 968; descender = -251; height = 1219; numGlyphs = 263; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__assets_fonts_jetbrainsmono_bold_italic_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_jetbrainsmono_bold_italic_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_jetbrainsmono_bold_italic_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_jetbrainsmono_bold_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_jetbrainsmono_bold_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_jetbrainsmono_bold_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_jetbrainsmono_extrabold_italic_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_jetbrainsmono_extrabold_italic_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_jetbrainsmono_extrabold_italic_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_jetbrainsmono_extrabold_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_jetbrainsmono_extrabold_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_jetbrainsmono_extrabold_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_jetbrainsmono_italic_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_jetbrainsmono_italic_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_jetbrainsmono_italic_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_jetbrainsmono_medium_italic_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_jetbrainsmono_medium_italic_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_jetbrainsmono_medium_italic_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_jetbrainsmono_medium_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_jetbrainsmono_medium_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_jetbrainsmono_medium_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_jetbrainsmono_regular_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_jetbrainsmono_regular_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_jetbrainsmono_regular_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_lato_black_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_lato_black_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_lato_black_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_lato_regular_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_lato_regular_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_lato_regular_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__assets_fonts_jetbrainsmono_bold_italic_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_jetbrainsmono_bold_italic_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_jetbrainsmono_bold_italic_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_jetbrainsmono_bold_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_jetbrainsmono_bold_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_jetbrainsmono_bold_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_jetbrainsmono_extrabold_italic_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_jetbrainsmono_extrabold_italic_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_jetbrainsmono_extrabold_italic_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_jetbrainsmono_extrabold_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_jetbrainsmono_extrabold_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_jetbrainsmono_extrabold_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_jetbrainsmono_italic_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_jetbrainsmono_italic_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_jetbrainsmono_italic_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_jetbrainsmono_medium_italic_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_jetbrainsmono_medium_italic_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_jetbrainsmono_medium_italic_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_jetbrainsmono_medium_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_jetbrainsmono_medium_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_jetbrainsmono_medium_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_jetbrainsmono_regular_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_jetbrainsmono_regular_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_jetbrainsmono_regular_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_lato_black_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_lato_black_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_lato_black_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_lato_regular_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_lato_regular_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_lato_regular_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#end

#end
#end

#end
