package com.gamehero.sxd2.world.globolMap
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MapSkin;
	import com.gamehero.sxd2.manager.TaskManager;
	import com.gamehero.sxd2.world.event.MapEvent;
	import com.gamehero.sxd2.world.model.MapConfig;
	import com.gamehero.sxd2.world.views.SceneViewBase;
	
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class GlobalSceneView extends SceneViewBase
	{
		
		public var leaveMapBtn:Button;//testBtn

		public function GlobalSceneView()
		{
			super();
		}
		
		override protected function init():void
		{
			_gameWorld = new GlobalGameWorld(this,stage.stageWidth,stage.stageHeight,false,17);
			
			_gameWorld.addEventListener(MapEvent.MAP_CLICK_PLAYER,mapClickPlayerHandle);
			
			super.init();
			
			addTestBtn(); //testBtn
			this.resize(null);
		}
		
		private function mapClickPlayerHandle(e:MapEvent):void
		{
			TaskManager.inst.moveObj.isMove = false;
		}
		
		private function addTestBtn():void
		{
			leaveMapBtn = new Button(MapSkin.LEAVEMAPBTNUP,null,MapSkin.LEAVEMAPBTNOVER);
			leaveMapBtn.addEventListener(MouseEvent.CLICK,actionBtnClickHandle);
			this.addChild(leaveMapBtn);
		}
		
		private function actionBtnClickHandle(e:Event):void
		{
			var id:int = GameData.inst.mapInfo.id;
			dispatchEvent(new MapEvent(MapEvent.RETURN_SCENE_MAP,{id:id}));
			
			var world:GlobalGameWorld = this._gameWorld as GlobalGameWorld;
			world.isMove = true;
		}
		
		override public function gc():void
		{
			// TODO Auto Generated method stub
			super.gc();
			leaveMapBtn.removeEventListener(MouseEvent.CLICK,actionBtnClickHandle);
			this.removeChild(leaveMapBtn);
		}
		
		
		override protected function resize(e:Event):void
		{
			var widthOffset:int; //宽的偏移量			
			if(App.stage.stageWidth > MapConfig.STAGE_MAX_WIDTH) widthOffset = App.stage.stageWidth - MapConfig.STAGE_MAX_WIDTH;//最大尺寸
			if(leaveMapBtn)
			{
				leaveMapBtn.x = App.stage.stageWidth - leaveMapBtn.width - widthOffset - 40;
				leaveMapBtn.y = 60;
			}
			super.resize(null);
		}
	}
}