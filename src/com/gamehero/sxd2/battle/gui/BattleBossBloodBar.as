package com.gamehero.sxd2.battle.gui
{
	import com.gamehero.sxd2.battle.data.BattleDataCenter;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.BattleSkin;
	import com.gamehero.sxd2.vo.MonsterVO;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import alternativa.gui.enum.Align;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	
	/**
	 * 战斗中BOSS的血条
	 * @author xuwenyi
	 * @create 2013-08-27
	 **/
	public class BattleBossBloodBar extends Sprite
	{
		// 血条顺序
		private static var bloodColors:Array;
		private static var redBlood:BitmapData;
		private static var yellowBlood:BitmapData;
		
		// 血条总宽度
		private static var bloodWidth:int = 368;
		
		// 姓名和等级
		private var nameLabel:Label;
		
		// boss头像
		private var headPanel:Sprite;
		private var headURL:String;
		
		// 当前百分比
		private var currentRate:Number = 1;
		// 目标百分比
		private var targetRate:Number = 1;
		// 每一条血条占用的百分比
		private var everyRate:Number = 0;
		// 总血条数
		private var bloodTotal:int;
		
		// 血条
		private var bloods:Array = [];
		private var bloodPanel:Sprite;
		private var bloodMask:Bitmap;
		
		
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleBossBloodBar()
		{
			super();
			
			this.mouseChildren = this.mouseEnabled = false;
		}
		
		
		
		/**
		 * 初始化
		 * */
		public function initUI():void
		{
			// 大背景
			var bg:Bitmap = new Bitmap(BattleSkin.BOSS_BLOOD_BG);
			this.addChild(bg);
			
			// 血条容器mask
			bloodMask = new Bitmap(BattleSkin.BOSS_BLOOD_MASK);
			bloodMask.x = 0;
			bloodMask.y = 0;
			bloodMask.cacheAsBitmap = true;
			
			// 血条容器
			bloodPanel = new Sprite();
			bloodPanel.x = 25;
			bloodPanel.y = 36;
			bloodPanel.mask = bloodMask;
			bloodPanel.cacheAsBitmap = true;
			this.addChild(bloodPanel);
			
			// 姓名
			nameLabel = this.createCommonLabel("" , GameDictionary.WHITE);
			nameLabel.x = 265;
			nameLabel.y = 56;
			nameLabel.width = 100;
			nameLabel.align = Align.CENTER;
			this.addChild(nameLabel);
			
			// 头像面板
			headPanel = new Sprite();
			headPanel.x = 398;
			headPanel.y = 2;
			this.addChild(headPanel);
			
			// 血条颜色顺序
			bloodColors = [BattleSkin.BOSS_BLOOD_GREEN,BattleSkin.BOSS_BLOOD_BLUE,BattleSkin.BOSS_BLOOD_PURPLE,BattleSkin.BOSS_BLOOD_GREEN,BattleSkin.BOSS_BLOOD_BLUE,BattleSkin.BOSS_BLOOD_PURPLE,BattleSkin.BOSS_BLOOD_GREEN,BattleSkin.BOSS_BLOOD_BLUE,BattleSkin.BOSS_BLOOD_PURPLE,BattleSkin.BOSS_BLOOD_GREEN,BattleSkin.BOSS_BLOOD_BLUE,BattleSkin.BOSS_BLOOD_PURPLE];
			redBlood = BattleSkin.BOSS_BLOOD_RED;
			yellowBlood = BattleSkin.BOSS_BLOOD_YELLOW;
		}
		
		
		
		
		
		/**
		 * 显示boss名字和等级
		 * */
		public function initBossInfo(monsterVO:MonsterVO):void
		{
			var global:Global = Global.instance;
			
			// 名字和等级
			nameLabel.text = monsterVO.monsterName + " " + monsterVO.level + "级";
			
			// boss血条数
			bloods = [];
			global.removeChildren(bloodPanel);
			var len:int = monsterVO.bossBlood;
			bloodTotal = len; // 总血条数
			everyRate = 1 / bloodTotal;// 每一条血条占用的百分比
			var colors:Array = bloodColors.concat();
			
			// 添加mask
			bloodPanel.addChild(bloodMask);
			
			for(var i:int=0;i<len;i++)
			{
				var bd:BitmapData;
				// 最上面一条血必定是黄色
				if(i == 0)
				{
					bd = yellowBlood;
				}
				// 最下面一条必定是红色
				else if(i == len - 1)
				{
					bd = redBlood;
				}
				else
				{
					bd = colors.shift();
				}
				var blood:Bitmap = new Bitmap(bd);
				blood.width = bloodWidth;
				bloodPanel.addChildAt(blood , 0);
				
				bloods.push(blood);
			}
			bloods.reverse();
			
			// 清空头像面板
			global.removeChildren(headPanel);
			// 加载头像
			headURL = GameConfig.ICON_URL + "battlehead/" + monsterVO.battleHead + ".swf";
			var loader:BulkLoaderSingleton = BattleDataCenter.instance.loader;
			loader.addWithListener(headURL , null , onHeadLoaded);
		}
		
		
		
		
		
		
		/**
		 * 头像加载完成
		 * */
		private function onHeadLoaded(e:Event):void
		{
			var imageItem:ImageItem = e.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE , onHeadLoaded);
			var PNGDataClass:Class = imageItem.getDefinitionByName("PNGData") as Class;
			var png:BitmapData = new PNGDataClass();
			var bmp:Bitmap = new Bitmap(png);
			headPanel.addChild(bmp);
		}
		
		
		
		
		
		
		
		/**
		 * 更新当前血量百分比
		 * */
		public function update(rate:Number):void
		{
			targetRate = Math.max(rate , 0);
			targetRate = Math.min(targetRate , 1);
			
			// 计算出哪些血条需要显示
			var visibleNum:int = Math.ceil(targetRate / everyRate);
			var currentBlood:Bitmap;// 当前显示的血条
			
			for(var i:int=0;i<bloodTotal;i++)
			{
				var blood:Bitmap = bloods[i];
				if(i < visibleNum)
				{
					blood.visible = true;
					
					if(i == visibleNum - 1)
					{
						currentBlood = blood;
					}
				}
				else
				{
					blood.visible = false;
				}
			}
			
			// 若存在当前显示的血条
			if(currentBlood != null)
			{
				var remainRate:Number = targetRate % everyRate;
				if(remainRate > 0.001)
				{
					currentBlood.width = bloodWidth * remainRate;
					currentBlood.x = bloodWidth - currentBlood.width;
				}
			}
		}
		
		
		
		
		
		
		
		/**
		 * 创建通用label
		 * */
		protected function createCommonLabel(text:String , color:uint):Label
		{
			var label:Label = new Label(false);
			label.text = text;
			label.width = 200;
			label.height = 20;
			label.size = 12;
			label.color = color;
			return label;
		}
		
		
		
		
		
		/**
		 * 清空
		 * */
		public function clear():void
		{
			nameLabel.text = "";
			
			currentRate = 1;
			targetRate = 1;
			everyRate = 0;
			bloodTotal = 0;
			
			bloods = [];
			
			var global:Global = Global.instance;
			global.removeChildren(headPanel);
			global.removeChildren(bloodPanel);
		}
		
	}
}