package
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import alternativa.gui.base.GUIobject;
	
	
	/**
	 * 全局APP类
	 * @author xuwenyi
	 * @create 2013-07-29
	 * @modify by Trey 2014-6-17
	 **/
	public class App
	{
		public static var stage:Stage;
		
		public static var ui:GUIobject = new GUIobject();	// UI层（UI顶层）
		
		public static var hintUI:Sprite = new Sprite();		// hint层
		public static var topUI:GUIobject = new GUIobject();	// Top UI层
		public static var windowUI:GUIobject = new GUIobject();// Window层
		
		
		// MainUI资源
		public static var mainUIRes:MovieClip;
		// 配置表资源
		public static var settingsBinary:ByteArray;
		
		// 模态
		static private var _modalShape:Shape;
		static private var _modalSprite:Sprite;
		

		
		public function App()
		{
			
		}
		
		
		/**
		 * 获得游戏帧频 
		 * @return 
		 * 
		 */
		static public function get frameRate():Number {
			
			return App.stage.frameRate;
		}
		
		
		/**
		 * 窗口模态设置
		 * @param isShow
		 * @param target
		 * @param color
		 * @param alpha
		 * 
		 */
		static public function modal(isShow:Boolean = false, target:DisplayObject = null, color:uint = 0, alpha:Number = .7):void {
			
			if(_modalSprite == null) {
				
				_modalSprite = new Sprite();
				
				_modalShape = new Shape();
				_modalShape.graphics.clear();
				_modalShape.graphics.beginFill(color, alpha);
				_modalShape.graphics.drawRect(0, 0, 10, 10);
				_modalShape.graphics.endFill();
				_modalSprite.addChild(_modalShape);
			}
			
			if(isShow) {
				
				var parent:DisplayObjectContainer = (target is Stage) ? (target as DisplayObjectContainer) : target.parent;
				
				_modalShape.width = App.stage.stageWidth;
				_modalShape.height = App.stage.stageHeight;
				
				var point:Point = parent.localToGlobal(new Point(parent.x, parent.y));
				_modalSprite.x = -point.x;
				_modalSprite.y = -point.y;
				
				if(parent is Stage) {
					
					parent.addChild(_modalSprite);
				}
				else {
					
					parent.addChildAt(_modalSprite, parent.getChildIndex(target));
				}
				
				App.stage.addEventListener(Event.RESIZE, onResize);
			}
			else {
				
				if(_modalSprite && _modalSprite.parent && _modalSprite.parent.contains(_modalSprite)) {
					
					_modalSprite.parent.removeChild(_modalSprite);
				}
				
				App.stage.removeEventListener(Event.RESIZE, onResize);
			}
		}
		
		
		static private function onResize(evt:Event):void
		{
			if(_modalShape){
				
				_modalShape.width = App.stage.stageWidth;
				_modalShape.height = App.stage.stageHeight;
			}
		}
		
	}
}