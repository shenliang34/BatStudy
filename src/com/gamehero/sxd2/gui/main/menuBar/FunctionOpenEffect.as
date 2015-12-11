package com.gamehero.sxd2.gui.main.menuBar
{
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.drama.DramaBlackScreen;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.GuideSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	import com.gamehero.sxd2.vo.FunctionVO;
	import com.gamehero.sxd2.world.views.GameWorld;
	import com.gamehero.sxd2.world.views.RoleLayer;
	import com.gamehero.sxd2.world.views.SceneViewBase;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * 功能开放动画
	 * @author xuwenyi
	 * @create 2015-11-10
	 **/
	public class FunctionOpenEffect
	{
		private static var _instance:FunctionOpenEffect;
		
		private var currentBtn:MenuButton;
		private var oldBtn:MenuButton;// menubar上正式的按钮
		
		// 功能开放相关特效
		private var light:MovieClip;
		private var mouse:MovieClip;
		
		private var isPlaying:Boolean;
		private var callback:Function;
		
		// 按钮上下抖动tween
		private var tween:TweenMax;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function FunctionOpenEffect()
		{
		}
		
		
		
		public static function get inst():FunctionOpenEffect
		{
			return _instance ||= new FunctionOpenEffect();
		}
		
		
		
		public function play(funcVO:FunctionVO , oldBtn:MenuButton , callback:Function = null):void
		{
			this.oldBtn = oldBtn;
			this.callback = callback;
			
			// 隐藏其他不相干元素
			this.setUIView(false);
			
			var stage:Stage = App.stage;
			stage.addEventListener(Event.RESIZE , resize);
			
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill(0,0);
			sp.graphics.drawRect(0,0,1920,1080);
			sp.graphics.endFill();
			sp.addEventListener(MouseEvent.CLICK , onClick);
			stage.addChild(sp);
			
			// 光芒特效
			light = new (GuideSkin.FUNCTION_OPEN_LIGHT)();
			sp.addChild(light);
			
			// 鼠标特效
			mouse = new (GuideSkin.FUNCTION_OPEN_MOUSE_EF)();
			sp.addChild(mouse);
			
			// 创建按钮
			currentBtn = this.createBtn(funcVO);
			sp.addChild(currentBtn);
			
			// 按钮上下抖动
			tween = TweenMax.to(currentBtn , 0.5 , {y:"-10" , repeat:-1 , yoyo:true});
			
			// 压屏
			DramaBlackScreen.inst.play1(1);
			
			this.resize();
		}
		
		
		
		
		
		private function createBtn(funcVO:FunctionVO):MenuButton
		{
			var btn:MenuButton;
			//判断是否使用默认按钮
			if(funcVO.buttonName)
			{
				var newBtn:DisplayObject;
				try
				{
					newBtn = new (MainSkin.getSwfClass(funcVO.buttonName));	
				}
				catch(e:Error)
				{
					newBtn = new (MainSkin.getSwfClass("HeroMenuBtn"));
				}
				btn = new MenuButton(newBtn as SimpleButton);
			}
			else
			{
				btn = new MenuButton(null);
			}
			btn.mouseEnabled = false;
			btn.mouseChildren = false;
			
			return btn;
		}
		
		
		
		
		
		private function onClick(e:MouseEvent):void
		{
			if(currentBtn != null)
			{
				var sp:Sprite = e.currentTarget as Sprite;
				var stage:Stage = App.stage;
				
				sp.removeEventListener(MouseEvent.CLICK , onClick);
				stage.removeEventListener(Event.RESIZE , resize);
				
				// 显示主UI
				this.setUIView(true);
				
				// 停止弹跳
				if(tween != null)
				{
					tween.kill();
					tween = null;
				}
				
				// 移除特效
				if(light != null)
				{
					light.stop();
					sp.removeChild(light);
				}
				if(mouse != null)
				{
					mouse.stop();
					sp.removeChild(mouse);
				}
				
				// 解除压屏
				DramaBlackScreen.inst.play2(1);
				
				// 计算目标点坐标
				var targetPoint:Point = new Point();
				if(oldBtn != null)
				{
					targetPoint = oldBtn.localToGlobal(new Point());
				}
				
				TweenLite.to(currentBtn , 0.5 , {x:targetPoint.x,y:targetPoint.y,onComplete:over});
				isPlaying = true;
				
				function over():void
				{	
					if(stage.contains(sp) == true)
					{
						stage.removeChild(sp);
					}
					Global.instance.removeChildren(sp);
					
					clear();
					
					if(callback != null)
					{
						callback();
					}
				}
			}
		}
		
		
		
		
		
		/**
		 * 自适应
		 * */
		private function resize(e:Event = null):void
		{
			if(currentBtn != null && isPlaying == false)
			{
				var stage:Stage = App.stage;
				var w:int = stage.stageWidth;
				var h:int = stage.stageHeight;
				
				currentBtn.x = (w - currentBtn.width) >> 1;
				currentBtn.y = (h - currentBtn.height) * 0.35;
				
				if(light != null)
				{
					light.x = w >> 1;
					light.y = currentBtn.y + 90;
				}
				
				if(mouse != null)
				{
					mouse.x = w >> 1;
					mouse.y = h * 0.75;
				}
			}
		}
		
		
		
		
		
		
		/**
		 * 设置UI是否显示
		 */
		public function setUIView(value:Boolean):void 
		{
			MainUI.inst.visible = value;
			
			var view:SceneViewBase = SXD2Main.inst.currentView;
			var world:GameWorld = view.gameWorld;
			var layer:RoleLayer = world.roleLayer;
			layer.setPlayerVisible(value);
		}
		
		
		
		
		
		
		public function clear():void
		{
			oldBtn = null;
			isPlaying = false;
			currentBtn = null;
			
			// 停止弹跳
			if(tween != null)
			{
				tween.kill();
				tween = null;
			}
			
			if(light != null)
			{
				light.stop();
			}
			if(mouse != null)
			{
				mouse.stop();
			}
		}
	}
}