package com.gamehero.sxd2.drama.cmds.npc
{
	import com.gamehero.sxd2.drama.base.BaseCmd;

	
	/**
	 * 根据NPC位置播放特效
	 */	
	public class EffectToNPCCmd extends BaseCmd
	{
		protected var _npcId:String;
		protected var _offX:Number;
		protected var _offY:Number;
		protected var _effectName:String;
		protected var _endType:String;
		
		
		
		
		public function EffectToNPCCmd()
		{
			super();
		}
		
		
		
		override public function fromXML(xml:XML):void
		{
			super.fromXML(xml);
			
			_offX = xml.@offX;
			_offY = xml.@offY;
			_effectName = xml.@effectName;
			_npcId = xml.@npcId;
			//_endType=xml.@endType!=undefined?xml.@endType:EffectIsoItem.ENDTYPE_AUTO;
		}
		
		
		
		
		override public function triggerCallBack(callBack:Function=null):void
		{
			super.triggerCallBack(callBack);
			playEffect();
		}
		
		
		
		
		protected function playEffect():void
		{
			/*var sprite:DisplayItem;
			var endFunc:Function=function():void
			{
				(sprite.parent as SpriteItem).removeChild(sprite);
				complete();
			};
			sprite = SXD2Main.inst.currentGameWorld.playEffectToNPC(_npcId,_effectName,_offX,_offY,_endType,endFunc);*/
		}
	}
}