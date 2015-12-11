package com.gamehero.sxd2.vo {
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	
	/**
	 * Base VO<br/>
	 * 含有copyValue基础方法 
	 * @author cuiyi
	 * 
	 */
	//public class BaseVO {
	public class BaseVO extends EventDispatcher {
		
		/**
		 * 快速拷贝属性，所有属性名称均与后台返回的对象属性名一致
		 * @param value
		 * 
		 */
		public function copyValue(obj:Object):void
		{
			// 现将目标对象深复制
			var byte:ByteArray = new ByteArray();
			byte.writeObject(obj);
			byte.position = 0;
			var value:Object = byte.readObject();
			
			for(var p:String in value)
			{
				// 注意：value[p]若为空，则认为该数据无效（若真实数据需要为空，需要用""，即空字符串来表示）
				if(value[p] != null && this.hasOwnProperty(p) )
				{
					// Boolean类型转换
					if( value[p] == "true" || value[p] == "false" )
					{
						
						this[p] = (value[p] == "true");
					}
					// 是否是嵌套的VO类型(该属性必须先初始化)
					else if(this[p] != null && this[p].hasOwnProperty("copyValue"))
					{	
						this[p].copyValue(value[p]);
					}
					else
					{
						
						this[p] = value[p];
					}
				}
			}
			
		}
		
	}
}