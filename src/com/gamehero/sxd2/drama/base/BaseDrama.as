package com.gamehero.sxd2.drama.base
{
	import com.gamehero.sxd2.drama.DramaManager;
	
	import flash.utils.setTimeout;

	/**
	 * 脚本播放器 
	 */	
	public class BaseDrama
	{
		public var id:uint;
		// 脚本命令队列 
		public var scriptCmds:Vector.<BaseCmd>;
		
		// 嵌套脚本父对象 
		public var parentScript:BaseDrama;
		// 脚本命令长度 
		private var totalCmd:uint;
		
		
		
		
		
		public function BaseDrama()
		{
			super();
		}
		
		
		
		/**
		 *重置脚本命令 
		 */		
		public function resetCmds(value:Vector.<BaseCmd>):void
		{
			scriptCmds = value;
			totalCmd = scriptCmds.length;
		}
		
		
		
		/**
		 *解析XML脚本 
		 */		
		public function fromXML(xml:XML):void
		{
			id = xml.@id;
			
			var xmlList:XMLList = xml.children();
			var len:int = xmlList.length();
			// 命令总个数
			totalCmd = len;
			scriptCmds = new Vector.<BaseCmd>(len);
			var scriptCmd:BaseCmd;
			
			for(var i:int=0;i < len; i++)
			{
				scriptCmd = DramaManager.inst.getCmd(xmlList[i]);
				scriptCmd.script = this;
				scriptCmds[i] = scriptCmd;
			}
		}
		
		//===================脚本运行相关属性==================================
		
		protected var _isRunning:Boolean;
		protected var _currentIndex:int;
		protected var completeCallBack:Function;
		public var globalData:Object;
		public var localData:Object;
		
		//=====================================================================
		
		/**
		 * 播放脚本
		 * @param globalData 全局属性，嵌套脚本也可以访问
		 * @param localData 局部属性，只能在当前脚本访问
		 * @param completeCallBack 脚本播放完成后的回调函数
		 * 
		 */		
		public function startScript(globalData:Object = null,localData:Object = null,completeCallBack:Function = null):void
		{
			if(_isRunning)
			{
				endScript();
			}
			this.globalData = globalData||{};
			this.localData = localData||{};
			this.completeCallBack = completeCallBack;
			_isRunning = true;
			_currentIndex = 0;
			
			this.nextCommand();
		}
		
		
		
		/** 
		 * 下一条脚本准备执行
		 */		
		public function nextCommand():void
		{
			if(_isRunning == true && _currentIndex < totalCmd)
			{
				var nextCmd:BaseCmd = scriptCmds[_currentIndex];
				_currentIndex++;
				//执行脚本
				if(nextCmd.cmdDelay > 0)
				{
					setTimeout(play , nextCmd.cmdDelay);
				}
				else
				{
					play();
				}
				
				function play():void
				{
					nextCmd.triggerCallBack(nextCommand);
				}
			}
			else
			{
				this.complete();
			}
		}
		
		
		
		/**
		 * 脚本播放完成 
		 */		
		public function complete():void
		{
			var tempCallBack:Function = completeCallBack;
			
			_currentIndex--;
			
			endScript();
			
			if(tempCallBack)
				tempCallBack();
		}
		
		
		/**
		 * 结束脚本 
		 */		
		public function endScript():void
		{
			completeCallBack = null;
			_isRunning = false;
			if(_currentIndex < totalCmd)
			{
				scriptCmds[_currentIndex].clear();
			}
		}
		
		/**
		 * 跳过剧情 
		 * 
		 */		
		public function skipScript():void
		{
			complete();
		}
		
		
	}
}