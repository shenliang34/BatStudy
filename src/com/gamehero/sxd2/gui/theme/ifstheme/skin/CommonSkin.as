package com.gamehero.sxd2.gui.theme.ifstheme.skin
{
	import com.gamehero.sxd2.core.Global;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;
	
	/**
	 * 通用组件皮肤
	 * @author xuwenyi
	 * @create 2015-08-20
	 **/
	public class CommonSkin
	{
		// 窗口
		static public var windowInner1Bg:BitmapData;	// 窗口内背景
		static public var windowInner2Bg:BitmapData;	// 窗口内背景2
		static public var windowInner3Bg:BitmapData;	// 窗口内背景3
		static public var windowInner4Bg:BitmapData;	// 窗口内背景4
		
		// ScaleBitmap 九宫格
		static public var windowInner1BgScale9Grid:Rectangle = new Rectangle(31, 31, 2, 2);
		static public var windowInner2BgScale9Grid:Rectangle = new Rectangle(31, 31, 2, 2);
		static public var windowInner3BgScale9Grid:Rectangle = new Rectangle(31, 115, 2, 2);
		static public var windowInner4BgScale9Grid:Rectangle = new Rectangle(10, 16, 1, 1);
		
		// 蓝色按钮们
		static public var blueButton1Down:BitmapData;
		static public var blueButton1Over:BitmapData;
		static public var blueButton1Up:BitmapData;
		static public var blueButton1Disable:BitmapData;
		
		//蓝色页签按钮
		static public var blueButton2Down:BitmapData;
		static public var blueButton2Over:BitmapData;
		static public var blueButton2Up:BitmapData;
		
		// 2字小蓝色按钮
		static public var blueButton3Down:BitmapData;
		static public var blueButton3Over:BitmapData;
		static public var blueButton3Up:BitmapData;
		
		// 大蓝色按钮们
		static public var blueBigButton3Down:BitmapData;
		static public var blueBigButton3Over:BitmapData;
		static public var blueBigButton3Up:BitmapData;
		static public var blueBigButton3Disable:BitmapData;
		
		static public var tBlueBtn1Up:BitmapData;
		static public var tBlueBtn1Over:BitmapData;
		static public var tBlueBtn1Down:BitmapData;
		
		// 红色按钮们
		static public var tRedBtn1Up:BitmapData;
		static public var tRedBtn1Over:BitmapData;
		static public var tRedBtn1Down:BitmapData;
		
		// X按钮
		static public var windowCloseBtnUp:BitmapData;
		static public var windowCloseBtnDown:BitmapData;
		static public var windowCloseBtnOver:BitmapData;
		static public var windowCloseBtnDisable:BitmapData;
		
		// 多选按钮
		static public var checkboxSelectUp:BitmapData;
		static public var checkboxSelectOver:BitmapData;
		static public var checkboxUp:BitmapData;
		static public var checkboxOver:BitmapData;
		
		// 滚动条
		static public var scbDownButtonDownSkin:BitmapData;
		static public var scbDownButtonUpSkin:BitmapData;
		static public var scbDownButtonOveSkin:BitmapData;
		static public var scbUpButtonDownSkin:BitmapData;
		static public var scbUpButtonUpSkin:BitmapData;
		static public var scbUpButtonOveSkin:BitmapData;
		static public var scbThumbDownSkin:BitmapData;
		static public var scbThumbUpSkin:BitmapData;
		static public var scbThumbOverSkin:BitmapData;
		static public var scbTrackSkin:BitmapData;
		static public var scbTrackIconSkin:BitmapData;
		
		
		//menupanel
		static public var MENU_SELECTED_BG:BitmapData;
		static public var MENU_BG:BitmapData;
		
		//步进器
		static public var NUMBER_INPUT_BG:BitmapData;
		static public var PLUS_DOWN:BitmapData;
		static public var PLUS_UP:BitmapData;
		static public var PLUS_OVER:BitmapData;
		static public var CUT_DOW:BitmapData;
		static public var CUT_UP:BitmapData;
		static public var CUT_OVER:BitmapData;
		
		static public var LeftStepper_Down:BitmapData;
		static public var LeftStepper_Over:BitmapData;
		static public var LeftStepper_Up:BitmapData;
		static public var MaxStepper_Down:BitmapData;
		static public var MaxStepper_Over:BitmapData;
		static public var MaxStepper_Up:BitmapData;
		static public var MinStepper_Down:BitmapData;
		static public var MinStepper_Over:BitmapData;
		static public var MinStepper_Up:BitmapData;
		static public var RightStepper_Down:BitmapData;
		static public var RightStepper_Over:BitmapData;
		static public var RightStepper_Up:BitmapData;
		
		
		public function CommonSkin()
		{
		}
		
		
		
		
		// 初始化
		public static function init(res:MovieClip):void
		{
			var domain:ApplicationDomain = res.loaderInfo.applicationDomain;
			var global:Global = Global.instance;
			
			// Window Skin
			windowInner1Bg = global.getBD(domain , "WINDOW_INNER1_BG");
			windowInner2Bg = global.getBD(domain , "WINDOW_INNER2_BG");
			windowInner3Bg = global.getBD(domain , "WINDOW_INNER3_BG");
			windowInner4Bg = global.getBD(domain , "GREY_BG");
			
			// 蓝色按钮
			blueButton1Up = global.getBD(domain , "BLUE_BTN_1_UP");
			blueButton1Down = global.getBD(domain , "BLUE_BTN_1_DOWN");
			blueButton1Over= global.getBD(domain , "BLUE_BTN_1_OVER");
			blueButton1Disable = global.getBD(domain , "BLUE_BTN_1_DISABLE");
			
			tBlueBtn1Up = global.getBD(domain , "T_BLUE_BTN_M_UP");
			tBlueBtn1Over = global.getBD(domain , "T_BLUE_BTN_M_OVER");
			tBlueBtn1Down = global.getBD(domain , "T_BLUE_BTN_M_DOWN");
			
			//页签按钮
			blueButton2Up = global.getBD(domain , "BLUE_BTN_2_UP");
			blueButton2Down = global.getBD(domain , "BLUE_BTN_2_DOWN");
			blueButton2Over = global.getBD(domain , "BLUE_BTN_2_OVER");
			
			// 大蓝色按钮
			blueBigButton3Down = global.getBD(domain , "blueButton_l_down");
			blueBigButton3Over = global.getBD(domain , "blueButton_l_over");
			blueBigButton3Up = global.getBD(domain , "blueButton_l_up");
			blueBigButton3Disable = global.getBD(domain , "blueButton_l_disabled");
			
			// 2字小蓝色按钮
			blueButton3Up = global.getBD(domain , "BLUE_BTN_3_UP");
			blueButton3Down = global.getBD(domain , "BLUE_BTN_3_DOWN");
			blueButton3Over = global.getBD(domain , "BLUE_BTN_3_OVER");
			
			// 红色按钮
			tRedBtn1Up = global.getBD(domain , "T_RED_BTN_M_UP");
			tRedBtn1Over = global.getBD(domain , "T_RED_BTN_M_OVER");
			tRedBtn1Down = global.getBD(domain , "T_RED_BTN_M_DOWN");
			
			// X按钮
			windowCloseBtnUp = global.getBD(domain , "WINDOW_CLOSE_BTN_UP");
			windowCloseBtnDown = global.getBD(domain , "WINDOW_CLOSE_BTN_DOWN");
			windowCloseBtnOver = global.getBD(domain , "WINDOW_CLOSE_BTN_OVER");
			windowCloseBtnDisable = global.getBD(domain , "WINDOW_CLOSE_BTN_DISABLE");
			
			// 多选
			checkboxSelectUp = global.getBD(domain , "CHECKBOX_SELECT_UP");
			checkboxSelectOver = global.getBD(domain , "CHECKBOX_SELECT_OVER");
			checkboxUp = global.getBD(domain , "CHECKBOX_UP");
			checkboxOver = global.getBD(domain , "CHECKBOX_OVER");
			
			// 滚动条
			scbDownButtonDownSkin = global.getBD(domain , "SCB_DOWNBUTTON_DOWN_SKIN");
			scbDownButtonUpSkin = global.getBD(domain , "SCB_DOWNBUTTON_UP_SKIN");
			scbDownButtonOveSkin = global.getBD(domain , "SCB_DOWNBUTTON_OVER_SKIN");
			scbUpButtonDownSkin = global.getBD(domain , "SCB_UPBUTTON_DOWN_SKIN");
			scbUpButtonUpSkin = global.getBD(domain , "SCB_UPBUTTON_UP_SKIN");
			scbUpButtonOveSkin = global.getBD(domain , "SCB_UPBUTTON_OVER_SKIN");
			scbThumbDownSkin = global.getBD(domain , "SCB_THUMB_DOWN_SKIN");
			scbThumbUpSkin = global.getBD(domain , "SCB_THUMB_UP_SKIN");
			scbThumbOverSkin = global.getBD(domain , "SCB_THUMB_OVER_SKIN");
			scbTrackSkin = global.getBD(domain , "SCB_TRACK_SKIN");
			scbTrackIconSkin = global.getBD(domain , "SCB_THUMB_ICON_SKIN");

			MENU_SELECTED_BG = global.getBD(domain , "MENU_SELECTED_BG");
			MENU_BG = global.getBD(domain , "MENU_BG");
			
			NUMBER_INPUT_BG = global.getBD(domain , "NUMBER_INPUT_BG");
			PLUS_DOWN = global.getBD(domain , "PLUS_DOWN");
			PLUS_UP = global.getBD(domain , "PLUS_UP");
			PLUS_OVER = global.getBD(domain , "PLUS_OVER");
			CUT_DOW = global.getBD(domain , "CUT_DOW");
			CUT_UP = global.getBD(domain , "CUT_UP");
			CUT_OVER = global.getBD(domain , "CUT_OVER");
			
			LeftStepper_Down = global.getBD(domain , "LeftStepper_Down");
			LeftStepper_Over = global.getBD(domain , "LeftStepper_Over");
			LeftStepper_Up = global.getBD(domain , "LeftStepper_Up");
			MaxStepper_Down = global.getBD(domain , "MaxStepper_Down");
			MaxStepper_Over = global.getBD(domain , "MaxStepper_Over");
			MaxStepper_Up = global.getBD(domain , "MaxStepper_Up");
			MinStepper_Down = global.getBD(domain , "MinStepper_Down");
			MinStepper_Over = global.getBD(domain , "MinStepper_Over");
			MinStepper_Up = global.getBD(domain , "MinStepper_Up");
			RightStepper_Down = global.getBD(domain , "RightStepper_Down");
			RightStepper_Over = global.getBD(domain , "RightStepper_Over");
			RightStepper_Up = global.getBD(domain , "RightStepper_Up");
		}
	}
}