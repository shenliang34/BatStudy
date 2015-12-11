package com.gamehero.sxd2.battle.display
{
	import com.gamehero.sxd2.world.display.DefaultFigureItem;
	
	import bowser.utils.effect.NumberUtil;
	
	/**
	 * 战斗中的人物模型
	 * @author xuwenyi
	 * @create 2013-11-08
	 **/
	public class BattleFigureItem extends DefaultFigureItem
	{	
		// 普通状态
		static public const STAND:String = "battle_stand";
		static public const RUN:String = "battle_run";
		static public const JUMP:String = "battle_jump";
		
		// 战斗状态
		static public const ATTACK:String = "battle_attack";
		static public const HIT:String = "battle_hit";
		static public const PARRY:String = "battle_parry";
		static public const DEAD:String = "battle_dead";
		
		// 起身
		static public const STANDUP:String = "battle_standup";
		
		// 卧倒姿势的受击
		public static const DEAD_HIT:String = "battle_hit06";
		
		// 默认技能状态
		public static const DEFAULT_SKILL:String = "01";
		// 默认受击状态
		public static const DEFAULT_HIT:String = "";
		
		//UI面板人物动作
		public static const UI_STAND:String = "ui_stand";
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleFigureItem(clearMemory:Boolean = true)
		{
			super(clearMemory);
		}
		
		
		
		public function get face():String
		{	
			return _face;
		}
		
		
		/**
		 * Set Face 
		 */
		public function set face(value:String):void
		{
			_face = value;	
		}
		
		
		
		
		
		
		/**
		 * 设置人物状态 
		 * @param param 动作id(技能使用的attackID:01,02...10,11...等)
		 */
		public function setFigureStatus(value:String , param:String = ""):void
		{	
			if(value != _status)
			{	
				// 攻击
				if(value.indexOf(ATTACK) >= 0)
				{
					if(param != "")
					{
						// 判断角色是否有此动作
						value += NumberUtil.getCompletionString(param , 2);
					}
					else
					{
						// 若没有配动作, 则直接跳过, 否则会覆盖之前的动作
						return;
					}
				}
				// 受击
				if(value.indexOf(HIT) >= 0)
				{
					if(param != "")
					{
						// 判断角色是否有此动作
						value += NumberUtil.getCompletionString(param , 2);
					}
				}
				// 保存
				_status = value;
				
				// 重置动画播放
				this.reset();
			}
		}
		
		
		
		
		
		
		
		
		/**
		 * 渲染关键字
		 * */
		override protected function get renderKey():String
		{
			return _status + "_" + _face + "_";
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