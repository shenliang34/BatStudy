package com.gamehero.sxd2.gui.friend.ui
{
	import com.gamehero.sxd2.gui.friend.model.FriendModel;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.list.ListItemObject;
	
	import flash.events.Event;
	
	import alternativa.gui.container.list.ListItemContainer;
	
	
	
	/**
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2015-11-24 上午10:17:49
	 * 
	 */
	public class PlayerIconItemObject extends ListItemObject
	{
		protected var initData:int = -1;
		protected var isInit:Boolean;
		
		protected var playerIconButton:PlayerIconButton;
		public function PlayerIconItemObject()
		{
			super();
			
			playerIconButton = new PlayerIconButton(0,true);
			addChild(playerIconButton);
		}
		
		override public function get data():Object
		{
			// TODO Auto Generated method stub
			return super.data;
		}
		
		override public function set data(value:Object):void
		{
			// TODO Auto Generated method stub
			if(super.data == null){
				initData = int(value);
			}
			super.data = value;
			if(value){
				this.visible = true;
				playerIconButton._iconImage.iconId = int(value);
			}else{
				this.visible = false;
			}
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
		
		override public function get selected():Boolean
		{
			// TODO Auto Generated method stub
			return super.selected;
		}
		
		override public function set selected(value:Boolean):void
		{
			// TODO Auto Generated method stub
			super.selected = value;
			if(isInit){
				playerIconButton._checkBox.checked = value;
				if(value){
					FriendModel.inst.myIconId = int(super.data);
					if(this.parent){
					this.parent.dispatchEvent(new Event(Event.SELECT))
					}
				}
			}else{
				isInit = true;
				playerIconButton._checkBox.checked = (initData == FriendModel.inst.myIconId);
			}
		}
		
	}
}