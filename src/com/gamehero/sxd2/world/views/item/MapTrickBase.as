package com.gamehero.sxd2.world.views.item
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.world.display.SwfRenderItem;
	import com.gamehero.sxd2.world.event.SwfRenderEvent;
	import com.gamehero.sxd2.world.model.MapTrickerType;
	import com.gamehero.sxd2.world.model.vo.SwfActionVo;
	
	import flash.events.Event;
	
	import bowser.render.display.SpriteItem;
	
	/**
	 * 非人挂件
	 * @author weiyanyu
	 * 创建时间：2015-7-14 下午8:30:22
	 * 
	 */
	public class MapTrickBase extends InterActiveItem
	{
		/**
		 * 渲染的swf组件 
		 */		
		public var body:SwfRenderItem;
		
		/**
		 * 动作数组 
		 */		
		private var _actionVec:Vector.<SwfActionVo>;
		
		private var _curAction:SwfActionVo;
		/**
		 * 触发条件的函数，判断是否达到条件 
		 */		
		private var _trigFun:Function;
		/**
		 * 处理条件的函数 
		 */		
		private var _resultFun:Function;
		/**
		 * 动作是否播放结束 
		 */		
		private var _isLoopOver:Boolean;
		
		private var _gameData:GameData;
		public function MapTrickBase(swfUrl:String)
		{
			super();
			body = new SwfRenderItem(swfUrl);
			addChild(body);
			if(body.isLoaded)
			{
				onSwfLoaded();
			}
			else
			{
				body.addEventListener(SwfRenderEvent.LOADED,onSwfLoaded);
			}
			body.addEventListener(SwfRenderEvent.ISOVER,isOverLooped);
			this.addEventListener(SwfRenderEvent.ADDED,onAdded);
			_gameData = GameData.inst;
		}
		
		protected function onAdded(event:Event):void
		{
			onSwfLoaded();
		}
		
		protected function isOverLooped(event:Event):void
		{
			_isLoopOver = true;
		}
		/**
		 * swf加载完成后解析响应配置 
		 * @param event
		 * 
		 */		
		protected function onSwfLoaded(event:Event = null):void
		{
			var swfVo:SwfActionVo;
			if(!body.isLoaded) return;
			if(body.actionXml == null) return;
			_actionVec = new Vector.<SwfActionVo>();
			var blendMode:String = body.actionXml.@blendMode;
			body.blendMode = blendMode == "" ? null : blendMode;
			body.frameRate = body.actionXml.@frameRate;
			for each(var xml:XML in body.actionXml.action)
			{
				swfVo = new SwfActionVo();
				swfVo.fromXml(xml);
				_actionVec.push(swfVo);
			}
			_curAction = _actionVec[0];
			setAction(_curAction.index);
		}
		
		/**
		 * 设置动作
		 */		
		private function setAction(act:int):void
		{
			if(act >= _actionVec.length) return;
			_curAction = _actionVec[act];
			body.status = "a" + _curAction.index;
			body.loop = _curAction.loop;
			
			_isLoopOver = false;
			
			switch(_curAction.trigType)
			{
				case MapTrickerType.TRIG_PLAYERLOC:
					_trigFun = checkPlayerLoc;
					break;
				case MapTrickerType.TRIG_ISLOOPOVER:
					_trigFun = isOverLoop;
					break;
				default:
					_trigFun = null;
			}
			switch(_curAction.resultType)
			{
				case MapTrickerType.RES_NEXTACTION:
					_resultFun = nextAction;
					break;
				case MapTrickerType.RES_REMOVESTAGE:
					_resultFun = removeStage;
					break;
				default:
					_resultFun = null;
			}
		}
		
		public function enterframe():void
		{
			if(_curAction)
			{
				if(_trigFun == null) return;
				if(_trigFun())
				{
					_resultFun();
				}
			}
		}
		/**
		 * 判断与主角的坐标，当玩家坐标大于挂件坐标时候触发 
		 * 
		 */		
		private function checkPlayerLoc():Boolean
		{
			if(this.x < _gameData.roleInfo.map.x)
			{
				return true;
			}
			else
				return false;
		}
		/**
		 *  动作是否播放结束 
		 * @return 
		 * 
		 */		
		private function isOverLoop():Boolean
		{
			return _isLoopOver;
		}
		
		
		/**
		 * 播放下一个动作 
		 * 
		 */		
		private function nextAction():void
		{
			setAction(++_curAction.index);
		}
		/**
		 * 从舞台上删除掉 
		 * 
		 */		
		public function removeStage():void
		{
			(this.parent as SpriteItem).removeChild(this);
			gc();
		}
		
		override public function gc(isCleanAll:Boolean=false):void
		{
			
			_actionVec = null;
			_gameData = null;
			_trigFun = null;
			_resultFun = null;
			body.removeEventListener(SwfRenderEvent.LOADED,onSwfLoaded);
			body.removeEventListener(SwfRenderEvent.ISOVER,isOverLooped);
			this.removeEventListener(SwfRenderEvent.ADDED,onAdded);
			body = null;
			super.gc();
		}
		
	}
}