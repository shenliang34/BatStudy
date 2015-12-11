package com.gamehero.sxd2.gui.hurdleGuide.components
{
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.core.components.McActiveObject;
	import com.gamehero.sxd2.gui.hurdleGuide.model.HurdleGuideModel;
	import com.gamehero.sxd2.gui.hurdleGuide.model.vo.HurdleVo;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.manager.HurdlesManager;
	import com.gamehero.sxd2.pro.PRO_Instance;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	import alternativa.gui.mouse.CursorManager;
	
	/**
	 * 节点控制
	 * @author weiyanyu
	 * 创建时间：2015-8-30 下午8:39:23
	 * 
	 */
	public class HurdleGuideNode
	{
		
		/**
		 * 未开启 
		 */		
		public static const NO_OPEN:int = 1;
		/**
		 * 开启 
		 */		
		public static const OPEN:int = 2;
		/**
		 * 通关 
		 */		
		public static const OVERRED:int = 3;
		/**
		 * 隐藏掉 
		 */		
		public static const HIDE:int = 4;
		
		
		/**
		 * 节点的 数据
		 */		
		private var _data:HurdleVo;
		/**
		 * 绑定的节点mc 
		 */		
		private var _nodeMc:MovieClip;
		private var _status:int = 0;
		
		private var _overColor:ColorTransform;
		private var _outColor:ColorTransform;
		
		
		
		private var _hitArea:McActiveObject;
		
		private var _hurdleTips:HurdleGuideTipsSprite;
		
		/**
		 * 当前状态 1 未开启 2已开启3已经通关 
		 */
		public function get status():int
		{
			return _status;
		}
		/**
		 * 请求进入副本 
		 */
		public var enterInstance:Function;
		public function HurdleGuideNode()
		{
			super();
		}
		/**
		 * 设置节点样式 
		 * 
		 */		
		public function setNode(mc:MovieClip):void
		{
			_nodeMc = mc;
			mc.gotoAndStop(1);//默认停止在第一帧
			
			_overColor = new ColorTransform(1,1,1,1,100,100,100,0);
			_outColor = new ColorTransform(1,1,1,1,0,0,0,0);
			
			_hitArea = new McActiveObject(McActiveObject.HurdleGuideNode);
			var body:MovieClip = _nodeMc.getChildByName("body") as MovieClip;
			
			
			_hitArea.x = mc.x + body.x;
			_hitArea.y = mc.y + body.y;
			_hitArea.setArea(body.width , body.height);
			mc.parent.addChild(_hitArea);
			
			_hitArea.addEventListener(MouseEvent.MOUSE_UP, clickHd);
			_hitArea.addEventListener(MouseEvent.ROLL_OUT, outHd);
			_hitArea.addEventListener(MouseEvent.ROLL_OVER, overHd);
			
		}
		
		public function addTips():void
		{
			if(_hurdleTips == null)
			{
				_hurdleTips = new HurdleGuideTipsSprite();
			}
			_nodeMc.parent.addChild(_hurdleTips);
			_hurdleTips.x = _nodeMc.x + (_nodeMc.width >> 1);
			_hurdleTips.y = _nodeMc.y - (_nodeMc.height >> 1);
			
		}
		
		private function clearTips():void
		{
			if(_hurdleTips && _hurdleTips.parent)
			{
				_hurdleTips.parent.removeChild(_hurdleTips);
				_hurdleTips = null;
			}
		}
		
		protected function overHd(event:MouseEvent):void
		{
			if(_status == OPEN || _status == OVERRED)
			{
				_nodeMc.getChildByName("body").transform.colorTransform = _overColor;
				CursorManager.cursorType = CursorManager.SWORD;
			}
		}
		
		protected function outHd(event:MouseEvent):void
		{
			if(_status == OPEN || _status == OVERRED)
			{
				_nodeMc.getChildByName("body").transform.colorTransform = _outColor;
				CursorManager.cursorType = CursorManager.ARROW;
			}
		}
		
		protected function clickHd(event:MouseEvent):void
		{
			if(_status == OVERRED)
			{
				MainUI.inst.openWindow(WindowEvent.HURDLE_CLEAROUT_WINDOW,_data);
			}
			else if(_status == OPEN)
			{
				enterInstance(_data.id);
			}
			
				
		}
		/**
		 * 设置剧情副本数据 
		 */		
		public function setNodeData(id:int):void
		{
			_data = HurdlesManager.getInstance().getHurdleById(id);
			_hitArea.data = _data;
		}
		/**
		 * 服务器数据来通知状态 
		 * @param pro
		 * 
		 */		
		public function updata(pro:PRO_Instance):void
		{
			if(pro && pro.instanceId && pro.instanceId.length > 0)
			{
				
				var instance:PRO_Instance;
				var isShow:Boolean = true;//是否显示
				for each(var id:int in pro.instanceId)
				{
					instance = HurdleGuideModel.inst.getNodeData(id);
					if(instance.status == NO_OPEN)
					{
						isShow = false;
						break;
					}
				}
				if(isShow)
				{
					setStatus(pro);
				}
				else
				{
					_nodeMc.visible = false;
					_status = HIDE;
				}
			}
			else
			{
				setStatus(pro);
			}
			_hitArea.pro = pro;
			_hitArea.visible = _nodeMc.visible;
			outHd(null);
		}
		/**
		 * 显示状态下设置mc 
		 * @param pro
		 * 
		 */		
		private function setStatus(pro:PRO_Instance):void
		{
			_status = pro.status;
			_nodeMc.visible = true;
			_nodeMc.gotoAndStop(_status);
			_hitArea.hint = pro.id + "";
		}
		
		
		
		
		
		public function clear():void
		{
			clearTips();
			_status = 0;
			if(_hitArea && _hitArea.parent)
			{
				_hitArea.parent.removeChild(_hitArea);
			}
			_nodeMc.gotoAndStop(1);
			_nodeMc = null;
			_hitArea.removeEventListener(MouseEvent.MOUSE_UP, clickHd);
			_hitArea.removeEventListener(MouseEvent.ROLL_OUT, outHd);
			_hitArea.removeEventListener(MouseEvent.ROLL_OVER, overHd);
			enterInstance = null;
			
			CursorManager.cursorType = CursorManager.ARROW;
		}
	}
}