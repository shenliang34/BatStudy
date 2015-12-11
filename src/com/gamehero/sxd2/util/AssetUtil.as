package com.gamehero.sxd2.util
{
    import com.gamehero.sxd2.local.Lang;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedSuperclassName;

	public class AssetUtil
	{
		//========单例单元========
		private static var m_instance:AssetUtil;
		private static var m_bBuildabled:Boolean;
		
		public static function get instance():AssetUtil
		{
			if(m_instance == null)
			{
				m_bBuildabled = true;
				m_instance = new AssetUtil();
				m_bBuildabled = false;
			}
			return m_instance;
		}
		//======constructor=========
		public function AssetUtil() 
		{ 
			if(m_bBuildabled){
				super();
				m_instance = this;
			}else	{
				throw new Error("AssetUtil是单例模式，请使用AssetUtil.Instance获取该实例！");
			}
		}
		
		/**
		 * 判断target是否是继承className指定的类
		 * @param	target
		 * @param	className
		 * @return
		 */
		public function  isExtends(target:Object,className:String):Boolean
		{
			var spClas:String = getQualifiedSuperclassName(target);
			if (spClas == null)
			{
				return false;
			}
			if (spClas==className)
			{
				return true;
			}
			target = getDefinitionByName(spClas) as Class;
			return isExtends(target, className);
		}
		
		/**
		 * 移除容器中的所有子对象
		 * @param	ctTarget  容器对象
		 * @param	bOnlyChild   是否只移除ctTarget的子对象，而子对象的子对象就不处理了 
		 */
		public  function removeAll(ctTarget:DisplayObjectContainer,bOnlyChild:Boolean=true):void
		{
			if(ctTarget!=null)
			{
				//trace("移除容器:",ctTarget.numChildren)
				while(ctTarget.numChildren>0)
				{
					if(!bOnlyChild)
					{
						removeAll(ctTarget.getChildAt(0) as DisplayObjectContainer);
					}
					ctTarget.removeChildAt(0);
				}
			}
		}
		
		/**
		 * 停止影片以及所有子影片的播放
		 * @param	mcTarget 目标影片
		 * @param	bSelf 停止是否包含目标影片本身
		 */
		public  function stopAll(mcTarget:DisplayObjectContainer,bSelf:Boolean=false):void
		{ 
			if(mcTarget!=null)
			{
				if(bSelf&&(mcTarget is MovieClip))
				{
					MovieClip(mcTarget).stop();
				}
				var num:int=mcTarget.numChildren;
				for(var i:int=0;i<num;i++)
				{
					var mcChild:MovieClip=mcTarget.getChildAt(i) as MovieClip;
					if(mcChild!=null)
					{
						stopAll(mcChild,true);
					}
				}
			}
		}
		
	}
}