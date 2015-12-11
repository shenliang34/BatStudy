package com.gamehero.sxd2.util
{
	import com.gamehero.sxd2.core.GameConfig;
	
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	
	import bowser.loader.BulkLoaderSingleton;

	
	/**
	 * 帧频开关：通过播放声音控制flash失焦后是否降帧的开关 
	 * @author wulongbin
	 * 
	 */	
	public class FPSSwitch
	{
		
		private static var _sound:Sound;
		private static var _isOpen:Boolean = false;
		
		
		public static function set isOpen(value:Boolean):void
		{
			_isOpen = value;
			if(_sound == null)
			{
				var url:String = GameConfig.SOUND_URL + "switch.mp3";
				BulkLoaderSingleton.instance.addWithListener(url, null, onComplete);
			}
			else
			{
				if(_isOpen)
				{
					_sound.play(0, 0, new SoundTransform(0,0));
				}
				else
				{
					_sound.close();
				}
			}
			
		}
		
		private static function onComplete(event:Event):void
		{
			var url:String = GameConfig.SOUND_URL + "switch.mp3";
			_sound = BulkLoaderSingleton.instance.getSound(url);
			if(_isOpen)
			{
				_sound.play(0, int.MAX_VALUE, new SoundTransform(0,0));
			}
			else
			{
				_sound.close();
			}
		}
	}
}