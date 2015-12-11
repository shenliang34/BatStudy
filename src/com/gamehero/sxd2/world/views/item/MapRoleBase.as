package com.gamehero.sxd2.world.views.item
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.event.RenderItemEvent;
	import com.gamehero.sxd2.manager.RoleSkinManager;
	import com.gamehero.sxd2.world.display.GossipComponent;
	import com.gamehero.sxd2.world.display.SceneFigureItem;
	import com.gamehero.sxd2.world.event.MapEvent;
	import com.gamehero.sxd2.world.model.MapConfig;
	import com.gamehero.sxd2.world.model.RoleActionDict;
	import com.gamehero.sxd2.world.model.vo.RoleSkinVo;
	
	import flash.events.Event;
	import flash.filters.BitmapFilter;
	import flash.geom.Rectangle;
	
	import alternativa.gui.enum.Align;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.render.display.RenderItem;
	import bowser.render.display.TextItem;

	/**
	 * 角色基本类
	 * 有状态，有朝向
	 * @author weiyanyu
	 * 创建时间：2015-6-15 下午5:23:55
	 * 
	 */
	public class MapRoleBase extends InterActiveItem
	{
		// 角色各种动作皮肤宽高	
		public var roleSkinVo:RoleSkinVo;
		// 姓名栏
		protected var _nameField:TextItem;	
		/**
		 * 角色身体 
		 */		
		public var avatar:SceneFigureItem;
		
		private var qeestionItem:RenderItem;
		private var exclamationItem:RenderItem;
		
		// 闲话组件
		public var gossip:GossipComponent;
		/**
		 *角色移动状态 
		 */		
		public var moveStatus:String;
		
		/**
		 * 构造函数
		 * */
		public function MapRoleBase()
		{
			super();
			
			_nameField = new TextItem(120, 20);
			_nameField.color = 0xffffff;
			_nameField.labelFilter =  MapConfig.NAME_LABEL_FILTER;
			_nameField.align = Align.CENTER;
			
			avatar = new SceneFigureItem(true);
			moveStatus = RoleActionDict.RUN;
		}
		
		/**
		 * 更新avatar
		 * */
		public function setAvatar(url:String):void
		{
			// 角色avatar
			avatar.frameRate = MapConfig.ROLE_FRAME_RATE;
			avatar.addEventListener(RenderItemEvent.LOADED , avatarLoaded);
			avatar.addEventListener(RenderItemEvent.FIRST_RENDER , firstRender);
			avatar.load(GameConfig.NPC_FIGURE_URL + url , BulkLoaderSingleton.instance);
			this.addChild(avatar);
			this.addChild(_nameField);
			
			roleSkinVo = RoleSkinManager.instance.getRoleSkinVo(url);
			
			// 注册闲话组件
			gossip = new GossipComponent();
			gossip.register(this);
			gossip.registerHeight = roleSkinVo ? roleSkinVo.standHeight : 130;
			
			avatar.face = RoleActionDict.RR;
			setStatus(RoleActionDict.STAND);
		}
		/**
		 * 设置角色站立or跑动 
		 * @param status
		 * 
		 */		
		public function setStatus(status:String):void
		{
			switch(status)
			{
				//站立
				case RoleActionDict.STAND:
					avatar.status = status;
					if(roleSkinVo)
					{
						_nameField.y = -roleSkinVo.standHeight - MapConfig.ROLE_NAME_OFFSET;
					}
					break;
				// 角色移动状态 跑 跳 走
				case RoleActionDict.MOVESTATUS:
					avatar.status = moveStatus;
					if(roleSkinVo)
					{
						_nameField.y = -roleSkinVo.runHeight - MapConfig.ROLE_NAME_OFFSET;
					}
					break;
				default:
					avatar.status = status;
					break;
			}
		}
		
		override public function get activeRect():Rectangle
		{
			if(_nameField && avatar)
			{
				return _nameField.drawRectangle.union(avatar.drawRectangle);
			}
			return new Rectangle(this.x,this.y,100,200);//默认大小，临时设置
		}
		/**
		 * 设置朝向 
		 * @param angle
		 * 
		 */		
		public function setFace(angle:Number):void
		{
			
			if(Math.abs(angle) < (Math.PI / 2))
			{
				avatar.face = RoleActionDict.RR;
			}
			else
			{
				avatar.face = RoleActionDict.LL;
			}
		}
		
		/**
		 * 设置名称
		 * @param name
		 * 
		 */		
		protected function setName(name:String):void
		{
			_nameField.text = name;
		}
		/**
		 * 角色加载完成
		 * */
		protected function avatarLoaded(e:Event):void
		{
			avatar.removeEventListener(RenderItemEvent.LOADED , avatarLoaded);
			
		}
		
		override public function set filters(filters:Vector.<BitmapFilter>):void
		{
			if(avatar) avatar.filters = filters;
		}
		
		
		
		/**
		 * 第一次渲染完成
		 * */
		private function firstRender(e:Event):void
		{
			avatar.removeEventListener(RenderItemEvent.FIRST_RENDER , firstRender);
			
			if(this.scaleX < 1)
			{
				this.x += avatar.itemWidth * (1-scaleX);
			}
			if(this.scaleY < 1)
			{
				this.y += avatar.itemHeight * (1-scaleY);
			}
			if(roleSkinVo == null)
				_nameField.y = -avatar.itemHeight - MapConfig.ROLE_NAME_OFFSET;
			
			dispatchEvent(new MapEvent(MapEvent.NPC_FIRST_RENDER,null));
		}
		
		
		
		override public function gc(isCleanAll:Boolean = false):void
		{
			if(avatar)
			{
				avatar.gc(true);
				avatar.filters = null;
				removeChild(avatar);
				avatar = null;
			}
			if(_nameField) 
			{
				_nameField.gc(true);
				removeChild(_nameField);
				_nameField = null;
			}
			
			// 清空闲话组件
			gossip.clear();
		}
	}
}