package com.gamehero.sxd2.gui.hurdleGuide.components
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.gui.hurdleGuide.model.HurdleGuideModel;
	import com.gamehero.sxd2.pro.PRO_Instance;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import alternativa.gui.base.GUIobject;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.loadingtypes.LoadingItem;
	
	/**
	 * 剧情副本导航内容
	 * @author weiyanyu
	 * 创建时间：2015-8-30 下午5:50:02
	 * 
	 */
	public class HurdleCont extends GUIobject
	{
		/**
		 * 中间展示的关卡节点容器 
		 */		
		private var _mainMc:MovieClip;
		/**
		 * 副本连线 
		 */		
		private var _hurdleLine:HurdleGuideLine = new HurdleGuideLine();
		/**
		 * 当前关卡节点 
		 */		
		private var _curInstanceList:Array;
		
		private var _nodeList:Vector.<HurdleGuideNode> = new Vector.<HurdleGuideNode>();
		
		
		private var _model:HurdleGuideModel;
		/**
		 * 请求进入副本 
		 */		
		public var enterInstance:Function;
		
		private var _url:String;
		
		private var _loader:BulkLoaderSingleton;
		
		public function HurdleCont()
		{
			super();
			_model = HurdleGuideModel.inst;
			_loader = BulkLoaderSingleton.instance;
		}
		
		private function onloaded(event:Event):void
		{
			var loadingItem:LoadingItem = event.target as LoadingItem;
			loadingItem.removeEventListener(Event.COMPLETE, onloaded);
			_mainMc = loadingItem.content as MovieClip;
			addChild(_mainMc);

			_hurdleLine.setMc((_mainMc.getChildByName("cloudMc") as MovieClip).getChildByName("lineMc") as MovieClip);
			var node:HurdleGuideNode;
			for(var i:int = 0; i < _model.curChapter.hurdleList[_model.curDiff].length; i++)//当前难度的节点设置
			{
		
				node = new HurdleGuideNode();
				node.setNode((_mainMc.getChildByName("node" + (i+1)) as MovieClip));
				node.enterInstance = enterInstance;
				_nodeList.push(node);
			}
			setDiff(_model.curDiff);
		}
		/**
		 * 设置难度 
		 * 
		 */		
		public function setDiff(value:int):void
		{
			if(_mainMc != null)
			{
				_mainMc.gotoAndStop(value + 1);
				switch(value)//获取当前难度的副本列表
				{
					case HurdleGuideModel.EASY:
						_curInstanceList = _model.curChapter.simple;
						break
					case HurdleGuideModel.HARD:
						_curInstanceList = _model.curChapter.hard;
						break
					case HurdleGuideModel.HELL:
						_curInstanceList = _model.curChapter.hell;
						break;
				}
				var node:HurdleGuideNode;
				var pro:PRO_Instance;
				var curLv:int;//未开放的位置
				for(var i:int = 0; i < _curInstanceList.length; i++)
				{
					node = _nodeList[i];
					node.setNodeData(int(_curInstanceList[i]));
					pro = _model.getNodeData(_curInstanceList[i]);
					node.updata(pro);
					if(node.status == HurdleGuideNode.OPEN || node.status == HurdleGuideNode.OVERRED)//如果已开启或者已通关，则记录一次节点 
					{
						curLv ++;
					}
				}
				
				_hurdleLine.setLevel(curLv);
				
				if(_model.curTipsNode > -1)//设置提示的节点
				{
					_nodeList[_model.curTipsNode].addTips();
				}
			}
			else
			{
				_loader.addWithListener(GameConfig.HURLDLE_URL + _model.curChapterId + ".swf",null,onloaded);
				_loader.start();
			}
			
		}
		
		
		public function clear():void
		{
			_hurdleLine.clear();
			if(_mainMc)
			{
				_mainMc.stop();
				if(_mainMc.parent)
					_mainMc.parent.removeChild(_mainMc);
			}
			_loader.removeEventListener(Event.COMPLETE, onloaded);
			_mainMc = null;
			_curInstanceList = null;
			_model = null;
			var node:HurdleGuideNode;
			for(var i:int = 0; i < _nodeList.length; i++)//当前难度的节点设置
			{
				node = _nodeList[i];
				node.clear();
			}
			_nodeList.length = 0;
			enterInstance = null;
		}
	}
}