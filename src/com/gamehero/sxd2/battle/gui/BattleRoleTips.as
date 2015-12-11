package com.gamehero.sxd2.battle.gui
{
	import com.gamehero.sxd2.battle.display.BPlayer;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.GameHintSkin;
	import com.gamehero.sxd2.gui.tips.BattleTips;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import org.bytearray.display.ScaleBitmap;
	
	
	/**
	 * 战斗角色tips
	 * @author xuwenyi
	 * @create 2013-12-10
	 **/
	public class BattleRoleTips extends Sprite
	{
		// 背景
		private var bg:ScaleBitmap;
		// 用于存放tips的容器
		private var content:Sprite;
		
		// 角色数据
		public var player:BPlayer;
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleRoleTips()
		{
			bg = new ScaleBitmap(GameHintSkin.TIPS_BG.clone());
			bg.scale9Grid = GameHintSkin.hintBgScale9Grid;
			this.addChild(bg);
			
			content = new Sprite();
			this.addChild(content);
		}
		
		
		
		
		/**
		 * 添加tips内容
		 * */
		public function show(player:BPlayer):void
		{
			this.clear();
			// 生成tips
			var obj:DisplayObject = player.isPlayer == true ? BattleTips.getBattleLeaderTips(player) : BattleTips.getBattleRoleTips(player);
			if(obj)
			{
				content.addChild(obj);
				
				this.draw();
				this.visible = true;
				this.player = player;
			}
		}
		
		
		
		
		
		
		/**
		 * 重绘背景
		 * */
		private function draw():void
		{	
			content.x = 10 + 3;
			content.y = 8 + 1;
			
			var w:int = content.width + 10 * 2;
			var h:int = content.height + 8 * 2;
			
			bg.setSize(w + 5, h + 5);
		}
		
		
		
		/**
		 * 清空
		 * */
		public function clear():void
		{
			Global.instance.removeChildren(content);
			
			this.visible = false;
			this.player = null;
		}
		
	}
}

