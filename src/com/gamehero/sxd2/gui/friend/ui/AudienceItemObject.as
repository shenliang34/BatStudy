package com.gamehero.sxd2.gui.friend.ui
{
	import com.gamehero.sxd2.gui.theme.ifstheme.container.list.ListItemObject;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	
	import alternativa.gui.base.GUIobject;
	import alternativa.gui.container.list.IItemRenderer;
	import alternativa.gui.theme.defaulttheme.skin.NumericConst;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2015-11-23 下午2:43:10
	 * 
	 */
	public class AudienceItemObject extends GUIobject implements IItemRenderer
	{
		protected var _data:Object;
		
		protected var _selected:Boolean = false;
		
		protected var _itemIndex:int = 0;
		
		private var _line:ScaleBitmap;
		private var _bg:ScaleBitmap;
		
		private var _audienceBtn:Button;
		private var _ignoreBtn:Button;
		
		private var _label:Label;
		public function AudienceItemObject()
		{
			super();
			
			_bg = new ScaleBitmap(CommonSkin.windowInner4Bg);
			_bg.scale9Grid = CommonSkin.windowInner4BgScale9Grid;
			_bg.width = 280;
			_bg.height = 40;
			addChild(_bg);
			
//			_line = new ScaleBitmap(GameHintSkin.TIPS_LINE);
//			_line.scale9Grid = ChatSkin.lineScale9Grid;
//			_line.x = 0;
//			_line.y = 0;
//			_line.setSize(290,1);
//			this.addChild(_line);
			
			_label = new Label();
			_label.text = "XXX刚刚关注了你";
			_label.y = 15;
			_label.x = 20;
			addChild(_label);
			
			_ignoreBtn = new Button(CommonSkin.blueButton3Up,CommonSkin.blueButton3Down,CommonSkin.blueButton3Over);
			_ignoreBtn.label = "忽略";
			_ignoreBtn.x = 225;
			_ignoreBtn.y = 10;
			this.addChild(_ignoreBtn);
			
			_audienceBtn = new Button(CommonSkin.blueButton3Up,CommonSkin.blueButton3Down,CommonSkin.blueButton3Over);
			_audienceBtn.label = "关注";
			_audienceBtn.x = 180;
			_audienceBtn.y = 10;
			this.addChild(_audienceBtn);
		}

		override public function get height():Number {
			
			return NumericConst.itemHeight + 15;
		}
		
		/**
		 * 关注按钮
		 * */
		public function get audienceBtn():Button
		{
			return _audienceBtn;
		}

		/**
		 * 忽略按钮
		 * */
		public function get ignoreBtn():Button
		{
			return _ignoreBtn;
		}
		
		public function get itemIndex():int
		{
			return _itemIndex;
		}
		
		public function set itemIndex(value:int):void
		{
			_itemIndex=value;
		}
		
		public function get data():Object
		{
			return _data;
		}
		
		public function set data(value:Object):void
		{
			_data=value;
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void
		{
			_selected=value;
		}

	}
}