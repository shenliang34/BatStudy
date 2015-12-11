package com.gamehero.sxd2.gui.friend.ui
{
	import com.gamehero.sxd2.gui.menu.MenuPanel;
	import com.gamehero.sxd2.gui.menu.OptionData;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.list.ListItemObject;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.panel.SimplePanel;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.util.FiltersUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import alternativa.gui.theme.defaulttheme.skin.NumericConst;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2015-11-18 下午8:11:16
	 * 
	 */
	public class FriendItemObject extends ListItemObject
	{
		private var _panle:SimplePanel;
		private var _selectedBp:Bitmap;
		private var _overBp:Bitmap;
		private var icon:PlayerIcon;
		private var _onlineBp:Bitmap;
		private var _bg:ScaleBitmap;
		private var _nameLb:Label;
		private var _levelLb:Label;
		private var _isOut:Boolean;
		public function FriendItemObject(url:String = null)
		{
			super();
			
			_bg = new ScaleBitmap(CommonSkin.windowInner4Bg);
			_bg.scale9Grid = CommonSkin.windowInner4BgScale9Grid;
			_bg.width = 180;
			_bg.height = 36;
			_bg.alpha = 0;
			addChild(_bg);
			
			_overBp = new Bitmap( FriendSkin.SLIDER);
			_overBp.width = 180;
			_overBp.height = 36;
			_overBp.visible = false;
			addChild(_overBp);
			
//			_selectedBp = new ScaleBitmap( CommonSkin.windowInner4Bg);
			_selectedBp = new Bitmap( FriendSkin.SLIDER);
//			_selectedBp.scale9Grid = CommonSkin.windowInner4BgScale9Grid;
			_selectedBp.width = 180;
			_selectedBp.height = 36;
			_selectedBp.visible = false;
			addChild(_selectedBp);
			
			icon = new PlayerIcon();
			addChild(icon);
			icon.x = icon.y = 3;
			icon.iconId = int(Math.random()*8);
			icon.scaleX = icon.scaleY = 0.6;
			
//			_onlineBp = new ScaleBitmap();
//			_onlineBp.x=0;
//			_onlineBp.y=0;
//			_onlineBp.bitmapData = CommonSkin.blueBigButton3Down;
//			_onlineBp.width = 220;
//			addChild(_onlineBp);
			
//			
			
			_nameLb = new Label();
			_nameLb.x = 54;
			_nameLb.y = 10;
			addChild(_nameLb);
			
			_levelLb = new Label();
			_levelLb.x = 130;
			_levelLb.y = 10;
			addChild(_levelLb);
			
			this.doubleClickEnabled = true;
			this.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			this.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			this.addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
		}
		
		private function onGetFriendIconLoaded(event:Event):void
		{
			// TODO Auto Generated method stub
			var imageItem : ImageItem = event.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE,onGetFriendIconLoaded);
			imageItem.removeEventListener(ErrorEvent.ERROR,onGetFriendIconError);
		}
		private function onGetFriendIconError(event:Event):void
		{
			// TODO Auto Generated method stub
			
			event.target.removeEventListener(Event.COMPLETE,onGetFriendIconLoaded);
			event.target.removeEventListener(ErrorEvent.ERROR,onGetFriendIconError);
		}
		
		public function setIcon(bd:BitmapData):void
		{
			icon.bitmapData = bd;
			icon.width = bd.width;
			icon.height = bd.height;
		}
		
		/**
		 *双击 
		 * 
		 */		
		override public function doubleClick():void
		{
			// TODO Auto Generated method stub
			super.doubleClick();
		}
		/**
		 *单击 
		 * 
		 */		
		override public function click():void
		{
			// TODO Auto Generated method stub
			super.click();
			this.selected = true;
			
			var selectFriend:*= _data;
			var options:Array = [];
			options.push(new OptionData(MenuPanel.OPTION_CHAT_PRIVATE , 		Lang.instance.trans("发送私聊")));
			options.push(new OptionData(MenuPanel.OPTION_REMOVE_AUDIENCE ,		Lang.instance.trans("取消关注")));
			options.push(new OptionData(MenuPanel.OPTION_COPY_NAME , 			Lang.instance.trans("复制名称")));
			options.push(new OptionData(MenuPanel.OPTION_REMOVE_FRIEND , 			Lang.instance.trans("移除好友")));
			options.push(new OptionData(MenuPanel.OPTION_TO_BLACK , 			Lang.instance.trans("移至黑名单")));
			MenuPanel.instance.initOptions(options);
			MenuPanel.instance.show(selectFriend,this.parent.parent);
		}
		
		
		protected function onAddToStage(event:Event):void
		{
			// TODO Auto-generated method stub
			setTimeout(function():void
			{
				if(stage)
				{
					stage.addEventListener(MouseEvent.MOUSE_DOWN , onMouseDown);
				}
			},1);
		}
		
		protected function onMouseDown(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			if(this._isOut)
				this.selected = false;
		}
		
		protected function onRollOver(event:MouseEvent):void
		{
			this._overBp.visible = true;
//			this._selectedBp.visible = true;
			_isOut = false;
		}
		
		protected function onRollOut(event:MouseEvent):void
		{
			this._overBp.visible = this.selected;
//			this._selectedBp.visible = this.selected;
			_isOut = true;
		}
		
		override public function get height():Number {
			
			return NumericConst.itemHeight + 20;
		}
		
		override public function get selected():Boolean
		{
			// TODO Auto Generated method stub
			return super.selected;
		}
		
		override public function get itemIndex():int
		{
			// TODO Auto Generated method stub
			return super.itemIndex;
		}
		
		override public function set itemIndex(value:int):void
		{
			// TODO Auto Generated method stub
			super.itemIndex = value;
		}
		
		
		override public function set selected(value:Boolean):void
		{
			// TODO Auto Generated method stub
			super.selected = value;
			this._selectedBp.visible = value;
			this._overBp.visible = false;
		}
		
		
		override public function set data(value:Object):void
		{
			_data = value;
			if(_data)
			{
				this.visible = true;
				_nameLb.text = _data.base.name;
				_levelLb.text = "LV."+String(_data.base.level);
				this.filters = (data.isOnline? []:FiltersUtil.BW_Fiter);
			}
			else
			{
				this.visible = false;
			}
		}
	}
}