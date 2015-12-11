package com.gamehero.sxd2.battle.gui
{
	import com.gamehero.sxd2.battle.data.BattleBuff;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.vo.BuffVO;
	
	import flash.display.Sprite;
	
	
	/**
	 * 战斗内Buff栏
	 * @author xuwenyi
	 * @create 2013-12-09
	 **/
	public class BattleBuffBar extends Sprite
	{
		// ICON X位置
		private var POSX:Array = [];
		
		public var limit:int = 8;// 显示个数
		public var face:int = 0;// 0正向;1反向
		
		public var buffs:Array = [];
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleBuffBar()
		{
			//icon位置(正)
			var pos:Array = [0,30,60,90,120,150,180,210];
			POSX[0] = pos;
			//icon位置(反)
			pos = [270,240,210,180,150,120,90,60,30,0];
			POSX[1] = pos;
		}
		
		
		
		
		/**
		 * 更新当前buff栏状态
		 * */
		public function update(buffs:Array):void
		{
			this.clear();
			
			if(buffs && buffs.length > 0)
			{
				// 排序,最晚触发的排最前面
				buffs = buffs.sortOn("triggerTime" , Array.NUMERIC);
				this.buffs = buffs;
				
				for(var i:int=0;i<limit;i++)
				{
					var buff:BattleBuff = buffs[i];
					if(buff)
					{
						var icon:BattleBuffIcon = new BattleBuffIcon();
						icon.update(buff);
						icon.x = POSX[face][i];
						icon.y = 0;
						this.addChild(icon);
					}
				}
			}
		}
		
		
		
		
		
		/**
		 * 清除
		 * */
		public function clear():void
		{
			this.buffs = [];
			
			var global:Global = Global.instance;
			global.removeChildren(this);
		}
		
	}
}