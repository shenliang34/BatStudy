package com.gamehero.sxd2.battle.gui
{
	import com.gamehero.sxd2.battle.data.BattleDataCenter;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.BattleSkin;
	import com.gamehero.sxd2.manager.SkillManager;
	import com.gamehero.sxd2.vo.BattleSkill;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	
	/**
	 * 战斗tips或新手引导里的技能icon
	 * @author xuwenyi
	 * @create 2014-01-20
	 **/
	public class TipsSkIcon extends Sprite
	{
		// 技能icon容器
		private var iconPanel:Sprite;
		private var iconURL:String;
		
		
		/**
		 * 构造函数
		 * */
		public function TipsSkIcon()
		{
			super();
		}
		
		
		
		
		/**
		 * 显示技能icon
		 * */
		public function load(id:String):void
		{
			// 产生要学习的技能
			var skill:BattleSkill = SkillManager.instance.getSkillBySkillID(id);
			if(skill)
			{
				// 技能背景
				var bg:Bitmap = new Bitmap(BattleSkin.SKILL_ICON_BG);
				bg.x = 0;
				bg.y = 0;
				this.addChild(bg);
				
				// 技能icon
				iconPanel = new Sprite();
				iconPanel.x = bg.x + 3;
				iconPanel.y = bg.y + 3;
				this.addChild(iconPanel);
				// 加载技能图标
				iconURL =  GameConfig.ICON_URL + "skill/" + skill.iconId + ".jpg";
				var loader:BulkLoaderSingleton = BattleDataCenter.instance.loader;
				loader.addWithListener(iconURL , null , onLoaded);
			}
		}
		
		
		
		
		/**
		 * 技能icon加载完成
		 * */
		private function onLoaded(e:Event):void
		{
			var imageItem:ImageItem = e.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE , onLoaded);
			
			// 添加头像
			var bmp:Bitmap = imageItem.content;
			if(bmp)
			{
				var icon:Bitmap = new Bitmap(bmp.bitmapData);
				var global:Global = Global.instance;
				global.removeChildren(iconPanel);
				iconPanel.addChild(icon);
			}
		}
		
	}
}