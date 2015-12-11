package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.vo.BattleSkillMove;
	import com.greensock.easing.Cubic;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import bowser.logging.Logger;
	import bowser.utils.GameTools;
	
	/**
	 * 壳动画配置表
	 * @author xuwenyi
	 * @create 2015-06-19
	 **/
	public class SkillMoveManager
	{
		static private var _instance:SkillMoveManager;
		
		
		private var MOVE:Dictionary = new Dictionary();//以ID为key
		private var skillMoveXMLList:XMLList;
		
		
		public function SkillMoveManager()
		{
			var settingsXML:XML = GameSettings.instance.settingsXML;
			skillMoveXMLList = settingsXML.skill_move.move;	
		}
		
		
		
		
		public static function get instance():SkillMoveManager
		{	
			return _instance ||= new SkillMoveManager();
		}
		
		
		
		
		/**
		 * 根据技能id获取技能对象
		 * */
		public function getMove(id:String):BattleSkillMove
		{
			var move:BattleSkillMove = MOVE[id];
			if(move == null)
			{
				var x:XML = GameTools.searchXMLList(skillMoveXMLList , "id" , id);
				if(x)
				{	
					move = new BattleSkillMove();
					// 配置表属性
					move.id = x.@id;
					move.delay = x.@delay;
					move.duration = x.@duration;
					move.angle = x.@angle;//Number(x.@angle)*Math.PI/180;
					move.scale = x.@scale;
					move.mirror = x.@mirror;
					move.hit = x.@hit;
					
					// 缓动
					if(x.@ease == "1")
					{
						move.ease = Cubic.easeIn;
					}
					else if(x.@ease == "2")
					{
						move.ease = Cubic.easeOut;
					}
					else if(x.@ease == "3")
					{
						move.ease = Cubic.easeInOut;
					}
					else
					{
						move.ease = null;
					}
					
					// 位移
					var movestr:String = String(x.@move);
					if(movestr != "")
					{
						var p:Array = movestr.split(",");
						move.move = new Point(p[0] , p[1]);
					}
					
					// 曲线顶点
					var curvestr:String = String(x.@curve);
					if(curvestr != "")
					{
						p = curvestr.split(",");
						move.curve = new Point(p[0] , p[1]);
					}
					
					// 保存到字典中
					MOVE[id] = move;
				}
				else
				{
					Logger.warn(SkillMoveManager , "壳动画数据找不到... id = " + id);
				}
			}
			return move;
		}
	}
}