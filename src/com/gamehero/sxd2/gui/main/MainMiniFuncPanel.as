package com.gamehero.sxd2.gui.main
{	
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.event.MainEvent;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.SButton;
	import com.gamehero.sxd2.gui.hurdleGuide.model.vo.HurdleVo;
	import com.gamehero.sxd2.gui.notice.NoticeUI;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ChatSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.manager.HurdlesManager;
	import com.gamehero.sxd2.manager.MailManager;
	import com.gamehero.sxd2.manager.MapsManager;
	import com.gamehero.sxd2.manager.SoundManager;
	import com.gamehero.sxd2.pro.NotifyInfo3Type;
	import com.gamehero.sxd2.pro.PRO_Map;
	import com.gamehero.sxd2.world.event.MapEvent;
	import com.gamehero.sxd2.world.model.MapModel;
	import com.gamehero.sxd2.world.model.MapTypeDict;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.system.ApplicationDomain;
	
	import alternativa.gui.base.GUIobject;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;

	/**
	 * 主UI右上小功能面板
	 * @author zhangxueyou
	 * @create 2015-07-15
	 **/
	public class MainMiniFuncPanel extends Sprite
	{
		private static var _instance:MainMiniFuncPanel;
		private var domain:ApplicationDomain;
		private var _hurdleBtnSp:GUIobject;//关卡内需要显示的按钮容器 
		private var _normalBtnSp:GUIobject;//普通场景需要显示的按钮容器 	
		private var _hurdleReportBtn:Button;//查看攻略 
		private var soundOpenBtn:SButton;//开启声音按钮
		private var soundCloseBtn:SButton;//关闭声音按钮
		private var isHideOtherPlayer:Boolean = true;//是否显示其他玩家
		private var redPoint:Bitmap; //聊天提示红点
		private var mapName:Bitmap;//地图名称
		private var bgMc:MovieClip;
		/**
		 * 构造函数
		 * */
		public function MainMiniFuncPanel()
		{
		}
		
		/**
		 * 初始化ui
		 * */
		public function init(domain:ApplicationDomain):void
		{
			this.domain = domain;
			
			// 背景
			var global:Global = Global.instance;
			bgMc = global.getRes(domain,"miniFunctionPanel") as MovieClip;
			addChild(bgMc);
			
			_normalBtnSp = new GUIobject();// 普通状态
			_hurdleBtnSp = new GUIobject();// 关卡状态
			addChild(_normalBtnSp);
			addChild(_hurdleBtnSp);
			
			// 初始化功能按钮
			initBtn();
			//提示红点
			redPoint = new Bitmap(ChatSkin.CHAT_REDPOINT);
			redPoint.x = 80;
			redPoint.y = 38;
			this.addChild(redPoint);
			redPoint.visible = false;
			
			mapName = new Bitmap();
			bgMc.addChild(mapName);

		}
		
		/**
		 *设置地图名称 
		 * 
		 */		
		public function loadMapName(bitmap:Bitmap):void
		{
			mapName.bitmapData = getCircleBmd(bitmap.bitmapData);
			mapName.x = bgMc.width - mapName.width >> 1;
			mapName.y = bgMc.height - mapName.height >> 1;;
		}

		/**
		 *地图名称资源缩放 
		 * @param bd
		 * @return 
		 * 
		 */		
		public function getCircleBmd(bd:BitmapData):BitmapData
		{
			var w:int = bd.width * 0.8;
			var h:int = bd.height * 0.8;
			var thumb:BitmapData = new BitmapData(w ,h,true,0x00000000);
			var mat:Matrix = new Matrix();
			mat.scale(0.8,0.8);
			thumb.draw(bd,mat,null,null,null,false);
			return thumb;
		}
		
		/**
		 * 设置当前显示按钮组
		 * */
		public function setBtnList():void
		{
			initBtnVisible();
			MainUI.inst.displayType = MapModel.inst.mapVo.type;//
			switch(MapModel.inst.mapVo.type)
			{	
				// 场景地图
				case MapTypeDict.NORMAL_MAP:
					_normalBtnSp.visible = true;
					break;
				case MapTypeDict.HURLDE_MAP:
				case MapTypeDict.FOG_LEVEL_MAP:
					var hurdleVo:HurdleVo = HurdlesManager.getInstance().getHurdleById(GameData.inst.curHurdleId);
					_hurdleReportBtn.locked = hurdleVo.difficult != 3;//3为 炼狱关卡
					_hurdleBtnSp.visible = true;
					break;
			}
//			loadMapName();
			setMailTips();
		}
		
		/**
		 * 初始的时候隐藏掉所有按钮，加载地图后再设置显示 
		 * 
		 */		
		private function initBtnVisible():void
		{
			_normalBtnSp.visible = false;
			_hurdleBtnSp.visible = false;
		}
		
		/**
		 * 初始化按钮
		 * */
		private function initBtn():void
		{
			_normalBtnSp.addChild(setActionBtnHandle(Lang.instance.trans("function_ui_10000"),3,38,MainSkin.MAINUI_BLUE_BTN_UP,MainSkin.MAINUI_BLUE_BTN_DOWN,MainSkin.MAINUI_BLUE_BTN_OVER));
			_normalBtnSp.addChild(setActionBtnHandle(Lang.instance.trans("function_ui_10001"),49,38,MainSkin.MAINUI_BLUE_BTN_UP,MainSkin.MAINUI_BLUE_BTN_DOWN,MainSkin.MAINUI_BLUE_BTN_OVER));
			_normalBtnSp.addChild(setActionBtnHandle(Lang.instance.trans("function_ui_10002"),96,38,MainSkin.MAINUI_BLUE_BTN_UP,MainSkin.MAINUI_BLUE_BTN_DOWN,MainSkin.MAINUI_BLUE_BTN_OVER));
			_normalBtnSp.addChild(setActionBtnHandle(Lang.instance.trans("function_ui_10003"),143,38,MainSkin.MAINUI_BLUE_BTN_UP,MainSkin.MAINUI_BLUE_BTN_DOWN,MainSkin.MAINUI_BLUE_BTN_OVER));
			
			_hurdleReportBtn = setActionBtnHandle("查看攻略",10,35,MainSkin.MAINUI_BLUE_BIG_BTN_UP,MainSkin.MAINUI_BLUE_BIG_BTN_DOWN,MainSkin.MAINUI_BLUE_BIG_BTN_OVER,MainSkin.MAINUI_BLUE_BTN_DISABLED);
			_hurdleBtnSp.addChild(_hurdleReportBtn);
			_hurdleBtnSp.addChild(setActionBtnHandle("离开副本",100,35,MainSkin.MAINUI_BLUE_BIG_BTN_UP,MainSkin.MAINUI_BLUE_BIG_BTN_DOWN,MainSkin.MAINUI_BLUE_BIG_BTN_OVER,MainSkin.MAINUI_BLUE_BTN_DISABLED));
			
			//声音按钮
			soundOpenBtn = new SButton(Global.instance.getRes(domain , "SOUND_OPEN_BTN") as SimpleButton);
			soundOpenBtn.x = 174;
			soundOpenBtn.y = 9;
			soundOpenBtn.addEventListener(MouseEvent.CLICK , changeSound);
			addChild(soundOpenBtn);
			soundCloseBtn = new SButton(Global.instance.getRes(domain , "SOUND_CLOSE_BTN") as SimpleButton);
			soundCloseBtn.x = 174;
			soundCloseBtn.y = 9;
			soundCloseBtn.addEventListener(MouseEvent.CLICK , changeSound);
			addChild(soundCloseBtn);
			// 初始化声音状态
			var isMute:Boolean = SoundManager.inst.mute;
			soundOpenBtn.visible = !isMute;
			soundCloseBtn.visible = isMute;
			
			initBtnVisible();
		}
		
		
		/**
		 * 设置主UI蓝底大按钮 4字按钮
		 * */
		private function setActionBtnHandle(lab:String,btnX:int,btnY:int,UpSkin:BitmapData, downSkin:BitmapData = null, overSkin:BitmapData = null, disableSkin:BitmapData = null):Button{
			var btn:Button = new Button(UpSkin,downSkin,overSkin,disableSkin);
			btn.label = lab;
			btn.x = btnX;
			btn.y = btnY;
			btn.addEventListener(MouseEvent.CLICK,actionBtnClickHandle);
			return btn;
		}
		
		/**
		 * 功能按钮点击事件
		 * */
		private function actionBtnClickHandle(e:MouseEvent):void{
			switch(e.currentTarget.label)
			{
				case "离开副本":
					var mapInfo:PRO_Map = new PRO_Map();
					mapInfo.id = 0;
					SXD2Main.inst.enterMap(mapInfo);
					break;
				case "查看攻略":
					MainUI.inst.openWindow(WindowEvent.HURDLE_REPORT_WINDOW);
					break;
				case "隐藏":
					e.currentTarget.label = "显示";
					isHideOtherPlayer = !isHideOtherPlayer;
					parent.dispatchEvent(new MainEvent(MainEvent.HIDEOTHERPLAYER,isHideOtherPlayer));
					break;
				case "显示":
					e.currentTarget.label = "隐藏";
					isHideOtherPlayer = !isHideOtherPlayer;
					parent.dispatchEvent(new MainEvent(MainEvent.HIDEOTHERPLAYER,isHideOtherPlayer));
					break;
				
				case "世界":
					this.parent.dispatchEvent(new MapEvent(MapEvent.ENTER_GOLBAL_WORLD,null));
					break;
				case "邮件":
					NoticeUI.inst.hideNoti(NoticeUI.inst.NOTIAREA3,NotifyInfo3Type.TYPE_MAIL);
					MainUI.inst.openWindow(WindowEvent.FRIEND_WINDOW);					
					break;
				case "设置":
					MainUI.inst.openWindow(WindowEvent.ROLESKILL_VIEW);
					break;
			}
		}
		
		
		/**
		 * 声音开关
		 * */
		private function changeSound(e:MouseEvent):void
		{
			var isMute:Boolean = SoundManager.inst.mute;
			if(isMute == true)
			{
				soundOpenBtn.visible = true;
				soundCloseBtn.visible = false;
				
				SoundManager.inst.mute = false;
			}
			else
			{
				soundOpenBtn.visible = false;
				soundCloseBtn.visible = true;
				
				SoundManager.inst.mute = true;
			}
		}
		
		/**
		 *设置新邮件提示 
		 * @param num
		 * 
		 */		
		public function setMailTips():void
		{
			if(MapModel.inst.mapVo == null || MapModel.inst.mapVo.type == MapTypeDict.NORMAL_MAP ){
				var num:int = MailManager.instance.mailCount;
				if(num > 0)
					redPoint.visible = true;
				else
					redPoint.visible = false;
			}
		}
		
		/**
		 * 获取单例
		 * */
		public static function get inst():MainMiniFuncPanel
		{
			return _instance ||= new MainMiniFuncPanel();
		}
	}
}