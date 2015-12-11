package com.gamehero.sxd2.gui.chat
{
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.gui.tips.ItemCellTips;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	
	/**
	 * 聊天中物品tips
	 * @author xuwenyi
	 * @create 2013-10-31
	 **/
	public class ChatItemTips extends Sprite
	{
		// 用于存放tips的容器
		private var content:Sprite;

		/**
		 * 构造函数
		 * */
		public function ChatItemTips()
		{
			content = new Sprite();
			this.addChild(content);
			
			this.hide();
		}

		/**
		 * 添加tips内容
		 * */
		public function show(sprite:Sprite):void
		{
			this.clear();
//			var obj:DisplayObject = ItemCellTips.getEquipCellTips(id)
			// 生成tips
			content.addChild(sprite);
			if(!this.visible) this.visible = true;
		}
		
		/**
		 * 隐藏tips
		 * */
		public function hide():void
		{
			this.visible = false;
		}
		
		/**
		 * 显示时添加鼠标事件
		 * */
		override public function set visible(value:Boolean):void 
		{
			if(stage)
			{
				if(value == true)
				{
					setTimeout(function():void
					{
						stage.addEventListener(MouseEvent.CLICK , onClick);
					},1);
				}
				else
				{
					stage.removeEventListener(MouseEvent.CLICK , onClick);
				}
			}
			super.visible = value;
		}
		
		/**
		 * 鼠标在场景任何地方点击时触发
		 * */
		private function onClick(e:MouseEvent):void
		{
			this.visible = false;
		}
		
		/**
		 * 清空
		 * */
		public function clear():void
		{
			Global.instance.removeChildren(content);
		}
		
	}
}