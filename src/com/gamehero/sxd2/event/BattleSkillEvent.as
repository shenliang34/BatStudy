package com.gamehero.sxd2.event
{
	import flash.events.Event;
	
	/**
	 * 战斗技能快捷栏事件
	 * @author xuwenyi
	 * @create 2013-08-20
	 **/
	public class BattleSkillEvent extends BaseEvent
	{
		public static const USE_SKILL:String = "useSkill";
		public static const SKILL_ICON_CLICK:String = "skillIconClick";// 点击技能icon派发
		
		public static const WALL_USE_SKILL:String = "wallUseSkill";
		public static const WALL_SKILL_ICON_CLICK:String = "wallSkillIconClick";// 保卫长城点击杀和桃派发
		
		
		/**
		 * 构造函数
		 * */
		public function BattleSkillEvent(type:String, data:Object=null)
		{
			super(type, data);
		}
		
		
		override public function clone():Event
		{
			return new BattleSkillEvent(type , data);
		}
	}
}