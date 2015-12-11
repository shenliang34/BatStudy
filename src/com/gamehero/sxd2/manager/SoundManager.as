package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.vo.SoundVO;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.utils.GameTools;
	import bowser.utils.data.Group;
	
	import br.com.stimuli.loading.loadingtypes.SoundItem;
	
	
	/**
	 * 声音管理类 
	 * @author xuwenyi
	 */
	public class SoundManager
	{
		private static var _instance:SoundManager;
		
		// 当前正在播放的channel list
		private var chanList:Group = new Group();

		// 当前音乐音量
		public var volume1:Number = 1;
		// 当前音效音量
		public var volume2:Number = 1;
		
		// 保存上一次音乐音量(用于恢复静音)
		private var preMusicVolume:Number = 1;
		private var preAudioVolume:Number = 1;
		
		// 是否静音
		private var isMute:Boolean;
		
		// XML配置表
		private var soundXMLList:XMLList;
		// 音乐事件列表
		private var SOUNDS:Dictionary = new Dictionary();
		// 延迟播放timer
		private var delayTimer:int = -1;
		
		
		private var _bLoader:BulkLoaderSingleton;
		
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function SoundManager()
		{
			// 获取静音状态
			var bool:Boolean = GameData.inst.checkConfigOpen(GameConfig.MUTE);
			this.mute = bool;
		}
		
		
		
		
		public static function get inst():SoundManager
		{
			if(_instance == null)
			{
				_instance = new SoundManager();
			}
			
			return _instance;
		}
		
		
		
		
		
		/**
		 * 根据事件名查找对应音乐资源的URL
		 * @param name 事件名
		 * */
		private function getSoundByID(soundID:String):SoundVO
		{
			if(soundXMLList == null)
			{
				var settingsXML:XML = GameSettings.instance.settingsXML;
				if(settingsXML)
				{
					soundXMLList = settingsXML.sounds.sounds;
				}
			}
			
			var soundVO:SoundVO = SOUNDS[soundID];
			if(soundVO == null && soundXMLList)
			{
				var x:XML = GameTools.searchXMLList(soundXMLList , "soundID" , soundID);
				if(x)
				{
					soundVO = new SoundVO();
					soundVO.soundID = x.@soundID;
					soundVO.type = x.@type;
					soundVO.url = x.@url;
					soundVO.loop = x.@loop;
					soundVO.volume = 1;
					if(x.@volume != "")
					{
						soundVO.volume = Number(x.@volume) * 0.01;
						soundVO.volume = Math.min(soundVO.volume , 1);
					}
					
					SOUNDS[soundVO.soundID] = soundVO;
				}
				else
				{
					//Logger.warn(SoundManager , "找不到音效配置... soundID = " + soundID);
				}
			}
			return soundVO;
		}
		
		
		
		
		
		
		/**
		 * 开始播放指定音源
		 * @param soundID 音乐id
		 * @param delay 延迟播放
		 * */
		public function play(soundID:String , delay:int = 0):void
		{
			if(delay > 0)
			{
				delayTimer = setTimeout(execute , delay);
			}
			else
			{
				execute();
			}
			
			function execute():void
			{
				// 通过ResourceLoaderFactory加载资源
				var soundVO:SoundVO = getSoundByID(soundID);
				if(soundVO)
				{
					// 加入列表
					chanList.add(soundVO);
					
					// 加载
					var url:String = GameConfig.SOUND_URL + soundVO.url + ".mp3";
					
					if(_bLoader == null) {
						
						_bLoader = BulkLoaderSingleton.createUniqueNamedLoader();
					}
					_bLoader.addWithListener(url , null , onLoaded);
					_bLoader.start();
					
					
					// 保存hash地址
					if(soundVO.soundHashURL == null || soundVO.soundHashURL == "")
					{
						soundVO.soundHashURL = BulkLoaderSingleton.getHashFileName(url);
					}
				}
			}
			
			
		}
		
		
		
		
		
		
		
		/**
		 * 音乐资源加载完成
		 */
		private function onLoaded(e:Event):void
		{	
			var soundItem:SoundItem = e.currentTarget as SoundItem;
			soundItem.removeEventListener(Event.COMPLETE , onLoaded);
			
			// 查找播放列表
			var soundHashURL:String = "";
			var urlReq:URLRequest = soundItem.url;
			if(urlReq)
			{
				soundHashURL = urlReq.url;
			}
			var vo:SoundVO = chanList.getChildByParam("soundHashURL",soundHashURL) as SoundVO;
			// 播放列表中存在该音源
			if(vo)
			{
				// 已经在播放了
				if(vo.channel)
				{
					// 若是音乐,为了不中断当前音乐,立即return
					if(vo.type == "1")
					{
						return;
					}
					// 若播放的是音效,则立刻停止它
					else
					{
						this.stop(vo.soundID);
						// 重新加入列表
						chanList.add(vo);
					}
				}
				
				// 音量
				var maxVolume:Number = vo.type == "1" ? volume1 : volume2;
				maxVolume *= vo.volume;
				var sndTransform:SoundTransform = new SoundTransform(maxVolume);
				// 循环次数
				var loop:int = 999999;
				if(vo.loop != "" && vo.loop != "0")
				{
					loop = int(vo.loop);
				}
				// 音源
				var sound:Sound = soundItem.loader;
				
				try
				{
					// 播放
					var channel:SoundChannel = sound.play(0 , loop , sndTransform);
					// 渐变播放
					if(vo.type == "1")
					{
						gradientPlay(vo);
					}
					channel.addEventListener(Event.SOUND_COMPLETE , playComplete , false , 0 , true);
					vo.channel = channel;
				}
				catch(e:Error)
				{
					//Logger.debug(SoundManager , "播放音效出错...soundID = " + vo.soundID);
				}
			}
		}
		
		
		
		
		
		
		
		
		/**
		 * 渐进播放音乐
		 * @param channel 播放的音频通道
		 * */
		private function gradientPlay(soundVO:SoundVO):void
		{
			var channel:SoundChannel = soundVO.channel;
			if(channel)
			{
				// 最大音量
				var maxVolume:Number = volume1;
				// 当前音量
				var v:Number = 0;
				// 每次增加的音量步长
				var step:Number = maxVolume/24;
				
				// 每帧循环
				loop();
				function loop():void
				{
					if(v < maxVolume)
					{
						v += step;
						channel.soundTransform = new SoundTransform(v*soundVO.volume);
						setTimeout(loop , 100);
					}
					else
					{
						channel.soundTransform = new SoundTransform(maxVolume*soundVO.volume);
					}
				}
			}
		}
		
		
		
		/**
		 * 渐退停止音乐
		 * @param channel 播放的音频通道
		 * */
		private function gradientStop(soundVO:SoundVO):void
		{
			var channel:SoundChannel = soundVO.channel;
			if(channel)
			{
				// 最大音量
				var maxVolume:Number = volume1;
				// 当前音量
				var v:Number = maxVolume;
				// 每次增加的音量步长
				var step:Number = maxVolume/12;
				
				// 每帧循环
				loop();
				function loop():void
				{
					if(v > 0)
					{
						v -= step;
						channel.soundTransform = new SoundTransform(v*soundVO.volume);
						setTimeout(loop , 100);
					}
					else
					{
						channel.stop();
					}
				}
			}
		}
		
		
		
		
		
		
		/**
		 * 音乐播放流错误,通常是没有找到该资源
		 * */
		private function IOErrorEventHandler(e:IOErrorEvent):void
		{
			
		}
		
		
		
		
		
		/**
		 * 音乐播放完成事件
		 * */
		private function playComplete( e:Event ):void
		{
			var channel:SoundChannel = e.currentTarget as SoundChannel;
			if(channel)
			{
				channel.removeEventListener(Event.SOUND_COMPLETE , playComplete);
				// 从正在播放的音乐列表中移除
				chanList.removeChildByParam("channel" , channel);
			}
		}
		
		
		
		
		
		/**
		 * 停止播放指定音源
		 * */
		public function stop(soundID:String):void
		{
			var vo:SoundVO = chanList.getChildByParam("soundID" , soundID) as SoundVO;
			if(vo)
			{
				chanList.remove(vo);
				
				var channel:SoundChannel = vo.channel;
				if(channel)
				{
					channel.stop();
					channel.removeEventListener(Event.SOUND_COMPLETE , playComplete);
					vo.channel = null;
				}
			}
		}
		
		
		
		
		
		/**
		 * 停止播放所有音源
		 * */
		public function stopAllSounds():void
		{
			// 停止延迟播放timer
			if(delayTimer >= 0)
			{
				clearTimeout(delayTimer);
				delayTimer = -1;
			}
			
			chanList.reset();
			var vo:SoundVO = chanList.next() as SoundVO;
			while(vo)
			{
				// 渐退停止
				this.gradientStop(vo);
				
				var channel:SoundChannel = vo.channel;
				if(channel)
				{
					channel.removeEventListener(Event.SOUND_COMPLETE , playComplete);
					vo.channel = null;
				}
				vo = chanList.next() as SoundVO;
			}
			chanList.reset();
			chanList.clear();
		}
		
		
		
		
		
		
		/**
		 * 改变音量
		 * @param type 音乐还是音效    0:音效  1:音乐
		 * @param value 音量值
		 * */
		public function changeVolume(type:String , value:Number):void
		{
			//var mgr:CookieManager = CookieManager.instance;
			// 音乐
			if(type == "1")
			{
				volume1 = value;
				//mgr.setCookieData(CookieManager.VOLUME1, volume1);
			}
			// 音效
			else
			{
				volume2 = value;
				//mgr.setCookieData(CookieManager.VOLUME2, volume2);
			}
			
			chanList.reset();
			var vo:SoundVO = chanList.next() as SoundVO;
			while(vo)
			{
				if(vo.type == type && vo.channel)
				{
					var maxVolume:Number = type == "1" ? volume1 : volume2;
					var sndTransform:SoundTransform = new SoundTransform(maxVolume*vo.volume);
					vo.channel.soundTransform = sndTransform;
				}
				vo = chanList.next() as SoundVO;
			}
			chanList.reset();
		}
		
		
		
		
		
		
		/**
		 * 是否静音
		 * */
		public function set mute(value:Boolean):void
		{
			// 静音模式
			if(value == true)
			{
				// 保存之前的音量
				preMusicVolume = volume1;
				preAudioVolume = volume2;
				
				this.changeVolume("1",0);
				this.changeVolume("2",0);
			}
			// 还原
			else
			{
				this.changeVolume("1", preMusicVolume);
				this.changeVolume("2", preAudioVolume);
			}
			
			isMute = value;
			
			// 保存到服务器
			GameProxy.inst.saveGameConfig(GameConfig.MUTE , value);
		}
		
		
		
		
		/**
		 * 当前状态是否静音
		 * */
		public function get mute():Boolean
		{
			return isMute;
		}
		
		
	}
}