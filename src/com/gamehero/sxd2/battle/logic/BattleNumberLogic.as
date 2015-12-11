import com.gamehero.sxd2.battle.BattleView;
import com.gamehero.sxd2.battle.data.BattleAtkData;
import com.gamehero.sxd2.battle.data.BattleDamageData;
import com.gamehero.sxd2.battle.display.BPlayer;
import com.gamehero.sxd2.vo.BattleSkillEf;

import flash.utils.Dictionary;

/**
 * 战斗飘字处理
 * @author xuwenyi
 * @create 2015-06-17
 **/





/**
 * 显示所有飘字
 * */
private function showDamages():void
{
	// 遍历floatTextData , 开始播放飘字效果
	for(var id:int in damageData)
	{
		var list:Array = damageData[id];
		if(list)
		{
			this.playDamage(list);
		}
	}
	// 清空
	damageData = new Dictionary();
}







/**
 * 播放一组飘字效果
 * @param list 飘字数据数组
 * */
private function playDamage(list:Array):void
{
	var view:BattleView = this;
	var t:int = 300 * dataCenter.playSpeed;// 播放速度系数
	
	// 开始播放
	play();
	
	// 播放单个飘字效果
	function play():void
	{
		if(list.length > 0)
		{
			// 播放飘字效果
			var dmgdata:BattleDamageData = list.shift();
			var atkData:BattleAtkData = dmgdata.atkData;
			efCanvas.playDmgEf(dmgdata , view);
			
			// 受击
			var aPlayer:BPlayer = dmgdata.aPlayer;
			var uPlayer:BPlayer = dmgdata.uPlayer;
			var skillEf:BattleSkillEf = dmgdata.skillEf;
			if(skillEf)
			{
				// 是否格挡
				if(atkData.pay == true)
				{
					uPlayer.parry();
				}
					// 是否闪避
				else if(atkData.avd == true)
				{
					uPlayer.avoid(skillEf);
				}
					// 是否播放受击动作
				else if(atkData.dmgShow > 0)
				{
					uPlayer.underAttack(skillEf);
					
					// 是否穿透
					if(atkData.pnt == true)
					{
						uPlayer.showPenetrationEf();
					}
					
					// 是否溅射
					var isSpurt:Boolean = atkData.spurt;
					var efUA:String = isSpurt == false ? skillEf.efUA : skillEf.efSUA;
					// 播放受击特效
					if(efUA != "")
					{
						if(skillEf.isPNG(efUA) == true)// 序列帧动画
						{
							uPlayer.playUA(skillEf , aPlayer.avatarFace , isSpurt);
						}
						else// swf动画
						{
							efCanvas.playSwfUA(skillEf , aPlayer , uPlayer);
						}
					}
				}
			}
			
			// 递归(同一个角色的飘字间隔)
			if(list.length > 0)
			{
				setTimer(play , t);
			}
		}
	}
	
}







/**
 * 添加飘字
 * */
private function addDamage(aPlayer:BPlayer,uPlayer:BPlayer,skillEf:BattleSkillEf,atkData:BattleAtkData):void
{
	// 获取飘字数据
	var data:BattleDamageData = this.createDamageData(aPlayer,uPlayer,skillEf,atkData);
	var arr:Array = damageData[data.id];
	if(arr)
	{
		arr.push(data);
	}
	else
	{
		// 没有此id,则新建
		damageData[data.id] = new Array();
		damageData[data.id].push(data);
	}
}






/**
 * 漂浮伤害数字
 * @param player 触发的角色
 * @param atk 攻击数据
 * @param dmg 伤害数值
 * */
private function createDamageData(aPlayer:BPlayer,uPlayer:BPlayer,skillEf:BattleSkillEf,atkData:BattleAtkData):BattleDamageData
{
	// 浮动文字
	var data:BattleDamageData = new BattleDamageData();
	data.aPlayer = aPlayer;
	data.uPlayer = uPlayer;
	data.skillEf = skillEf;
	data.id = uPlayer.tempID;
	//data.isSelf = isSelf;
	data.atkData = atkData;
	return data;
}
