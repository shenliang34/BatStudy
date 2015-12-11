package com.gamehero.sxd2.drama
{
	import com.gamehero.sxd2.drama.values.WvalueType;
	import com.gamehero.sxd2.drama.base.BaseDrama;

	/**
	 *条件判断结果
	 * 用于可能的条件判断 
	 * @author wulongbin
	 * 
	 */	
	public class ConditionInfo
	{
		protected var _condition:Function;
		protected var _conditionParam:Vector.<WvalueType>;
		public function ConditionInfo()
		{
		}
		/**
		 *初始条件函数 
		 * @param condition
		 * @param param
		 * @param getValueType
		 * 
		 */		
		public function initCondition(condition:String,param:String,getValueType:Function):void
		{
			_condition=DramaManager.instance.getCondition(condition);
			var paramArr:Array=param.split(",");
			var i:int=0;
			var len:int=paramArr.length;
			_conditionParam=new Vector.<WvalueType>(len);
			for(;i<len;i++)
			{
				_conditionParam[i]=getValueType(paramArr[i],"Object");
			}
		}
		/**
		 *判断条件是否达成 
		 * @param scirpt
		 * @return 
		 * 
		 */		
		public function check(scirpt:BaseDrama):Boolean
		{
			var i:int=0;
			var len:int=_conditionParam.length;
			var param:Array=new Array(len);
			for(;i<len;i++)
			{
				param[i]=_conditionParam[i].getValue(scirpt);
			}
			return _condition.apply(null,param);
		}
	}
}