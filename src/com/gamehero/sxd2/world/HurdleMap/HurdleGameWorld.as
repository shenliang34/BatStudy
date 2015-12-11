package com.gamehero.sxd2.world.HurdleMap
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.world.HurdleMap.components.MapFogLayer;
	import com.gamehero.sxd2.world.event.MapEvent;
	import com.gamehero.sxd2.world.model.MapTypeDict;
	import com.gamehero.sxd2.world.views.GameWorld;
	
	import flash.display.Sprite;

	
	/**
	 * 关卡地图
	 * @author weiyanyu
	 * 创建时间：2015-7-7 下午1:43:41
	 * 
	 */
	public class HurdleGameWorld extends GameWorld
	{
		/**
		 * 迷雾层 
		 */		
		private var _mapFogLayer:MapFogLayer;
		
		
		public function HurdleGameWorld(canvas:Sprite, width:Number, height:Number, transparent:Boolean=true, renderTime:int=33)
		{
			super(canvas, width, height, transparent, renderTime);
		}
		
		override public function moveWolrd():void
		{
			super.moveWolrd();
			if(_roleLayer)
			{
				_roleLayer.initLoc(-_camera.x,-_camera.y);
				if(_mapFogLayer)
				{
					_mapFogLayer.x = -camera.x;
					_mapFogLayer.y = -camera.y;
					_mapFogLayer.focus(_roleLayer.role.x,_roleLayer.role.y);
				}
			}

		}
		
		override public function initRoleLayer():void
		{
			_roleLayer = new HurdleRoleLayer();
			_roleLayer.navTri = _model.sceneVo.tri;
			
			if(!isMask && !GameData.inst.isLoadHurdle)
			{
				_roleLayer.addChild(maskRenderItem);	
				GameData.inst.isLoadHurdle = true;
			}
			
			this.addChildAt(_roleLayer,_roleLayerVo.index);
			(_roleLayer as HurdleRoleLayer).init();
			_roleLayer.initMap(_roleLayerVo);
			var gd:GameData = GameData.inst;
			
			_roleLayer.setRoleLoc(_model.sceneVo.birthX,_model.sceneVo.birthY);
			if(_model.mapVo.type == MapTypeDict.FOG_LEVEL_MAP) //类型3 为迷雾关卡
			{
				_mapFogLayer = new MapFogLayer(_model.sceneVo.width,_model.sceneVo.height);
				addChild(_mapFogLayer);
				_mapFogLayer.focus(_roleLayer.role.x,_roleLayer.role.y);
			}
			
			
			resize(width,height);
			canInteractive = true;
		}
		
		private function mapResLoadCompleteHandle(e:MapEvent):void
		{
			if(_roleLayer == null)
			{
				isMask = true;
				return;
			}
			_roleLayer.removeChild(maskRenderItem);	
		}
		
		public function nextWave():void
		{
			(_roleLayer as HurdleRoleLayer).nextWave();
		}
		
		override public function gc(isCleanAll:Boolean=false):void
		{
			if(_mapFogLayer) _mapFogLayer.gc();
			_mapFogLayer = null;
			super.gc(isCleanAll);
		}
	}
}