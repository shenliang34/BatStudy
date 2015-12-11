package com.gamehero.sxd2.util
{
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	

	/**
	 *异步器 
	 * 支持以下功能：
	 * addFuncByFrame:添加轮询回调函数，轮询帧数间隔取值范围为1-10000;
	 * addFuncByTime:添加一次性回调函数，时间间隔为下一帧
	 * addFuncToEnd:
	 * to:缓动接口
	 * @author wulongbin
	 */
	public class WasynItem implements IasynItem
	{		
		
		protected var _timeFuncs:Dictionary;
		protected var _currentFrameFuncs:Dictionary;
		protected var _frameFuncs:Dictionary;
		protected var _bigSpaceLine:Vector.<WheadNode>;
		protected var _currentTime:uint;
		protected var _currentNode:WfuncNode;
		
		protected var _tweens:Dictionary;
		protected var _nowFrame:Number;
		protected var _nowTime:Number;
		protected var _stepTime:Number=0;
		protected var _lastTime:Number;
		protected var _offTime:Number;
		
		
//		protected var _threaders:Dictionary;
		
		/**
		 *最大时间间隔 
		 */		
		protected var Max_Space:uint=0;
		public function WasynItem():void
		{
			this.Max_Space=(1<<14)-1;
			init();
		}
		
		protected function init():void
		{
			_frameFuncs=new Dictionary;
			_timeFuncs=new Dictionary;
			_currentFrameFuncs=new Dictionary;
			var len:int=Max_Space+1;
			_bigSpaceLine=new Vector.<WheadNode>(len,true);
			for(var i:int=0;i<len;i++)
			{
				_bigSpaceLine[i]=new WheadNode;
			}
			_currentTime=0;
			
			_tweens=new Dictionary();
			_nowFrame=0;
			_nowTime=0;
			_lastTime=getTimer();
		}
		/**
		 *添加轮询函数，若相同函数已经添加轮询，则会自动移除上次添加的轮询 
		 * @param callback
		 * @param frame 轮询周期，默认为每帧轮询一次
		 * 
		 */		
		public function addFuncByFrame(callback:Function,frame:uint=1):void
		{
			var node:WfuncNode=_frameFuncs[callback] as WfuncNode;
			if(node!=null)
			{
				node.func=null;
				node.nextLine=nullNode;
			}
			if(frame<1) frame=1;
			node=new WfuncNode(callback,nextLine,frame);
			var topNode:WheadNode=_bigSpaceLine[(_currentTime+frame)&Max_Space];
			topNode.last.next=node;
			topNode.last=node;
			_frameFuncs[callback]=node;
		}
		/**
		 *移除轮询 
		 * @param callback
		 * 
		 */		
		public function removeFuncByFrame(callback:Function):void
		{
			var node:WfuncNode=_frameFuncs[callback] as WfuncNode;
			if(node==null) return;
			node.func=null;
			node.nextLine=nullNode;
			delete _frameFuncs[callback];
		}
		/**
		 *添加一次性回调函数，当执行完回调后会自动删除该回调引用
		 * @param callback
		 * @param frame 延迟帧时间
		 * 
		 */		
		public function addFuncByTimer(callback:Function,frame:uint=1):void
		{
			var node:WfuncNode=_timeFuncs[callback] as WfuncNode;
			if(node!=null)
			{
				node.func=null;
				node.nextLine=nullNode;
			}
			frame=Math.max(frame,1);
			node=new WfuncNode(callback,oneTimeNode,frame);
			var topNode:WheadNode=_bigSpaceLine[(_currentTime+frame)&Max_Space];
			topNode.last.next=node;
			topNode.last=node;
			_timeFuncs[callback]=node;
		}
		/**
		 *移除一次性回调函数 
		 * @param func
		 * 
		 */		
		public function removeFuncByTimer(func:Function):void
		{
			
			var node:WfuncNode=_timeFuncs[func] as WfuncNode;
			if(node==null) return;
			node.func=null;
			node.nextLine=nullNode;
			delete _timeFuncs[func];
		}
		
		public function addFuncToEnd(func:Function):void
		{
			_currentFrameFuncs[func]=func;
		}
		
		public function removeFuncToEnd(func:Function):void
		{
			delete _currentFrameFuncs[func];
		}
		
		
		
		private var nextNode:WfuncNode;
		public function renderFrame():void
		{
			var lastTime:Number=getTimer();
			_offTime=(lastTime-_lastTime);
			_stepTime=_offTime*App.stage.frameRate*0.001;
			_nowTime+=lastTime-_lastTime;
			_lastTime=lastTime;
			_nowFrame++;
			
			_currentTime=(_currentTime+1)&Max_Space;
			var currentLine:WheadNode=_bigSpaceLine[_currentTime];
			_currentNode= currentLine.next;
			while(_currentNode)
			{
				nextNode=_currentNode.next;
				_currentNode.nextLine();
				_currentNode=nextNode;
			}
			currentLine.reset();
			
			for each(var func:Function in _currentFrameFuncs)
			{
				delete _currentFrameFuncs[func];
				func();
			}
//			renderThreader();
		}
		
		private function nullNode():void
		{
			
		}
		
		private function oneTimeNode():void
		{
			delete _timeFuncs[_currentNode.func];
			_currentNode.func();
		}
		
		private function nextLine():void
		{
			_currentNode.func();
			var spaceLine:WheadNode=_bigSpaceLine[(_currentTime+_currentNode.space)&Max_Space];
			spaceLine.last.next=_currentNode;
			spaceLine.last=_currentNode;
			_currentNode.next=null;
		}		
		
		//==============Tween=======================
		
		public function get nowFrame():Number
		{
			return _nowFrame;
		}
		
		public function get nowTime():Number
		{
			return _nowTime;
		}
		/**
		 *步长系数，相对于一帧的时间系数 
		 * @return 
		 * 
		 */		
		public function get stepTime():Number
		{
			return _stepTime;
		}
		
		public function killTarget(target:Object):void
		{
			delete _tweens[target];
		}
		
//		public function renderThreader():void
//		{
//			for each(var obj:Wthreader in _threaders)
//			{
//				obj.run();
//			}
//		}
		
		public function set running(value:Boolean):void
		{
			if(value)
			{
				_lastTime=getTimer();
			}
		}
		
		public function get running():Boolean
		{
			return false;
		}
		
//		public function addThreader(loopFunc:Function, completeFunc:Function=null, minTime:uint=5):void
//		{
//			var threader:Wthreader=new Wthreader(this,loopFunc,completeFunc,minTime);
//			_threaders[threader]=threader;
//			threader.start();
//		}
		
//		public function removeThreader(t:Wthreader):void
//		{
//			delete _threaders[t];
//		}
		
		public function disposeAsynItem():void
		{
			//delete Timer
			var node:WfuncNode;
			var callBack:*;
			for(callBack in _frameFuncs)
			{
				node=_frameFuncs[callBack] as WfuncNode;
				node.func=nullNode;
				delete _frameFuncs[callBack];
			}
		}

		public function get offTime():Number
		{
			return _offTime;
		}

	}
}
class WfuncNode
{
	public var next:WfuncNode;
	public var space:uint;
	public var func:Function;
	public var nextLine:Function;
	public function WfuncNode(func:Function,nextLine:Function,space:uint):void
	{
		this.func=func;
		this.nextLine=nextLine;
		this.space=space;
	}
}

class WheadNode extends WfuncNode
{
	public var last:WfuncNode;
	public function WheadNode():void
	{
		super(null,null,0);
		last=this;
	}
	
	public function reset():void
	{
		last=this;
		next=null;
	}
}
