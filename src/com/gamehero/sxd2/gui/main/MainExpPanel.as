package com.gamehero.sxd2.gui.main
{
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.gui.tips.FloatTips;
	import com.gamehero.sxd2.local.Lang;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.ApplicationDomain;
	import flash.text.TextField;

	/**
	 * 主UI右下经验面板
	  * @author zhangxueyou
	 * @create 2015-07-15
	 **/
	public class MainExpPanel extends Sprite
	{
		private static var _instance:MainExpPanel;
		private var domain:ApplicationDomain;
		private var expLoading:MovieClip;
		private var expTxt:TextField;					//玩家经验
		private var mouseOverMc:MovieClip;				//鼠标移入mc
		
		/**
		 * 经验位置 
		 */		
		private var _expLocNum:int;
		/**
		 * 当前经验 
		 */		
		private var _curExp:int;
		
		
		/**
		 * 构造函数
		 * */
		public function MainExpPanel()
		{
		}
		
		/**
		 * 初始化
		 * */
		public function init(domain:ApplicationDomain):void
		{
			this.domain = domain;
			
			var global:Global = Global.instance;
			
			initPlayerLevelListHandle();
			
			var mc:MovieClip = global.getRes(domain,"expPanel") as MovieClip;
			addChild(mc);
			
			expLoading = mc.getChildByName("expLoading") as MovieClip; 
			expLoading.addEventListener(Event.ENTER_FRAME,onFrame);
			var exp:int = GameData.inst.playerExtraInfo.exp;
			
			expTxt = mc.getChildByName("expTxt") as TextField;
			
			mouseOverMc = mc.getChildByName("mouseOverMc") as MovieClip;
			mouseOverMc.addEventListener(MouseEvent.MOUSE_OVER,mouseOverMcMouseOverHandle);
			mouseOverMc.addEventListener(MouseEvent.MOUSE_OUT,mouseOverMcMouseOutHandle);
			
			initPlayerExpHandle();
			
		}
		
		
		protected function onFrame(event:Event):void
		{
			if(expLoading.currentFrame >= _expLocNum) expLoading.stop();
		}
		
		public function initPlayerExpHandle():void
		{
			var playerExp:int = GameData.inst.playerExtraInfo.exp;
			var expMax:int = getPlayerLevelHandle(GameData.inst.playerInfo.level);
			var totolExp:int = getLevelNeedExp(GameData.inst.playerInfo.level) + playerExp;
			if(_curExp == 0)
			{
			}
			else
			{
				if((totolExp - _curExp) > 0)
				{
					FloatTips.inst.show(Lang.instance.trans("Item_name_10010003") +" +" +  (totolExp - _curExp));
				}
			}

			expTxt.text = playerExp + "/" + expMax;
			if(playerExp < 1) playerExp = 1;
			var curExp:int = Math.floor(playerExp / expMax * 100);
			if(curExp > 100) curExp = 100;
			if(curExp > _expLocNum && _curExp != 0)
			{
				expLoading.play();
			}
			else
			{
				expLoading.gotoAndStop(curExp);
			}
			_expLocNum = curExp;
			
			_curExp = totolExp;
			expTxt.visible = false;
		}
		
		
		
		/**
		 * 鼠标移出经验数值 隐藏经验数值
		 * */
		private function mouseOverMcMouseOutHandle(e:MouseEvent):void{
			expTxt.visible = false;
		}
		
		
		
		/**
		 * 鼠标移入经验条 显示经验数值
		 * */
		private function mouseOverMcMouseOverHandle(e:MouseEvent):void{
			expTxt.visible = true;
		}

		
		
		/**
		 * 初始化等级上线信息
		 * */
		private var playerLevelList:XMLList;
		private function initPlayerLevelListHandle():void{
			playerLevelList = GameSettings.instance.settingsXML.player_level.Sheet1;
		}
		/**
		 * 升级到当前等级需要经验 
		 * @param level 等级需求
		 * @return 
		 * 
		 */		
		private function getLevelNeedExp(level:int):int
		{
			var exp:int;
			var len:int = playerLevelList.length();
			for (var i:int = 0; i < len; i++) {
				var levelXML:XML = playerLevelList[i];
				exp += int(levelXML.@exp);
				if(levelXML.@level == level) {
					break;
				}
			}
			return exp;
		}
		
		/**
		 * 根据等级获取经验上限
		 * */
		private function getPlayerLevelHandle(level:int):int{
			var len:int = playerLevelList.length();
			for (var i:int = 0; i < len; i++) {
				var levelXML:XML = playerLevelList[i]
				if(levelXML.@level == level) {
					return levelXML.@exp;
				}
			}
			
			return null;
		}
		
		
		/**
		 * 获取单例
		 * */
		public static function get inst():MainExpPanel
		{
			return _instance ||= new MainExpPanel();
		}

	}
}