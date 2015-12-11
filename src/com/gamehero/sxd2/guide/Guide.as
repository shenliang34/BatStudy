package com.gamehero.sxd2.guide
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.event.GuideEvent;
	import com.gamehero.sxd2.manager.GuideManager;
	import com.gamehero.sxd2.services.GameService;
	import com.gamehero.sxd2.services.Interface;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;

	
	/**
	 * 新手引导基类 
	 * @author wulongbin
	 * 
	 */	
	public class Guide
	{
		public static const Type_Null:String = "null";
		public static const Type_Click:String = "click";
		public static const Type_Drag:String = "drag";
		
		public static const Direct_Up:uint = 0;
		public static const Direct_Left:uint = 1;
		public static const Direct_Right:uint = 2;
		public static const Direct_Down:uint = 3;
		
		// 正在执行的引导个数
		private static var _playGuideNum:int = 0;
		// 正在执行的引导对象数组
		private static var _currentGuides:Vector.<Guide> = new Vector.<Guide>;
		
		private var _clickCallBack:Function;
		private var _type:String;
		
		protected var mask:GuideMask;
		protected var guideVO:GuideVO
		protected var completecallBack:Function;
		protected var isForceGuide:Boolean = true;// 是否强制引导
		
		// 是否已完成引导
		protected var hasComplete:Boolean = false;
		
		
		
		/**
		 * 构造函数
		 * */
		public function Guide()
		{
			mask = new GuideMask(0,0);
		}
		
		
		
		
		
		public function playGuide(vo:GuideVO, callBack:Function = null, param:Object = null):void
		{
			guideVO = vo;
			guideVO.isPlay = true;
			
			completecallBack = callBack || function():void{};
			
			// 引导个数+1
			if(isForceGuide == true)
			{
				playGuideNum++;
			}
			
			// 监听结束新手引导的事件
			GuideManager.instance.addEventListener(GuideEvent.GUIDE_COMPLETE , guideCompleteHandler);
		}
		
		
		
		
		/**
		 * 新手引导提前结束
		 * */
		protected function guideCompleteHandler(e:GuideEvent = null):void
		{
			GuideManager.instance.removeEventListener(GuideEvent.GUIDE_COMPLETE , guideCompleteHandler);
			
			// 完成引导
			if(hasComplete == false)
			{
				this.complete();
				this.removeGuide();
			}
		}
		
		
		
		
		/**
		 * 完成引导时调度 
		 */		
		protected function complete():void
		{
			// 引导个数-1
			if(isForceGuide == true)
			{
				playGuideNum--;
			}
				
			// 发送请求
			var param:GS_GuidId_Req_Pro = new GS_GuidId_Req_Pro;
			param.guidId = guideInfo.id;
			GameService.instance.send(Interface.GS_GuidComplete, param);
			
			// 完成回调
			if(completecallBack)
			{
				completecallBack();
				completecallBack = null;
			}
			
			// 已完成标志
			hasComplete = true;
		}
		
		
		
		
		/**
		 *弹出点击引导
		 * @param clickTarget 点击目标
		 * @param isMode 
		 * @param clickCallBack
		 */		
		public function popupClickGuide(target:DisplayObject , isMode:Boolean = true, des:String="", 
										direction:uint = 0, clickCallBack:Function = null, 
										eventName:String = MouseEvent.CLICK, guideParent:DisplayObjectContainer = null):void {
			
			this.removeGuide();
			
			_type = Type_Click;
			
			_clickCallBack = clickCallBack;
			
			_currentGuides.push(this);
//			mask.setTargetDisplay(target, des, direction, onClick, isMode, null, eventName);
			mask.setTargetDisplay(target, des, direction, onClick, isMode, null, eventName, guideParent);
		}
		
		
		
		
		/**
		 *弹出拖拽引导 
		 * @param from
		 * @param to
		 * @param isMode
		 * @param des
		 * @param direction
		 * @param clickCallBack
		 * 
		 */		
		public function popupDragGuide(from:DisplayObject, to:DisplayObject, isMode:Boolean = true, des:String="" , direction:uint = 0):void
		{
			this.removeGuide();
			
			_type = Type_Drag;
			
			mask.setTargetDisplay(from, des, direction, null, isMode, to);
			_currentGuides.push(this);
		}
		
		
		
		
		/**
		 *清除当前引导箭头 
		 */		
		public static function clearGuide():void
		{
			for each(var guide:Guide in _currentGuides)
			{
				guide.removeGuide();
			}
		}
		
		
		
		
		
		/**
		 *移除引导 
		 */		
		public function removeGuide():void
		{
			if(_type == Type_Null)
			{
				return;
			}
			
			var idx:int = _currentGuides.indexOf(this);
			// 若该引导存在
			if(idx >= 0)
			{
				_currentGuides.splice(idx,1);
				switch(_type)
				{
					case Type_Click:
						mask.setTargetDisplay(null, "" , 0 ,null);
						_clickCallBack = null;
						break;
					
					case Type_Drag:
						mask.setTargetDisplay(null, "" , 0 ,null);
				}
			}
			_type = Type_Null;
		}
		
		
		
		
		
		private function onClick():void
		{
			var tempCallBack:Function = _clickCallBack;
			
			// 移除引导
			this.removeGuide();
			// 回调
			if(tempCallBack)
			{
				tempCallBack();
			}
			
		}
		
		public static function get isPlayGuide():Boolean
		{
			return _playGuideNum > 0;
		}
		
		
		private static function get playGuideNum():int
		{
			return _playGuideNum;
		}
		

		private static function set playGuideNum(value:int):void
		{
			_playGuideNum = value;
			
			// 新手引导中，则停止自动任务
			if(isPlayGuide) {
				
				GameData.inst.isAutoMove = false;
			}
		}

	}
}