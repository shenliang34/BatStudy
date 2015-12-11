package com.gamehero.sxd2.world.display
{
	import flash.display.BitmapData;
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import bowser.render.vo.AnimationVO;

	/**
	 * swf的动画数据，包括每帧的截图，注册点
	 * @author weiyanyu
	 * 创建时间：2015-7-13 上午11:04:23
	 * 
	 */
	public class SwfAtlas
	{
		private var _mc:MovieClip;
		/**
		 * 标签帧位置   key 标签  value 位置
		 */		
		private var _frameDict:Dictionary;
		
		/**
		 * 动作长度字典  key 动作标签  value 长度
		 */		
		private var _actionDict:Dictionary;	
		
		/**
		 * 已经绘制的帧数；
		 * 如果绘制的帧数等于总帧数的时候，mc要释放掉 
		 */		
		private var _drawNum:int;
		/**
		 * swf总帧数 
		 * @return 
		 * 
		 */		
		
		public var totalFrame:int;

		/**
		 * 是否有动作（标签） 
		 * （一些简单的swf不需要动作）
		 */		
		public function get hasLabels():Boolean
		{
			return _hasLabels;
		}
		//是否有动作（标签） 
		private var _hasLabels:Boolean;
		/**
		 * 帧数组 
		 */		
		private var _frameAnimVec:Vector.<AnimationVO>;
		
		
		private var _actionXML:XML;
		public function get actionXML():XML
		{
			return _actionXML;
		}
		
		
		public function SwfAtlas(mc:MovieClip)
		{
			_mc = mc;
			totalFrame = mc.totalFrames;
			_frameAnimVec = new Vector.<AnimationVO>(mc.totalFrames);
			
			var labelsNum:int = _mc.currentLabels.length;//数组长度
			if(labelsNum > 0)//如果有标签
			{
				_frameDict = new Dictionary();
				
				_actionDict = new Dictionary();
				
				_actionXML = _mc.xml;
				var actionLen:int;//动作长度
				
				var beginFrame:FrameLabel;//当前标签所在位置
				var endFrame:FrameLabel;//新的标签开始位置
				
				for(var i:int = 0; i < labelsNum; i++)
				{
					beginFrame = _mc.currentLabels[i] as FrameLabel;
					
					if(i < labelsNum - 1)
					{
						endFrame = mc.currentLabels[i + 1];
						actionLen = endFrame.frame - beginFrame.frame;
					}
					else
					{
						actionLen = _mc.totalFrames + 1 - beginFrame.frame;
					}
					_actionDict[beginFrame.name] = actionLen;
					_frameDict[beginFrame.name] = beginFrame.frame - 1;
				}
				_hasLabels = true;
			}
			else//没有标签
			{
				_hasLabels = false;
			}

		}
		/**
		 * @param status 动作状态
		 * @param frameNum 动作所在的帧头位置 从0开始
		 * @return 当前位置的数据
		 * 
		 */		
		public function getAnimation(status:String,frameNum:int):AnimationVO
		{
			var actionFrame:int = _frameDict[status] + frameNum;//找到动作的帧头位置
			return getCurAnimation(actionFrame);
		}
		/**
		 * 根据帧的位置直接获得帧的数据 
		 * @param frameNum 帧头
		 * @return 
		 * 
		 */		
		public function getCurAnimation(frameNum:int):AnimationVO
		{
			if(_frameAnimVec[frameNum]) return _frameAnimVec[frameNum];
			_frameAnimVec[frameNum] = drawMc(frameNum);
			return _frameAnimVec[frameNum];
		}
		/**
		 * 获取动作的长度 
		 * @return 
		 * 
		 */		
		public function getStatusLen(status:String):int
		{
			return int(_actionDict[status]);
		}
		//绘制帧
		private function drawMc(frameNum:int):AnimationVO
		{
			_mc.gotoAndStop(frameNum + 1);
			var rect:Rectangle = _mc.getBounds(_mc);
			if(rect.isEmpty())	return null;
			
			// TRICKY：注意小数，若不取整，某些含有小数的、regPoint不一致的情况下会出现动画轻微抖动情况
			rect.x = int(rect.x);
			rect.y = int(rect.y);
			
			var bitmapData:BitmapData = new BitmapData(rect.width, rect.height, true, 0);
			var matrix:Matrix = new Matrix();
			matrix.translate(-rect.x, -rect.y);
			
			bitmapData.draw(_mc, matrix);
			
			// TRICKY: 进一步缩小BitmapData大小, 去掉透明区域，4278190080即0xFF000000
			// 灰常重要，如果不去掉透明区域，内存占用率会大大的提升
			var tempRect:Rectangle = bitmapData.getColorBoundsRect(4278190080, 0, false);
			if(tempRect.width != 0 && tempRect.height != 0 && 
				(tempRect.width != bitmapData.width || tempRect.height != bitmapData.height) ) {
				var shrinkBD:BitmapData = new BitmapData(tempRect.width, tempRect.height, true, 0);
				shrinkBD.copyPixels(bitmapData, tempRect, new Point(0, 0));
				bitmapData.dispose();
				bitmapData = shrinkBD;
				rect.offset(tempRect.x, tempRect.y);
			}
			var animationVO:AnimationVO = new AnimationVO();
			animationVO.bitmapData = bitmapData;
			animationVO.regPoint = new Point((-rect.x), (-rect.y));
			_drawNum ++;
			if(_drawNum >= _mc.totalFrames) _mc = null;//释放掉mc
			return animationVO;
		}
		
		
		public function dispose():void
		{
			_mc = null;
			if(_actionDict)
			{
				for(var frameName:String in _actionDict )
				{
					_actionDict[frameName] = null;
					delete _actionDict[frameName];
				}
				_actionDict = null;
			}
			if(_frameDict)
			{
				for(var frameName1:String in _frameDict )
				{
					_frameDict[frameName1] = null;
					delete _frameDict[frameName1];
				}
				_frameDict = null;
			}
			
			for each(var vo:AnimationVO in _frameAnimVec)
			{
				if(vo != null)
				{
					vo.clear();
					vo = null;
				}
			}
			
			_frameAnimVec = null;
			
		}
	}
}