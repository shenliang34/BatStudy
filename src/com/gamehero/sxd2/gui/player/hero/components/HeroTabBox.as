package com.gamehero.sxd2.gui.player.hero.components
{
	import com.gamehero.sxd2.core.SoundConfig;
	import com.gamehero.sxd2.gui.core.tab.TabEvent;
	import com.gamehero.sxd2.manager.HeroManager;
	import com.gamehero.sxd2.manager.SoundManager;
	import com.gamehero.sxd2.pro.PRO_Hero;
	import com.gamehero.sxd2.vo.HeroVO;
	
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	
	import alternativa.gui.base.GUIobject;
	
	/**
	 * 伙伴页签
	 * @author weiyanyu
	 * 创建时间：2015-8-27 下午1:44:58
	 * 
	 */
	public class HeroTabBox extends GUIobject
	{
		public function HeroTabBox()
		{
			super();
		}
		/**
		 * 移入 
		 */		
		private var over:BitmapData;
		/**
		 * 正常 
		 */		
		private var normal:BitmapData;
		/**
		 * 选中 
		 */		
		private var selected:BitmapData;
		/**
		 * 当前选择的页签索引 
		 */		
		private var _curIndex:int = -1;
		/**
		 *  当前选中的按钮 
		 */		
		private var _curBtn:HeroTabBtn;
		/**
		 * 首次打开页签后，记录页签顺序 
		 */		
		private var _btnList:Vector.<HeroTabBtn> = new Vector.<HeroTabBtn>();
		/**
		 * 伙伴页签对应的伙伴id 
		 */		
		private var _preHeroIdList:Vector.<int> = new Vector.<int>();
		/**
		 * 设置三态皮肤 
		 * @param over
		 * @param normal
		 * @param selected
		 * 
		 */		
		public function setSkin(over:BitmapData,normal:BitmapData,selected:BitmapData):void
		{
			this.over = over;
			this.normal = normal;
			this.selected = selected;
		}
		/**
		 * 初始化数据 
		 * @param list
		 * 
		 */		
		public function init(list:Array):void
		{
			var heroTabBtn:HeroTabBtn;
			var heroVo:HeroVO;
			var heroId:int = -1;

			var heroIdList:Vector.<int> = new Vector.<int>();
			for(var i:int = 0; i < list.length; i++)
			{
				heroTabBtn = new HeroTabBtn(normal,selected,over);
				heroVo = HeroManager.instance.getHeroByID((list[i] as PRO_Hero).heroId.toString());
				addChild(heroTabBtn);
				heroTabBtn.index = i;
				heroTabBtn.data = (heroVo);
				heroTabBtn.addEventListener(MouseEvent.MOUSE_UP,onClick);
				heroTabBtn.width = 67;
				heroTabBtn.y = i * 45;
				_btnList.push(heroTabBtn);
				heroIdList.push(int(heroVo.id));
			}
			graphics.clear();
			this.graphics.beginFill(0,0);
			this.graphics.drawRect(0,0,67,list.length * 45);
			this.graphics.endFill();
			
			if(_preHeroIdList.length != 0)
			{
				heroId = _preHeroIdList[_curIndex];//上次刷新数据时候选中的伙伴id
				var index:int = heroIdList.indexOf(heroId);
				if(index > -1)//如果之前选中的伙伴还存在
				{
					curIndex = index;
				}
				else
				{
					curIndex = 0;
				}
			}
			else
			{
				curIndex = 0;
			}
			_preHeroIdList = heroIdList;
			
		}
		
		/**
		 * 点击 
		 * @param event
		 */		
		protected function onClick(event:MouseEvent):void
		{
			var btn:HeroTabBtn;
			btn = event.target as HeroTabBtn;
			curIndex = (btn.index);
			// 切页音效
			SoundManager.inst.play(SoundConfig.TOOGLE_CLICK);
		}
		
		/**
		 * 当前选择的页签 
		 */
		public function get curIndex():int
		{
			return _curIndex;
		}
		
		/**
		 * 设置当前页签
		 * @private
		 */
		public function set curIndex(value:int):void
		{
			_curIndex = value;
			for each(var tab:HeroTabBtn in _btnList)
			{
				if(tab.index != value)
				{
					tab.selected = false;
				}
				else
				{
					tab.selected = true;
					_curBtn = tab;
				}
			}
			if(_curBtn && _curBtn.hero)
				dispatchEvent(new TabEvent(TabEvent.SELECTED,_curBtn.hero));
		}
		
		/**
		 * 当前选中的额按钮 
		 * @return 
		 * 
		 */		
		public function get curBtn():HeroTabBtn
		{
			return _curBtn;
		}
		
		public function clear():void
		{
			for each(var tab:HeroTabBtn in _btnList)
			{
				removeChild(tab);
				tab.clear();
				tab = null;
			}
			_btnList.length = 0;
			this.graphics.clear();
		}
		
	}
}