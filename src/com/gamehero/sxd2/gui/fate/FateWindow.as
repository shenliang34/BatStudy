package com.gamehero.sxd2.gui.fate
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.event.FateEvent;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.core.GameWindow;
	import com.gamehero.sxd2.gui.notice.NoticeUI;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MapSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.tooltip.GameHint;
	import com.gamehero.sxd2.gui.tips.FloatTips;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.manager.DialogManager;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.manager.TaskManager;
	import com.gamehero.sxd2.pro.NotifyInfo3Type;
	import com.gamehero.sxd2.pro.PRO_Fate;
	import com.gamehero.sxd2.vo.TaskInfoVo;
	import com.netease.protobuf.TextFormat;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.loadingtypes.XMLItem;
	
	/**
	 * 命途窗口
	 * @author zhangxueyou
	 * @create 2015-11-4
	 **/
	public class FateWindow extends GameWindow
	{
		private static const WINDOW_WIDTH:Number = 1200;//面板默认宽
		private static const WINDOW_HEIGHT:Number = 650;//面板默认高
		private static const MOVEDELAY:Number = 500;//移动的延迟时间
		
		private var curChapterId:int;//当前章节Id
		private var fateXml:XML;//产出配置信息
		private var fateMc:MovieClip;//命途动画对象
		private var fateInfo:PRO_Fate;//命途信息
		private var curPos:int;//当前位置
		private var stepNumber:int;//移动的步数
		private var entryCount:int;//属性获得计数
		private var propertyList:Array = [];//获取属性数组
		private var fateList:Array = [];//命格属性数组
		private var newFateInfo:PRO_Fate;//新章节数据
		private var gameHint:GameHint;//体力提示
		private var iconList:Array = [];
		/**
		 *构造 
		 * @param position
		 * @param resourceURL
		 * @param width
		 * @param height
		 * 
		 */		
		public function FateWindow(position:int, resourceURL:String=null, width:Number=0, height:Number=0)
		{
			super(position, "FateWindow.swf", WINDOW_WIDTH, WINDOW_HEIGHT);
		}
		
		/**
		 *初始化窗口 
		 * 
		 */		
		override protected function initWindow():void
		{
			// TODO Auto Generated method stub
			super.initWindow();
			initUI();
		}
		
		/**
		 *初始化UI 
		 * 
		 */		
		private function initUI():void
		{
			if(!windowResource) return;
			var mainClass:Class = windowResource.loaderInfo.applicationDomain.getDefinition("fateMc") as Class;
			fateMc = new mainClass() as MovieClip;
			addChild(fateMc);
			fateMc.rollBtn.addEventListener(MouseEvent.CLICK,rollBtnClickHandle);
			fateMc.instancyMc.visible = false;
			fateMc.instancyMc.gotoAndStop(1);
			fateMc.addDataMc.visible = false;
			fateMc.addDataMc.gotoAndStop(1);
			fateMc.candleTips.addEventListener(MouseEvent.MOUSE_MOVE,candleTipsOverHandle);
			fateMc.candleTips.addEventListener(MouseEvent.MOUSE_OUT,candleTipsOutHandle);
			
			gameHint = new GameHint();
			addChild(gameHint);
			gameHint.visible = false;
			
			var closeButton:Button = new Button(MapSkin.LEAVEMAPBTNUP,null,MapSkin.LEAVEMAPBTNOVER);
			closeButton.x = 1050;
			closeButton.y = 590;
			closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
			this.addChild(closeButton);
		}
		
		/**
		 *蜡烛移入提示 
		 * @param e
		 * 
		 */		
		private function candleTipsOverHandle(e:MouseEvent):void
		{
			setGameHintHandle("蜡烛会随着剧情的进展而熄灭");
		}
		
		/**
		 *蜡烛移出提示 
		 * @param e
		 * 
		 */
		private function candleTipsOutHandle(e:MouseEvent):void
		{
			gameHint.visible = false;
		}
		
		/**
		 * 设置提示
		 * @param x
		 * @param y
		 * @param str
		 * 
		 */		
		private function setGameHintHandle(str:String):void
		{
			gameHint.visible = true;
			gameHint.x = mouseX;
			gameHint.y = mouseY;
			gameHint.text = str;
		}
		
		/**
		 *设置窗口信息 
		 * @param info
		 * 
		 */		
		public function initWindowInfo(info:PRO_Fate):void
		{
			if(curChapterId && curChapterId != info.id)
			{
				fateMc.rollBtn.visible = false;
				newFateInfo = info;
				var len:int = fateXml.Sheet1.length();
				fateInfo.current = len - 1;
				stepNumber = len - curPos;
				fateMc.qianMc.gotoAndPlay(1);
				fateMc.qianMc.addEventListener(Event.ENTER_FRAME,qianEnterFrameHandle);
			}
			else
			{
				fateInfo = info; x
				
				if(!fateXml)
				{
					curPos = 0;
					var url:String = GameConfig.FATE_URL + "fate_" + info.id + ".xml";
					BulkLoaderSingleton.instance.addWithListener(url , {id:url} , onConfigLoaded);
					BulkLoaderSingleton.instance.start();
					fateMc.gridMc["faceMc"].x = fateMc.gridMc["r" + fateInfo.current].x;
					fateMc.gridMc["faceMc"].y = fateMc.gridMc["r" + fateInfo.current].y - 15;
					fateMc.qianMc.gotoAndStop(1);
				}
				else	
				{
					if(fateInfo.current != curPos)
					{
						fateMc.rollBtn.visible = false;
						stepNumber = fateInfo.current - curPos;
						fateMc.qianMc.gotoAndPlay(1);
						fateMc.qianMc.addEventListener(Event.ENTER_FRAME,qianEnterFrameHandle);
					}
				}
			}
			
			setCandleInfo();
			fateMc.soulTxt.text = "当前拥有命魂：" + info.soul;
			fateMc.costTxt.text = "本次消耗命魂：" + info.cost;
			
			var mytf:flash.text.TextFormat = new flash.text.TextFormat();
			if(info.soul < info.cost)
				mytf.color = 0xff0000;
			else
				mytf.color = 0xC7C7BA;
					
			fateMc.costTxt.setTextFormat(mytf);
			
		}
		
		/**
		 *移动定时器 
		 * @param e
		 * 
		 */		
		private function moveTimerHandle(e:Event):void
		{
			setMapMove();
		}
		
		/**
		 *移动定时器关闭 
		 * @param e
		 * 
		 */		
		private function moveTimerCompleteHandle(e:Event):void
		{
			e.currentTarget.removeEventListener(TimerEvent.TIMER,moveTimerHandle);
			e.currentTarget.removeEventListener(TimerEvent.TIMER_COMPLETE,moveTimerCompleteHandle);
			fateMc.rollBtn.visible = true;
			if(curPos == fateXml.Sheet1.length())
			{
				fateMc.rollBtn.visible = false;
				fateMc.addDataMc.visible = true;
				fateMc.addDataMc.gotoAndPlay(1);
				fateMc.addDataMc.addEventListener(Event.ENTER_FRAME,addDataMcEnterFrameHandle);
			}
		}
		
		/**
		 *获取命途动画帧频事件 
		 * @param e
		 * 
		 */		
		private function addDataMcEnterFrameHandle(e:Event):void
		{
			if(e.currentTarget.currentFrame == e.currentTarget.totalFrames)
			{
				e.currentTarget.visible = false;
				e.currentTarget.gotoAndStop(1);
				e.currentTarget.removeEventListener(Event.ENTER_FRAME,addDataMcEnterFrameHandle);
				
				if(newFateInfo)
				{
					fateXml = null;
					curChapterId = newFateInfo.id;
					initWindowInfo(newFateInfo);
					newFateInfo = null;
					fateMc.rollBtn.visible = true;
				}
				
			}
		}
		
		/**
		 *设置地图移动 
		 * 
		 */		
		private function setMapMove():void
		{
			if(curPos <= fateInfo.current)
			{
				
				var awardStr:String
				awardStr = fateXml.Sheet1[curPos].@value;
				var awardStrList:Array = awardStr.split("-");
				if(fateXml.Sheet1[curPos].@type == 0)
				{
					var propBaseVo:PropBaseVo = ItemManager.instance.getPropById(awardStrList[0]);
					awardStr = "获得" + propBaseVo.name + "  x" + awardStrList[1];
				}
				else
				{
					var nameStr:String = Lang.instance.trans(awardStrList[0]);
					var value:int = awardStrList[1];
					
					awardStr = "获取属性:" + nameStr + "+" + value;
					setPropertyHandle(curPos);
				}
				
				curPos ++;
				
				fateMc.gridMc["faceMc"].x = fateMc.gridMc["r" + curPos].x;
				fateMc.gridMc["faceMc"].y = fateMc.gridMc["r" + curPos].y - 15;
				
				var tipsObj:Object = new Object();
				tipsObj.x = fateMc.gridMc["r" + curPos].x;
				tipsObj.y = fateMc.gridMc["r" + curPos].y - 20;
				tipsObj.tipsStr = awardStr;
				tipsObj.displayer = fateMc.gridMc["faceMc"];
				FloatTips.inst.show(awardStr,tipsObj,0);
				
				setGirdInfo(false);
			}
			
		}
		
		/**
		 *加载命途当前章节产出表 
		 * @param event
		 * 
		 */		
		protected function onConfigLoaded(event:Event):void
		{
			var xmlItem:XMLItem = event.target as XMLItem;
			fateXml = new XML(xmlItem.content);
			
			propertyList.splice(0);
			fateList.splice(0);
			fateMc.entryMc.gotoAndStop(1);
			setPropertyDisplayerHandle();
			entryCount = 0;
			
			setGirdInfo(true);
			
			curPos = fateInfo.current;
			curChapterId = fateInfo.id;
			
		}
		
		/**
		 *设置当前张格子信息 
		 * @param index
		 * 
		 */		
		private function setGirdInfo(bool:Boolean):void
		{
			iconListClear();
			iconList.splice(0);
			/*
			propertyList.splice(0);
			fateList.splice(0);
			*/
			var dataCount:int;

			var len:int = fateXml.Sheet1.length();
			var pos:int;
			if(bool)
				pos = fateInfo.current
			else
				pos = curPos;
		
			for(var i:int;i<len;i++)
			{
				var iconMc:MovieClip = fateMc.gridMc["r" + (i + 1)].icon;
				var obj:Object = new Object();
				obj.mc = iconMc;
				var count:int;
				if(fateXml.Sheet1[i].@type == 0)
				{
					var coloer:String;
					if(i < pos)
						coloer = "gray";
					else
						coloer = fateXml.Sheet1[i].@color;
					
					var awardStr:String
					awardStr = fateXml.Sheet1[i].@value;
					var awardStrList:Array = awardStr.split("-");
					var fateItem:FateItem = new FateItem();
					fateItem.setUI(fateXml.Sheet1[i].@icon,coloer,awardStrList[1]);
					iconMc.addChild(fateItem);
					obj.removeMc = fateItem;
				}
				else
				{
					if(bool)
					{
						if(i < pos)
							setPropertyHandle(i);
						
						var icon:Bitmap;
						icon = new Bitmap(this.getSwfBD(fateXml.Sheet1[i].@icon));
						iconMc.addChild(icon);	
						iconMc.x = 1;
						iconMc.y = 1;
						iconMc.id = i;
						iconMc.addEventListener(MouseEvent.MOUSE_OVER,iconMcMouseOverHandle);
						iconMc.addEventListener(MouseEvent.MOUSE_OUT,iconMcMouseOutHandle);
					}
				}
				iconList.push(obj);
			}	
		}
		
		/**
		 *属性图标鼠标移入事件 显示提示 
		 * @param e
		 * 
		 */		
		private function iconMcMouseOverHandle(e:MouseEvent):void
		{
			var awardStr:String = fateXml.Sheet1[e.currentTarget.id].@value;
			var awardStrList:Array = awardStr.split("-");
			var nameStr:String = Lang.instance.trans(awardStrList[0]);
			var value:int = awardStrList[1];
			awardStr = "获取属性:" + nameStr + "+" + value;
			setGameHintHandle(awardStr);
		}
		
		/**
		 *属性图标鼠标移出事件 隐藏提示 
		 * @param e
		 * 
		 */	
		private function iconMcMouseOutHandle(e:MouseEvent):void
		{
			gameHint.visible = false;
		}
		
		/**
		 *图标清理 
		 * 
		 */		
		private function iconListClear():void
		{
			var len:int = iconList.length;
			for(var i:int;i<len;i++)
			{
				var obj:Object = iconList[i];
				try
				{
					obj.mc.removeChild(obj.removeMc);
				} 
				catch(error:Error) 
				{
					trace(i + "---" + error);
				}		
			}
		}
		
		/**
		 *设置蜡烛 
		 * 
		 */		
		private function setCandleInfo():void
		{
			var xmlList:XMLList = GameSettings.instance.settingsXML.fate_candle.Sheet1;
			for(var i:int;i<xmlList.length();i++)
			{
				var xml:XML = xmlList[i];
				var taskId:int = getCurrentMainTaskId();
				if(xml.@id == fateInfo.id)
				{
					if(xml.@taskid < taskId)
						fateMc["candleMc" + xml.@candle].gotoAndStop(2);
					else
						fateMc["candleMc" + xml.@candle].gotoAndStop(1);
				}
				
			
			}
			if(isInstancyStatus())
			{
				fateMc.instancyMc.gotoAndPlay(1);
				fateMc.instancyMc.visible = true;
			}
				
		}
		
		/**
		 *抽签点击事件 
		 * @param e
		 * 
		 */		
		private function rollBtnClickHandle(e:MouseEvent):void
		{
			if(!fateMc.rollBtn.visible) return;
			if(fateInfo.cost > fateInfo.soul)
			{
				DialogManager.inst.showPrompt("命魂不足");
//				fateMc.rollBtn.visible = true;
			}
			else
			{
//				fateMc.rollBtn.visible = false;
				dispatchEvent(new FateEvent(FateEvent.FATEROLL));
			}
		}
		
		/**
		 *获取命途信息 
		 * 
		 */		
		private function getWindowInfo():void
		{
			dispatchEvent(new FateEvent(FateEvent.FATEINFO));
		}
		
		/**
		 *抽签动画的帧频事件 
		 * @param e
		 * 
		 */		
		private function qianEnterFrameHandle(e:Event):void
		{
			if(e.currentTarget.currentFrame == 16)
			{
				e.currentTarget.stepNumberMc.gotoAndPlay((stepNumber - 1) * 40 + 1);
			}
			if(e.currentTarget.currentFrame == e.currentTarget.totalFrames)
			{
				e.currentTarget.gotoAndStop(1);
				e.currentTarget.removeEventListener(Event.ENTER_FRAME,qianEnterFrameHandle);
				var timer:Timer = new Timer(MOVEDELAY,stepNumber);
				timer.addEventListener(TimerEvent.TIMER,moveTimerHandle);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE,moveTimerCompleteHandle);
				timer.start();
				
			}
		}
		
		/**
		 *获取主线任务ID 用于判断剩余蜡烛 
		 * @return 
		 * 
		 */		
		private function getCurrentMainTaskId():int
		{
			var list:Array = GameData.inst.taskList;
			var len:int = list.length;
			var i:int;
			for(i;i<len;i++)
			{
				var taskVo:TaskInfoVo = TaskManager.inst.getTaskDataById(list[i].id);
				if(taskVo.type == 1)
				{
					return taskVo.taskId;
				}
			}
			return 0;
		}
		
		/**
		 *设置获取的属性信息 
		 * @param pos
		 * 
		 */		
		private function setPropertyHandle(pos:int):void
		{
			trace("当前获得的属性有" + entryCount);
			fateMc.entryMc.gotoAndPlay(entryCount * 13 + 1);
			fateMc.entryMc.effectMc.gotoAndPlay(2);
			entryCount++;
			
			var str:String = fateXml.Sheet1[pos].@value;
			var list:Array = str.split("-");
			var nameStr:String = Lang.instance.trans(list[0]);
			var value:int = list[1];
			//如果当前位置大于蜡烛全灭的位置 获得属性减半
			if(isInstancyStatus())
			{
				fateMc.entryMc.effectMc.gotoAndPlay(2);
				value = value * 0.5;
				var fateStr:String = "命格属性:" + nameStr + "+" + value;
				fateList.push(fateStr);
			}
			var awardStr:String = nameStr + "+" + value;
			propertyList.push(awardStr);

			setPropertyDisplayerHandle();
		}
		
		/**
		 *设置获取属性显示 
		 * 
		 */		
		private function setPropertyDisplayerHandle():void
		{
			fateMc.propertyTxt.text = "";
			for(var i:int;i<propertyList.length;i++)
			{
				fateMc.propertyTxt.text += propertyList[i] + "\n";
			}
			
			fateMc.fateTxt.text = "";
			for(i=0;i<fateList.length;i++)
			{
				fateMc.fateTxt.text += fateList[i] + "\n";
			}
		}
		
		/**
		 *窗口关闭点击事件 
		 * @param e
		 * 
		 */		
		private function onCloseButtonClick(e:MouseEvent):void
		{
			close();
		}
		
		/**
		 *窗口关闭 
		 * 
		 */		
		override public function close():void
		{
			// TODO Auto Generated method stub
			super.close();
		}
		
		/**
		 *是否紧急状态 
		 * @return 
		 * 
		 */		
		private function isInstancyStatus():Boolean
		{
			if(fateInfo.isDiscount)
			{
				if(curPos > fateInfo.last || !fateInfo.last)
				{
					return true;
				}
			}	
			return false;
		}
		
		/**
		 *窗口打开 
		 * 
		 */		
		override public function show():void
		{
			// TODO Auto Generated method stub
			NoticeUI.inst.hideNoti(NoticeUI.inst.NOTIAREA3,NotifyInfo3Type.TYPE_FATE);
			super.show();
			getWindowInfo();
		}
		
	}
}