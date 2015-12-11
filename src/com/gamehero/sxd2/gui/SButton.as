package com.gamehero.sxd2.gui
{
		import flash.display.MovieClip;
		import flash.display.SimpleButton;
		import flash.display.Sprite;
		import flash.events.MouseEvent;
		
		import alternativa.gui.base.ActiveObject;
		import alternativa.gui.mouse.CursorManager;
		
		
		
		/**
		 * 用于包装simplebutton
		 * */
		public class SButton extends Sprite
		{
			public static const Status_Up:uint = 0;
			public static const Status_Down:uint = 1;
			public static const Status_Over:uint = 2;
			public static const Status_Disable:uint = 3;
			
			
			protected var _statuses:Vector.<Object>;
			private var _status:int = -1;
			private var _simpleButton:SimpleButton;

			private var hitAreaSprite:ActiveObject;
			public var isResponse:Boolean;
			
			
			
			/**
			 * 构造函数
			 * */
			public function SButton(btn:SimpleButton)
			{
				_simpleButton = btn;
				
				if(_simpleButton)
				{
					//确保状态全部不为空
					_statuses = new Vector.<Object>(4);
					_statuses[Status_Up]	= _simpleButton.upState;
					_statuses[Status_Over] = _simpleButton.overState;
					_statuses[Status_Down] = _simpleButton.downState;
					_statuses[Status_Disable] = _simpleButton.upState;
					
					this.addChild(_simpleButton.upState);
					this.addChild(_simpleButton.overState);
					this.addChild(_simpleButton.downState);
					
					//默认全部不显示
					var len:int = _statuses.length;
					for(var i:int = 0;i <len;i++)
					{
						_statuses[i].visible = false;
					}
					status = Status_Up;
					
					// 点击区域 , hint区域
					hitAreaSprite = new ActiveObject();
					hitAreaSprite.graphics.beginFill(0,0);
					hitAreaSprite.graphics.drawRect(0, 0, width , height);
					hitAreaSprite.graphics.endFill();
					hitAreaSprite.cursorActive = true;
					addChild(hitAreaSprite);
					
					hitAreaSprite.addEventListener(MouseEvent.MOUSE_DOWN, downHd);
					hitAreaSprite.addEventListener(MouseEvent.ROLL_OUT, outHd);
					hitAreaSprite.addEventListener(MouseEvent.ROLL_OVER, overHd);
				}
				else
				{
					this.graphics.beginFill(0xff0000);
					this.graphics.drawRect(0,0,50,30);
					this.graphics.endFill();
				}
			}
			
			
			
			
			public function set hint(value:String):void 
			{
				if(hitAreaSprite == null) 
				{	
					hitAreaSprite = new ActiveObject();
					hitAreaSprite.graphics.beginFill(0,0);
					hitAreaSprite.graphics.drawRect(0, 0, width , height);
					addChild(hitAreaSprite);
					
					hitAreaSprite.cursorType = CursorManager.HAND;
				}
				
				hitAreaSprite.hint = value;
			}
			
			
			
			private function overHd(event:MouseEvent):void
			{
				if(_status != Status_Down)
				{
					status = Status_Over;
					
					// 悬浮音效
					//SoundManager.instance.play(SoundConfig.BTN_MOUSE_OVER);
					
					// 更改鼠标手型
					CursorManager.cursorType = CursorManager.HAND;
				}
			}
			
			
			
			
			private function outHd(event:MouseEvent):void
			{
				if(_status != Status_Down)
				{
					status = Status_Up;
					
					// 更改鼠标手型
					CursorManager.reset();
				}
			}
			
			
			
			
			private function downHd(event:MouseEvent):void
			{
				status = Status_Down;
				
				this.addEventListener(MouseEvent.MOUSE_UP,inUpHd);
				App.stage.addEventListener(MouseEvent.MOUSE_UP,outUpHd);
				
				// 点击音效
				//SoundManager.instance.play(SoundConfig.BTN_MOUSE_CLICK);
			}
			
			
			
			private function inUpHd(event:MouseEvent):void
			{
				status = Status_Over;
				
				this.removeEventListener(MouseEvent.MOUSE_UP,inUpHd);
				App.stage.removeEventListener(MouseEvent.MOUSE_UP,outUpHd);
			}
			
			
			
			private function outUpHd(event:MouseEvent):void
			{
				status = Status_Up;
				
				this.removeEventListener(MouseEvent.MOUSE_UP,inUpHd);
				App.stage.removeEventListener(MouseEvent.MOUSE_UP,outUpHd);
			}
			
			
			
			public function get status():int
			{
				return _status;
			}
			
			
			
			public function set status(value:int):void
			{
				if(isResponse) return;
				if(_status >= 0 && _status < 4)
				{
					_statuses[_status].visible = false;
				}
				
				_status = value;
				
				if(value >= 0 && value < 4)
				{
					_statuses[_status].visible = true;
					if(_statuses[_status] is MovieClip) {
						
						(_statuses[_status] as MovieClip).gotoAndPlay(1);
					}
				}
			}
			
			
			
			public function set enabledUI(value:Boolean):void
			{
				this.mouseChildren = value;
				this.mouseEnabled = value;
				
				if(value)
				{
					if(this.status == Status_Disable)
						this.status = Status_Up;
					this.filters = null;
				}
				else
				{
					if(this.status != Status_Disable)
						this.status = Status_Disable;
					//this.filters = FiltersUtil.BW_Fiter;
				}
			}
			
			
			
			
			
			public function clear():void
			{
				hitAreaSprite.removeEventListener(MouseEvent.MOUSE_DOWN, downHd);
				hitAreaSprite.removeEventListener(MouseEvent.ROLL_OUT, outHd);
				hitAreaSprite.removeEventListener(MouseEvent.ROLL_OVER, overHd);
			}
			
		}
	}

