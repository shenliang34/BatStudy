package com.gamehero.sxd2.gui.chat
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.event.ChatEvent;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.pro.PRO_PlayerBase;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.ApplicationDomain;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.utils.effect.color.ColorTransformUtils;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * 私聊窗口里的成员
	 * @author cuixu
	 * @create 2015-11-23
	 **/
	public class ChatMember extends Sprite
	{
		private var domain:ApplicationDomain;
		public var base:PRO_PlayerBase;
		
		// 焦点背景
		private var focus:Bitmap;
		//头像
		private var headIcon:ScaleBitmap;
		// 关闭按钮
		private var closeBtn:Button;
		
		/**
		 * 构造函数
		 * */
		public function ChatMember(base:PRO_PlayerBase , domain:ApplicationDomain)
		{
			this.domain = domain;
			this.base = base;
			
			// 鼠标响应区域
			this.graphics.beginFill(0,0);
			this.graphics.drawRect(0,0,191,29);
			this.graphics.endFill();
			
			// 焦点背景
			focus = new Bitmap(this.getRes("MEMBER_FOCUS") as BitmapData);//w:186 h:28
			focus.x = 5;
			focus.y = 1;
			focus.visible = false;
			this.addChild(focus);
			
			// 加载头像
			headIcon = new ScaleBitmap();
			headIcon.x = 0;
			headIcon.y = 0;
			
			addChild(headIcon);
			var iconIndex:String = base.sexOrJob ? "102" : "101";
			BulkLoaderSingleton.instance.addWithListener(GameConfig.ICON_URL + "playerhead/"+ iconIndex + ".png", null, onHeadLoaded);
			
			// 姓名文本
			var label:Label = new Label(false);
			label.x = 35;
			label.y = 8;
			label.text = base.name;
			label.width = 115;
			label.height = 18;
			label.color = GameDictionary.WHITE;
			label.size = 12;
			this.addChild(label);
			
			// 关闭按钮
			closeBtn = new Button(getRes("CLOSE_UP") as BitmapData, getRes("CLOSE_DOWN") as BitmapData, getRes("CLOSE_OVER") as BitmapData);
			closeBtn.x = 169;
			closeBtn.y = 8;
			closeBtn.addEventListener(MouseEvent.CLICK , close);
			this.addChild(closeBtn);
			
			this.buttonMode = true;
		}
		
		private function onHeadLoaded(e:Event):void
		{
			var imageItem:ImageItem = e.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE , onHeadLoaded);
			
			headIcon.bitmapData = imageItem.content.bitmapData;
			headIcon.setSize(28,28);
		}
		
		/**
		 * 是否选中
		 * */
		public function set selected(value:Boolean):void
		{
			focus.visible = value;
		}
		
		/**
		 * 是否在线
		 * */
		public function set online(value:Boolean):void
		{
			var utils:ColorTransformUtils = ColorTransformUtils.instance;
			if(value == true)
			{
				utils.clear(this);
			}
			else
			{
				utils.addSaturation(this , -100);
			}
		}
		
		/**
		 * 关闭此成员聊天
		 * */
		private function close(e:MouseEvent):void
		{
			e.stopImmediatePropagation();
			this.dispatchEvent(new ChatEvent(ChatEvent.REMOVE_MEMBER));
		}
		
		/**
		 * 清空
		 * */
		public function clear():void
		{
			this.online = true;
			
			domain = null;
			
			closeBtn.removeEventListener(MouseEvent.CLICK , close);
			closeBtn = null;
			headIcon.bitmapData = null;
		}
		
		/**
		 * 加载的swf的导出类得到BitmapData 
		 * @param className
		 */
		private function getRes(className:String):Object
		{	
			return new (domain.getDefinition(className) as Class)();
		}
	}
}