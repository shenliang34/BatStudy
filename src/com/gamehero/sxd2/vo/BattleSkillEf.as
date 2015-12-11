package com.gamehero.sxd2.vo
{
	import com.gamehero.sxd2.core.GameConfig;
	
	import bowser.utils.data.Vector2D;
	
	
	/**
	 * 技能效果VO
	 * @author xuwenyi
	 * @create 2014-02-11
	 **/
	public class BattleSkillEf
	{
		// 该技能相关效果属性
		public var effectID:String;
		public var dmgWeight:Number;//连击伤害权重
		public var moveDis:Number;//离目标的距离
		public var atkRange:Number;//1单体,2一行,3一列,4AOE
		public var actionId:Number;
		public var attackId:String;
		public var hit:String;
		public var actionDuration:Number;//整个攻击动作持续时间
		public var uatkDuration:Number;//受击持续时间
		
		// 多重攻击间隔
		public var multiAtkInterval:Number;
		
		// 特效资源url路径
		public var efSE:String;
		public var efUA:String;
		public var efSUA:String;
		public var efSK:String;
		
		// 特效分类
		public var efRule:String;
		
		// 特效素材是否分层
		public var seLayer:String;//自身效果是否分层
		public var uaLayer:String;
		public var suaLayer:String;
		public var skLayer:String;//技能本身效果是否分层
		
		public var seDelay:Number;//自身特效出现的延迟时间
		public var skDelay:Number;//过程特效出现的延迟时间
		public var uaDelays:Array;//受击特效出现的延迟时间
		public var suaDelays:Array;//溅射受击时间点
		
		public var actionFrame:Number;//攻击动作的帧频
		public var seFrame:Number;//自身特效的帧频
		public var skFrame:Number;//过程特效的帧频
		public var uaFrame:Number;//受击特效的帧频
		
		public var moves:Array;//壳动画
		public var moveDelays:Array;
		public var isSkillMove:Boolean;
		
		public var bulletDuration:Number;//子弹飞行时间(毫秒)
		public var bulletPos:String;//子弹以人物哪个位置为注册点(1头顶,2中间,3脚底)
		public var bulletOffset:Vector2D;//子弹最终飞向的点坐标
		
		public var chainUaType:String;//防御链晶格受击类型(1:单体,2:身旁,3:身后,4:周围)
		
		public var shakeDelays:Array;
		public var flashDelays:Array;
		public var blackDelay:String;
		public var blackDuration1:Number;
		public var blackDuration2:Number;
		
		// 音效相关
		public var seSound:String;
		public var seSoundDelay:Number;
		public var uaSound:String;
		public var uaSoundDelay:Number;
		
		// 合击时间点
		public var jointAtkDelay:Number;
		
		// 是否出现横幅特效
		public var isBurst:String;
		
		public var burstModel:String;
		public var burstBG:String;
		public var burstText:String;
		
		
		public function BattleSkillEf()
		{
			super();
		}
		
		
		
		
		/**
		 * 获取se效果
		 * */
		public function getSeURL():String
		{
			var url:String;
			if(this.isPNG(efSE) == true)
			{
				url = GameConfig.BATTLE_SE_URL + efSE + "_se";
			}
			else
			{
				url = GameConfig.BATTLE_SE_SWF_URL + efSE + "_se.swf";
			}
			return url;
		}
		
		
		
		
		
		
		/**
		 * 获取受击效果
		 * */
		public function getUaURL():String
		{
			var url:String;
			if(this.isPNG(efUA) == true)
			{
				url = GameConfig.BATTLE_UA_URL + efUA + "_ua";
			}
			else
			{
				url = GameConfig.BATTLE_UA_SWF_URL + efUA + "_ua.swf";
			}
			return url;
		}
		
		
		
		
		/**
		 * 获取技能溅射受击效果
		 * */
		public function getSUaURL():String
		{
			var url:String;
			if(this.isPNG(efSUA) == true)
			{
				url = GameConfig.BATTLE_UA_URL + efSUA + "_ua";
			}
			else
			{
				url = GameConfig.BATTLE_UA_SWF_URL + efSUA + "_ua.swf";
			}
			return url;
			return url;
		}
		
		
		
		
		/**
		 * 获取过程效果
		 * */
		public function getSkURL():String
		{
			var url:String;
			if(this.isPNG(efSK) == true)
			{
				url = GameConfig.BATTLE_SK_URL + efSK;
			}
			else
			{
				url = GameConfig.BATTLE_SK_SWF_URL + efSK + ".swf";
			}
			return url;
		}
		
		
		
		
		
		/**
		 * 是否为序列帧动画
		 * */
		public function isPNG(url:String):Boolean
		{
			return url.indexOf("png_") >= 0;
		}
		
		
		
		
		
		
		/**
		 * 获取uaDelay
		 * */
		public function getUaDelay(pos:int):Number
		{
			var uaDelay:String;
			if(uaDelays.length > 1)
			{
				uaDelay = uaDelays[pos];
			}
			else
			{
				uaDelay = uaDelays[0];
			}
			
			return uaDelay == "" ? 300 : Number(uaDelay);
		}
	}
}