package com.gamehero.sxd2.battle.display
{
	import com.greensock.TweenMax;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.BattleSkin;
	import com.gamehero.sxd2.vo.BattleSkill;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import bowser.render.display.RenderItem;
	import bowser.render.display.SpriteItem;
	
	
	/**
	 * 战斗中人物头上的技能icon
	 * @author xuwenyi
	 * @create 2013-08-09
	 **/
	public class RoleSkIcon extends SpriteItem
	{
		// icon图标
		private var icon:RenderItem;
		private var iconURL:String;
		// icon背景
		private var iconBG:RenderItem;
		// 选中框
		private var selectedBG:RenderItem;
		// 缓动
		private var tween:TweenMax;
		
		
		
		/**
		 * 构造函数
		 * */
		public function RoleSkIcon()
		{
			super();
			
//			eventDisp = new EventDispatcher();
		}
		
		
		
		/**
		 * 更新技能图标
		 * */
		public function update(skill:BattleSkill):void
		{
			this.clear();
			
			// 技能存在
			if(skill)
			{
				// icon背景
				iconBG = new RenderItem();
				iconBG.renderSource = BattleSkin.SKILL_ICON_BG;
				iconBG.scaleX = iconBG.scaleY = 0.6;
				iconBG.x = -1;
				iconBG.y = -1;
				this.addChild(iconBG);
				
				// 选中框
				selectedBG = new RenderItem();
				selectedBG.renderSource = BattleSkin.SKILL_SELECT_BG;
				selectedBG.scaleX = selectedBG.scaleY = 0.57;
				this.addChild(selectedBG);
				
				// icon
				iconURL = GameConfig.ICON_URL + "skill/" + skill.iconId + ".jpg";
				icon = new RenderItem(iconURL);
				icon.scaleX = icon.scaleY = 0.57;
				icon.x = 2;
				icon.y = 2;
				this.addChild(icon);
				
				// 渐隐选中框
				TweenMax.to(selectedBG , 1.2 , {alpha:0});
			}
		}
		
		
		
		
		/**
		 * 变大后消失
		 * */
		public function hide():void
		{
			if(icon)
			{
				// 隐藏icon背景
				if(iconBG)
				{
					iconBG.visible = false;
				}
				
				// 渐隐变大
				tween = TweenMax.to(icon , 0.4 , {alpha:0,scaleX:1.14,scaleY:1.14,x:"-12",y:"-12",onComplete:animateCompHandler});
				
				// 动画完毕
				function animateCompHandler():void
				{
					// 清理
					clear();
					// 完成事件
					dispatchEvent(new Event(Event.COMPLETE));
				}
			}
			else
			{
				// 清理
				clear();
			}
		}
		
		
		
		
		/**
		 * 清除
		 * */
		public function clear():void
		{
			if(tween)
			{
				tween.kill();
				tween = null;
			}
			
			this.removeChildren();
		}
		
		
	}
}