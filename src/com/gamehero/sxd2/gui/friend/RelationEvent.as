package com.gamehero.sxd2.gui.friend {
	
	import com.gamehero.sxd2.event.BaseEvent;
	
	import flash.events.Event;
	
	/**
	 * 关系相关事件
	 * @author Trey
	 * @create 2013-10-24
	 **/
	public class RelationEvent extends BaseEvent {
		
		static public const UPDATE_RELATION_LIST_E:String = "updateRelationList";			// 更新
		static public const UPDATE_RELATION_FOCUS:String="updateRelationFocus";//好友关注提示

		static public const GET_RELATION_LIST_E:String = "getRelationList";			// 获得关系列表
		static public const GET_RELATION_LIST_OK_E:String = "getRelationListOK";	// 获得关系列表返回
		static public const GET_RELATION_INFO_OK_E:String = "getRelationInfoOK";	// 获得关系信息返回
		
		static public const RELATION_CHANGE_OPERATOR:String="relationChangeOperator";
		static public const RELATION_CHANGE_OPERATOR_OK:String="relationChangeOperatorOK";
		
		public var operatorType:String;
		/**
		 * 构造函数
		 * 
		 */
		public function RelationEvent(type:String, data:Object = null) {
			
			super(type, data);
		}
		
		
		override public function clone():Event {
			
			var e:RelationEvent= new RelationEvent(type , data);
			e.operatorType=operatorType;
			return e;
		}
	}
}