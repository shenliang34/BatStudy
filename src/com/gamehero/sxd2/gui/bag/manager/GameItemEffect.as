package com.gamehero.sxd2.gui.bag.manager
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.main.menuBar.MenuButton;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ItemSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	import com.gamehero.sxd2.manager.FunctionManager;
	import com.gamehero.sxd2.manager.ItemManager;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.utils.MovieClipPlayer;
	
	import br.com.stimuli.loading.loadingtypes.LoadingItem;

	/**
	 * 获取背包道具的动画展示
	 * @author weiyanyu
	 * 创建时间：2015-8-26 下午6:12:27
	 * 
	 */
	public class GameItemEffect extends Sprite
	{
		
		private static var _instance:GameItemEffect;
		
		public static function get inst():GameItemEffect
		{
			if(_instance == null)
			{
				_instance = new GameItemEffect();
			}
			return _instance;
		}
		/**
		 * 动画对象池 
		 */		
		private var mcPool:Vector.<MovieClip> = new Vector.<MovieClip>();
		/**
		 * 对象队列 
		 */		
		private var itemList:Vector.<int> = new Vector.<int>();
		/**
		 * 道具动画播放间隔控制Timer 
		 */
		private var _timer:Timer;
		public function GameItemEffect()
		{
			_timer = new Timer(100);
			_timer.addEventListener(TimerEvent.TIMER,onTimer);
			_timer.start();
		}
		
		protected function onTimer(event:TimerEvent):void
		{
			// TODO Auto-generated method stub
			if(itemList.length > 0)
			{
				var id:int = itemList.shift();
				var propBaseVo:PropBaseVo = ItemManager.instance.getPropById(id);
				BulkLoaderSingleton.instance.addWithListener(GameConfig.ITEM_ICON_URL + propBaseVo.ico + ".jpg", null, onIconLoaded);
				BulkLoaderSingleton.instance.start();
			}
			
		}		
		
		public function stop():void
		{
			_timer.stop();
		}
		
		public function start():void
		{
			_timer.start();
		}

		/**
		 * 展示道具飞 
		 * @param itemId
		 * 
		 */		
		public function show(itemId:int):void
		{
			if(itemList.indexOf(itemId) == -1)
			{
				itemList.push(itemId);
			}
		}
		
		private function onIconLoaded(event:Event):void
		{
			var loadingItem:LoadingItem = event.target as LoadingItem;
			event.target.removeEventListener(Event.COMPLETE, onIconLoaded);

			var bmp:Bitmap = loadingItem.content;
			var sp:Sprite = new Sprite();
			sp.addChild(bmp);
			sp.name = "bmp";
			var mc:MovieClip = getMc();
			var mp:MovieClipPlayer = new MovieClipPlayer();
			mp.play(mc , mc.totalFrames/24 , 0 , mc.totalFrames);
			mp.addEventListener(Event.COMPLETE , over);
			
			function over(e:Event):void
			{
				mp.removeEventListener(Event.COMPLETE , over);
				
				var sp:Sprite = mc._Icon.getChildByName("bmp");
				if(sp)
					mc._Icon.removeChild(sp);
				App.topUI.removeChild(mc);
				pushPool(mc);
			}
			
			//直接加在swf到舞台
			mc._Icon.addChildAt(sp,0);
			mc.play();
			bmp.x = -22;
			bmp.y = -22;
			App.topUI.addChildAt(mc,0);
			
			var bagBtn:MenuButton = FunctionManager.inst.getFuncBtn2(WindowEvent.BAG_WINDOW);
			var pos:Point = bagBtn.parent.localToGlobal(new Point(bagBtn.x , bagBtn.y));
			mc.x = pos.x;
			mc.y = pos.y;
		}
		
		
		
		private function pushPool(mc:MovieClip):void
		{
			mcPool.push(mc);
		}
		
		private function getMc():MovieClip
		{
			if(mcPool.length > 0)
			{
				return mcPool.pop()
			}
			else
			{
				return new ItemSkin.ITEM_GET_EFFECT as MovieClip;
			}
		}
	}
}