package com.gamehero.sxd2.gui.arena
{
	import com.gamehero.sxd2.common.BitmapNumber;
	import com.gamehero.sxd2.core.Global;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.system.ApplicationDomain;
	
	import alternativa.gui.base.ActiveObject;
	
	
	/**
	 * 竞技场右上星级面板
	 * @author xuwenyi
	 * @create 2015-09-30
	 **/
	public class ArenaLevelPanel extends ActiveObject
	{	
		// 星星坐标
		private static const P1:Array = [new Point(17,22),new Point(49,10),new Point(80,22)];
		private static const P2:Array = [new Point(7,32),new Point(34,13),new Point(62,13),new Point(89,32)];
		private static const P3:Array = [new Point(2,35),new Point(25,20),new Point(48,5),new Point(71,20),new Point(94,35)];
		
		// 星星背景
		private var starBG1:Bitmap;
		private var starBG2:Bitmap;
		private var starBG3:Bitmap;
		
		// 星星面板
		private var starPanel:Sprite;
		private var starBMD:BitmapData;
		
		// 排名
		private var rank:BitmapNumber;
		
		// 奖牌
		private var madel1:Bitmap;
		private var madel2:Bitmap;
		private var madel3:Bitmap;
		private var madel4:Bitmap;
		private var madel5:Bitmap;
		
		// 等级
		private var level:BitmapNumber;
		
		
		
		/**
		 * 构造函数
		 * */
		public function ArenaLevelPanel(domain:ApplicationDomain)
		{
			var global:Global = Global.instance;
			
			// 背景
			var bg:Bitmap = new Bitmap(global.getBD(domain , "ARENA_LEVEL_BG"));
			this.addChild(bg);
			
			// 星星背景
			starBG1 = new Bitmap(global.getBD(domain , "STAR_BG_1"));
			starBG1.x = 38;
			starBG1.y = 7;
			starBG1.visible = false;
			this.addChild(starBG1);
			
			starBG2 = new Bitmap(global.getBD(domain , "STAR_BG_2"));
			starBG2.x = 38;
			starBG2.y = 7;
			starBG2.visible = false;
			this.addChild(starBG2);
			
			starBG3 = new Bitmap(global.getBD(domain , "STAR_BG_3"));
			starBG3.x = 38;
			starBG3.y = 7;
			starBG3.visible = false;
			this.addChild(starBG3);
			
			// 星星面板
			starPanel = new Sprite();
			starPanel.x = 38;
			starPanel.y = 7;
			this.addChild(starPanel);
			
			// 排名
			rank = new BitmapNumber();
			rank.x = 88;
			rank.y = 14;
			this.addChild(rank);
			
			starBMD = global.getBD(domain , "STAR");
			
			// 奖牌
			madel1 = new Bitmap(global.getBD(domain , "MADEL_1"));
			madel1.x = 55;
			madel1.y = 69;
			madel1.visible = false;
			this.addChild(madel1);
			
			madel2 = new Bitmap(global.getBD(domain , "MADEL_2"));
			madel2.x = 55;
			madel2.y = 69;
			madel2.visible = false;
			this.addChild(madel2);
			
			madel3 = new Bitmap(global.getBD(domain , "MADEL_3"));
			madel3.x = 55;
			madel3.y = 69;
			madel3.visible = false;
			this.addChild(madel3);
			
			madel4 = new Bitmap(global.getBD(domain , "MADEL_4"));
			madel4.x = 55;
			madel4.y = 69;
			madel4.visible = false;
			this.addChild(madel4);
			
			madel5 = new Bitmap(global.getBD(domain , "MADEL_5"));
			madel5.x = 55;
			madel5.y = 69;
			madel5.visible = false;
			this.addChild(madel5);
			
			// 等级
			level = new BitmapNumber();
			level.x = 91;
			level.y = 143;
			this.addChild(level);
		}
		
		
		
		
		
		public function update(star:int , lv:int , rankNum:int):void
		{
			level.update(BitmapNumber.BATTLE_B_YELLOW , lv+"");
			rank.clear();
			
			var levelName:String;
			//传说
			if(lv <= 0)
			{
				madel1.visible = false;
				madel2.visible = false;
				madel3.visible = false;
				madel4.visible = false;
				madel5.visible = true;
				
				starBG1.visible = false;
				starBG2.visible = false;
				starBG3.visible = false;
				
				level.clear();
				rank.update(BitmapNumber.BATTLE_B_YELLOW , rankNum+"");
				
				levelName = "传说";
			}
			//1-3钻石
			else if(lv <= 3)
			{
				madel1.visible = false;
				madel2.visible = false;
				madel3.visible = false;
				madel4.visible = true;
				madel5.visible = false;
				
				starBG1.visible = false;
				starBG2.visible = false;
				starBG3.visible = true;
				
				levelName = "钻石";
			}
			//4-7黄金
			else if(lv <= 7)
			{
				madel1.visible = false;
				madel2.visible = false;
				madel3.visible = true;
				madel4.visible = false;
				madel5.visible = false;
				
				starBG1.visible = false;
				starBG2.visible = false;
				starBG3.visible = true;
				
				levelName = "黄金";
			}
			//8-12白银
			else if(lv <= 12)
			{	
				madel1.visible = false;
				madel2.visible = true;
				madel3.visible = false;
				madel4.visible = false;
				madel5.visible = false;
				
				starBG1.visible = false;
				starBG2.visible = true;
				starBG3.visible = false;
				
				levelName = "白银";
			}
			//13-15青铜
			else if(lv <= 15)
			{
				madel1.visible = true;
				madel2.visible = false;
				madel3.visible = false;
				madel4.visible = false;
				madel5.visible = false;
				
				starBG1.visible = true;
				starBG2.visible = false;
				starBG3.visible = false;
				
				levelName = "青铜";
			}
			
			this.updateStar(star , lv);
			
			// tips
			this.hint = "当前竞技等级：" + levelName;
		}
		
		
		
		
		
		/**
		 * 更新星星
		 * */
		private function updateStar(star:int , lv:int):void
		{
			Global.instance.removeChildren(starPanel);
			
			var points:Array;
			// 1-7 五颗星
			if(lv <= 7)
			{
				points = P3;
			}
			// 8-12 四颗星
			else if(lv <= 12)
			{
				points = P2;
			}
			// 12-15 三颗星
			else if(lv <= 15)
			{
				points = P1;
			}
			
			for(var i:int=0;i<star;i++)
			{
				var s:Bitmap = new Bitmap(starBMD);
				s.x = points[i].x;
				s.y = points[i].y;
				starPanel.addChild(s);
			}
		}
	}
}