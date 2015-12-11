package com.gamehero.sxd2.drama
{
	import com.gamehero.sxd2.drama.base.BaseDrama;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.manager.TaskManager;
	import com.gamehero.sxd2.services.GameService;
	import com.gamehero.sxd2.world.HurdleMap.HurdleSceneView;
	import com.gamehero.sxd2.world.views.GameWorld;
	import com.gamehero.sxd2.world.views.RoleLayer;
	import com.gamehero.sxd2.world.views.SceneViewBase;
	
	import bowser.logging.Logger;

	
	/**
	 * 剧情脚本 
	 * @author wulongbin
	 * @modify Trey
	 */	
	public class Drama extends BaseDrama
	{
		private static var _isDrama:uint = 0;
		
		private var compressScreen:Boolean = true;	// 是否有幕布效果
		private var skip:Boolean = false;    // 是否可跳过
		
		
		
		/**
		 * 构造函数
		 * */
		public function Drama()
		{
			super();
		}
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			compressScreen = !(xml.@compressScreen == "0");
			skip = xml.@skip != undefined ? xml.@skip == "1" : false;
		}
		
		
		override public function startScript(globalData:Object = null, localData:Object = null, completeCallBack:Function = null):void
		{
			isDrama++;
			
			Logger.debug(Drama, "StartDrama:" + id);
			
			// 关闭所有窗口
			WindowManager.inst.closeAllWindow();
			
			// UI处理
			this.setUIView(false);
			// 隐藏其他玩家和npc
			this.setPlayerVisible(false);
			
			// 是否需要压屏表现
			if(compressScreen == true)
			{
				DramaBlackScreen.inst.play1(0 , over);
			}
			else
			{
				over();
			}
			
			function over():void
			{
				compressScreenOver(globalData , localData , completeCallBack);
			}
			
			// TO TEST：消息挂起，不再处理消息
			GameService.instance.pending = true;
		}
		
		
		
		
		/**
		 * 压屏结束
		 * */
		private function compressScreenOver(globalData:Object = null, localData:Object = null, completeCallBack:Function = null):void
		{
			super.startScript(globalData, localData, completeCallBack);
		}
		
		
		
		
		
		/**
		 * 解除压屏结束
		 * */
		private function uncompressScreenOver():void
		{
			// 显示主UI
			this.setUIView(true);
			// 显示其他玩家
			this.setPlayerVisible(true);
			
			// TO TEST：取消消息挂起，继续处理消息
			GameService.instance.pending = false;
			
			super.complete();
		}
		
		
		
		
		
		
		private static function get isDrama():uint
		{
			return _isDrama;
		}
		
		
		
		
		private static function set isDrama(value:uint):void
		{
			_isDrama = value;
		}
		
		
		
		
		override public function complete():void
		{
			Logger.debug(Drama, "EndDrama:" + id);
			
			isDrama--;
			
			// 是否需要解除压屏
			if(compressScreen == true)
			{
				DramaBlackScreen.inst.play2(0 , uncompressScreenOver);
			}
			else
			{
				uncompressScreenOver();
			}
		}
		
		
		
		
		
		/**
		 * 设置UI视图 
		 */
		public function setUIView(value:Boolean):void 
		{
			MainUI.inst.visible = value;
			
			// 场景是否可点击移动
			var view:SceneViewBase = SXD2Main.inst.currentView;
			view.gameWorld.canInteractive = value;
			
			// 若在剧情副本中,是否显示箭头
			if(view is HurdleSceneView)
			{
				HurdleSceneView(view).isShowArrow = value;
			}
			
			// 停止任务自动寻路
			TaskManager.inst.colseAutoTaskHandle();
		}
		
		
		
		
		
		/**
		 * 设置其他玩家隐藏显示
		 * */
		public function setPlayerVisible(value:Boolean):void
		{
			var view:SceneViewBase = SXD2Main.inst.currentView;
			var world:GameWorld = view.gameWorld;
			var layer:RoleLayer = world.roleLayer;
			layer.setPlayerVisible(value);
			layer.setNpcVisible(value);
			layer.setMonsterVisible(value);
		}
		
	}
}