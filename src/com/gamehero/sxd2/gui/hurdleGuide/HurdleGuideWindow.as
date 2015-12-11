package com.gamehero.sxd2.gui.hurdleGuide
{
	import com.gamehero.sxd2.gui.SButton;
	import com.gamehero.sxd2.gui.core.GameWindow;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.core.components.McActiveObject;
	import com.gamehero.sxd2.gui.hurdleGuide.components.HurdleCont;
	import com.gamehero.sxd2.gui.hurdleGuide.event.HurdleGuideEvent;
	import com.gamehero.sxd2.gui.hurdleGuide.model.HurdleGuideModel;
	import com.gamehero.sxd2.manager.ChapterManager;
	import com.gamehero.sxd2.pro.InstanceStatus;
	import com.gamehero.sxd2.pro.MSG_UPDATE_INSTANCE_ACK;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import bowser.loader.BulkLoaderSingleton;
	
	/**
	 * 关卡选择
	 * @author weiyanyu
	 * @create 2015年7月9日 14:12:08
	 **/
	public class HurdleGuideWindow extends GameWindow
	{
		
		/**
		 * 构造函数
		 * */
		public function HurdleGuideWindow(position:int, resourceURL:String = "HurdleGuideWindow.swf")
		{
			super(position, resourceURL, 1103, 673);
		}
		//箱子第一帧是关闭，第二帧是可以领取，第三帧是打开
		/**
		 * 宝箱 关闭 
		 */		
		public static var BOX_CLOSE:int = 1;
		/**
		 * 宝箱可以领取 
		 */		
		public static var CAN_GET:int = 2;
		/**
		 * 包厢已经领取 
		 */		
		public static var OPENED:int = 3;
		
		private var _loader:BulkLoaderSingleton;
		/**
		 * 章节内容 
		 */		
		private var _cont:HurdleCont;
		/**
		 * 主面板 
		 */		
		private var _mainMc:MovieClip;
		
		private var _model:HurdleGuideModel;
		/**
		 * 左下角进度条 
		 */		
		private var _progressBar:MovieClip;
		/**
		 * 进度值 
		 */		
		private var _progressTips:McActiveObject;
		
		private var _closeBtn:SButton;
		
		
		/**
		 * 难度按钮 
		 */		
		private var _difficultBtnList:Vector.<SButton> = new Vector.<SButton>();
		
		override protected function initWindow():void
		{
			super.initWindow();
			
			_model = HurdleGuideModel.inst;
			
			_model.guideDomain = uiResDomain;
			
			var mainClass:Class = windowResource.loaderInfo.applicationDomain.getDefinition("mainMc") as Class;
			
			_mainMc = new mainClass() as MovieClip;
			addChild(_mainMc);
			
			_closeBtn = new SButton(getSwfInstance("CloseBtn"));
			addChild(_closeBtn);
			_closeBtn.x = 1000;
			_closeBtn.y = 12;
			
			_progressBar = _mainMc.leftBanner.progressBar;
			_progressTips = new McActiveObject();
			_progressBar.addChild(_progressTips);
			_progressTips.setArea(240,_progressBar.height);//进度条长度是240
		}
		
		override public function onShow():void
		{
			super.onShow();
			
			var i:int;
			
			_model.curChapterId = int(windowParam.chapterId);
			var curHurdleId:String = (windowParam.hurdleId);//当前需要引导的副本id
			_model.curChapter = ChapterManager.getInstance().getChapterById(_model.curChapterId);
			
			if(int(curHurdleId) > 0)//如果有需要引导的副本，
			{
				var hurdleArr:Array;
				for(i = 0; i < _model.curChapter.hurdleList.length ;i++)
				{
					hurdleArr = _model.curChapter.hurdleList[i];
					if(hurdleArr.indexOf(curHurdleId) > -1)
					{
						_model.curDiff = i;//需要引导的副本所在的难度
						_model.curTipsNode = hurdleArr.indexOf(curHurdleId);//需要引导的副本所在的位置
					}
				}
			}
			else
			{
				_model.curDiff = HurdleGuideModel.EASY;
			}
			
			
			_cont = new HurdleCont();
			_cont.enterInstance = enterInstance;
			(_mainMc.getChildByName("bg") as MovieClip).addChildAt(_cont,1);
			
			
			_closeBtn.addEventListener(MouseEvent.CLICK,onClose);
			
			var leftBottomBtn:MovieClip;
			var mc:McActiveObject;
			for(i = 0; i < _model.curChapter.hardNum; i++)//领奖按钮
			{
				leftBottomBtn = getSwfInstance("Box" + i) as MovieClip;
				addChild(leftBottomBtn);
				leftBottomBtn.name = "box" + i;
				(leftBottomBtn.num as TextField).text = _model.curChapter.condition[i];
				mc = new McActiveObject(McActiveObject.HurdleGuideBox);
				mc.setArea(leftBottomBtn.width,leftBottomBtn.height);
				addChild(mc);
				mc.ent = _model.curChapter.condition[i];
				
				mc.x = leftBottomBtn.x = 69 + 240 / _model.curChapter.hardNum * (i + 1);//进度条长度是240,平均分割
				mc.y = leftBottomBtn.y = 542;
				mc.hint = "giftBtn" + i;
				mc.name = "giftBtn" + i;
				mc.data = _model.curChapter["reward_" + (i+1)];
				mc.addEventListener(MouseEvent.CLICK,onGetGift);
			}
			var rightBottomBtn:SButton;
			for(i = 0; i < _model.curChapter.hardNum; i++)//难度按钮添加
			{
				rightBottomBtn = new SButton(getSwfInstance("Btn" + i) as SimpleButton);
				_difficultBtnList.push(rightBottomBtn);
				addChild(rightBottomBtn);
				rightBottomBtn.x = 1010;
				rightBottomBtn.name = "btn" + i;
			}
			
			dispatchEvent(new HurdleGuideEvent(HurdleGuideEvent.UPDATE,_model.curChapterId));
		}
		/**
		 * 领取阶段奖励 
		 * @param event
		 * 
		 */		
		protected function onGetGift(event:MouseEvent):void
		{
			var btn:McActiveObject = event.target as McActiveObject;
			var index:int = int(btn.name.charAt(7));//第8位是按钮的索引 giftBtn+ i
			var hurdleEvent:HurdleGuideEvent = new HurdleGuideEvent(HurdleGuideEvent.ACCEPT,_model.curChapterId);
			hurdleEvent.ent = index;
			dispatchEvent(hurdleEvent);
		}
		/**
		 * 领取奖励后设置领奖箱子状态 
		 * @param index
		 */		
		public function updataGiftBtn(index:int):void
		{
			var leftBottomBtn:MovieClip = getChildByName("box" + index) as MovieClip;
			leftBottomBtn.gotoAndStop(OPENED);//
			leftBottomBtn.openMc.gotoAndPlay(1);//播放开箱动作
//			var mc:McActiveObject = getChildByName("giftBtn" + index) as McActiveObject;
//			mc.ent = OPENED;
		}
		/**
		 * 更新副本信息 
		 * @param chapterList
		 * 
		 */		
		public function update(chapterList:MSG_UPDATE_INSTANCE_ACK):void
		{
			var percent:Number = _model.starLen / _model.curChapter.condition[_model.curChapter.hardNum - 1];//宝箱进度
			
			_progressBar.gotoAndStop(int(100 * (percent)));//
			_progressTips.hint = "当前获得星数：" + _model.starLen + "星";
			
			initRightBtnStatus(_difficultBtnList[_model.curDiff]);
			
			var mc:McActiveObject;
			var leftBottomBtn:MovieClip;
			var leftBottomBtnFrame:int;
			for(var i:int = 0; i < _model.curChapter.hardNum; i++)//宝箱奖励三个按钮的状态设置
			{
				leftBottomBtn = getChildByName("box" + i) as MovieClip;
				mc = getChildByName("giftBtn" + i) as McActiveObject;
				if(!chapterList.boxReceived[i])//如果宝箱没有领取
				{
					if((i + 1) / _model.curChapter.hardNum <= percent)//宝箱条件的最后一个是可领的最大值
					{//
						leftBottomBtnFrame = CAN_GET;
					}
					else
					{
						leftBottomBtnFrame = BOX_CLOSE;
					}
				}
				else
				{
					leftBottomBtnFrame = OPENED;
				}
//				mc.ent = leftBottomBtnFrame;
				leftBottomBtn.gotoAndStop(leftBottomBtnFrame);//箱子第一帧是关闭，第二帧是可以领取，第三帧是打开
			}
			_cont.setDiff(_model.curDiff);
		}
		protected function onClose(event:MouseEvent):void
		{
			close();
		}	
		
		protected function onChangePage(event:MouseEvent):void
		{
			var rightBottomBtn:SButton = event.currentTarget as SButton;
			initRightBtnStatus(rightBottomBtn);//选中当前按钮
			var diff:int = int(rightBottomBtn.name.charAt(3));//根据按钮名字获得难度索引 0，1，2
			if(_model.curDiff != diff)
			{
				_cont.setDiff(diff);
				_model.curDiff = diff;
			}

		}
		/**
		 * 设置难度按钮的状态 ,调整坐标
		 * @param rightBottomBtn
		 * 
		 */		
		private function initRightBtnStatus(rightBottomBtn:SButton):void
		{
			var btns:Vector.<SButton> = new Vector.<SButton>();
			for(var i:int = 0; i < _model.curChapter.hardNum; i++)
			{
				_difficultBtnList[i].status = SButton.Status_Up;
				_difficultBtnList[i].visible = _model.getNodeData(_model.curChapter.hurdleList[i][0]).status != InstanceStatus.Disabled;//每个难度第一个节点是否开启
				
				if(_difficultBtnList[i].visible)
				{
					_difficultBtnList[i].addEventListener(MouseEvent.CLICK,onChangePage);
					btns.push(_difficultBtnList[i]);
				}
				else
				{
					_difficultBtnList[i].removeEventListener(MouseEvent.CLICK,onChangePage);
				}
			}
			var firstX:int = (50 + 50 + 34) - (btns.length - 1) * 50 - 34 >> 1;//三个按钮的总高度   减去  当前按钮应该占用的高度   除以  2，这样可以居中
			for(i = 0; i < btns.length; i++)
			{
				btns[i].y = 480 + firstX + i * 50;
			}
			rightBottomBtn.status = SButton.Status_Down;
		}
		/**
		 * 请求进入副本 
		 * @param instanceId
		 * 
		 */		
		private function enterInstance(instanceId:int):void
		{
			dispatchEvent(new HurdleGuideEvent(HurdleGuideEvent.ENTER_INSTANCE,instanceId));
		}
		
		override public function close():void
		{
			super.close();
			if(_cont && _cont.parent)
			{
				_cont.parent.removeChild(_cont);
				_cont.clear();
				_cont = null;
			}
			var rightBottomBtn:SButton;
			for(var i:int = 0; i < _difficultBtnList.length; i++)
			{
				rightBottomBtn = _difficultBtnList[i];
				rightBottomBtn.removeEventListener(MouseEvent.CLICK,onChangePage);
				removeChild(rightBottomBtn);
			}
			_difficultBtnList.length = 0;
			
			var mc:McActiveObject;
			var leftBottomBox:MovieClip;
			for( i = 0; i < _model.curChapter.hardNum; i++)
			{
				mc = getChildByName("giftBtn" + i) as McActiveObject;
				leftBottomBox = getChildByName("box" + i) as MovieClip;
				mc.removeEventListener(MouseEvent.CLICK,onGetGift);
				removeChild(mc);
				leftBottomBox.stop();
				removeChild(leftBottomBox);
			}
			
			_closeBtn.removeEventListener(MouseEvent.CLICK,onClose);
			
			_model.clear();
			
			WindowManager.inst.closeGeneralWindow(HurdleClearOutWindow);
		}
	}
}