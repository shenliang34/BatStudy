package com.gamehero.sxd2.gui.roleSkill
{
	import com.gamehero.sxd2.event.WindowEvent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
	 * 主角技能Mediator
	 * @author zhangxueyou
	 * @create 2015-10-26
	 **/	
	public class RoleSkillMediator extends Mediator
	{
		[Inject]
		public var view:RoleSkillView;
		
		/**
		 *构造 
		 * 
		 */		
		public function RoleSkillMediator()
		{
			super();
		}
		
		/**
		 *初始化 
		 * 
		 */		
		override public function initialize():void
		{
			// TODO Auto Generated method stub
			super.initialize();
			
			this.addViewListener(WindowEvent.HIDE_FULLSCREEN_VIEW , close);
			
		}
		
		/**
		 *销毁
		 * 
		 */		
		override public function destroy():void
		{
			// TODO Auto Generated method stub
			super.destroy();
			
			this.removeViewListener(WindowEvent.HIDE_FULLSCREEN_VIEW , close);
		}
		
		/**
		 * 退出全屏
		 * */
		private function close(e:WindowEvent):void
		{
			this.dispatch(e);
		}
		
	}
}