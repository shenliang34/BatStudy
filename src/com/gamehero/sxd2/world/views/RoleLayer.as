package com.gamehero.sxd2.world.views
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.event.NPCEvent;
	import com.gamehero.sxd2.manager.TaskManager;
	import com.gamehero.sxd2.pro.MSG_MAP_UPDATE_ACK;
	import com.gamehero.sxd2.pro.PRO_Player;
	import com.gamehero.sxd2.world.HurdleMap.components.MapPatrolMonster;
	import com.gamehero.sxd2.world.display.SwfRenderItem;
	import com.gamehero.sxd2.world.event.MapEvent;
	import com.gamehero.sxd2.world.event.SwfRenderEvent;
	import com.gamehero.sxd2.world.globolMap.GlobalGameWorld;
	import com.gamehero.sxd2.world.model.GameWorldItemType;
	import com.gamehero.sxd2.world.model.MapConfig;
	import com.gamehero.sxd2.world.model.MapModel;
	import com.gamehero.sxd2.world.model.RoleActionDict;
	import com.gamehero.sxd2.world.model.vo.MapDecoVo;
	import com.gamehero.sxd2.world.model.vo.MapLayerVo;
	import com.gamehero.sxd2.world.utls.MapMathUtil;
	import com.gamehero.sxd2.world.utls.NavMeshUtil;
	import com.gamehero.sxd2.world.views.item.InterActiveItem;
	import com.gamehero.sxd2.world.views.item.MainRole;
	import com.gamehero.sxd2.world.views.item.MapCityItem;
	import com.gamehero.sxd2.world.views.item.MapDecoItem;
	import com.gamehero.sxd2.world.views.item.MapJumpSpotItem;
	import com.gamehero.sxd2.world.views.item.MapMonster;
	import com.gamehero.sxd2.world.views.item.MapNPC;
	import com.gamehero.sxd2.world.views.item.MapRoleBase;
	import com.gamehero.sxd2.world.views.item.MapRunRoleBase;
	import com.gamehero.sxd2.world.views.item.MapTrickBase;
	import com.gamehero.sxd2.world.views.item.MouseItem;
	import com.gamehero.sxd2.world.views.item.OtherPlayer;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import bowser.iso.pathfinding.navmesh.findPath.NavMesh;
	import bowser.iso.pathfinding.navmesh.geom.Vector2f;
	import bowser.render.display.DisplayItem;
	import bowser.render.display.SpriteItem;
	import bowser.utils.data.Group;

	
	/**
	 * 添加角色，并且控制视图移动
	 * 添加挂件，鼠标对象，
	 * @author weiyanyu
	 * 创建时间：2015-6-2 下午5:47:13
	 * 
	 */
	public class RoleLayer extends SpriteItem
	{
		
		public function RoleLayer()
		{
			super();
			
			_model = MapModel.inst;
		}
		private var _navMesh:NavMesh;//寻路
		private var _navTri:String;//路点
		public var role:MainRole;//主角
		
		/**
		 * 当前鼠标移入的挂件 ，
		 * 需要设置亮态
		 */		
		protected var _curFocusTargetPendant:InterActiveItem;
		/**
		 * 当前点击的挂件 ，
		 */		
		protected var _curClickTargetPendant:InterActiveItem;
		/**
		 * 点击后计时器 
		 */		
		private var _clickTimer:Timer;
		
		/**
		 * 地图信息 
		 */		
		public var data:MapLayerVo;
		/**
		 * 加载计数
		 */
		private var loadCount:int = 0;
		
		public var isDialogue:Boolean;
		
		// npc列表
		private var npcList:Group = new Group();
		// 挂件列表
		private var decoList:Group = new Group();
		// 怪物列表
		private var monsterList:Group = new Group();
		
		public var isDrivenCollide:Boolean
		
		private var _model:MapModel;	
		/**
		 * 玩家字典 
		 */		
		private var _playerDict:Dictionary = new Dictionary();
		/**
		 * 不在场景内的角色 
		 */		
		private var _removedPlayerPool:Dictionary = new Dictionary();
		/**
		 *跳点列表 
		 */		
		private var jumpSpotList:Array = new Array();
		/**
		 *城市列表 
		 */		
		private var cityList:Array = new Array();
		
		/**
		 * 设置路点 
		 * @param tri
		 */		
		public function set navTri(tri:String):void
		{
			if(_navMesh == null)
			{
				_navMesh = new NavMesh();
			}
			_navMesh.createNavMesh(NavMeshUtil.createNavMesh(tri));
		}
		
		/**
		 * 设置主角的位置 
		 * @param gx
		 * @param gy
		 * 
		 */		
		public function setRoleLoc(gx:int,gy:int):void
		{
			if(!contains(role))
			{
				addChild(role);
			}
			role.x = gx;
			role.y = gy;
		}
		
		/**
		 * enterframe 
		 * 
		 */		
		public function onRenderFrame():void
		{
			sortRole();
			
			// 主角执行enterframe
			role.enterFrame();
			
			for each(var player:OtherPlayer in _playerDict)
			{
				player.enterFrame();
			}
			
			// 所有npc执行enterframe
			var len:int = npcList.length;
			for(var i:int=0;i<len;i++)
			{
				var npc:MapNPC = npcList.getChildAt(i) as MapNPC;
				if(npc != null)
				{
					npc.enterFrame();
				}
			}
			
			var obj:Object = TaskManager.inst.moveObj;
			var distance:int;
			var item:MapJumpSpotItem;

			if(TaskManager.inst.moveObj.isMove && !(this.parent is GlobalGameWorld))
			{
				if(role.x < obj.x + 50 && role.x > obj.x - 50 && role.y < obj.y + 50 && role.y > obj.y - 50 )
				{
					parent.dispatchEvent(new MapEvent(MapEvent.MAP_MOVE_COMPLETE));
				}	
			}
			else if(_curClickTargetPendant)//  && _curClickTargetPendant.visible 当主角走到点击对象的位置（npc静态不动）
			{	
				distance = MapMathUtil.getItemDistance(role,_curClickTargetPendant);
				if(_curClickTargetPendant is MapJumpSpotItem)
				{
					if(distance < 50)
					{
						role.moveStatus = RoleActionDict.RUN;
						role.stop();
						_curClickTargetPendant = null;
					}	
				}
				else
				{
					if(distance <= MapConfig.ITEM_DISTANCE)//当角色与目标npc的距离小于某个值，证明已经走到npc跟前了。
					{
						dispatchEvent(new MapEvent(MapEvent.MAP_ACTIVE_COLLIDE,{role:role,targe:_curClickTargetPendant}));
						role.stop();
						_curClickTargetPendant = null;
					}
				}
			}
			else
			{
				
				isDrivenCollide = true;
				
				//是否检测被动碰撞
				if(isDrivenCollide)
				{
					for each(var jumpSpotItem:MapJumpSpotItem in jumpSpotList)
					{
						distance = MapMathUtil.getItemDistance(role,jumpSpotItem);
						if(distance <= MapConfig.ITEM_DISTANCE)
						{
							item = getNextJumpSpot(jumpSpotItem);
							if(item)
							{
								role.moveStatus = RoleActionDict.JUMP;
								goTarget(role,item.x,item.y);
							}
						}
					}
					
					/*
					for each(var pendant:DisplayItem in childs)
					{
						var item:InterActiveItem = pendant as InterActiveItem;
						if(item == null) continue;
						distance = MapMathUtil.getItemDistance(role,item);
						if(distance <= MapConfig.ITEM_DISTANCE)
						{	
							if(item.mapData != null)
							{
								if(item.mapData.type == GameWorldItemType.JUMPSPOT)
								{
									var jumpSpot:MapJumpSpotItem = item as MapJumpSpotItem;
									role.setStatus(RoleActionDict.JUMP);
									goTarget(role,jumpSpotList.toArray()[1].x,jumpSpotList.toArray()[1].y);
									if(jumpSpot.isJump)
									{
										role.setStatus(RoleActionDict.STAND);										
										jumpSpot.isJump = false;
									}
									else
									{
										
										jumpSpot.isJump = true;

									}
									
								}
							}
							else
							{
								//玩家角色
							}
						}
					}
					*/
				}
			}
		}
		
		/**
		 * 点击 
		 */		
		public function onStageClicked(event:MouseEvent):void
		{
			if(role.moveStatus == RoleActionDict.JUMP) return;
			
			var posObj:Object = new Object();
			if(_curFocusTargetPendant && (_curFocusTargetPendant.type != GameWorldItemType.WUYA))//如果当前有选中的对象
			{
				_curClickTargetPendant = _curFocusTargetPendant;//那么选中的对象与点击的对象是同一个
				
				if(_curClickTargetPendant.visible)
				{
					posObj.type = 1;
					posObj.x = _curClickTargetPendant.x;
					posObj.y = _curClickTargetPendant.y;
				}
				var distance:int = Math.sqrt((role.x - _curClickTargetPendant.x) * (role.x - _curClickTargetPendant.x) + (role.y - _curClickTargetPendant.y) *　(role.y - _curClickTargetPendant.y));
				if(distance > MapConfig.ITEM_DISTANCE) 
					this.goTarget(role , _curClickTargetPendant.x , _curClickTargetPendant.y);
			}
			else
			{
				var father:GameWorld = this.parent as GameWorld;
				var targetX:int = father.canvas.mouseX + father.camera.x + father.stageCamera.x;
				var targetY:int = father.canvas.mouseY + father.camera.y + father.stageCamera.y;
				this.goTarget(role , targetX , targetY);
				_curClickTargetPendant = null;
			}
			
			parent.dispatchEvent(new MapEvent(MapEvent.MAP_CLICK_PLAYER,posObj));
			
			if(!_clickTimer) {//  && isDialogue 鼠标按下后要开始记录按下的时间，当一定时间后默认是“点击地面”的效果
				_clickTimer = new Timer(MapConfig.MOUSE_DOWN_TIME);
				_clickTimer.addEventListener(TimerEvent.TIMER, onClickTimer);
			}
			_clickTimer.start();
			
		}
		
		/**
		 * go 
		 * @param runRole 需要行走的人物对象
		 * @param targetX
		 * @param targetY
		 * @param mouseEffect 是否需要显示鼠标波纹效果
		 */		
		public function goTarget(runRole:MapRunRoleBase , targetX:int , targetY:int , mouseEffect:Boolean = true):void
		{
			var item:InterActiveItem;
			if(isDialogue)
			{
				parent.dispatchEvent(new NPCEvent(NPCEvent.HIDE_BUBBLE));
				isDialogue = false;
			}
			else
			{
				for each(var pendant:DisplayItem in childs)
				{
					item = pendant as InterActiveItem;
					if(item == null || item.mapData == null) continue;
					if(item.mapData.x == targetX && item.mapData.y == targetY){
						_curClickTargetPendant = item;
						break;
					}
				}
			}
			
			var distance:int = Math.sqrt((runRole.x - targetX) * (runRole.x - targetX) + (runRole.y - targetY) *　(runRole.y - targetY));
			if(_curClickTargetPendant)
			{
				//如果目标对象存在 距离小于安全距离, 立即停止移动
				if(distance <= MapConfig.ITEM_DISTANCE)
				{
					runRole.stop();
					return;
				}
					
			}
			else
			{
				//目标对象不存在，点击角色自身，所以没必要走动
				if(distance <= MapConfig.OWN_DISTANCE) 
				{
					runRole.stop();
					return;
				}
			}
			var path:Vector.<Vector2f> = _navMesh.findPath(runRole.x,runRole.y,targetX,targetY);
			if(path == null) return;
			if(path.length > 0 && mouseEffect == true)
			{
				var vf:Vector2f = path[path.length - 1];
				var mouseItem:MouseItem = new MouseItem(GameConfig.SWF_FIGURE_URL + "MousePoint.swf");
				mouseItem.x = vf.x;
				mouseItem.y = vf.y;
				addChild(mouseItem);
			}
			runRole.path = path;
		}
		
		private function onClickTimer(event:TimerEvent):void {
			onStageClicked(null);
		}
		
		/**
		 * 鼠标移动 
		 */		
		public function onMouseMove(event:MouseEvent):void
		{
			if(_curFocusTargetPendant != null)
			{//如果鼠标在挂件上滑动，
				
				if(!_curFocusTargetPendant.activeRect.contains((this.parent as GameWorld).canvas.mouseX,(this.parent as GameWorld).canvas.mouseY))
				{//如果鼠标划出挂件
					_curFocusTargetPendant.onMouseOutHandler(event);
					_curFocusTargetPendant = null;	
				}
			}
			else
			{
				var item:InterActiveItem;
				//遍历舞台对象，找到当前鼠标所在的对象
				for each(var pendant:DisplayItem in childs)
				{
					item = pendant as InterActiveItem;
					if(item == null) continue;
					if(item.activeRect && item.activeRect.contains((this.parent as GameWorld).canvas.mouseX,(this.parent as GameWorld).canvas.mouseY))
					{
						if(_curFocusTargetPendant)
						{
							_curFocusTargetPendant.onMouseOutHandler(event);
						}
						_curFocusTargetPendant = pendant as InterActiveItem;
						_curFocusTargetPendant.onMouseOverHandler(event);
						
					}
				}
			}
		}
		
		/**
		 * 鼠标抬起 
		 * @param event
		 * 
		 */		
		public function onGameWorldMouseUp(event:MouseEvent):void
		{
			stopClickTimer();
		}
		
		/**
		 * 停止点击的计时器 
		 * 
		 */		
		public function stopClickTimer():void
		{
			if(_clickTimer) {
				_clickTimer.stop();
			}
		}
		
		/**
		 * 深度排序， 
		 */		
		public function sortRole():void
		{
			childs.sort(sortChildren);
		}
		
		private function sortChildren(a:DisplayItem,b:DisplayItem):int
		{
			
			if(a ==  role && a.x == b.x && a.y == b.y)
				return 1;
			else if(b == role && a.x == b.x && a.y == b.y)
				return -1;
			else if(a.y > b.y)
			{
				return 1;
			}
			else if(a.y < b.y)
			{
				return -1;
			}
			else
			{
				return 0;
			}
		}
		
		/**
		 * 初始化舞台挂件 
		 */		
		protected function initDeco():void
		{
			if(data.isMain)
			{
				role = new MainRole();
				role.setAvatar(MapConfig.MAIN_ROLE_SKIN_URL);
			}
			for each (var item:MapDecoVo in data.decoVec) {
				//index=3 为中景层
				if(data.index != 3)
				{
					var pendant:DisplayItem = addItem(item);
					if(pendant)
						addChild(pendant);
				}
				else
				{
					// 当中景层资源全部加载完后去除马赛克
					var url:String = GameConfig.RESOURCE_URL + item.url;
					var renderItem:SwfRenderItem = new SwfRenderItem(GameConfig.RESOURCE_URL + item.url,true);
					renderItem.isBackground = true;
					renderItem.x = item.x;
					renderItem.y = item.y;
					renderItem.addEventListener(SwfRenderEvent.LOADED,completeHandler);
					addChild(renderItem);
					
					loadCount++;
				}
			}
		}
		
		/**
		 * 加载完成
		 * */
		private function completeHandler(e:Event):void
		{
			e.target.removeEventListener(SwfRenderEvent.LOADED, completeHandler);
			loadCount -- ;
			
			if(loadCount <= 0)
				parent.dispatchEvent(new MapEvent(MapEvent.MAP_RESLOAD_COMPLETE,null));
		}		
		
		/**
		 * 每帧根据摄像机位置，调整坐标 
		 * @param cx
		 * @param cy
		 * 
		 */		
		public function initLoc(cx:int,cy:int):void
		{
			this.x = data.x + data.speedX * cx;
			this.y = data.y + data.speedY * cy;
		}
		
		/**
		 * 初始化图层 数据
		 * @param layer
		 * 
		 */		
		public function initMap(layer:MapLayerVo):void
		{
			data = layer;
			this.x = data.x;
			this.y = data.y;
			initDeco();
			
		}
		
		/**
		 * 添加挂件 
		 * 所有场景初始化加载的物品
		 * @param deco
		 * @return 
		 * 
		 */		
		protected function addItem(deco:MapDecoVo):DisplayItem
		{
			var item:InterActiveItem;
			switch(deco.type)
			{
				// 普通装饰物
				case "null":
				case GameWorldItemType.DECO:
					item = addDeco(deco,data.isBack);
					decoList.add(item);
					break;
				// npc
				case GameWorldItemType.NPC:
					item = addNpc(deco);
					npcList.add(item);
					break;
				// 传送门
				case GameWorldItemType.SWITCH_MAP:
					item = addMapSwitch(deco);
					decoList.add(item);
					break;
				// 乌鸦
				case GameWorldItemType.WUYA:
					item = addWuya(deco);
					decoList.add(item);
					break;
				// 普通不移动的怪物
				case GameWorldItemType.MONSTER:
					item = addMonster(deco);
					monsterList.add(item);
					break;
				// 会巡逻的怪物
				case GameWorldItemType.HURDLE_MONSTER:
					item = addHurdleMonster(deco);
					monsterList.add(item);
					break;
				// 世界地图上的城市
				case GameWorldItemType.CITY:
					item = addMapCity(deco);
					cityList.push(item);
					if(item == null) return item;
					break;
				case GameWorldItemType.CITYNAME:
					item = addMapCityName(deco);
					if(item == null) return item;
					break;
				case GameWorldItemType.JUMPSPOT:
					item = addMapJumpSpot(deco);
					jumpSpotList.push(item)
					break;
			}
			item.type = deco.type;
			item.mapData = deco;
			item.x = deco.x;
			item.y = deco.y;
			return item;
		}
		
		/**
		 * 添加普通的单帧挂件 
		 * @param deco
		 * @return 
		 * 
		 */		
		protected function addDeco(deco:MapDecoVo,isBack:Boolean):MapDecoItem
		{
			return new MapDecoItem(GameConfig.RESOURCE_URL + deco.url,isBack);
		}
		
		/**
		 * 添加npc 
		 * @param deco
		 * @return 
		 * 
		 */		
		protected function addNpc(deco:MapDecoVo):MapNPC
		{
			return new MapNPC();
		}
		
		/**
		 * 普通怪物 
		 * @param deco
		 * @return 
		 * 
		 */		
		protected function addMonster(deco:MapDecoVo):MapMonster
		{
			return new MapMonster();
		}
		
		/**
		 * 关卡巡逻怪物 
		 * @param deco
		 * @return 
		 * 
		 */		
		protected function addHurdleMonster(deco:MapDecoVo):MapPatrolMonster
		{
			return new MapPatrolMonster();	
		}
		
		/**
		 * 添加“乌鸦” 机关挂件 
		 * @param deco
		 * @return 
		 * 
		 */		
		protected function addWuya(deco:MapDecoVo):InterActiveItem
		{
			return new MapTrickBase(GameConfig.SWF_FIGURE_URL + deco.url);
		}
		
		/**
		 * 添加传送门 
		 * @param deco
		 * @return 
		 * 
		 */		
		protected function addMapSwitch(deco:MapDecoVo):InterActiveItem
		{
			return	new MapDecoItem(GameConfig.SWF_FIGURE_URL + deco.url);
		}
		
		/**
		 * 添加城市入口
		 * @param deco
		 * @return 
		 * 
		 */		
		protected function addMapCity(deco:MapDecoVo):InterActiveItem
		{
			if(getMapCity(deco.id))
				return	new MapCityItem(GameConfig.RESOURCE_URL + deco.url,int(deco.ent));
			return null;
		}
		
		/**
		 * 添加城市名称
		 * @param deco
		 * @return 
		 * 
		 */	
		protected function addMapCityName(deco:MapDecoVo):MapDecoItem
		{
			if(getMapCity(deco.id))
				return new MapDecoItem(GameConfig.RESOURCE_URL + deco.url);
			return null;
		}
		
		/**
		 * 添加跳点
		 * @param deco
		 * @return 
		 * 
		 */	
		protected function addMapJumpSpot(deco:MapDecoVo):InterActiveItem
		{
			return new MapJumpSpotItem(GameConfig.SWF_FIGURE_URL + deco.url,int(deco.ent));
		}
		
		/**
		 *根据Id获取可以进入的城市 
		 * @param id
		 * @return 
		 * 
		 */		
		protected function getMapCity(id:int):Boolean
		{
			var list:Array = _model.cityList;
			var len:int = list.length;
			var i:int;
			for(i;i<len;i++)
			{
				if(list[i] == id)
					return true;		
			}
			return false;
		}
		
		/**
		 *根据城市Id获取城市位置 
		 * @param id
		 * @return 
		 * 
		 */		
		public function getCityPos(id:int):MapCityItem
		{
			for each(var item:MapCityItem in cityList)
			{
				if(item && item.entMapId == id)
				{
					return 	item;
				}
				
			}
			return null;
		}
		
		/**
		 * 获取地图传送阵
		 * */
		public function getTeleportInfo():InterActiveItem
		{
			for each(var pendant:DisplayItem in childs)
			{
				var item:InterActiveItem = pendant as InterActiveItem;
				if(item != null)
				{
					if(item.type == GameWorldItemType.SWITCH_MAP)
						return item;
				}
				
			}
			return null;
		}
		
		
		
		
		
		/**
		 * 摧毁deco
		 * */
		public function destoryDeco(id:int):void
		{
			var deco:InterActiveItem = this.getDeco(id);
			if(deco)
			{
				this.removeChild(deco);
				decoList.remove(deco);
			}
		}
		
		
		
		
		
		/**
		 * 通过id找到挂件
		 * */
		public function getDeco(id:int):InterActiveItem
		{
			for(var i:int;i<decoList.length;i++)
			{
				var item:InterActiveItem = decoList.getChildAt(i) as InterActiveItem;
				if(item.mapData.id == id)
					return item;
			}
			return null;
		}
		
		
		/**
		 * 创建指定npc
		 * */
		public function createNpc(npcId:int , pos:Point , face:String):MapNPC
		{
			var vo:MapDecoVo = new MapDecoVo();
			vo.id = npcId;
			vo.x = pos.x;
			vo.y = pos.y
			
			var npc:MapNPC = this.addNpc(vo);
			npc.type = GameWorldItemType.NPC;
			npc.mapData = vo;
			npc.x = vo.x;
			npc.y = vo.y;
			npc.avatar.face = face;
			this.addChild(npc);
			
			npcList.add(npc);
			
			return npc;
		}
		
		
		
		/**
		 * 销毁指定npc
		 * */
		public function destoryNpc(npcId:int):void
		{
			var npc:MapNPC = this.getMapNpc(npcId);
			if(npc)
			{
				this.removeChild(npc);
				npcList.remove(npc);
			}
		}
		
		
		
		/**
		 * 初始化npc状态
		 */	
		public function setMapNpcStatus():void
		{
			for(var i:int;i<npcList.length;i++)
			{
				var npc:MapNPC = npcList.getChildAt(i) as MapNPC;
				npc.setNpcTaskStatus(0);
			}
		}
		
		
		
		/**
		 * 通过npc id查找npc对象
		 * */
		public function getMapNpc(npcId:int):MapNPC
		{
			for(var i:int;i<npcList.length;i++)
			{
				var npc:MapNPC = npcList.getChildAt(i) as MapNPC;
				if(npc.npcVo.id == npcId)
					return npc;
			}
			return null;
		}
		
		
		
		/**
		 * 显示/隐藏 npc
		 * */
		public function setNpcVisible(value:Boolean):void
		{
			for(var i:int=0;i<npcList.length;i++)
			{
				var npc:MapNPC = npcList.getChildAt(i) as MapNPC;
				npc.visible = value;
			}
		}
		
		
		
		/**
		 * 显示/隐藏 玩家
		 * */
		public function setPlayerVisible(value:Boolean):void
		{
			for each(var player:OtherPlayer in _playerDict)
			{
				player.visible = value;
			}
		}
		
		
		/**
		 *初始化玩家 
		 * 
		 */		
		public function initPlayers():void
		{
			for each(var pp:PRO_Player in _model.playerDict)
			{
				initPlayer(pp);
			}
		}
		
		
		
		/**
		 * 刷新玩家数据 
		 * 
		 */		
		public function updatePlayer(info:MSG_MAP_UPDATE_ACK):void
		{
			for each(var pp:PRO_Player in _model.playerDict)
			{
				initPlayer(pp);
			}
		}
		
		
		
		private function initPlayer(pp:PRO_Player):void
		{
			if(pp.map)
			{
				if(pp.map.isEnter)
				{
					addPlayer(pp);
				}
				else if(pp.map.isLeave)
				{
					delPlayer(pp);
				}
				else
				{
					updatePlayerInfo(pp);
				}
			}
		}
		
		//刷新单个玩家数据
		private function updatePlayerInfo(pp:PRO_Player):void
		{
			if(_playerDict[pp.id.toNumber()] == null)
			{
				addPlayer(pp);
			}
			var player:OtherPlayer = _playerDict[pp.id.toNumber()];
			player.updataInfo(pp);
		}
		
		/**
		 * 场景中添加玩家 
		 * @param pp
		 * 
		 */		
		private function addPlayer(pp:PRO_Player):void
		{
			pp.map.isEnter = false;
			var player:OtherPlayer = getPlayer(pp);
			_playerDict[pp.id.toNumber()] = player;
			player.setAvatar("player_zhujue01_m");
			player.updataInfo(pp);
			addChild(player);
			player.x = pp.map.x;
			player.y = pp.map.y;
		}
		
		private function delPlayer(pp:PRO_Player):void
		{
			var id:Number = pp.id.toNumber();
			var player:OtherPlayer = _playerDict[id];
			if(player)
			{
				_playerDict[id] = null;
				delete _playerDict[id];
				
				_removedPlayerPool[id] = player;
				removeChild(player);
			}
			_model.playerDict[id] = null;
			delete _model.playerDict[id];
		}
		
		/**
		 * 从池子里面找找看 
		 * @param pp
		 * @return 
		 * 
		 */		
		private function getPlayer(pp:PRO_Player):OtherPlayer
		{
			var id:Number = pp.id.toNumber();
			if(_removedPlayerPool[id])
			{
				var player:OtherPlayer = _removedPlayerPool[id] as OtherPlayer;
				_removedPlayerPool[id] = null;
				delete _removedPlayerPool[id];
				return player;
			}
			else 
				return new OtherPlayer;
		}
		
		
		
		
		
		
		/**
		 * 设置怪物是否显示
		 * */
		public function setMonsterVisible(value:Boolean):void
		{
			for(var i:int=0;i<monsterList.length;i++)
			{
				var monster:MapRoleBase = monsterList.getChildAt(i) as MapRoleBase;
				monster.visible = value;
			}
		}
		
		/**
		 *获取下一个跳点 
		 * @return 
		 * 
		 */		
		private function getNextJumpSpot(item:MapJumpSpotItem):MapJumpSpotItem
		{
			for each(var jumpSpotItem:MapJumpSpotItem in jumpSpotList)
			{
				if(jumpSpotItem.isJump)
				{
					if(role.avatar.face == RoleActionDict.LL)
					{
						if(item.x > jumpSpotItem.x )
							return jumpSpotItem;
					}
					else
					{
						if(item.x < jumpSpotItem.x)
							return jumpSpotItem;
					}
				}
				
			}
			return null;
		}
		
		
		
		
		override public function gc(isCleanAll:Boolean=false):void
		{
			if(_clickTimer) {
				_clickTimer.stop();
				_clickTimer.removeEventListener(TimerEvent.TIMER, onClickTimer);
				_clickTimer = null;
			}
			
			for each(var pp:PRO_Player in _model.playerDict)
			{
				delPlayer(pp);
				
				_model.playerDict[pp.id.toNumber()] = null;
				delete _model.playerDict[pp.id.toNumber()];
			}
			
			_navMesh = null;
			if(role) 
			{
				role.gc(true);
				role = null;
			}
			_curFocusTargetPendant = null;
			_curClickTargetPendant = null;
			data = null;
			
			for each(var p:PRO_Player in _model.playerDict){
				if(p.map.x == x && p.map.y){
					delPlayer(p);
				}
			}
			
			// 清除npc列表
			npcList.clear();
			// 清除deco列表
			decoList.clear();
			// 清除怪物列表
			monsterList.clear();
			
			super.gc(isCleanAll);
		}
	}
}