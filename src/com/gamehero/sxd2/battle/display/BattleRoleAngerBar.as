package com.gamehero.sxd2.battle.display
{
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.BattleSkin;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import bowser.render.display.RenderItem;
	import bowser.render.display.SpriteItem;
	
	/**
	 * 场景中角色怒气条
	 * @author xuwenyi
	 * @create 2015-07-31
	 **/
	public class BattleRoleAngerBar extends SpriteItem
	{
		// 怒气背景
		private var bg:RenderItem;
		// 怒气颜色(黄)
		private var bar1BD:BitmapData;
		private var bar1:RenderItem;
		// 怒气颜色(橙色)
		private var bar2BD:BitmapData;
		private var bar2:RenderItem;
		// 隔断数量
		private var gaps:int;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleRoleAngerBar(gaps:int = 2)
		{
			super();
			
			this.gaps = gaps;
			
			// 添加怒气背景
			bg = new RenderItem();
			bg.renderSource = BattleSkin.ROLE_ANGER_BG;
			this.addChild(bg);
			
			// 添加黄色怒气
			bar1 = new RenderItem();
			bar1BD = BattleSkin.ROLE_ANGER_1;
			bar1.renderSource = bar1BD;
			bar1.x = 2;
			bar1.y = 1;
			this.addChild(bar1);
			
			// 添加橙色怒气
			bar2 = new RenderItem();
			bar2BD = BattleSkin.ROLE_ANGER_2;
			bar2.renderSource = bar2BD;
			bar2.x = 2;
			bar2.y = 1;
			bar2.visible = false;
			this.addChild(bar2);
			
			// 隔断
			var gapW:int = 60/gaps;// 每个隔断的宽度
			for(var i:int=1;i<gaps;i++)
			{
				var gap:RenderItem = new RenderItem();
				gap.renderSource = BattleSkin.ROLE_ANGER_GAP;
				gap.x = gapW * i;
				gap.y = 1;
				this.addChild(gap);
			}
		}
		
		
		
		
		
		
		/**
		 * 更新怒气状态
		 * */
		public function update(anger:Number , maxAnger:Number):void
		{
			var rate:Number;
			var widthTotal:int = bar1BD.width;
			var widthTarget:int;
			var bd:BitmapData;
			
			// 先判断当前怒气是第几档
			if(anger / gaps > 1)// 第二档
			{
				bar1.renderSource = bar1BD;
				
				anger -= gaps;
				rate = Math.min(anger / gaps , 1);
				widthTarget = Math.floor(widthTotal*rate);// 最终长度
				if(widthTarget > 0)
				{
					bd = new BitmapData(widthTarget , bar2BD.height , true , 0);
					bd.copyPixels(bar2BD , new Rectangle(widthTotal - widthTarget , 0 , widthTarget , bar2BD.height) , new Point());
					bar2.renderSource = bd;
					
					bar2.visible = true;
				}
				else
				{
					bar2.visible = false;
				}
			}
			else// 第一档
			{
				rate = anger / gaps;
				widthTarget = Math.floor(widthTotal*rate);// 最终长度
				if(widthTarget > 0)
				{
					bd = new BitmapData(widthTarget , bar1BD.height , true , 0);
					bd.copyPixels(bar1BD , new Rectangle(widthTotal - widthTarget , 0 , widthTarget , bar1BD.height) , new Point());
					bar1.renderSource = bd;
					
					bar1.visible = true;
				}
				else
				{
					bar1.visible = false;
				}
				
				bar2.visible = false;
			}
		}
		
		
		
		
		
		/**
		 * 清空
		 * */
		public function clear():void
		{
			bar1BD = null;
			bar2BD = null;
			
			this.gc();
		}
		
	}
}