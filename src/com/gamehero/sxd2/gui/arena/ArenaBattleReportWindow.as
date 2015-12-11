package com.gamehero.sxd2.gui.arena
{
	import com.gamehero.sxd2.gui.core.GeneralWindow;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	
	import flash.display.Bitmap;
	
	import org.bytearray.display.ScaleBitmap;
	
	
	/**
	 * 竞技场战报窗口
	 * @author xuwenyi
	 * @create 2015-10-09
	 **/
	public class ArenaBattleReportWindow extends GeneralWindow
	{
		private var reportLogs:Array = [];
		
		
		/**
		 * 构造函数
		 * */
		public function ArenaBattleReportWindow(position:int, resourceURL:String = "ArenaBattleReportWindow.swf")
		{
			super(position, resourceURL, 321, 346);
		}
		
		
		
		
		override protected function initWindow():void
		{
			super.initWindow();
			
			// 九宫格框
			var innerBg:ScaleBitmap;
			innerBg = new ScaleBitmap(CommonSkin.windowInner2Bg);
			innerBg.scale9Grid = CommonSkin.windowInner2BgScale9Grid;
			innerBg.setSize(305, 292);
			innerBg.x = 8;
			innerBg.y = 39;
			this.addChild(innerBg);
			
			// 背景
			var bg:Bitmap = new Bitmap(this.getSwfBD("BG"));
			bg.x = 7;
			bg.y = 45;
			this.addChild(bg);
			
			// 战报记录
			for(var i:int=0;i<5;i++)
			{
				var log:ArenaBattleReportLog = new ArenaBattleReportLog();
				log.x = 7;
				log.y = 45 + i*57;
				log.visible = false;
				this.addChild(log);
				
				reportLogs.push(log);
			}
		}
		
		
		
		
		override public function onShow():void
		{
			super.onShow();
			
			var logs:Array = ArenaModel.inst.data.logs;
			for(var i:int=0;i<logs.length;i++)
			{
				reportLogs[i].update(logs[i]);
				reportLogs[i].visible = true;
			}
		}
		
		
		
		
		override public function close():void
		{
			this.clear();
			
			super.close();
		}
		
		
		
		
		public function clear():void
		{
			for(var i:int=0;i<reportLogs.length;i++)
			{
				reportLogs[i].visible = false;
				reportLogs[i].clear();
			}
		}
	}
}