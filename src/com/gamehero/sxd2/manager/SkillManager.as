package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.vo.BattleSkill;
	
	import flash.utils.Dictionary;
	
	import bowser.logging.Logger;
	import bowser.utils.GameTools;
	import bowser.utils.data.Group;
	
	/**
	 * 技能配置表管理类
	 * @author xuwenyi
	 * @create 2013-08-20
	 **/
	public class SkillManager
	{
		private static var _instance:SkillManager;
		
		// 技能字典
		private var SKILL:Dictionary = new Dictionary();//以skillID为key
		private var GROUP:Dictionary = new Dictionary();//以groupID为key
		private var TYPE:Dictionary = new Dictionary();//以type为key
		
		private var skillXMLList:XMLList;
		
		/**
		 * 构造函数
		 * */
		public function SkillManager()
		{
			var settingsXML:XML = GameSettings.instance.settingsXML;
			this.skillXMLList = settingsXML.skills.skills;
		}
		
		public static function get instance():SkillManager {
			
			return _instance ||= new SkillManager();
		}
		
		/**
		 * 根据技能id获取技能对象
		 * */
		public function getSkillBySkillID(skillId:String):BattleSkill
		{
			if(skillId == "")
			{
				Logger.warn(SkillManager , "技能数据找不到... id = empty");
				return null;
			}
			
			var skill:BattleSkill = SKILL[skillId];
			if(skill == null)
			{
				var x:XML = GameTools.searchXMLList(skillXMLList , "skillId" , skillId);
				if(x)
				{	
					skill = new BattleSkill();
					// 配置表属性
					skill.fromXML(x);
					
					// 保存到字典中
					// 按skillID分类
					SKILL[skill.skillId] = skill;
				}
				else
				{
					Logger.warn(SkillManager , "技能数据找不到... id = " + skillId);
				}
			}
			return skill;
		}

		/**
		 * 根据groupID获取技能对象列表
		 * */
		public function getSkillByGroupID(groupId:String):Group
		{
			var group:Group = GROUP[groupId];
			if(group == null)
			{
				group = new Group();
				// 找到所有groupID相符的项,生成该组数据
				var xmllist:XMLList = skillXMLList.(@groupId == groupId);
				var iLen:int = xmllist.length();
				for(var i:int=0;i<iLen;i++)
				{
					var x:XML = xmllist[i];
					var skill:BattleSkill = getSkillBySkillID(x.@skillId);
					if(skill)
					{
						group.add(skill);
					}
				}
				GROUP[groupId] = group;
			}
			return group;
		}
		
		/**
		 * 根据type获取技能对象列表
		 * */
		public function getSkillByType(type:int):Array
		{
			var list:Array = TYPE[type];
			if(list == null)
			{
				list = new Array();
				var xmllist:XMLList = skillXMLList.(@skill_type == type);
				var iLen:int = xmllist.length();
				for(var i:int=0;i<iLen;i++)
				{
					var x:XML = xmllist[i];
					var skill:BattleSkill = getSkillBySkillID(x.@skillId);
					if(skill)
					{
						list.push(skill)
					}
				}
				TYPE[type] = list;
			}
			return list;
		}

		/**
		 * 获取某个技能的前一等级技能
		 * */
		public function getPreSkill(id:String):BattleSkill
		{
			var preSkill:BattleSkill;
			var skill:BattleSkill = this.getSkillBySkillID(id);
			if(skill)
			{
				var group:Group = this.getSkillByGroupID(skill.groupId);
				if(group)
				{
					preSkill = group.getChildByParam("skillLevel" , skill.skillLevel - 1) as BattleSkill;
				}
			}
			return preSkill;
		}

		/**
		 * 获取某个技能的后一等级技能
		 * */
		public function getNextSkill(id:String):BattleSkill
		{
			var nextSkill:BattleSkill;
			var skill:BattleSkill = this.getSkillBySkillID(id);
			if(skill)
			{
				var group:Group = this.getSkillByGroupID(skill.groupId);
				if(group)
				{
					nextSkill = group.getChildByParam("skillLevel" , skill.skillLevel + 1) as BattleSkill;
				}
			}
			return nextSkill;
		}
		
		/**
		 *根据技能类型获取类型描述 
		 * @param type
		 * @return 
		 * 
		 */		
		public function getSkillTypeByDescribe(type:int):String
		{
			var str:String
			switch(int(type))
			{
				case 0:
					str = "【全系】";
					break;
				case 1:
				{
					str = "【金系】";
					break;
				}
				case 2:
				{
					str = "【木系】";	
					break;
				}
				case 3:
				{
					str = "【水系】";
					break;
				}
				case 4:
				{
					str = "【火系】";
					break;
				}
				case 5:
				{
					str = "【土系】";
					break;
				}
					
				default:
				{
					break;
				}
			}
			return str;
		}
		
		/**
		 *根据技能id获取技能数据和槽位 
		 * @param skillId
		 * @return 
		 * 
		 */		
		public function getRoleSkillBySkillID(skillId:String):Object
		{
			var skills:Array = GameData.inst.roleSkill.skills;
			var i:int = 0;
			var len:int = skills.length;
			for(i;i<len;i++)
			{
				if(skills[i].skillId == skillId)
				{
					var obj:Object = new Object();
					obj.skillVo = getSkillBySkillID(skillId);
					obj.pos = skills[i].pos;
					if(obj.skillVo)
						return obj
					else
						return null;
					
				}
			}
			return null;
		}
	}
}