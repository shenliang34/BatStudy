package com.gamehero.sxd2.battle.layer
{
	import com.gamehero.sxd2.battle.data.BattleDataCenter;
	import com.gamehero.sxd2.battle.data.BattleGrid;
	import com.gamehero.sxd2.battle.display.BPlayer;
	import com.gamehero.sxd2.battle.display.BattleFigureItem;
	import com.gamehero.sxd2.battle.display.BattleSwfEf;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.vo.BattleSkillEf;
	
	import flash.display.Sprite;
	
	import bowser.utils.data.Group;
	import bowser.utils.data.Vector2D;
	
	
	/**
	 * 用于播放传统swf技能特效层
	 * @author xuwenyi
	 * @create 2015-06-04
	 **/
	public class BattleSwfSkillLayer extends Sprite
	{
		// 空中效果列表
		private var airList:Group = new Group();
		
		
		public function BattleSwfSkillLayer()
		{
			super();
		}
		
		
		
		
		
		/**
		 * 播放SE
		 * */
		public function playSE(skillEf:BattleSkillEf , aPlayer:BPlayer):void
		{
			var url:String = skillEf.getSeURL();
			var se:BattleSwfEf = new BattleSwfEf(url);
			se.x = aPlayer.x;
			se.y = aPlayer.y;
			se.scaleX = aPlayer.camp == 1 ? 1 : -1;
			se.animCompHandler = animCompHandler;
			se.play(false);
			
			airList.add(se);
			this.addChild(se);
		}
		
		
		
		
		
		/**
		 * 播放SE
		 * */
		public function playUA(skillEf:BattleSkillEf , aPlayer:BPlayer , uPlayer:BPlayer):void
		{
			var url:String = skillEf.getUaURL();
			var ua:BattleSwfEf = new BattleSwfEf(url);
			ua.x = uPlayer.x;
			ua.y = uPlayer.y;
			ua.scaleX = aPlayer.camp == 1 ? 1 : -1;// 根据攻击者面向判定特效朝向
			ua.animCompHandler = animCompHandler;
			ua.play(false);
			
			airList.add(ua);
			this.addChild(ua);
		}
		
		
		
		
		
		
		/**
		 * 添加某个SK效果
		 * @param face 效果朝向
		 * */
		public function playSK(skillEf:BattleSkillEf , aPlayer:BPlayer , uPlayer:BPlayer):void
		{
			var efRule:String = skillEf.efRule;
			// 此技能必须有空中或地面特效规则才能显示
			if(efRule && efRule != "")
			{
				// 确定播放位置
				var pos:Vector2D = this.getPos(skillEf , aPlayer , uPlayer);
				
				// 空中效果
				var airURL:String = skillEf.getSkURL();
				var air:BattleSwfEf = this.getItem(airURL , skillEf , aPlayer , uPlayer);
				air.animCompHandler = animCompHandler;
				if(pos)
				{
					air.x = pos.x;
					air.y = pos.y;
				}
				airList.add(air);
				this.addChild(air);
			}
		}
		
		
		
		
		
		
		
		
		/**
		 * 效果播放完毕
		 * */
		private function animCompHandler(ef:BattleSwfEf):void
		{
			if(ef)
			{
				airList.remove(ef);
				if(this.contains(ef) == true)
				{
					this.removeChild(ef);
				}
			}
		}
		
		
		
		
		
		/**
		 * 生成效果对象
		 * */
		private function getItem(url:String , skillEf:BattleSkillEf , aPlayer:BPlayer , uPlayer:BPlayer):BattleSwfEf
		{
			var aAvatar:BattleFigureItem = aPlayer.avatar;
			var ef:BattleSwfEf = new BattleSwfEf(url);
			switch(skillEf.efRule)
			{
				// 旋转子弹
				case "6":
					ef.move(skillEf , aPlayer , uPlayer , true);
					ef.play(true);
					break;
				
				// 非旋转子弹
				case "7":
					ef.move(skillEf , aPlayer , uPlayer , false);
					ef.play(true);
					break;
				
				// 非子弹类效果
				default:
					ef.play(false);
					ef.scaleX = aPlayer.camp == 1 ? 1 : -1;// 过程特效的方向
					break;
			}
			return ef;
		}
		
		
		
		
		
		
		
		/**
		 * 播放位置
		 * */
		private function getPos(skillEf:BattleSkillEf , aPlayer:BPlayer , uPlayer:BPlayer):Vector2D
		{
			var dataCenter:BattleDataCenter = BattleDataCenter.instance;
			var grid:BattleGrid;
			var pos:Vector2D;
			switch(skillEf.efRule)
			{
				// 目标身上播放
				// 指向性
				case "1":
				case "3":
					pos = new Vector2D(uPlayer.x , uPlayer.y);
					break;
				// 释放者身上播放
				case "2":
					pos = new Vector2D(aPlayer.x , aPlayer.y);
					break;
				// 我方阵型区域
				case "4":
					grid = aPlayer.camp == 1 ? dataCenter.grid1 : dataCenter.grid2;
					pos = grid.getMidPos();
					break;
				// 敌方阵型区域
				case "5":
					grid = aPlayer.camp == 1 ? dataCenter.grid2 : dataCenter.grid1;
					pos = grid.getMidPos();
					break;
				// 旋转子弹
				// 不旋转子弹
				case "6":
				case "7":
					pos = null;
					break;
				// 横排
				case "8":
					grid = aPlayer.camp == 1 ? dataCenter.grid2 : dataCenter.grid1;
					pos = grid.getMidPosByRow(uPlayer.pos);
					break;
				// 竖排
				case "9":
					grid = aPlayer.camp == 1 ? dataCenter.grid2 : dataCenter.grid1;
					pos = grid.getMidPosByColumn(uPlayer.pos);
					break;
			}
			return pos;
		}
		
		
		
		
		
		
		
		/**
		 * 清空
		 * */
		public function clear():void
		{
			var list:Array = airList.toArray();
			for(var i:int=0;i<list.length;i++)
			{
				var ef:BattleSwfEf = list[i];
				ef.clear();
			}
			
			airList.clear();
			
			Global.instance.removeChildren(this);
		}
	}
}