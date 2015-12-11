package com.gamehero.sxd2.world.views
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.gui.progress.MapLoadingUI;
	import com.gamehero.sxd2.world.display.SwfRenderItem;
	import com.gamehero.sxd2.world.event.MapEvent;
	import com.gamehero.sxd2.world.event.RoleEvent;
	import com.gamehero.sxd2.world.event.SwfRenderEvent;
	import com.gamehero.sxd2.world.model.MapConfig;
	import com.gamehero.sxd2.world.model.MapModel;
	import com.gamehero.sxd2.world.model.vo.MapLayerVo;
	import com.gamehero.sxd2.world.model.vo.SceneVo;
	import com.gamehero.sxd2.world.views.item.InterActiveItem;
	import com.gamehero.sxd2.world.views.item.MainRole;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.render.display.RenderStage;
	
	import br.com.stimuli.loading.loadingtypes.XMLItem;
	
	/**
	 * 	场景 抽象类
	 *  加载资源，移动场景，舞台鼠标事件，调整摄像机
	 * @author weiyanyu
	 * 创建时间：2015-5-28 上午11:04:43
	 */
	public class GameWorld extends RenderStage
	{
		private var _loader:BulkLoaderSingleton;
		/**
		 * 图层 数组
		 */		
		protected var _layerArr:Vector.<RoleLayer>;
		/**
		 * 角色层，包括各种npc，怪物，交互的挂件 
		 */		
		protected var _roleLayer:RoleLayer;
		/**
		 * 角色层的初始数据 
		 */		
		protected var _roleLayerVo:MapLayerVo;
		/**
		 * 人物图层的摄像机 <br>
		 * 
		 * 场景的大小就是人物层所在图层的大小，<br>
		 * _camera的大小是固定的最大屏幕尺寸,这样可以保证不管屏幕怎么变化，都可以有一个不变的视角<前后图层关系>；<br>
		 * _camera的坐标是相对于人物层的
		 * 
		 */		
		protected var _camera:Camera;
		/**
		 * 摄像机的摄像机，用来截取图层摄像机的画面</br>
		 * 
		 * 与_camera的区别：</br>
		 * 为了防止放大与缩小屏幕的时候会出现图层的相对移动，需要保证有个 “假”摄像机的大小是固定的，这个就是_camera的作用；</br>
		 * 而 _stageCamera则是保证在放大缩小屏幕的时候，摄像机在 _camera这个 “假”窗口下自由移动； <br>
		 * 坐标是相对于_camera的坐标
		 * 
		 */		
		private var _stageCamera:Camera;
		/**
		 * 当前舞台是否可以交互 
		 */		
		private var _canInteractive:Boolean;
		/**
		 * 是否移动 摄像机
		 */		
		public var isMoveCamera:Boolean = true;
		/**
		 * 是否显示，
		 * 如果显示则需要渲染，不显示则停掉 
		 */		
		public var isShow:Boolean = true;
		/**
		 * 马赛克资源
		 */
		public var maskRenderItem:SwfRenderItem;
		/**
		 * 马赛克标记
		 */
		public var isMask:Boolean = false;
		/**
		 *马赛克放大倍数 
		 */		
		private var MaskMultiple:int = 20;
		// 摄像机对准的目标
		public var cameraFocusTarget:InterActiveItem;
		
		protected var _model:MapModel;
		
		public function GameWorld(canvas:Sprite, width:Number, height:Number, transparent:Boolean=true,renderTime:int = 33)
		{
			super(canvas, width, height, transparent, renderTime);
			_model = MapModel.inst;
			
			addEventListener(MapEvent.MAP_RESLOAD_COMPLETE,mapResLoadCompleteHandle);
		}
		
		/**
		 * gameworld
		 * @param event
		 * 
		 */		
		override protected function onRenderFrame(event:Event = null):void
		{
			super.onRenderFrame(event);
			onCanvasMouseMove(null);//要时刻处理鼠标问题，因为即便是鼠标不动，鼠标下面的元件也可以自己动；
			if(_roleLayer != null)
			{
				_roleLayer.onRenderFrame();//这里会不断设置主角的位置，刷新场景其他人的位置。
				if(this._roleLayer.role.isMoving == true)
				{
					if(isMoveCamera)
					{
						this.adjustCamera(cameraFocusTarget);
						this.moveWolrd();
					}
				}
			}
		}
		
		/**
		 * 调整摄像机 焦点
		 * @param target 目标对象
		 */		
		public function adjustCamera(target:InterActiveItem = null):void
		{
			if(_camera != null)
			{
				// 若target为null,则默认对准主角
				if(target == null)
				{
					_camera.setFocus(_roleLayer.role.x,_roleLayer.role.y);
				}
				else
				{
					_camera.setFocus(target.x,target.y);
				}
				_stageCamera.setFocus(camera.getFocusX() , camera.getFocusY());
			}
		}
		
		
		
		/**
		 * 移动世界
		 */		
		public function moveWolrd():void
		{
			if(_stageCamera != null)
			{	
				for each(var layer:RoleLayer in _layerArr)
				{
					layer.initLoc(-_camera.x,-_camera.y);//设置非人物层与人物层的相对位置
				}
				this.x = -_stageCamera.x;
				this.y = -_stageCamera.y;//移动画布，显示对应窗口大小的画面
			}
		}
		
		/**
		 * 重置渲染区域的大小 <br>
		 * 
		 * 缩放窗口的时候，人物的位置在图层上面是没有变化的，因此_camera的坐标不会改变；
		 * 只要_camera坐标不动，那么图层的相对位置 就会保持不动
		 * @param newWidth
		 * @param newHeight
		 * 
		 */		
		override public function resize(newWidth:Number, newHeight:Number):void 
		{
			super.resize(newWidth,newHeight);//size是绘制
			
			if(_stageCamera != null)
			{
				_stageCamera.setWinSize(newWidth,newHeight);
			}
			if(isShow)
			{
				if(isMoveCamera)
				{
					this.adjustCamera(cameraFocusTarget);
					this.moveWolrd();
				}
			}
			else
			{
				stopRender();
			}

		}
		
		/**
		 * 资源加载完成 清理马赛克  
		 * @param e
		 * 
		 */		
		protected function mapResLoadCompleteHandle(e:MapEvent):void
		{
			if(_roleLayer == null)
			{
				isMask = true;
				return;
			}
			_roleLayer.removeChild(maskRenderItem);
		}
		
		
		/**
		 * 加载地图 
		 * @param id
		 * 
		 */		
		public function loadWorld(mapid:int):void
		{
			MapLoadingUI.inst.show();
			stopRender();
			_loader = BulkLoaderSingleton.instance;
			_model.sceneVo = new SceneVo();
			_model.sceneVo.sceneId = mapid;
			
			var url:String = GameConfig.MAPS_URL + mapid + ".xml";
			_loader.addWithListener(url , {id:url} , onConfigLoaded , onConfigProgress);
			_loader.start();
		}
		
		
		
		/**
		 * 加载进度
		 * */
		private function onConfigProgress(e:ProgressEvent):void
		{
			var progress:Number = e.bytesLoaded / e.bytesTotal;
			MapLoadingUI.inst.updateProgress(Math.floor(progress*100));
		}
		
		
		/**
		 * 初始化数据加载完成 
		 * @param event
		 * 
		 */		
		private var xmlItem:XMLItem;
		private var maskUrl:String;
		protected function onConfigLoaded(event:Event):void
		{
			xmlItem = event.target as XMLItem;
			var xml:XML = new XML(xmlItem.content);
			var list:Array = GameData.inst.loadCompleteMapId;
			var mapId:int = xml.@sceneId;
			
			if(list.indexOf(mapId) == -1)
			{
				GameData.inst.isLoadScene = false;
				maskUrl = GameConfig.MAPS_URL + xml.@sceneId + "/" + xml.@sceneId + "_mask.swf";
				maskRenderItem = new SwfRenderItem(maskUrl,true);
				maskRenderItem.isBackground = true;
				maskRenderItem.x = xml.@maskX;
				maskRenderItem.y = xml.@maskY;
				maskRenderItem.addEventListener(SwfRenderEvent.LOADED,maskRenderItemLoaderHandle);
				list.push(mapId);
			}
			else
			{
				
				GameData.inst.isLoadScene = true;
				isMask = true;
				initMap();
			}
			
		}
		
		/**
		 * 马赛克资源加载完成
		 */	
		private function maskRenderItemLoaderHandle(e:Event):void
		{
			e.target.removeEventListener(SwfRenderEvent.LOADED, maskRenderItemLoaderHandle);
			maskRenderItem.renderSource = getCircleBmd(maskRenderItem.renderSource);
			initMap();
		}
		
		/**
		 * 根据配置表初始化地图数据
		 */
		private function initMap():void
		{
			// 隐藏loading
			MapLoadingUI.inst.hide();
			
			_layerArr = new Vector.<RoleLayer>;
			
			xmlItem.removeEventListener(Event.COMPLETE, onConfigLoaded);
			var xml:XML = new XML(xmlItem.content);
			_model.sceneVo.fromXML(xml);
			var sceneVo:SceneVo = _model.sceneVo;
			
			if(_loader != null)
				_loader.remove(sceneVo.sceneId + "");
			
			var layer:RoleLayer;
			
			//创建并初始化所有图层
			for(var i:int = 0; i < sceneVo.layerVec.length; i++)
			{
				if(sceneVo.layerVec[i].isMain)
				{
					_roleLayerVo = sceneVo.layerVec[i];
					continue;
				}
				else
				{
					layer = new RoleLayer();
				}
				_layerArr.push(layer);
				this.addChild(layer);
				layer.initMap(sceneVo.layerVec[i]);
			}
			
			//摄像机设置属性
			if(_camera == null)
				_camera = new Camera();
			if(_stageCamera == null)
				_stageCamera = new Camera();
			
			_camera.setSceneSize(sceneVo.width,sceneVo.height);
			_camera.setWinSize(MapConfig.STAGE_MAX_WIDTH,MapConfig.STAGE_MAX_HEIGHT);		
		
			_stageCamera.setSceneSize(MapConfig.STAGE_MAX_WIDTH,MapConfig.STAGE_MAX_HEIGHT);
			
			//添加角色
			initRoleLayer();
			
			ROLE.addEventListener(RoleEvent.MOVE_EVENT,onPatchRoleLoc);

			// 告诉外部地图已加载完成
			dispatchEvent(new MapEvent(MapEvent.MAP_INIT));
			
		}
		
		/**
		 * 初始化角色图层 
		 * 
		 */		
		public function initRoleLayer():void
		{
		}
		/**
		 * 设置场景是否可以交互 
		 * @param value
		 * 
		 */		
		public function set canInteractive(value:Boolean):void
		{
			_canInteractive = value;
			if(_canInteractive)
			{
				_canvas.addEventListener(MouseEvent.MOUSE_DOWN, onGameWorldMouseDown);		// Mouse Move: 选中效果
				_canvas.addEventListener(MouseEvent.MOUSE_UP, onGameWorldMouseUp);
			}
			else
			{
				_roleLayer.stopClickTimer();
				_canvas.removeEventListener(MouseEvent.MOUSE_DOWN, onGameWorldMouseDown);		// Mouse Move: 选中效果
				_canvas.removeEventListener(MouseEvent.MOUSE_UP, onGameWorldMouseUp);
				
			}
		}
		
		override public function stopRender():void
		{
			super.stopRender();
			if(_roleLayer)
			{
				ROLE.stop();
			}
		}

		/**
		 * 鼠标抬起 
		 * @param event
		 * 
		 */		
		protected function onGameWorldMouseUp(event:MouseEvent):void
		{
			if(_roleLayer)
			{
				_roleLayer.onGameWorldMouseUp(event);
			}
		}
		
		protected function onCanvasMouseMove(event:MouseEvent):void
		{
			if(_roleLayer)
			{
				_roleLayer.onMouseMove(event);
			}

		}
		protected function onGameWorldMouseDown(event:MouseEvent):void
		{
			if(_roleLayer)
			{
				_roleLayer.onStageClicked(event);
			}
		}
		
		public function get canvas():Sprite
		{
			return _canvas;
		}
		
		public function get camera():Camera
		{
			return _camera;
		}
		
		public function get stageCamera():Camera
		{
			return _stageCamera;
		}
		
		/**
		 * 设置摄像机焦点,同时移动场景
		 * */
		public function setCameraFocus(focusX:int , focusY:int):void
		{
			_camera.setFocus(focusX , focusY);
			_stageCamera.setFocus(camera.getFocusX() , camera.getFocusY());
			this.moveWolrd();
		}
		
		/**
		 * 获得主角， 
		 * @return 
		 * （为了方便一些动画调位置）
		 */		
		public function get ROLE():MainRole
		{
			return _roleLayer.role;
		}
		/**
		 * @return 人物相对屏幕的猪脚 
		 */		
		public function get rolePoint():Point
		{
			return new Point(_stageCamera.getFocusX(),_stageCamera.getFocusY());
		}
		
		override public function gc(isCleanAll:Boolean=false):void
		{
			this.stopRender();
			this.renderer.gc();
			
			if(_loader) _loader.pauseAndRemoveAllPaused();
			
			_roleLayer = null;
			
			for each(var layer:RoleLayer in _layerArr)
			{
				layer.gc(true);
			}
			_layerArr = null;
			_loader = null;
			_camera = null;
			_stageCamera = null;
			isMoveCamera = true;
			cameraFocusTarget = null;
			_model.sceneVo = null;
			if(_canInteractive)
			{
				_canvas.removeEventListener(MouseEvent.MOUSE_DOWN, onGameWorldMouseDown);		// Mouse Move: 选中效果
//				_canvas.removeEventListener(MouseEvent.MOUSE_MOVE, onCanvasMouseMove);		// Mouse Move: 选中效果
				_canvas.removeEventListener(MouseEvent.MOUSE_UP, onGameWorldMouseUp);
			}
			
			removeEventListener(MapEvent.MAP_RESLOAD_COMPLETE,mapResLoadCompleteHandle);
			super.gc(isCleanAll);
			
		}
		
		/**
		 * 根据原始位图，获得对应比例的位图 
		 * @param bd
		 * @param w
		 * @param h
		 * @return 
		 */		
		public function getCircleBmd(bd:BitmapData):BitmapData
		{
			var thumb:BitmapData = new BitmapData(bd.width * MaskMultiple,bd.height * MaskMultiple,true,0x00000000);
			var mat:Matrix = new Matrix();
			mat.scale(MaskMultiple,MaskMultiple);
			thumb.draw(bd,mat,null,null,null,false);
			return thumb;
		}
		
		public function get roleLayer():RoleLayer
		{
			return _roleLayer;
		}
		
		protected function onPatchRoleLoc(event:RoleEvent):void
		{
			dispatchEvent(new RoleEvent(RoleEvent.MOVE_EVENT));
		}
		
		
		
		/**
		 * 获取地图坐标相对屏幕的坐标
		 * */
		public function getStagePoint(xx:int , yy:int):Point
		{
			return new Point(xx - camera.x - stageCamera.x , yy - camera.y - stageCamera.y);
		}
		
	}
}