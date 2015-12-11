package com.gamehero.sxd2.world.sceneMap
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.pro.PRO_Map;
	import com.gamehero.sxd2.world.model.MapModel;
	import com.gamehero.sxd2.world.views.GameWorld;
	
	import flash.display.Sprite;

	/**
	 * 
	 * 大地图场景世界
	 * @author weiyanyu
	 * 创建时间：2015-7-8 下午2:26:25
	 * 
	 */
	public class SceneGameWorld extends GameWorld
	{
		public function SceneGameWorld(canvas:Sprite, width:Number, height:Number, transparent:Boolean=true, renderTime:int=33)
		{
			super(canvas, width, height, transparent, renderTime);
		}
		
		//移动世界
		override public function moveWolrd():void
		{
			super.moveWolrd();
			if(_roleLayer != null)
			{
				_roleLayer.initLoc(-_camera.x,-_camera.y);
			}
		}
		
		//初始化角色图层
		override public function initRoleLayer():void
		{
			_roleLayer = new SceneRoleLayer;
			_roleLayer.navTri = _model.sceneVo.tri;

			if(!isMask && !GameData.inst.isLoadScene)
			{	
				_roleLayer.addChild(maskRenderItem);
			}
			
			this.addChildAt(_roleLayer,_roleLayerVo.index);
			
			_roleLayer.initMap(_roleLayerVo);
			
			var mapInfo:PRO_Map = GameData.inst.mapInfo
			_roleLayer.setRoleLoc(mapInfo.x,mapInfo.y);	
			
			resize(width,height);
			canInteractive = true;
			MapModel.inst.isLoaded = true;
			(canvas as SceneView).initPlayers();
			
		}
		
		
	}
}