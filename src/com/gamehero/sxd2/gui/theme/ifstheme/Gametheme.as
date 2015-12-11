package com.gamehero.sxd2.gui.theme.ifstheme {
	
	
	import flash.filters.GlowFilter;
	import flash.text.TextFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.FontLookup;
	
	import alternativa.gui.controls.text.Label;
	import alternativa.gui.controls.text.LabelTF;
	import alternativa.gui.theme.defaulttheme.fonts.Fonts;
	
	
	/**
	 * Game Theme 
	 * @author Trey
	 * 
	 */
	public class Gametheme {
		
		
		static public const TEXT_FILTER:GlowFilter = new GlowFilter(0x1c1c20, 1, 2, 2, 8);
		
		
		public static function init():void {
			
			Fonts.init();
			LabelTF.embedFonts = false;
			LabelTF.defaultFormat = new TextFormat("宋体", 12, 0xffffff, false);
			Label.fontDescription = new FontDescription("宋体");
			Label.fontDescription.fontLookup = FontLookup.DEVICE;
		}

	}
}