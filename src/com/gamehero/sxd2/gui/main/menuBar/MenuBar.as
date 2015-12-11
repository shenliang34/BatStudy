package com.gamehero.sxd2.gui.main.menuBar
{
    import com.gamehero.sxd2.gui.main.MainUI;
    import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
    import com.gamehero.sxd2.manager.FunctionManager;
    import com.gamehero.sxd2.vo.FunctionVO;
    import com.greensock.TweenLite;
    
    import flash.display.DisplayObject;
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
	
	
	
	/**
	 * 按钮Menu
	 * @author xuwenyi
	 * @create-date 2015-9-24
	 */
	public class MenuBar extends Sprite
	{
		// 每个按钮的间隔
		protected static const SPACE:int = 60;
		
		// 整体宽度
		protected var _width:int;
		
		protected var currentMenuBtn:MenuButton;		//当前功能开放按钮
		
		// 功能按钮（MenuButton或者Sprite）
		protected var btns:Array = [];

		
		
		
		public function MenuBar()
		{
			super();
		}
		
		
		
		
		
		/**
		 * 初始化菜单按钮
		 * */
		public function init():void
		{
			
		}
		
		
		
		
		
		/**
		 * 注册新菜单按钮 
		 */		
		public function registerButton(funcVO:FunctionVO , callback:Function = null):void
		{
			// 创建menubtn
			currentMenuBtn = this.createMenuBtn(funcVO);
			
			// 是否显示在主UI上
			var inMainUI:Boolean = funcVO.isMainUI == 1;
			if(inMainUI == true)
			{
				currentMenuBtn.visible = false;
				currentMenuBtn.addEventListener(MouseEvent.CLICK, onWindowButtonClick);
				
				// 找到添加的位置
				var idx:int = btns.length;
				for(var i:int = 0; i < btns.length; i++)
				{
					if(funcVO.position <= btns[i].funcVO.position)
					{
						idx = i;
						break;
					}
				}
				
				btns.splice(idx , 0 , currentMenuBtn);
				currentMenuBtn.x = idx * SPACE;
				this.addChild(currentMenuBtn);
				
				// 整体移动菜单按钮
				this.playMenuMove(idx + 1);
				
				// 调整菜单整体宽度
				_width = btns.length * SPACE;
				MainUI.inst.resize();
				
				// 功能开放动画
				FunctionOpenEffect.inst.play(funcVO , currentMenuBtn , over);
				function over():void
				{
					currentMenuBtn.visible = true;
					currentMenuBtn.showFuncOpenLight();
					
					if(callback != null)
					{
						callback();
					}
				}
			}
		}
		
		
		
		
		
		
		/**
		 * 创建menuButton
		 * */
		protected function createMenuBtn(funcVO:FunctionVO):MenuButton
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
			btn.funcID = funcVO.id;
			btn.name = funcVO.id + "";
			btn.funcVO = funcVO;
			btn.position = funcVO.position;
			funcVO.menuBtn = btn;
			
			return btn;
		}
		
		
		
		
		
		
		/**
		 * 移出功能 
		 */		
		public function removeButton(funcVO:FunctionVO):void
		{
			var btn:MenuButton;
			for(var i:int=0;i<btns.length;i++) 
			{	
				btn = btns[i];
				if(btn.funcID == funcVO.id)
				{
					btn.removeEventListener(MouseEvent.CLICK, onWindowButtonClick);
					btn.clear();
					
					this.removeChild(btn);
					btns.splice(i , 1);
					
					break;
				}
			}
			// 重新定位坐标
			for(i=0;i<btns.length;i++) 
			{	
				btns[i].x = i * SPACE;
			}
		}
		
		
		
		
		
		
		
		
		/**
		 * 播放菜单移动动画 
		 * @param idx 从第几个开始移动
		 */		
		protected function playMenuMove(idx:int):void
		{
			var i:int;
			for(i = idx; i < btns.length; i++)
			{
				TweenLite.to(btns[i] , 1 , { x:i * SPACE });
			}
		}
		
		
		
		
		
		/**
		 * 点击功能按钮打开功能界面
		 */
		protected function onWindowButtonClick(e:MouseEvent):void 
		{	
			var btn:Object = e.currentTarget as Object;
			var funcVO:FunctionVO = FunctionManager.inst.getFunctionVO(int(btn.name));
			MainUI.inst.openWindow(funcVO.name);
		}
		
		
		
		
		
		override public function get width():Number
		{
			return _width;
		}
		
		
	}
}