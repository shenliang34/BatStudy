package com.gamehero.sxd2.login
{
	import flash.display.Sprite;
	
	
	/**
	 * 登录界面
	 * @author xuwenyi
	 * @create 2013-07-04
	 **/
	public class LoginView extends Sprite
	{
		// 创建人物UI
		private var createRoleView:CreateRoleView;
		
		
		
		
		
		/**
		 * 显示角色创建界面
		 * @param createOpt 创建界面选择
		 */
		public function showRoleView(sex:int):void
		{
			createRoleView = new CreateRoleView(sex);
			
			this.addChild(createRoleView);
		}
		
		
		
		
		
		/**
		 * 显示errcode
		 * */
		public function setErrorTip(key:int):void
		{
			createRoleView.setErrorTip(key);
		}
		
		
		
		
		
		public function clear():void
		{
			if(createRoleView)
			{
				createRoleView.clear();
				createRoleView = null;
			}
		}
	}
}