package com.gamehero.sxd2.gui.player.hero.components
{
	
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.core.tab.TabBarBtn;
	import com.gamehero.sxd2.vo.HeroVO;
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import alternativa.gui.controls.text.Label;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	/**
	 * 伙伴页签
	 * @author weiyanyu
	 * 创建时间：2015-8-27 下午1:51:30
	 * 
	 */
	public class HeroTabBtn extends TabBarBtn
	{
		private var _hero:HeroVO;
		/**
		 * 运动sp 
		 */		
		private var _tweenMc:Sprite;
		/**
		 * 人名 
		 */		
		private var _nameLabel:Label;
		/**
		 * 头像 
		 */		
		private var _headIcon:Bitmap;
		
		private var _tween:TweenMax;
		
		/**
		 * 划过状态 
		 */		
		private var _overMask:Bitmap;
		/**
		 * 正常状态 
		 */		
		private var _normalMask:Bitmap;
		/**
		 * 选中状态 
		 */		
		private var _selectedMask:Bitmap;
		
		private var WIDTH:int = 67;//总的宽高
		private var HEGHT:int = 40;
		
		private static var TWEEN_TIME:Number = .2;
		/**
		 * 正常状态下的底图偏移 
		 */		
		private static var NORMAL_OFF_SET:Number = 9;
		/**
		 * 滑动状态下的底图偏移 
		 */		
		private static var OVER_OFF_SET:Number = 8;
		
		
		public function HeroTabBtn(normalBd:BitmapData,selectedBd:BitmapData,overBd:BitmapData)
		{
			super(normalBd,selectedBd,overBd);
			
			this.width = WIDTH;
			this.height = HEGHT;
			//设置三个状态的遮罩
			_overMask = new Bitmap(_overBd);
			_overMask.x = OVER_OFF_SET;
			_overMask.cacheAsBitmap = true;
			addChild(_overMask);
			_overMask.visible = false;
			_normalMask = new Bitmap(_normalBd);
			_normalMask.x = NORMAL_OFF_SET;
			_normalMask.cacheAsBitmap = true;
			addChild(_normalMask);
			_normalMask.visible = false;
			_selectedMask = new Bitmap(_selectedBd);
			addChild(_selectedMask);
			_selectedMask.visible = false;
			_selectedMask.cacheAsBitmap = true;
			
			//拼图
			this.cacheAsBitmap = true;
			
			_tweenMc = new Sprite();
			addChild(_tweenMc);
			_nameLabel = new Label();
			_nameLabel.x = WIDTH + ((_bg.width - _nameLabel.width) >> 1);
			_nameLabel.y = 15;
			_nameLabel.color = GameDictionary.WINDOW_WHITE;
			_tweenMc.addChild(_nameLabel);
			_headIcon = new Bitmap();
			addChild(_headIcon);
			_tweenMc.addChild(_headIcon);
			
			
		}
		
		
		/**
		 * 伙伴信息 
		 */
		public function get hero():HeroVO
		{
			return _hero;
		}

		override public function set data(value:Object):void
		{
			_hero = value as HeroVO;
			if(hero)
			{
				_nameLabel.text = hero.name;
				// 加载头像
				var url:String = GameConfig.HERO_URL + "tab/" + hero.id + ".swf";
				var loader:BulkLoaderSingleton = BulkLoaderSingleton.instance;
				loader.addWithListener(url , null , onLoaded);
			}
			else
			{
				this.clear();
			}
		}
		
		/**
		 * 头像加载完成
		 * */
		private function onLoaded(e:Event):void
		{
			var imageItem:ImageItem = e.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE , onLoaded);
			var PNGDataClass:Class = imageItem.getDefinitionByName("PNGData") as Class;
			
			// 添加icon
			var png:BitmapData = new PNGDataClass;
			_headIcon.bitmapData = png;
		}
		
		override protected function onMouseOut(event:MouseEvent):void
		{
			if(!_selected)
			{
				setNormal();
			}
		}	
		override protected function onMouseOver(event:MouseEvent):void
		{
			if(!_selected)
			{
				setOver();
			}
		}
		/**
		 * 点击 
		 * @param event
		 * 
		 */		
		override protected function onClick(event:MouseEvent):void
		{
			if(!_selected)
			{
				setClick();
			}
			_selected = true;
		}
		
		/**
		 * 设置常态 
		 * 
		 */		
		private function setNormal():void
		{
			killTween(_normalBd,NORMAL_OFF_SET,_normalMask,_tweenMc,0);
			_nameLabel.x = WIDTH + NORMAL_OFF_SET + ((_bg.width - _nameLabel.width) >> 1);
		}
		
		/**
		 * 设置划过状态 
		 * 
		 */		
		private function setOver():void
		{
			killTween(_overBd,OVER_OFF_SET,_overMask,_tweenMc,-WIDTH);
			_nameLabel.x = WIDTH + OVER_OFF_SET + ((_bg.width - _nameLabel.width) >> 1);
		}
		/**
		 * 设置点击状态 
		 * 
		 */		
		private function setClick():void
		{
			_tweenMc.x = -WIDTH;
			killTween(_selectedBd,10,_selectedMask,_bg,0);
			_nameLabel.x = WIDTH + ((_bg.width - _nameLabel.width) >> 1);
		}
		/**
		 *  
		 * @param bgBd 底图背景
		 * @param bgx 底图坐标
		 * @param aniMc 运动的mc
		 * @param targetX 目标点
		 * @param maskBmp 遮罩
		 * 
		 */		
		private function killTween(bgBd:BitmapData,bgx:int,maskBmp:Bitmap,aniMc:DisplayObject,targetX:int):void
		{
			
			_bg.bitmapData = bgBd;
			_bg.x = bgx;
			_normalMask.visible = false;
			_selectedMask.visible = false;
			_overMask.visible = false;
			if(_tween)
			{
				_tween.kill();
				_tween = null;
			}
			maskBmp.visible = true;
			this.mask = maskBmp;
			_tween = TweenMax.to(aniMc , TWEEN_TIME , {x:targetX});
		}
		

		
		override public function set selected(value:Boolean):void {
			_selected = value;
			if(value == true)
			{
				setClick();
			}
			else
			{
				setNormal();
			}
		}
		
		override public function clear():void
		{
			super.clear();
			if(_tween)
			{
				_tween.kill();
				_tween = null;
			}
			_hero = null;
		}
		
	}
}