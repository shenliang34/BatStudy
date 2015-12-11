package com.gamehero.sxd2.gui.notice
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.gui.main.MainUI;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.utils.MovieClipPlayer;

	/**
	 * 游戏提示层
	 * @author zhangxueyou
	 * @create 2015-09-22
	 **/
	public class NoticeUI extends Sprite
	{
		/** 
		 * 单例对象 
		**/
		private static var _instance:NoticeUI;//单例对象
		public var NOTIAREA1:String = "notiArea1";//1号区域
		public var NOTIAREA2:String = "notiArea2";//2号区域
		public var NOTIAREA3:String = "notiArea3";//3号区域
		public var NOTIAREA4:String = "notiArea4";//4号区域
		
		private var notiArea1:NoticeArea1;//提示1号区域	
		private var notiArea2:NoticeArea2;//提示2号区域
		private var notiArea3:NoticeArea3;//提示3号区域		
		/**
		 * 右下角区域 
		 */		
		public var notiArea4:NoticeArea4;//提示4号区域
		
		public var pathingItem:MovieClip;//自动寻路对象
		private var completeTask:MovieClip;//完成任务
		private var startTask:MovieClip;//接收任务
		
		/**
		 * 构造函数
		 */
		public function NoticeUI()
		{
			super();
			init();
		}
		
		/**
		 * 初始化UI
		 */
		public function init():void
		{
			
			BulkLoaderSingleton.instance.addWithListener(GameConfig.TASK_URL + "pathingItem.swf",null,pathingItemCompleteHandle);
			BulkLoaderSingleton.instance.addWithListener(GameConfig.TASK_URL + "completeTask.swf",null,completeTaskCompleteHandle);
			BulkLoaderSingleton.instance.addWithListener(GameConfig.TASK_URL + "startTask.swf",null,startTaskCompleteHandle);
			
			BulkLoaderSingleton.instance.start();
			
			
			notiArea1 = new NoticeArea1();
			addChild(notiArea1);
			notiArea1.visible = false;
			notiArea2 = new NoticeArea2();
			addChild(notiArea2);
			notiArea2.visible = false;
			notiArea3 = new NoticeArea3();
			addChild(notiArea3);
			notiArea3.visible = false;
			notiArea4 = new NoticeArea4();
			addChild(notiArea4);
//			notiArea4.visible = false;
			
			App.stage.addEventListener(Event.RESIZE, onResize);
			onResize();
			
		}
		
		/**
		 * 显示提示
		 * @param area 显示区域
		 * @param data 所需数据
		 */
		public function showNoti(area:String,data:*):void
		{
			switch(area)
			{
				case NOTIAREA1:
				{
					notiArea1.addNoti(data);
					break;
				}
				case NOTIAREA3:
					notiArea3.showTips(data);
					break;
				default:
				{
					break;
				}
			}
		}
		
		/**
		 * 隐藏提示
		 * @param area 隐藏区域
		 * @param data 所需数据
		 */
		public function hideNoti(area:String,data:* = null):void
		{
			switch(area)
			{
				case NOTIAREA3:
					if(!notiArea3.visible) return;
					notiArea3.hideTips(data);
					break;
				default:
				{
					break;
				}
			}
		}
		
		/**
		 *自动寻路动画加载完成 
		 * @param e
		 * 
		 */		
		private function pathingItemCompleteHandle(e:Event):void
		{
			pathingItem = e.currentTarget.content;
			this.addChild(pathingItem);
			setPathingItem(false);
			onResize();
		}
		
		/**
		 *完成动画加载完成 
		 * @param e
		 * 
		 */		
		private function completeTaskCompleteHandle(e:Event):void
		{
			completeTask = e.currentTarget.content;
			this.addChild(completeTask);
			completeTask.gotoAndStop(1);
			completeTask.visible = false;
			onResize();
		}
		
		/**
		 *设置完成任务动画显示 
		 * 
		 */		
		public function setCompleteTaskVisible():void
		{
			completeTask.visible = true;
			
			var mp:MovieClipPlayer = new MovieClipPlayer();
			mp.play(completeTask , completeTask.totalFrames/24 , 0 , completeTask.totalFrames);
			mp.addEventListener(Event.COMPLETE , over);
			
			function over(e:Event):void
			{
				completeTask.visible = false;
				
				mp.removeEventListener(Event.COMPLETE , over);
				mp = null;
			}
		}
		
		/**
		 *开始任务动画加载完成 
		 * @param e
		 * 
		 */		
		private function startTaskCompleteHandle(e:Event):void
		{
			startTask = e.currentTarget.content;
			this.addChild(startTask);
			startTask.gotoAndStop(1);
			startTask.visible = false;
			onResize();
		}
		
		/**
		 *设置开始任务动画 
		 * 
		 */		
		public function setSatrtTaskVisible():void
		{
			startTask.visible = true;
			
			var mp:MovieClipPlayer = new MovieClipPlayer();
			mp.play(startTask , startTask.totalFrames/24 , 0 , startTask.totalFrames);
			mp.addEventListener(Event.COMPLETE , over);
			
			function over(e:Event):void
			{
				startTask.visible = false;
				
				mp.removeEventListener(Event.COMPLETE , over);
				mp = null;
			}
		}
		
		
		
		/**
		 *自适应定位
		 */		
		public function onResize(event:Event = null):void
		{
			var w:Number  = App.stage.stageWidth;
			var h:Number  = App.stage.stageHeight;
			
			var offset:Number = h / 600;
			
			notiArea1.x = w - notiArea1.width >> 1
			notiArea1.y = int(50 * offset);
			
			notiArea2.x = w - notiArea2.width >> 1;
			notiArea2.y = h - notiArea2.height >> 1;
			
			notiArea3.x = w - notiArea3.width >> 1;
			notiArea3.y = h - notiArea3.height - int(100 * offset);
			
			notiArea4.x = w - notiArea4.width;
			if(MainUI.inst.menuBar1)
				notiArea4.y = MainUI.inst.menuBar1.y - notiArea4.height;
			
			
			if(completeTask != null)
			{
				completeTask.x = w / 2;
				completeTask.y = h / 2 - 150;	
			}
			if(startTask != null)
			{
				startTask.x = w / 2;
				startTask.y = h / 2 - 150;
			}
			if(pathingItem != null)
			{
				pathingItem.x = w / 2;
				pathingItem.y = h - int(150 * offset);
			}
		}
		
		public function setPathingItem(bool:Boolean):void
		{
			if(!pathingItem) return;
			if(bool)
			{
				pathingItem.visible = bool;
				pathingItem.gotoAndPlay(1);
			}
			else
			{
				pathingItem.visible = bool;
				pathingItem.gotoAndStop(1);
			}
		}
		
		/**
		 *获取单例
		 */
		public static function get inst():NoticeUI {	
			
			return _instance ||= new NoticeUI();
		}
	}
}