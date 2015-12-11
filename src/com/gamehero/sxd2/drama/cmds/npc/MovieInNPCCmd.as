package com.gamehero.sxd2.drama.cmds.npc
{
	import com.gamehero.sxd2.drama.base.BaseCmd;
	
	import flash.events.MouseEvent;
	
	import bowser.render.display.DisplayItem;
	import bowser.render.display.SpriteItem;
	
	/**
	 *在NPC内播放movieClip
	 * @author wulongbin
	 * 
	 */	
	public class MovieInNPCCmd extends BaseCmd
	{
		protected var _npcId:String;
		protected var _offX:Number;
		protected var _offY:Number;
		protected var _movieName:String;
		
		
		
		public function MovieInNPCCmd()
		{
			super();
		}
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			
			_offX = xml.@offX;
			_offY = xml.@offY;
			_movieName = xml.@movieName;
			_npcId = xml.@npcId;
		}
		
		override public function triggerCallBack(callBack:Function=null):void
		{
			super.triggerCallBack(callBack);
			/*var sprite:DisplayItem;
			var endFunc:Function=function(e:*=null):void
			{
				App.stage.removeEventListener(MouseEvent.CLICK,endFunc);
				if(sprite.parent)
				{
					(sprite.parent as SpriteItem).removeChild(sprite);
					complete();
				}
			};
			sprite = SXD2Main.inst.currentGameWorld.playFaceMovie(_npcId,_movieName,_offX,_offY,endFunc);
			App.stage.addEventListener(MouseEvent.CLICK,endFunc);*/
		}
	}
}