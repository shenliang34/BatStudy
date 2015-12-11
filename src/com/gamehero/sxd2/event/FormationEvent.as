package com.gamehero.sxd2.event
{
	
	import flash.events.Event;

	/**
	 * @author Wbin
	 * 创建时间：2015-8-25 下午4:54:30
	 * 
	 */
	public class FormationEvent extends BaseEvent
	{
		/**请求布阵信息0  ，  切换阵型1-9*/
		public static const MSGID_FORMATION_INFO:String = "MSGID_FORMATION_INFO";
		/**伙伴上下阵通讯*/
		public static const MSGID_FORMATION_PUT_HERO:String = "MSGID_FORMATION_PUT_HERO";
		
		/**请求奇术信息*/
		public static const MSGID_MAGIC_INFO:String = "MSGID_MAGIC_INFO";
		/**奇术升级*/
		public static const MSGID_LEVELUP_MAGIC:String = "MSGID_LEVELUP_MAGIC";
		
		/**伙伴交换位置*/
		public static const EXCHANGE_HERO:String = "ExchangeHero";
		/**双击伙伴背包中的伙伴上阵*/
		public static const DOUBLE_CLICK_HERO:String = "DOUBLE_CLICK_HERO";
		/**控制站位拖拽格子显示与否*/
		public static const DRAG_CELL_VISIBLE:String = "DRAG_CELL_VISIBLE";
		/**控制羁绊拖拽格子显示与否*/
		public static const FETTER_DRAG_CELL_VISIBLE:String = "FETTER_DRAG_CELL_VISIBLE";
		/**控制跟随鼠标的人形显示*/
		public static const DRAG_MOUSE_FIGURE_VISIBLE:String = "DRAG_MOUSE_FIGURE_VISIBLE";
		
		/**天缘信息展示重排*/
		public static const FETTER_INFO:String = "FETTER_INFO";
		/**天缘信息展示重排事件1*/
		public static const FETTER_INFO_1:String = "FETTER_INFO_1";
		
		/**上阵与助阵伙伴buff*/
		public static const INBATTLE_2_HELPBATTLE:String = "INBATTLE_2_HELPBATTLE"
		/**布阵、天缘提示*/
		public static const FORMATION_REMINDER:String = "FORMATION_REMINDER";
		
		/**伙伴换位模型假放*/
		public static const FIGURE_DRAW:String = "FIGURE_DRAW";
		
		public function FormationEvent(type:String, data:Object = null)
		{
			super(type , data);
		}
		
		override public function clone():Event
		{
			return new FormationEvent(type , data);
		}
	}
}