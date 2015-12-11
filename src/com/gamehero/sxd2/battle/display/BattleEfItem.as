package com.gamehero.sxd2.battle.display
{
	import com.gamehero.sxd2.world.display.DefaultFigureItem;
	import com.gamehero.sxd2.world.display.GameRenderItem;
	
	import flash.geom.Rectangle;
	
	/**
	 * 战斗中的特效
	 * @author xuwenyi
	 * @create 2013-12-24
	 **/
	public class BattleEfItem extends GameRenderItem
	{
		// 技能状态
		static public const SELF_AIR:String = "effect_01";
		static public const SELF_GROUND:String = "effect_07";
		static public const UNDERATTACK_AIR:String = "effect_02";
		static public const UNDERATTACK_GROUND:String = "effect_08";
		static public const TARGET_AIR:String = "effect_03";
		static public const TARGET_GROUND:String = "effect_04";
		static public const BULLET_AIR:String = "effect_09";
		static public const BULLET_GROUND:String = "effect_10";
		static public const AREA_AIR:String = "effect_05";
		static public const AREA_GROUND:String = "effect_06";
		
		// 朝向
		protected var _face:String = DefaultFigureItem.RIGHT;
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleEfItem(clearMemory:Boolean = true)
		{
			super(clearMemory);
		}
		
		
		
		
		/**
		 * Set Face 
		 */
		public function set face(value:String):void
		{
			_face = value;
		}
		
		
		
		
		
		public function get face():String
		{	
			return _face;
		}
		
		
		
		
		
		/**
		 * 获取渲染key
		 * */
		override protected function get renderKey():String
		{
			if(this.face == "")
			{
				return this.status + "_";
			}
			else
			{
				return this.status + "_" + this.face + "_";
			}
		}
		
		
		
		
		
		
		/**
		 * 复写render
		 * */
		override protected function render():void
		{
			super.render();
			
			// 调整位置
			if(renderData)
			{
				var frame:Rectangle = renderData.frame;
				if(frame)
				{
					this.x = frame.x;
					this.y = frame.y;
				}
			}
		}
		
		
		
		
		
		/**
		 * Gabage Collect  
		 * @param isCleanAll 是否完全清理
		 * 
		 */
		override public function gc(isCleanAll:Boolean = false):void
		{
			this.clearRender();
			this.clear();
		}
	}
}