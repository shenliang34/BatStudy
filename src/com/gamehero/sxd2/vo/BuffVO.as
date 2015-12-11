package com.gamehero.sxd2.vo
{
	
	
	/**
	 * buff vo
	 * @author xuwenyi
	 * @create 2013-12-06
	 **/
	public class BuffVO extends BaseVO
	{
		public var buffId:String;
		public var maxoverLay:String;
		public var cname:String;
		public var description:String;
		public var buffClass:String;
		public var expireType:String;
		public var expireValue:String;
		public var effect:String;
		public var Bufficon:String;
		public var efURL:String;
		public var displayType:String;
		public var displayPos:String;
		public var isStopAction:String;
		public var cannotUseSkill:String;
		public var priority:String;
		public var isHide:String;
		
		
		
		public function BuffVO()
		{
			super();
		}
		
		public function formatDescription(param:int):String
		{
			var des:String = description;
			var nums:Array = des.match(/{num[0-9]+}/gi);
			for(var i:int=0;i<nums.length;i++)
			{
				var num:String = nums[i];
				num = num.replace("{num" , "");
				num = num.replace("}" , "");
				des = des.replace(/{num[0-9]+}/ , int(num)*param);
			}
			
			return des;
		}
	}
}