package com.gamehero.sxd2.gui.takeCards.components
{
	import com.gamehero.sxd2.battle.display.BattleFigureItem;
	import com.gamehero.sxd2.common.SpriteFigureItem;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.gui.core.components.McActiveObject;
	import com.gamehero.sxd2.gui.player.hero.model.HeroDict;
	import com.gamehero.sxd2.gui.takeCards.event.TakeCardsEvent;
	import com.gamehero.sxd2.gui.takeCards.model.TakeCardsModel;
	import com.gamehero.sxd2.manager.HeroManager;
	import com.gamehero.sxd2.vo.HeroVO;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import alternativa.gui.base.ActiveObject;
	
	/**
	 * 
	 * @author weiyanyu
	 * 创建时间：2015-10-15 下午9:03:49
	 * 
	 */
	public class TakeCardsHeroItem extends ActiveObject
	{
		/**
		 * 人物模型 
		 */		
		private var _figure:SpriteFigureItem;
		/**
		 * 数据 
		 */		
		private var _heroVo:HeroVO;
		/**
		 *  
		 */		
		private var _model:TakeCardsModel;
		/**
		 * 火球 
		 */		
		private var _fireMc:MovieClip;
		/**
		 * 索引 
		 */		
		private var _index:int;
		
		private var _activeMc:McActiveObject;
		public function TakeCardsHeroItem()
		{
			super();
			_model = TakeCardsModel.inst;
			this.height = 170;
			this.width = 107;
			_activeMc = new McActiveObject();
			
		}

		/**
		 * 索引 
		 * @return 
		 * 
		 */		
		public function get index():int
		{
			return _index;
		}

		public function set index(value:int):void
		{
			_index = value;
			
			_heroVo = HeroManager.instance.getHeroByID(_model.msg.items[value] + "");
			_activeMc.data = _heroVo;
			
			var url:String = GameConfig.BATTLE_FIGURE_URL + _heroVo.url;
			if(_figure)
			{
				_figure.clear();
				_figure.load(url);
				_figure.frameRate = 18;
			}
			else
			{
				_figure = new SpriteFigureItem(url,false,BattleFigureItem.STAND);
				_figure.frameRate = 18;
				
				_fireMc = Global.instance.getRes(_model.domain,"Quality_" +_heroVo.quality) as MovieClip;
				addChild(_fireMc);
				
				addChild(_activeMc);//让交互区域放在最上层
			}
		}

		protected function onGet(event:MouseEvent):void
		{
			_model.heroIsOpenVec[index] = true;
			setOpen(true);
		}
		/**
		 * 设置是否打开 
		 * @param value
		 * 
		 */		
		public function setOpen(value:Boolean,isInit:Boolean = false):void
		{
			var rect:Rectangle;
			if(value)//伙伴出来了
			{
				_activeMc.removeEventListener(MouseEvent.CLICK,onGet);
				_activeMc.removeEventListener(MouseEvent.ROLL_OVER,onOver);
				_activeMc.removeEventListener(MouseEvent.ROLL_OUT,onOut);
				_fireMc.gotoAndStop(3);
				
				_figure.play();
				(_fireMc.roleMc.role as MovieClip).removeChildren();
				_fireMc.roleMc.role.addChild(_figure);
				rect = _fireMc.roleMc.role.getBounds(this);
				if(isInit)//如果是初始化设置状态，则不用播放打开时候的动画；
				{
					(_fireMc.roleMc as MovieClip).gotoAndStop((_fireMc.roleMc as MovieClip).totalFrames);
				}
				else
				{
					if(_heroVo.quality == HeroDict.PURPLE || _heroVo.quality == HeroDict.ORANGE)
					{
						dispatchEvent(new TakeCardsEvent(TakeCardsEvent.CARDS_OPEN,_heroVo.quality));
					}
				}
			}
			else
			{
				if(!hasEventListener(MouseEvent.CLICK))
				{
					_activeMc.addEventListener(MouseEvent.CLICK,onGet);
					_activeMc.addEventListener(MouseEvent.ROLL_OVER,onOver);
					_activeMc.addEventListener(MouseEvent.ROLL_OUT,onOut);
				}
				_fireMc.gotoAndStop(1);
				rect = _fireMc.getBounds(this);
			}
			_activeMc.setArea(rect.width,rect.height,rect.x,rect.y);

		}
		
		protected function onOver(event:MouseEvent):void
		{
			_fireMc.gotoAndStop(2);
		}
		
		protected function onOut(event:MouseEvent):void
		{
			_fireMc.gotoAndStop(1);
		}
		
		public function clear():void
		{
			_activeMc.removeEventListener(MouseEvent.CLICK,onGet);
			_activeMc.removeEventListener(MouseEvent.MOUSE_OVER,onOver);
			_activeMc.removeEventListener(MouseEvent.MOUSE_OUT,onOut);
			
			if(_figure)
			{
				_figure.stop();
				if(_figure.parent)
					_figure.parent.removeChild(_figure);
				_figure = null;
			}
			
			if(_fireMc)
			{
				_fireMc.stop();
				removeChild(_fireMc);
				_fireMc = null;
			}
			removeChild(_activeMc);
		}
		
	}
}