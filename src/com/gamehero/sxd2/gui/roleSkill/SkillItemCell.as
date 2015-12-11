package com.gamehero.sxd2.gui.roleSkill
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.gui.bag.component.ItemDragObject;
	import com.gamehero.sxd2.manager.SkillManager;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSG_SKILL_SET_REQ;
	import com.gamehero.sxd2.pro.PRO_SkillSlot;
	import com.gamehero.sxd2.services.GameService;
	import com.gamehero.sxd2.vo.BattleSkill;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import alternativa.gui.base.ActiveObject;
	import alternativa.gui.event.DragEvent;
	import alternativa.gui.mouse.dnd.IDrag;
	import alternativa.gui.mouse.dnd.IDragObject;
	import alternativa.gui.mouse.dnd.IDrop;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	
	/**
	 * 技能图标模块
	 * @author zhangxueyou
	 * @create 2015-10-26
	 **/
	public class SkillItemCell extends ActiveObject implements IDrag, IDrop
	{
		
		/**
		 * 背景资源 
		 */		
		protected var backGroud:Bitmap;
		/**
		 * 图标资源 
		 */		
		protected var icon:Bitmap;
		/**
		 *是否装备图标 
		 */		
		protected var stow:Bitmap;
		/**
		 * 是否可以拖动 
		 */		
		protected var _isDragable:Boolean;
		/**
		 * 拖拽的数据 
		 */		
		protected var _dragData:Object;
		/**
		 * 格子大小 
		 */		
		protected var _size:int;
		/**
		 * 图标路径 
		 */		
		protected var _url:String;
		/**
		 *技能数据 
		 */				
		public var skillData:BattleSkill;
		/**
		 *是否是插槽 
		 */		
		public var isSlot:Boolean;
		/**
		 *插槽数据 
		 */		
		public var slotInfo:PRO_SkillSlot;
		/**
		 *技能类型 是否为全系 
		 */		
		public var isAll:Boolean = true;
		
		/**
		 *构造 
		 * @param bmd
		 * 
		 */		
		public function SkillItemCell()
		{
			super();
			initUI();
			
			this.graphics.beginFill(0,0);
			this.graphics.drawRect(0,0,50,50);
			this.graphics.endFill();
			
			size = 50;
			
			this.addEventListener(DragEvent.CANCEL , dragCancel);
			this.addEventListener(MouseEvent.DOUBLE_CLICK,doubleClickHandle);
			this.doubleClickEnabled = true;
		}
		
		/**
		 *设置信息 
		 * @param vo
		 * 
		 */		
		public function set data(vo:BattleSkill):void
		{
			skillData = vo;
			loadIcon();
		}
		
		/**
		 *设置技能图标尺寸 
		 * @return 
		 * 
		 */	
		public function set size(value:int):void
		{
			this.height = this.width = _size = value;
			initLoc();
		}
		
		/**
		 *获取技能图标尺寸 
		 * @return 
		 * 
		 */		
		public function get size():int
		{
			return _size;
		}
		
		/**
		 * 重新设置ui位置 
		 */		
		private function initLoc():void
		{
			backGroud.x = size - backGroud.width >> 1;
			backGroud.y = size - backGroud.height >> 1;
			
			icon.x = size - icon.width >> 1;
			icon.y = size - icon.height >> 1;
		}
		
		/**
		 * 初始化UI
		 * 
		 */		
		protected function initUI():void
		{
			backGroud = new Bitmap();
			addChild(backGroud);
			
			icon = new Bitmap();
			addChild(icon);
			
			stow = new Bitmap();
			addChild(stow);
			
			var stowUrl:String = GameConfig.SKILL_ICON_URL + "stow.png";
			BulkLoaderSingleton.instance.addWithListener(stowUrl, null, onSkillStowLoaded);
			
			var url:String = GameConfig.SKILL_ICON_URL + "skillBg.png";
			BulkLoaderSingleton.instance.addWithListener(url, null, onSkillBgLoaded);
		}
		
		/**
		 *加载背景资源 
		 * @param event
		 * 
		 */		
		protected function onSkillBgLoaded(event:Event):void {
			var imageItem:ImageItem = event.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE, onIconLoaded);
			imageItem.removeEventListener(ErrorEvent.ERROR, onIconLoadError);
			setBackGroud(imageItem.content.bitmapData);
		}
		
		/**
		 * 设置背景 
		 * @param bd
		 * 
		 */		
		public function setBackGroud(bd:BitmapData):void
		{
			backGroud.bitmapData = bd;
			backGroud.x = this.width - bd.width>> 1;
			backGroud.y = this.height - bd.height >> 1;
		}
		
		/**
		 *加载技能图标 
		 * 
		 */		
		protected function loadIcon():void
		{
			var url:String
			var isLoad:Boolean = true;
			_isDragable = true;
			if(skillData)
			{
				this.hint = skillData.name;
			}
			if(!slotInfo)
			{
				if(skillData)
				{
					var obj:Object = SkillManager.instance.getRoleSkillBySkillID(skillData.skillId);
					if(obj)
					{
						var skillVo:BattleSkill = obj.skillVo;
						url = GameConfig.SKILL_ICON_URL + skillVo.groupId + ".png";
						if(obj.pos > 0)
							stow.visible = true;
						else
							stow.visible = false;
					}	
					else
					{
						stow.visible = false;
						_isDragable = false;
						var level:int = GameData.inst.playerInfo.level;
						if(level < skillData.skillLevel)
							url = GameConfig.SKILL_ICON_URL + "lock.png";
						else
							url = GameConfig.SKILL_ICON_URL + "unlock.png";
					}
				}
				else
					isLoad = false;
			}
			else
			{
				stow.visible = false;
				if(slotInfo.isOpen)
				{
					if(skillData)
					{
						if(skillData.groupId)
						{
							url = GameConfig.SKILL_ICON_URL + skillData.groupId + ".png";
						}		
						else
						{
							_isDragable = false;
							url = GameConfig.SKILL_ICON_URL + slotInfo.slotId + ".png";
							this.hint = "放置技能后将在第" + slotInfo.slotId + "回合释放";
						}
					}
					else
					{
						_isDragable = false;
						url = GameConfig.SKILL_ICON_URL + slotInfo.slotId + ".png";
						this.hint = "放置技能后将在第" + slotInfo.slotId + "回合释放";
					}
				}
				else
				{
					_isDragable = false;
					url = GameConfig.SKILL_ICON_URL + "lock.png";	
				}		
			}
			
			if(isLoad)
			{
				BulkLoaderSingleton.instance.addWithListener(url, null, onIconLoaded, null, onIconLoadError);
				BulkLoaderSingleton.instance.start();
			}
		}
		
		/**
		 *已装备图标添加 
		 * @param e
		 * 
		 */		
		private function onSkillStowLoaded(e:Event):void
		{
			var imageItem:ImageItem = e.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE, onIconLoaded);
			imageItem.removeEventListener(ErrorEvent.ERROR, onIconLoadError);
			stow.bitmapData = imageItem.content.bitmapData;
		}
		
		/**
		 *技能图标加载完成 
		 * @param event
		 * 
		 */		
		protected function onIconLoaded(event:Event):void {			
			var imageItem:ImageItem = event.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE, onIconLoaded);
			imageItem.removeEventListener(ErrorEvent.ERROR, onIconLoadError);
			setIcon(imageItem.content.bitmapData);
		}

		/**
		 * 加载失败（临时用） 
		 * @param event
		 * 
		 */
		protected function onIconLoadError(event:ErrorEvent):void {
			
			event.target.removeEventListener(Event.COMPLETE, onIconLoaded);
			event.target.removeEventListener(ErrorEvent.ERROR, onIconLoadError);
			// 使用默认图标
			_url = GameConfig.SKILL_ICON_URL + "lock.png";
			BulkLoaderSingleton.instance.addWithListener(_url, null, onIconLoaded);
		}	
		
		/**
		 * 设置icon 
		 * @param bd
		 * 
		 */		
		public function setIcon(bd:BitmapData):void
		{
			icon.bitmapData = bd;
			icon.width = bd.width;
			icon.height = bd.height;
			icon.x = _size - icon.width >> 1;
			icon.y = _size - icon.height >> 1;
		}
		
		/**
		 *
		 * @return 
		 * 
		 */		
		public function isDragable():Boolean
		{
			return _isDragable;
		}
		
		/**
		 *
		 * @return 
		 * 
		 */		
		public function getDragObject():IDragObject
		{
			if(_dragData == null)
			{
				_dragData = new Object();
			}
			_dragData.skillItem = this;
			
			if(_dragData.bd == null) 
			{	
				_dragData.bd = icon.bitmapData; 
			}
			return new ItemDragObject(_dragData);
		}
		
		/**
		 *
		 * @param dragObject
		 * @return 
		 * 
		 */		
		public function canDrop(dragObject:IDragObject):Boolean
		{
			return true;
		}
		
		/**
		 *
		 * @param dragObject
		 * 
		 */		
		public function drop(dragObject:IDragObject):void
		{
			var item:SkillItemCell = dragObject.data.skillItem;
			var groupId:int;
			var pos:int
			if(isSlot)
			{
				if(slotInfo)
				{
					var skill:BattleSkill = SkillManager.instance.getSkillBySkillID(item.skillData.skillId);
					if(item.skillData)
						groupId = int(skill.groupId);
					pos = slotInfo.slotId;
				}
					
			}
			else
			{
				if(!skillData) return;
				groupId = int(skillData.groupId);
				if(!item.slotInfo) return;
				pos = item.slotInfo.slotId;
			}
			
			send(groupId,pos);
		}
		
		/**
		 * 取消拖拽
		 * */
		private function dragCancel(e:DragEvent):void
		{
			if(slotInfo)
			{
				send(0,slotInfo.slotId);
				
			}
		}
		
		/**
		 *图标双击事件 
		 * @param e
		 * 
		 */		
		private function doubleClickHandle(e:MouseEvent):void
		{
			if(!_isDragable) return;
			if(slotInfo)
			{
				send(0,slotInfo.slotId);
			}
			else
			{
				send(int(skillData.groupId),6);
			}
		}
		
		/**
		 *发送请求 
		 * @param id
		 * @param pos
		 * 
		 */		
		private function send(id:int,pos:int):void
		{
			var ack:MSG_SKILL_SET_REQ = new MSG_SKILL_SET_REQ();
			ack.groupId = id
			ack.pos = pos;
			GameService.instance.send(MSGID.MSGID_SKILL_SET,ack);
			
//			dispatchEvent(new RoleSkillEvent(RoleSkillEvent.SET_SKILL,ack));
		}
		
		/**
		 * 
		 * 清除数据相关的内容
		 * （一般用于界面内清除，背景_backGroud保留）
		 *  @see gc()
		 */		
		public function clear():void
		{
			icon.bitmapData = null;
			this.hint = null;
			skillData = null;
			_url = null;
			_isDragable = false;
			_dragData = null;
		}
	}
}