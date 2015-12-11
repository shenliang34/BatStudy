package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.vo.BattleSkillEf;
	
	import flash.utils.Dictionary;
	
	import bowser.logging.Logger;
	import bowser.utils.GameTools;
	import bowser.utils.data.Vector2D;
	
	/**
	 * 技能效果配置表管理
	 * @author xuwenyi
	 * @create 2014-02-11
	 **/
	public class SkillEfManager
	{
		static private var _instance:SkillEfManager;
		
		
		private var EFFECT:Dictionary = new Dictionary();//以ID为key
		private var skillEfXMLList:XMLList;
		
		
		
		/**
		 * Constructor
		 * @param singleton
		 * 
		 */
		public function SkillEfManager(singleton:Singleton)
		{	
			var settingsXML:XML = GameSettings.instance.settingsXML;
			var xmlList:XMLList = settingsXML.skill_effect;
			var xml:XML = xmlList[0];
			this.init(xml);
		}
		
		
		static public function get instance():SkillEfManager {
			
			return _instance ||= new SkillEfManager(new Singleton());
		}
		
		
		
		/**
		 * 加载配置表
		 * */
		public function init(xml:XML):void
		{
			skillEfXMLList = xml.children();
		}
		
		
		/**
		 * 根据技能id获取效果配置
		 * */
		public function getEffects(ids:Array):Vector.<BattleSkillEf>
		{
			var vec:Vector.<BattleSkillEf> = new Vector.<BattleSkillEf>();
			for(var i:int=0;i<ids.length;i++)
			{
				var effectID:String = ids[i];
				var ef:BattleSkillEf = EFFECT[effectID];
				if(ef == null)
				{
					var x:XML = GameTools.searchXMLList(skillEfXMLList , "effectID" , effectID);
					if(x)
					{
						ef = new BattleSkillEf();
						// 配置表属性
						ef.effectID = x.@effectID;
						
						// 连击伤害权重
						ef.dmgWeight = x.@dmgWeight;
						ef.dmgWeight = ef.dmgWeight <= 0 ? 1 : ef.dmgWeight;
						
						ef.moveDis = x.@moveDis;//离目标的距离
						ef.atkRange = x.@atkRange;//1单体，2打一列，3打一行，4AOE
						ef.actionId = x.@actionId;
						ef.attackId = x.@attackId;
						ef.hit = x.@hit;
						ef.actionDuration = x.@actionDuration;
						ef.uatkDuration = x.@uatkDuration;
						
						// 多重攻击间隔
						ef.multiAtkInterval = x.@multiAtkInterval;
						
						// 技能效果url
						ef.efSE = x.@efSE;
						ef.efUA = x.@efUA;
						ef.efSUA = x.@efSUA;
						ef.efSK = x.@efSK;
						
						// 技能效果播放规则
						ef.efRule = x.@efRule;
						
						// 技能效果是否分方向分层
						ef.seLayer = x.@seLayer;
						ef.uaLayer = x.@uaLayer;
						ef.suaLayer = x.@suaLayer;
						ef.skLayer = x.@skLayer;
						
						ef.seDelay = x.@seDelay;
						ef.skDelay = x.@skDelay;
						
						var uaDelayStr:String = x.@uaDelay;
						
						ef.uaDelays = String(x.@uaDelay).split(";");
						ef.suaDelays = String(x.@suaDelay).split(";");
						
						ef.actionFrame = x.@actionFrame;
						ef.seFrame = x.@seFrame;
						ef.skFrame = x.@skFrame;
						ef.uaFrame = x.@uaFrame;
						
						var movesstr:String = String(x.@moves);
						ef.moves = movesstr == "" ? null : movesstr.split(";");
						ef.moveDelays = String(x.@moveDelays).split(";");
						ef.isSkillMove = String(x.@isSkillMove) == "1" ? true : false;
						
						ef.bulletDuration = x.@bulletDuration;
						ef.bulletPos = x.@bulletPos;
						// 子弹最终飞向的点坐标
						var bulletOffset:String = x.@bulletOffset;
						if(bulletOffset != "")
						{
							var arr:Array = bulletOffset.split(",");
							ef.bulletOffset = new Vector2D(Number(arr[0]) , Number(arr[1]));
						}
						
						ef.shakeDelays = String(x.@shakeDelay).split(";");
						ef.flashDelays = String(x.@flashDelay).split(";");
						ef.blackDelay = x.@blackDelay;
						ef.blackDuration1 = x.@blackDuration1;
						ef.blackDuration2 = x.@blackDuration2;
						
						ef.seSound = x.@seSound;
						ef.seSoundDelay = x.@seSoundDelay;
						ef.uaSound = x.@uaSound;
						ef.uaSoundDelay = x.@uaSoundDelay;
						
						ef.isBurst = x.@isBurst;
						
						// 合击时间点
						ef.jointAtkDelay = x.@jointAtkDelay;
						
						// 保存到字典中
						// 按id分类
						EFFECT[ef.effectID] = ef;
					}
					else
					{
//						Logger.warn(SkillEfManager , "没有找到技能效果数据... effectID = " + effectID);
					}
				}
				
				if(ef != null)
				{
					vec.push(ef);
				}
			}
			
			return vec;
		}
	}
}


class Singleton{}