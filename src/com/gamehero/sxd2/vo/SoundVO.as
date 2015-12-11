package com.gamehero.sxd2.vo
{
	import flash.media.SoundChannel;
	
	/**
	 * 音效vo
	 * @author xuwenyi
	 * @create 2014-04-19
	 **/
	public class SoundVO extends BaseVO
	{
		public var soundID:String;
		public var type:String;
		public var url:String;
		public var loop:String;
		public var volume:Number;
		
		public var soundHashURL:String;//hash地址
		public var channel:SoundChannel;
		
		
		
		/**
		 * 构造函数
		 * */
		public function SoundVO()
		{
			super();
		}
	}
}