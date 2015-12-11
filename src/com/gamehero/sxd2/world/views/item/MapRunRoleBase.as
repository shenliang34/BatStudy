package com.gamehero.sxd2.world.views.item
{
	import com.gamehero.sxd2.world.event.MapEvent;
	import com.gamehero.sxd2.world.model.MapConfig;
	import com.gamehero.sxd2.world.model.RoleActionDict;
	
	import flash.utils.getTimer;
	
	import bowser.iso.pathfinding.navmesh.geom.Vector2f;
	
	/**
	 * 角色类,玩家，主角
	 * 移动，寻路
	 * @author weiyanyu
	 * @create 
	 **/
	public class MapRunRoleBase extends MapRoleBase
	{
		private var _path:Vector.<Vector2f>;//路径
		/**
		 * 是否在移动 
		 */		
		private var _isMoving:Boolean;
		
		/**
		 * 已经过去的毫秒数
		 * 
		 */
		private var _pastMS:int = 0;	// 
		
		// ms/px 速度
		public var speed:Number = MapConfig.RUN_SPEED_MILLISENDS;
		
		public function get isMoving():Boolean
		{
			return _isMoving;
		}
		public function set isMoving(isMove:Boolean):void
		{
			if(isMove)
			{
				setStatus(RoleActionDict.MOVESTATUS);
				_isMoving = true;
			}
			else
			{
				setStatus(RoleActionDict.STAND);
				_isMoving = false;
			}
		}
		
		/**
		 * 构造函数
		 * */
		public function MapRunRoleBase()
		{
			super();
		}
		
		public function set path(p:Vector.<Vector2f>):void
		{
			_path = p;
		}
		
		public function get path():Vector.<Vector2f>
		{
			return _path;
		}
		/**
		 * 每帧处理 
		 * @param e
		 * 
		 */		
		override public function enterFrame():void
		{
			if(_path == null) return;
			if(_path.length > 0) 
			{
				this.move(_path[0].x,_path[0].y);
			}
			else
			{
				this.stop();
			}
	
		}
		/**
		 * 向着着目标前进 
		 * @param tx
		 * @param ty
		 * 
		 */		
		private function move(tx:int,ty:int):void
		{
			var dx:Number = tx - x;
			var dy:Number = ty - y;
			var angle:Number = Math.atan2(dy,dx);
			setFace(angle);

			var distance:int = dx * dx + dy * dy;
			
			var _leftTime:int = Math.sqrt(distance) * speed;	// 需要多少时间走完
			
			var _addonX:Number;
			var _addonY:Number;
			if (_leftTime > 0){
				
				_addonX = (dx / _leftTime);
				_addonY = (dy / _leftTime);
				
			}
			
			_pastMS = _pastMS == 0 ? 15 : (getTimer() - _pastMS);
			
			_addonX = int(_addonX * _pastMS);
			_addonY = int(_addonY * _pastMS);
			
			var d2:int = _addonX * _addonX + _addonY * _addonY;//每帧的总距离
			
			if(distance <= d2)
			{
				this.x = tx;
				this.y = ty;
				_path.splice(0, 1);
				
				// 没有路径了 停止角色移动
				if(_path.length == 0) 
				{
					this.stop();
				}
				else
				{
					_pastMS = getTimer();
				}
			}
			else
			{
				isMoving = true;
				x += _addonX;
				y += _addonY;
				
				_pastMS = getTimer();
			}
		}
		
		
		/**
		 * 立即停止移动
		 * */
		public function stop():void
		{
			_path = null;
			isMoving = false;
			_pastMS = 0;
			
			this.dispatchEvent(new MapEvent(MapEvent.ROLE_STOP , this));
		}
		
		
		override public function gc(isCleanAll:Boolean=false):void
		{
			_path = null;
			super.gc(true);
		}
	}
}