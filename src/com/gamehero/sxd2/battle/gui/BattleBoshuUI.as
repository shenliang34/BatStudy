package com.gamehero.sxd2.battle.gui
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	
	/**
	 * 波数显示UI
	 * @author xuwenyi
	 * @create 2014-02-17
	 **/
	public class BattleBoshuUI extends Sprite
	{
		// 火球对象
		private var fires:Array = [];
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleBoshuUI()
		{
			
		}
		
		
		
		
		
		/**
		 * 初始化
		 * */
		public function init(FireClass:Class):void
		{
			// 最多2个火球
			for(var i:int=0;i<2;i++)
			{
				var fire:MovieClip = new FireClass() as MovieClip;
				fire.x = i * 80;
				fire.y = 45;
				fire.visible = false;
				fires.push(fire);
				
				this.addChild(fire);
			}
		}
		
		
		
		
		
		
		/**
		 * 初始化
		 * */
		public function update(curBoshu:int , totalBoshu:int):void
		{
			var minus:int = totalBoshu - curBoshu;
			if(minus >= 2)
			{
				fires[0].visible = true;
				fires[1].visible = true;
			}
			else if(minus >= 1)
			{
				fires[0].visible = false;
				fires[1].visible = true;
			}
			else
			{
				fires[0].visible = false;
				fires[1].visible = false;
			}
		}
		
		
		
		
		
		/**
		 * 清空
		 * */
		public function clear():void
		{
			fires[0].visible = false;
			fires[1].visible = false;
		}
		
	}
}