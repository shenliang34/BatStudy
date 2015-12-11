package com.gamehero.sxd2.vo
{
	public class TaskInfoVo
	{
		public var status:int //任务当前状态
		public var taskId:int;//任务ID 
		public var title:String;//任务名称 
		public var name:String;// 任务名称简称
		public var type:int;//任务大类 
		public var pre_taskid:int;//前置任务ID
		public var receive_obj_type:int;//接取任务对象类型
		public var receive_obj_attr:int;//接取任务对象属性
		public var goal_type:int;//任务目标类型
		public var object_id:String;//目标类型的对象id
		public var object_num:int;//目标的对象数量
		public var finish_obj_type:int;//完成任务对象类型
		public var finish_obj_attr:int;//完成任务对象属性
		public var minlevel:int;//接取最低等级
		public var maxlevel:int;//接取最高等级
		public var gold:int;//奖励铜币
		public var EXP:int;//奖励经验
		public var details:String;//任务面板的描述
		public var tracer_recieve_text:String;//任务未接取，追踪栏显示内容
		public var tracer_goal_text:String;//任务进行时，追踪栏显示内容
		public var tracer_finish_text:String;//任务完成，追踪栏显示内容
		public var npc_recieve_text:String;//接取任务时，NPC的对话
		public var npc_goal_text:String;//任务未完成时，NPC的对话
		public var npc_finish_text:String;//任务完成时，NPC的对话
		public var player_recieve_text:String;//接取任务时，玩家的对话
		public var player_goal_text:String;//任务未完成时，玩家的对话
		public var player_finish_text:String;//任务完成时，玩家的对话
		public var boxId:String;//奖励箱子
		
		public var drama1:int;//任务接取时触发的剧情
		public var drama2:int;//任务完成时触发的剧情
			
		public function TaskInfoVo()
		{
		}
	}
}