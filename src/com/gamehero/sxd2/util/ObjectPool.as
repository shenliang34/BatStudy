package com.gamehero.sxd2.util
{
	import flash.utils.Dictionary;

	/**
	 * 对象池 
	 * @author wlb
	 * 
	 */	
	public class ObjectPool
	{
		private var _pool:Dictionary;
		private var _clazz:Class
		
		public function ObjectPool(clazz:Class):void
		{
			_clazz = clazz;
			_pool = new Dictionary(true);
		}
		
		
		public function getObject():*
		{
			for(var obj:* in _pool)
			{
				delete _pool[obj];
				return obj;
			}
			
			return new _clazz;
		}
		
		
		public function release(obj:Object):void
		{
			_pool[obj] = true;
		}
	}
}