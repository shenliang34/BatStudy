package com.gamehero.sxd2.drama.cmds
{
	import com.gamehero.sxd2.drama.DramaManager;
	import com.gamehero.sxd2.drama.base.BaseCmd;
	import com.gamehero.sxd2.drama.base.BaseDrama;

	
	/**
	 * 并行播放指令 
	 */	
	public class ParallelCmd extends BaseCmd
	{
		public var cmds:Vector.<BaseCmd>;
		
		private var totalScript:uint;
		private var completeNum:uint = 0;
		
		
		
		
		public function ParallelCmd()
		{
			super();
		}
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			var xmlList:XMLList=xml.children();
			totalScript = xmlList.length();
			cmds = new Vector.<BaseCmd>(totalScript);
			
			var cmd:BaseCmd;
			for(var i:int=0;i<totalScript;i++)
			{
				cmd = DramaManager.inst.getCmd(xmlList[i]);
				cmds[i] = cmd;
			}
		}
		
		
		
		override public function set script(value:BaseDrama):void
		{
			super.script=value;
			for each(var cmd:BaseCmd in cmds)
			{
				cmd.script=value;
			}
		}
		
		
		
		override public function triggerCallBack(callBack:Function=null):void
		{
			super.triggerCallBack(callBack);
			
			completeNum=0;
			
			var len:int = cmds.length;
			var cmd:BaseCmd;
			for(var i:int=0;i<len;i++)
			{
				cmd = cmds[i];
				cmd.triggerCallBack(completeCmd);
			}
		}
		
		private function completeCmd():void
		{
			completeNum++;
			if(completeNum >= totalScript)
			{
				complete();
				
				cmds = null;
			}
		}
	}
}