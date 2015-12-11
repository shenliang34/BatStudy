package com.gamehero.sxd2.battle.layer
{
	import com.gamehero.sxd2.battle.data.BattleDataCenter;
	import com.gamehero.sxd2.battle.data.BattleGrid;
	import com.gamehero.sxd2.battle.display.BPlayer;
	import com.gamehero.sxd2.battle.display.BattleEf;
	import com.gamehero.sxd2.battle.display.BattleEfItem;
	import com.gamehero.sxd2.battle.display.BattleFigureItem;
	import com.gamehero.sxd2.vo.BattleSkillEf;
	
	import bowser.render.display.SpriteItem;
	import bowser.utils.data.Group;
	import bowser.utils.data.Vector2D;
	
	
	/**
	 * 战斗效果层(渲染引擎层)
	 * @author xuwenyi
	 * @create 2013-12-24
	 **/
	public class BattleEfLayer
	{
		private static var _instance:BattleEfLayer;
		// 空中层
		public var airLayer:SpriteItem = new SpriteItem();
		// 地面层
		public var groundLayer:SpriteItem = new SpriteItem();
		
		// 空中效果列表
		private var airList:Group = new Group();
		// 地面效果列表
		private var groundList:Group = new Group();
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleEfLayer(){}
		
		public static function get instance():BattleEfLayer
		{
			if(_instance == null)
			{
				_instance = new BattleEfLayer();
			}
			return _instance;
		}
		
		
		
		
		
		/**
		 * 添加显示某个效果
		 * @param face 效果朝向
		 * */
		public function add(skillEf:BattleSkillEf , aPlayer:BPlayer , uPlayer:BPlayer):void
		{
			var efRule:String = skillEf.efRule;
			// 此技能必须有空中或地面特效规则才能显示
			if(efRule && efRule != "")
			{
				// 确定播放位置
				var pos:Vector2D = this.getPos(skillEf , aPlayer , uPlayer);
				// 确定播放状态
				var status:Object = this.getStatus(efRule);
				
				// 空中效果
				var airURL:String = skillEf.getSkURL();
				var air:BattleEf = this.getItem(airURL , status.air , skillEf , aPlayer , uPlayer);
				air.animCompHandler = animCompHandler;
				if(pos)
				{
					air.x = pos.x;
					air.y = pos.y;
				}
				airList.add(air);
				airLayer.addChild(air);
				
				// 地面效果
				if(skillEf.skLayer == "1")
				{
					var groundURL:String = skillEf.getSkURL();
					var ground:BattleEf = this.getItem(groundURL , status.ground , skillEf , aPlayer , uPlayer);
					ground.animCompHandler = animCompHandler;
					if(pos)
					{
						ground.x = pos.x;
						ground.y = pos.y;
					}
					groundList.add(ground);
					groundLayer.addChild(ground);
				}
			}
		}
		
		
		
		
		
		
		
		
		/**
		 * 效果播放完毕
		 * */
		private function animCompHandler(ef:BattleEf):void
		{
			if(ef)
			{
				airList.remove(ef);
				if(airLayer.contains(ef) == true)
				{
					airLayer.removeChild(ef);
				}
				
				groundList.remove(ef);
				if(groundLayer.contains(ef) == true)
				{
					groundLayer.removeChild(ef);
				}
			}
		}
		
		
		
		
		
		/**
		 * 生成效果对象
		 * */
		private function getItem(url:String , status:String , skillEf:BattleSkillEf , aPlayer:BPlayer , uPlayer:BPlayer):BattleEf
		{
			var aAvatar:BattleFigureItem = aPlayer.avatar;
			var ef:BattleEf = new BattleEf(url , status , aAvatar.face , skillEf.skFrame);
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
		 * 播放状态
		 * */
		private function getStatus(effectRule:String):Object
		{
			var status:Object = new Object();
			switch(effectRule)
			{
				// 目标身上播放
				case "1":
				// 释放者身上播放
				case "2":
				// 我方阵型区域
				case "4":
				// 敌方阵型区域
				case "5":
					status.air = BattleEfItem.AREA_AIR;
					status.ground = BattleEfItem.AREA_GROUND;
					break;
					
				// 指向性
				case "3":
					status.air = BattleEfItem.TARGET_AIR;
					status.ground = BattleEfItem.TARGET_GROUND;
					break;
				
				// 子弹类
				case "6":
				case "7":
					status.air = BattleEfItem.BULLET_AIR;
					status.ground = BattleEfItem.BULLET_GROUND;
					break;
			}
			return status;
		}
		
		
		
		
		
		
		/**
		 * 清空
		 * */
		public function clear():void
		{
			var list:Array = airList.concat(groundList).toArray();
			for(var i:int=0;i<list.length;i++)
			{
				var ef:BattleEf = list[i];
				ef.clear();
			}
			
			airList.clear();
			groundList.clear();
			
			airLayer.removeChildren();
			groundLayer.removeChildren();
		}
		
	}
}