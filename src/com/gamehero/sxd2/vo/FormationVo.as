package com.gamehero.sxd2.vo
{
	/**
	 * @author Wbin
	 * 创建时间：2015-8-25 下午4:09:10
	 * 
	 */
	public class FormationVo
	{
		public var formation_id:int;
		public var pos_1:int;
		public var pos_2:int;
		public var pos_3:int;
		public var pos_4:int;
		public var pos_5:int;
		public var name:String;
		public var des:String;
		
		public var posList:Array = [];
		
		public function FormationVo()
		{
			
		}
		
		
		
		// 找到对应pos的索引
		public function getPosIndex(pos:int):int
		{
			return posList.indexOf(pos) + 1;
		}
		
	}
}