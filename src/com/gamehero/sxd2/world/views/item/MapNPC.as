package com.gamehero.sxd2.world.views.item
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.manager.FunctionManager;
	import com.gamehero.sxd2.manager.NPCManager;
	import com.gamehero.sxd2.manager.TaskManager;
	import com.gamehero.sxd2.pro.TaskStatus;
	import com.gamehero.sxd2.vo.FunctionVO;
	import com.gamehero.sxd2.vo.NpcVO;
	import com.gamehero.sxd2.world.display.GossipComponent;
	import com.gamehero.sxd2.world.display.SwfRenderItem;
	import com.gamehero.sxd2.world.event.MapEvent;
	import com.gamehero.sxd2.world.model.MapConfig;
	import com.gamehero.sxd2.world.model.vo.MapDecoVo;
	
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilter;
	

	/**
	 * 简单的npc
	 * 只有身体，不能移动
	 * @author weiyanyu
	 * 创建时间：2015-6-11 下午2:34:51
	 * @modified by zhangxueyou 15-11-19 添加任务状态 功能图标
	 */
	public class MapNPC extends MapRunRoleBase
	{
		private var _npcVo:NpcVO;//npc对象
		/**
		 * 问号 
		 */		
		private var qeestionItem:SwfRenderItem;
		/**
		 * 感叹号 
		 */		
		private var exclamationItem:SwfRenderItem;
		private var funIcon:SwfRenderItem;
		/**
		 * 构造函数
		 * */
		public function MapNPC()
		{
			super();
			initUI();
		}
		
		/**
		 *初始化UI
		 *  
		 * 
		 */		
		private function initUI():void
		{
			qeestionItem = new SwfRenderItem(GameConfig.NPCFACE_URL + "qeestionItem.swf",false);
			this.addChild(qeestionItem);
			qeestionItem.visible = false;
			
			exclamationItem = new SwfRenderItem(GameConfig.NPCFACE_URL + "exclamationItem.swf",false);
			this.addChild(exclamationItem);
			exclamationItem.visible = false;
			
			addEventListener(MapEvent.NPC_FIRST_RENDER , npcFirstRenderHandle);
		}
		
		/**
		 *第一次渲染完成 
		 * @param e
		 * 
		 */		
		private function npcFirstRenderHandle(e:MapEvent):void
		{
			var npcTaskList:Array = TaskManager.inst.getNpcTasks(_npcVo.id)
			if(!npcTaskList.length)
			{
				if(_npcVo.funcId)
				{
					var funcVo:FunctionVO = FunctionManager.inst.getFunctionVO(npcVo.funcId);
					if(funcVo)
					{
						var isOpen:Boolean = FunctionManager.inst.isFuncOpen(funcVo.id);
						if(isOpen)
							setNpcFunctionIcon();
					}
					
				}
			}
			else
			{
				TaskManager.inst.sortTasks(npcTaskList,2);
				setNpcTaskStatus(npcTaskList[0].status);
			}
			
		}
		
		/**
		 * 基础数据
		 * */
		override public function set mapData(value:MapDecoVo):void
		{
			super.mapData = value;
			
			_npcVo = NPCManager.instance.getNpcData(value.id);
			
			if(_npcVo)
			{
				NPCManager.instance.setNpcXY(_npcVo.id,value.x,value.y);
				setAvatar(_npcVo.url);
				setName(_npcVo.name);
			}
		}
		
		/**
		 *鼠标移入 
		 * @param event
		 * 
		 */		
		override public function onMouseOverHandler(event:MouseEvent):void
		{
			avatar.filters = MapConfig.NPCFILTER;
		}
		
		/**
		 *鼠标移出 
		 * @param event
		 * 
		 */
		override public function onMouseOutHandler(event:MouseEvent):void
		{
			avatar.filters = null;
		}
		
		/**
		 *设置滤镜
		 * @param filters
		 * 
		 */		
		override public function set filters(filters:Vector.<BitmapFilter>):void
		{
			super.filters = filters;
		}
		
		/**
		 *Gc 
		 * @param isCleanAll
		 * 
		 */		
		override public function gc(isCleanAll:Boolean = false):void
		{
			if(qeestionItem) 
			{
				qeestionItem.gc(true);
			}
			qeestionItem = null;
			
			if(exclamationItem) 
			{
				exclamationItem.gc(true);
			}
			exclamationItem = null;
			
			if(funIcon) 
			{
				funIcon.gc(true);
			}
			funIcon = null;
			
			super.gc(true);
		}
		
		public  function get npcVo():NpcVO
		{
			return _npcVo;
		}
		
		/**
		 * 设置角色任务状态 
		 * @param status
		 * 
		 */	
		public function setNpcTaskStatus(status:int):void
		{
			exclamationItem.visible = false;
			qeestionItem.visible = false;
			if(funIcon) funIcon.visible = true;
			
			switch(status)
			{
				case TaskStatus.Finished:
				{
					qeestionItem.x = _nameField.x + 15;
					qeestionItem.y = _nameField.y;
					qeestionItem.visible = true;
					if(funIcon)
						funIcon.visible = false;
					break;
				}
				case TaskStatus.Startable:
				{
					exclamationItem.x = _nameField.x + 15;
					exclamationItem.y = _nameField.y;
					exclamationItem.visible = true;
					if(funIcon)
						funIcon.visible = false;
					break;
				}
			}
		}
		
		/**
		 *设置Npc功能图标 
		 * 
		 */		
		public function setNpcFunctionIcon():void
		{
			var url:String = GameConfig.NPCFACE_URL + "func_name_" + _npcVo.funcId + ".swf"
			funIcon = new SwfRenderItem(url,true);
			this.addChild(funIcon);
			funIcon.x = _nameField.x - 20;
			funIcon.y = _nameField.y - 75;
		}
	}
}