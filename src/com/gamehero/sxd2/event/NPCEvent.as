package com.gamehero.sxd2.event
{
	
	/**
	 *NPC对象 
	 * @author wulongbin
	 * 
	 */	
//	public class NPCEvent extends Event
	public class NPCEvent extends BaseEvent
	{
		// NPC寻路到达终点事件 
		public static const NPC_REACHPOINT:String="NPC_REACHPOINT";
		// 鼠标经过事件 
		public static const NPC_MOUSE_OVER:String="NPC_MOUSE_OVER";
		// 鼠标移出事件 
		public static const NPC_MOUSE_OUT:String="NPC_MOUSE_OUT";
//		// 冒泡对话结束 
//		public static const NPC_DIALOG_OVER:String="NPC_DIALOG_OVER";
		// NPC显示对象更新 
		public static const NPC_FIGURE_RENDER:String="NPC_FIGURE_RENDER";
		
		
		// NPC冒泡组件相关事件
		public static const SHOW_BUBBLE:String = "showBubble";
		public static const UPDATE_BUBBLE:String = "updabeBubble";
		public static const HIDE_BUBBLE:String = "hideBubble";
		
		
		// NPC任务相关
		public static const UPDATE_HEAD_ICON:String = "updateHeadIcon";
		// NPC状态ICON是否显示
		public static const SHOW_HEAD_ICON:String = "showHeadIcon";
		
		
		// NPC状态ICON相关
		public static const UPDATE_STAT_ICON:String = "updateStatIcon";
		
		
		// NPC巡逻相关
		public static const NPC_GUARDING:String = "NPCGuarding";

		public static const NPC_CHASING:String = "NPCChasing";
		public static const NPC_NEED_CHASE:String = "NPCNeedChase";
		
		
		
		public function NPCEvent(type:String, data:Object = null)
		{
			super(type, data);
		}
		
		
		
	}
}