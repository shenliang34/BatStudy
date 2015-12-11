package com.gamehero.sxd2.gui.hurdleGuide
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.core.GeneralWindow;
	import com.gamehero.sxd2.gui.core.components.InnerBg;
	import com.gamehero.sxd2.gui.hurdleGuide.components.HurdleClearItemRender;
	import com.gamehero.sxd2.gui.hurdleGuide.event.HurdleClearOutEvent;
	import com.gamehero.sxd2.gui.hurdleGuide.model.vo.HurdleVo;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.scrollPane.NormalScrollPane;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.inputBox.InputNumBox;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.gui.tips.HurdleGuideTips;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.pro.PRO_Item;
	import com.gamehero.sxd2.vo.GiftBoxVo;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import alternativa.gui.controls.text.Label;
	
	/**
	 *  扫荡界面
	 * @author weiyanyu
	 * 创建时间：2015-9-6 上午10:22:24
	 * 
	 */
	public class HurdleClearOutWindow extends GeneralWindow
	{
		/**		 * 开始扫荡 		 */		
		private const BEGIN_CLEAR:int = 1;
		/**		 * 暂停扫荡 		 */		 
		private const PAUSE_CLEAR:int = 2;
		/**		 * 继续扫荡 		 */		
		private const GOON_CLEAR:int = 3;
		/**		 * 扫荡状态		 */		
		private var _status:int = -1;
		
		/**		 * 服务器发送的单条奖励信息		 */		
		private const REPOT:int = 1;
		/**		 * 客户端统计所有的奖励信息		 */		
		private const STATISTICS:int = 2;
		
		/**		 * 已经扫荡的次数 		 */		
		private var _hasCounted:int = 0;
		/**		 * 扫荡反馈面板 		 */		
		private var _infoPanel:NormalScrollPane;
		/**		 * 最初打开界面的时候需要显示的 信息		 */		
		private var _beginInfoPanel:Sprite;
		/**	 * 次数输入  */		
		private var _numStepper:InputNumBox;
		/**		 * 体力消耗文本说明		 */		
		private var _stepperLabel:Label;
		
		/**	 * 计时器 	 */		
		private var _intervalId:uint;
		/**	 * 计时器间隔 	 */		
		private const INTERVAL_TIME:int = 2000;
		
		/**    开始扫荡/停止扫荡  */		
		private var _clearOutBtn:Button;
		/**	 * 奖励条目  */		
		private var _hurdleGiftVec:Vector.<HurdleClearItemRender>;
		/**		 * 最后一条奖励条目		 */		
		private var _preHurdleRender:HurdleClearItemRender;
		/**	 * 扫荡中的描述		 */		
		private var _clearOutDec:Label;
		/**		 * 统计获得的所有物品 		 */		
		private var _statisticsDict:Dictionary;
		/**		 * 统计呈现项		 */		
		private var _statisticsItem:HurdleClearItemRender;
		
		private var _data:HurdleVo;
		
		public function HurdleClearOutWindow(position:int, resourceURL:String="HurdleClearOut.swf", width:Number=0, height:Number=0)
		{
			super(position, resourceURL, 321, 351);
		}
		override protected function initWindow():void
		{
			super.initWindow();
			// 九宫格框
			var innerBg:InnerBg = new InnerBg();
			addInnerBg(innerBg,8,39,305,211);
			
			_infoPanel = new NormalScrollPane();
			_infoPanel.width = 305;
			_infoPanel.height = 191;
			add(_infoPanel,8,39);
			_infoPanel.content = new Sprite();
			
		    innerBg = new InnerBg();
			add(innerBg,8,252,305,86);
			
			_stepperLabel = new Label();
			add(_stepperLabel,17,263,49,14);
			_stepperLabel.color = GameDictionary.WINDOW_WHITE;
			_stepperLabel.text = "扫荡次数";
			
			_stepperLabel = new Label();
			add(_stepperLabel,181,263);
			
			_numStepper = new InputNumBox();
			add(_numStepper,70,261);
			_numStepper.needEvent = true;
			
			var line:Bitmap = new Bitmap(getSwfBD("LINE"));
			add(line,20,286);
			
			_clearOutBtn = new Button(CommonSkin.blueButton1Up,CommonSkin.blueButton1Down,CommonSkin.blueButton1Over);
			add(_clearOutBtn,126,297);
			_clearOutBtn.label = "开始扫荡";
			
			_clearOutDec = new Label();
			add(_clearOutDec,15,233);
			_clearOutDec.size = 14;
			_clearOutDec.color = GameDictionary.YELLOW;
		}
		override public function onShow():void
		{
			super.onShow();
			_clearOutBtn.addEventListener(MouseEvent.CLICK,onClearClick);
			_numStepper.addEventListener(Event.CHANGE,numChange);
			
			_data = windowParam as HurdleVo;
			setStatus(BEGIN_CLEAR);

			_numStepper.maxNum = int(GameData.inst.playerExtraInfo.stamina / _data.consume_num);
			_numStepper.num = _numStepper.maxNum > 0 ? 1 : 0;
			_numStepper.defaultNum = 1;
			_numStepper.needEvent = true;

			setCostLabel();
			
			_clearOutDec.visible = false;
			
			_hurdleGiftVec = new Vector.<HurdleClearItemRender>();
			_statisticsDict = new Dictionary();
			
		}
		/**
		 * 步进器改变 
		 */		
		protected function numChange(event:Event):void
		{
			setCostLabel();
		}
		/**
		 * 设置 最大数量
		 */		 
		protected function onMaxHandler(event:MouseEvent):void
		{
			var maxCount:int = GameData.inst.playerExtraInfo.stamina / _data.consume_num
			_numStepper.num = _numStepper.maxNum = maxCount;
			setCostLabel();
		}
		/**
		 * 重新设置说明文字 
		 */	
		private function setCostLabel():void
		{
			_stepperLabel.text = GameDictionary.createCommonText("消耗") 
				+ GameDictionary.createCommonText("" + (_data.consume_num * int(_numStepper.num)),GameDictionary.YELLOW)
				+ GameDictionary.createCommonText("体力");
		}
		/**
		 * 点击按钮 开始扫荡/停止扫荡 /继续扫荡
		 * @param event
		 */		
		protected function onClearClick(event:MouseEvent):void
		{
			switch(_status)
			{
				case BEGIN_CLEAR://当前为刚打开窗口的状态
				{
					if(canClearOut)
					{
						clearBeginPanel();
						setStatus(PAUSE_CLEAR);
					}
					break;
				}
				case PAUSE_CLEAR://正在扫荡中
				{
					setStatus(GOON_CLEAR);
					break;
				}
				case GOON_CLEAR://扫荡停止
				{
					if(canClearOut)
					{
						clearStatisticsItem();
						setStatus(PAUSE_CLEAR);
					}
					break;
				}
			}
		}
		/**
		 * 判断是否可以扫荡 
		 * @return 
		 */		
		private function get canClearOut():Boolean
		{
			if(_numStepper.num == 0) return false;
			if(GameData.inst.playerExtraInfo.stamina < _data.consume_num) return false;
			return true;
		}
		/**
		 * 设置当前扫荡状态 
		 * @param status
		 */		
		private function setStatus(status:int):void
		{
			_status = status;
			switch(status)
			{
				case BEGIN_CLEAR://
				{
					setBeginInfo();
					_clearOutBtn.label = "开始扫荡";
					break;
				}
				case PAUSE_CLEAR://
				{
					clearItem();
					_clearOutDec.text = "正在扫荡第" + (_hasCounted + 1) + "次";
					_clearOutDec.visible = true;
					_numStepper.needEvent = false;
					beginClearOut();
					_clearOutBtn.label = "结束扫荡";
					break;
				}
				case GOON_CLEAR://
				{
					_clearOutDec.text = "扫荡已完成";
					_numStepper.needEvent = true;
					_hasCounted = 0;
					clearIntervalId();
					_clearOutBtn.label = "继续扫荡";
					addRenderItem(getStatisticsArr(),STATISTICS);
					break;
				}
			}
		}
		/**
		 * 设置开始扫荡之前显示数据 
		 */		
		private function setBeginInfo():void
		{
			var proList:Vector.<Vector.<GiftBoxVo>> = ItemManager.instance.getMustProList(_data.box_id);
			_beginInfoPanel = HurdleGuideTips.getBoxItemCont(proList);
			add(_beginInfoPanel,18,53);
		}
		/**
		 * 获取统计信息 
		 * @return 
		 * 
		 */		
		private function getStatisticsArr():Array
		{
			var arr:Array = new Array;
			for each(var pro:PRO_Item in _statisticsDict)
			{
				arr.push(pro);
			}
			return arr;
		}
		/**
		 * 清除开始时候的展示面板 
		 */		
		private function clearBeginPanel():void
		{
			if(_beginInfoPanel)
			{
				removeChild(_beginInfoPanel);
				_beginInfoPanel = null;
			}
		}
		/**
		 * 清除统计 
		 */		
		private function clearStatisticsItem():void
		{
			if(_statisticsItem)
			{
				(_infoPanel.content as Sprite).removeChild(_statisticsItem);
				_statisticsItem.clear();
				_statisticsItem = null;
			}
		}
		/**
		 * 开始扫荡；继续扫荡 
		 */		
		private function beginClearOut():void
		{
			clearIntervalId();
			_intervalId = setInterval(clearOutHandler,INTERVAL_TIME);
		}
		/**
		 * 每2s扫荡一次 
		 */		
		private function clearOutHandler():void
		{
			dispatchEvent(new HurdleClearOutEvent(HurdleClearOutEvent.CLEAR_OUT,_data.id));
		}
		/**
		 * 添加扫荡奖励 
		 * @param arr 奖励数组
		 */		
		public function addReport(arr:Array):void
		{
			for each(var pro:PRO_Item in arr)
			{
				if(_statisticsDict[pro.itemId])
				{
					(_statisticsDict[pro.itemId] as PRO_Item).num += pro.num;//统计所有的相同道具的数量
				}
				else
				{
					_statisticsDict[pro.itemId] = pro;
				}
			}
			addRenderItem(arr);
		}
		
		public function stopClearOut():void
		{
			setStatus(GOON_CLEAR);
		}
		
		/**
		 *  添加单条界面
		 * @param arr 奖励数据
		 * @param type
		 */		
		private function addRenderItem(arr:Array,type:int = REPOT):void
		{
			var item:HurdleClearItemRender = new HurdleClearItemRender();
			arr.sortOn("itemId",Array.NUMERIC);
			switch(type)
			{
				case REPOT:
					item.setData(arr,_hasCounted);
					_hurdleGiftVec.push(item);
					if(_preHurdleRender){
						item.y = 0 + _preHurdleRender.y + _preHurdleRender.height;
					}else{
						item.y = 0;
					}
					
					_hasCounted ++;
					_clearOutDec.text = "正在扫荡第" + (_hasCounted + 1) + "次";

					_preHurdleRender = item;
					
					
					_numStepper.num --;
					setCostLabel();
					_numStepper.maxNum = int(GameData.inst.playerExtraInfo.stamina / _data.consume_num);
					if(_numStepper.num <= 0 || !canClearOut)
					{
						clearIntervalId();
						setStatus(GOON_CLEAR);
					}
					break;
				case STATISTICS:
					if(_preHurdleRender)
					{
						item.statistics(arr,"扫荡共计获得");
						_statisticsItem = item;
						_statisticsItem.y = 0 + _preHurdleRender.y + _preHurdleRender.height;
						_preHurdleRender = null;
					}
					break;
			}

			(_infoPanel.content as Sprite).addChild(item);
			item.x = 10;
			_infoPanel.refresh();
			_infoPanel.scrollBar.scrollPosition = _infoPanel.scrollBar.maxScrollPosition;
	
		}
		
		/**
		 * 清除计时器interval 
		 */		
		private function clearIntervalId():void
		{
			if(_intervalId > 0)
			{
				clearInterval(_intervalId);
				_intervalId = 0;
			}
		}
		
		override public function close():void
		{
			super.close();
			_clearOutBtn.removeEventListener(MouseEvent.CLICK,onClearClick);
			_numStepper.removeEventListener(Event.CHANGE,numChange);
			
			clearIntervalId();
		
			clearItem();
			
			_hasCounted = 0;            
			
			
			_preHurdleRender = null;
			clearBeginPanel();
			
			_hurdleGiftVec = null;
			_statisticsDict = null;
		}
		/**
		 * 清除所有的展示item 
		 * 
		 */		
		private function clearItem():void
		{
			if(_hurdleGiftVec)
			{
				for(var i:int = 0; i < _hurdleGiftVec.length; i++)
				{
					var item:HurdleClearItemRender = _hurdleGiftVec[i];
					item.clear();
					(_infoPanel.content as Sprite).removeChild(item);
				}
				_hurdleGiftVec.length = 0;
			}
			clearStatisticsItem();
			
			if(_statisticsDict)
			{
				for each(var pro:PRO_Item in _statisticsDict)
				{
					_statisticsDict[pro.itemId] = null;
					delete _statisticsDict[pro.itemId];
				}
			}
			
			_infoPanel.refresh();
		}
	}
}