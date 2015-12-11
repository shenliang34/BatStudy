package com.gamehero.sxd2.gui.main.menuBar {
	
    import com.gamehero.sxd2.data.GameDictionary;
    import com.gamehero.sxd2.gui.SButton;
    import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
    import com.gamehero.sxd2.gui.theme.ifstheme.skin.GuideSkin;
    import com.gamehero.sxd2.vo.FunctionVO;
    
    import flash.display.Bitmap;
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    import alternativa.gui.enum.Align;
    
    import bowser.utils.MovieClipPlayer;
    import bowser.utils.bitmap.XBitmap;
	
	
	/**
	 * 主UI功能按钮（含有数字） 
	 * @author Trey 
	 */
	public class MenuButton extends SButton
	{	
		// 功能id
		public var funcID:uint;
		public var funcVO:FunctionVO;
		public var position:int;
		
		private var _funcNumContaner:Sprite;
		private var _funcNewContaner:Bitmap;
		private var _funcFullContaner:Bitmap;
		private var _funcNumLabel:Label;
		
		// 功能提示效果
		private var funcHintMovie:XBitmap;
		
		private var m_num:int;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function MenuButton(btn:SimpleButton)
		{	
			super(btn);
			
			// TRICKY：屏蔽转圈效果对按钮事件的影响
			this.mouseEnabled = false;
			
			this.addEventListener(Event.ADDED_TO_STAGE , onAdd);
			this.addEventListener(Event.REMOVED_FROM_STAGE , onRemove);
		}
		
		
		
		
		private function onAdd(e:Event):void
		{
			
		}
		
		
		
		
		
		private function onRemove(e:Event):void
		{
			this.clear();
		}
		
		
		
		
		
		/**
		 * 更新功能点数 
		 */
		public function updateFuncNum(value:int):void 
		{	
			m_num = value;
			
			// 创建_funcNumContaner
			if(!_funcNumContaner && value > 0) {
				
				_funcNumContaner = new Sprite();
				
				/*var bitmap:Bitmap = new Bitmap(MainSkin.funcNumIcon);
				_funcNumContaner.addChild(bitmap);*/
				
				_funcNumLabel = new Label;
				_funcNumLabel.width = 16
				_funcNumLabel.align = Align.CENTER;
				_funcNumLabel.color = GameDictionary.YELLOW;
				_funcNumLabel.x = 5;
				_funcNumLabel.y = 2;
				
				_funcNumContaner.x = (this.width >> 1) + 5;
				_funcNumContaner.addChild(_funcNumLabel);
				
				_funcNumContaner.mouseChildren = _funcNumContaner.mouseEnabled = _funcNumContaner.tabChildren = false;
			}
			
			if(value > 0)
			{	
				value = value > 99 ? 99 : value;
				_funcNumLabel.text = String(value);
				addChild(_funcNumContaner);
			}
			else 
			{	
				if(_funcNumContaner && contains(_funcNumContaner)) 
				{	
					removeChild(_funcNumContaner);
				}
			}
				
		}
		
		
		
		
		
		
		/**
		 * 功能提示效果(转圈)
		 */
		public function showFuncHint():void
		{
			
		}
		
		
		
		
		
		
		
		/**
		 * 显示功能开放发光特效
		 */
		public function showFuncOpenLight():void
		{
			var light:MovieClip = new GuideSkin.FUNCTION_OPEN_BTN_EF();
			var mp:MovieClipPlayer = new MovieClipPlayer();
			mp.play(light , light.totalFrames/24 , 0 , light.totalFrames);
			mp.addEventListener(Event.COMPLETE , over);
			
			light.x = 45;
			light.y = 48;
			this.addChild(light);
			
			function over(e:Event):void
			{
				mp.removeEventListener(Event.COMPLETE , over);
				if(contains(light) == true)
				{
					removeChild(light);
				}
			}
		}
		
		
		
		
		
		
		
		/**
		 * 点击后移除功能提示效果
		 */
		public function onMenuButtonClick(e:MouseEvent = null):void
		{	
			this.clear();
		}
		
		
		
		
		
		
		
		
		public function get num():int
		{
			return m_num;
		}

		
		
		
		
		
		/**
		 * 清空
		 * */
		override public function clear():void
		{
			funcID = 0;
			
			if(funcVO)
			{
				funcVO.menuBtn = null;
			}
			funcVO = null;
			
			super.clear();
		}
	}
}