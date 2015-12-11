package com.gamehero.sxd2.guide
{
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.util.FiltersUtil;
	import com.gamehero.sxd2.util.WasynManager;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.display.DisplayObjectContainer;

	
	/**
	 * 引导模板
	 * @author wulongbin
	 * 
	 */	
	public class GuideMask extends Sprite
	{
		private var _targetDisplay:DisplayObject;
		private var _toDisplay:DisplayObject;
		
		
		private var _maskColor:uint;
		private var _maskAlpha:Number;
		private var _callBack:Function;
		
		private var _isResetTargetMask:Boolean = false;
		private var _targetMaskOffX:Number;
		private var _targetMaskOffY:Number;
		private var _targetMaskWidth:Number;
		private var _targetMaskHeight:Number;
		
		private var _isResetToMask:Boolean = false;
		private var _toMaskOffX:Number;
		private var _toMaskOffY:Number;
		private var _toMaskWidth:Number;
		private var _toMaskHeight:Number;
		
		private var _mouseEventName:String;
		private var _isMode:Boolean = false;
		private var _arrow:GuideArrow;
		private var _targetRect:Rectangle = new Rectangle;
		
		
		public function GuideMask(color:uint,alpha:Number)
		{
			this._maskColor = color;
			this._maskAlpha = alpha;
			
			this.addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemoveFromStage);
		}
		
		private function onAddToStage(event:Event):void
		{
			App.stage.addEventListener(Event.RESIZE,onResize);
			
		}
		
		private function onRemoveFromStage(event:Event):void
		{
			App.stage.removeEventListener(Event.RESIZE,onResize);	
		}
		
		public function get targetDisplay():DisplayObject
		{
			return _targetDisplay;
		}

		/**
		 * 设置点击目标 
		 * @param target
		 * @param callBack
		 * 
		 */		
		public function setTargetDisplay(target:DisplayObject, des:String , 
										 direction:int , callBack:Function , isMode:Boolean = true, toDisplay:DisplayObject = null, 
										 mouseEventName:String = MouseEvent.CLICK, guideParent:DisplayObjectContainer = null):void {
			
			if(_targetDisplay)
			{
				_targetDisplay.removeEventListener(_mouseEventName , onClick);
				FiltersUtil.stopGlowFilterMovie(_targetDisplay);
			}
			
			_isResetTargetMask = false;
			_isResetToMask = false;
			
			_toDisplay = toDisplay;
			_targetDisplay = target;
			_callBack = callBack;
			_isMode = isMode;
			_mouseEventName = mouseEventName;
			
			if(_targetDisplay)
			{
				if(_arrow == null)
				{
					_arrow = new GuideArrow;
					addChild(_arrow);
				}
				_arrow.setLabel( des, direction);
				
				if(guideParent == null) {
					
					App.stage.addChild(this);
				}
				else {
					
					guideParent.addChild(this);
				}
				
				if(_callBack != null)
				{
					_targetDisplay.addEventListener(_mouseEventName , onClick);
				}
				
				onResize();
				WasynManager.instance.addFuncByFrame(onResize , 3);
				FiltersUtil.playGlowFilterMovie(_targetDisplay, 0xFFFFCC);
			}
			else
			{
				stopResize();
				if(parent)
				{
//					App.stage.removeChild(this);
					parent.removeChild(this);
				}
			}
		}
		
		public function stopResize():void
		{
			WasynManager.instance.removeFuncByFrame(onResize);
		}
		
		
		private function onResize(e:Event=null):void
		{
			if(visible && _targetDisplay)
			{
				_targetRect = _targetDisplay.getBounds(App.stage);
				
				if(_isResetTargetMask)
				{
					_targetRect.x += _targetMaskOffX;
					_targetRect.y += _targetMaskOffY;
					_targetRect.width = _targetMaskWidth;
					_targetRect.height = _targetMaskHeight;
				}
				
				switch(_arrow.direction)
				{
					case Guide.Direct_Down:
						_arrow.x = (_targetRect.width - _arrow.width >> 1) + _targetRect.x;
						_arrow.y = _targetRect.y - _arrow.height - 50;
						
						break;
					
					case Guide.Direct_Up:
						_arrow.x = (_targetRect.width - _arrow.width >> 1) + _targetRect.x;
						_arrow.y = _targetRect.bottom  + 50;
						break;
					
					case Guide.Direct_Left:
						_arrow.y = (_targetRect.height - _arrow.height >> 1) + _targetRect.y;
						_arrow.x = _targetRect.right  + 50;
						break;
					
					case Guide.Direct_Right:
						_arrow.y = (_targetRect.height - _arrow.height >> 1) + _targetRect.y;
						_arrow.x = _targetRect.x - _arrow.width - 50;
						break;
				}
			}
			
			updateMaskBG();
		}
		
		
		/**
		 * 更新蒙版 
		 * 
		 */		
		private function updateMaskBG():void
		{
			this.graphics.clear();
			if(_isMode)
			{
				this.graphics.beginFill(_maskColor, _maskAlpha);
				this.graphics.drawRect(0, 0, App.stage.stageWidth, App.stage.stageHeight);
				this.graphics.drawRect(_targetRect.x, _targetRect.y, _targetRect.width, _targetRect.height);
				
				if(_toDisplay)
				{
					var toRect:Rectangle = _toDisplay.getBounds(App.stage);
					if(_isResetToMask)
					{
						toRect.x += _toMaskOffX;
						toRect.y += _toMaskOffY;
						toRect.width = _toMaskWidth;
						toRect.height = _toMaskHeight;
					}
					
					this.graphics.drawRect(toRect.x, toRect.y, toRect.width, toRect.height);
				}
			}
		}
		
		/**
		 *使用代理点击目标 
		 * @param w
		 * @param h
		 * 
		 */		
		public function resetTargetMask(w:Number, h:Number , offX:Number = 0, offY:Number = 0):void
		{
			_isResetTargetMask = true;
			_targetMaskOffX = offX;
			_targetMaskOffY = offY;
			_targetMaskWidth = w;
			_targetMaskHeight = h;
			onResize();
		}
		
		/**
		 *使用代理点击目标 
		 * @param w
		 * @param h
		 * 
		 */		
		public function resetToDisplayMask(w:Number, h:Number , offX:Number = 0, offY:Number = 0):void
		{
			_isResetToMask = true;
			_toMaskOffX = offX;
			_toMaskOffY = offY;
			_toMaskWidth = w;
			_toMaskHeight = h;
			onResize();
		}
		
		
		
		/**
		 * 点击后触发
		 * */
		protected function onClick(e:Event):void
		{
			e.currentTarget.removeEventListener(_mouseEventName , onClick);

			// 回调
			if(_callBack)
			{
				_callBack();
			}
		}

		
		/**
		 *蒙版颜色 
		 * @return 
		 * 
		 */		
		public function get maskColor():uint
		{
			return _maskColor;
		}

		public function set maskColor(value:uint):void
		{
			_maskColor = value;
			updateMaskBG();
		}

		
		/**
		 *蒙版alpha 
		 * @return 
		 * 
		 */		
		public function get maskAlpha():Number
		{
			return _maskAlpha;
		}

		public function set maskAlpha(value:Number):void
		{
			_maskAlpha = value;
			updateMaskBG();
		}

		
	}
}