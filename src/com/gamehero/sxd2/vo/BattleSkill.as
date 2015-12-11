package com.gamehero.sxd2.vo
{
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.manager.SkillEfManager;
	
	
	/**
	 * 战斗中技能数据的封装
	 * @author xuwenyi
	 * @create 2013-07-26
	 **/
	public class BattleSkill extends BaseVO
	{
		public var skillId:String;
		public var groupId:String;
		public var efs:Vector.<BattleSkillEf>;
		public var skillLevel:int;
		public var name:String;
		public var description:String;
		public var releaseType:String;
		public var consumeAnger:int;			//消耗的怒气值
		public var iconId:String;				//技能图标
		public var skillType:int;				//技能类型
		public var upCondition:int;				//学习条件
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleSkill()
		{
		}
		
		
		
		public function fromXML(x:XML):void
		{
			this.skillId = x.@skillId;
			this.groupId = x.@groupId;
			this.skillLevel = x.@skillLevel;
			
			var ids:Array = String(x.@effectIDs).split(";");
			this.efs = SkillEfManager.instance.getEffects(ids);
			
			this.name = Lang.instance.trans(x.@cname);
			this.description = Lang.instance.trans(x.@description);
			this.releaseType = x.@releaseType;
			this.consumeAnger = x.@consume_anger;
			
			this.iconId = x.@iconId;
			this.skillType = x.@skill_type;
			this.upCondition = x.@up_condition;
		}
	}
}