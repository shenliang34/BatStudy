package com.gamehero.sxd2.drama.cmds.effect
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.drama.base.BaseCmd;
	import com.gamehero.sxd2.world.views.GameWorld;
	import com.gamehero.sxd2.world.views.SceneViewBase;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	
	import alternativa.gui.base.ActiveObject;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	
	/**
	 * 可点击的场景内特效
	 * @author xuwenyi
	 * @create 2015-11-11
	 **/
	public class ClickEffectCmd extends BaseCmd
	{
		private var mc:MovieClip;
		
		private var x:Number;
		private var y:Number;
		private var url:String;
		private var clickDelay:int;
		private var test:Boolean;
		
		private var clickPanel:ActiveObject;
		private var rect:Rectangle;
		
		
		
		public function ClickEffectCmd()
		{
			super();
		}
		
		
		
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			x = xml.@x;
			y = xml.@y;
			url = GameConfig.DRAMA_EFFECT_URL + xml.@url + ".swf";
			clickDelay = xml.@clickDelay;
			test = xml.@test == "1" ? true : false;
			
			// 鼠标响应区域
			var rectStr:String = xml.@rect;
			if(rectStr != "")
			{
				var arr:Array = rectStr.split("^");
				rect = new Rectangle(arr[0] , arr[1] , arr[2] , arr[3]);
			}
		}
		
		
		
		
		
		override public function triggerCallBack(callBack:Function=null):void
		{
			super.triggerCallBack(callBack);
			
			// 开始加载动画资源
			var loader:BulkLoaderSingleton = BulkLoaderSingleton.instance;
			loader.addWithListener(url , null , onLoad);
		}
		
		
		
		
		
		private function onLoad(e:Event):void
		{
			var imageItem:ImageItem = e.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE , onLoad);
			
			var cls:Class = imageItem.getDefinitionByName("EFFECT") as Class;
			if(cls)
			{
				var view:SceneViewBase = SXD2Main.inst.currentView;
				var world:GameWorld = view.gameWorld;
				var pos:Point = world.getStagePoint(x , y);
				
				mc = new cls() as MovieClip;
				mc.x = pos.x;
				mc.y = pos.y;
				view.addChild(mc);
				
				mc.gotoAndPlay(0);
				
				if(clickDelay > 0)
				{
					setTimeout(addEvent , clickDelay);
				}
				else
				{
					addEvent();
				}
				
				function addEvent():void
				{
					if(rect != null)
					{
						clickPanel = new ActiveObject();
						clickPanel.cursorActive = true;
						clickPanel.graphics.beginFill(0 , test == true ? 0.5 : 0);
						clickPanel.graphics.drawRect(0 , 0 , rect.width , rect.height);
						clickPanel.graphics.endFill();
						
						clickPanel.x = rect.x;
						clickPanel.y = rect.y;
						mc.addChild(clickPanel);
						
						clickPanel.addEventListener(MouseEvent.CLICK , over);
					}
					else
					{
						mc.addEventListener(MouseEvent.CLICK , over);
					}
				}
			}
		}
		
		
		
		
		private function over(e:MouseEvent):void
		{
			mc.gotoAndStop(0);
			mc.removeEventListener(MouseEvent.CLICK , over);
			SXD2Main.inst.currentView.removeChild(mc);
			
			if(clickPanel != null)
			{
				if(mc.contains(clickPanel) == true)
				{
					mc.removeChild(clickPanel);
				}
				
				clickPanel.removeEventListener(MouseEvent.CLICK , over);
				clickPanel = null;
			}
			
			mc = null;
			
			complete();
		}
		
	}
}