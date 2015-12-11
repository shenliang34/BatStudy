package com.gamehero.sxd2.gui.main.menuBar
{
	import com.gamehero.sxd2.manager.FunctionManager;
	import com.gamehero.sxd2.vo.FunctionVO;
	
	import flash.events.MouseEvent;
	
	/**
	 * 右下菜单
	 * @author xuwenyi
	 * @create 2015-09-28
	 **/
	public class MainMenuBar1 extends MenuBar
	{
		public function MainMenuBar1()
		{
			super();
		}
		
		
		
		
		override public function init():void
		{
			var opened:Array = FunctionManager.inst.getOpendList(MenuBarDict.RIGHT_BOTTOM).toArray();
			for(var i:int=0;i<opened.length;i++)
			{
				var funcVO:FunctionVO = opened[i];
				
				var btn:MenuButton = this.createMenuBtn(funcVO);	
				var inMainUI:Boolean = funcVO.isMainUI == 1;
				if(inMainUI == true)
				{
					btn.addEventListener(MouseEvent.CLICK, onWindowButtonClick);
					this.addChild(btn);
					
					btns.push(btn);
				}
			}
			
			// 对btn位置排序
			btns.sortOn("position" , Array.NUMERIC);
			for(i=0;i<btns.length;i++)
			{
				btns[i].x = i * SPACE;
			}
			
			// 调整菜单整体宽度
			_width = btns.length * SPACE;
		}
	}
}