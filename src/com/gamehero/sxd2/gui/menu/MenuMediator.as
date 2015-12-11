package com.gamehero.sxd2.gui.menu
{
	import com.gamehero.sxd2.core.ClientLog;
	import com.gamehero.sxd2.event.ChatEvent;
	import com.gamehero.sxd2.event.MenuEvent;
	import com.gamehero.sxd2.gui.bag.component.ItemCell;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.buyback.model.BuyBackDict;
	import com.gamehero.sxd2.gui.core.money.ItemCost;
	import com.gamehero.sxd2.gui.friend.event.FriendEvent;
	import com.gamehero.sxd2.gui.player.hero.components.HeroItemCell;
	import com.gamehero.sxd2.gui.player.hero.model.HeroModel;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.pro.HERO_EQUIP_OPT_TYPE;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSGID_STORE_OPT_REQ;
	import com.gamehero.sxd2.pro.PRO_Item;
	import com.gamehero.sxd2.services.GameService;
	
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	
	import bowser.remote.RemoteClient;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	
	/**
	 * 弹出菜单mediator
	 * @author xuwenyi
	 * @create 2013-10-28
	 **/
	public class MenuMediator extends Mediator
	{
		[Inject]
		public var view:MenuPanel;
		/**
		 * 伙伴model 
		 */		
		private var _heroModel:HeroModel;
		
		
		/**
		 * 构造函数
		 * */
		public function MenuMediator()
		{
			super();
			_heroModel = HeroModel.instance;
		}
		
		/**
		 * initialize
		 */
		override public function initialize():void
		{
			super.initialize();
			
			this.addViewListener(MenuEvent.OPEN_OPTION , openOption);
		}
		
		/**
		 * destroy
		 */
		override public function destroy():void
		{
			super.destroy();
			
			this.removeViewListener(MenuEvent.OPEN_OPTION , openOption);
		}
		
		/**
		 * 执行选项
		 * */
		private function openOption(e:MenuEvent):void
		{
			// 选项数据
			var option:OptionData = e.data as OptionData;
			var params:Object = option.params;//参数
			switch(option.id)
			{
				// 展示道具
				case MenuPanel.OPTION_SHOW:
					dispatch(new ChatEvent(ChatEvent.CHATSHOWITEMTIPS,(params as ItemCell).data));
					break;
				// 装备
				case MenuPanel.OPTION_EQUIP:
					
					break;
				//伙伴装备
				case MenuPanel.OPTION_HERO_EQUIP:
					HeroModel.instance.itemHeroEquip((params as ItemCell).data.id,HERO_EQUIP_OPT_TYPE.HERO_EQUIP_PUT_ON);
					break;
				// 使用
				case MenuPanel.OPTION_USE:
					GameProxy.inst.itemUse((params as ItemCell).data.id,1);
					break;
				// 卸下
				case MenuPanel.OPTION_UNSNATCH:
					HeroModel.instance.itemHeroEquip((params as HeroItemCell).data.id,HERO_EQUIP_OPT_TYPE.HERO_EQUIP_PUT_OFF);
					break;
				//回购
				case MenuPanel.BUY_BACK:
					var propVo:PropBaseVo = ItemManager.instance.getPropById((params as PRO_Item).itemId);
					if(ItemCost.canUseSingCost(propVo.cost))
					{
						var msg:MSGID_STORE_OPT_REQ = new MSGID_STORE_OPT_REQ();
						msg.opt = BuyBackDict.BUYBACK;
						msg.id = (params as PRO_Item).id;
						GameService.instance.send(MSGID.MSGID_STORE_OPT,msg);
					}
					break;
				// 查看人物属性
				case MenuPanel.OPTION_CHECK_STATE:
					
					break;
				// 出售
				case MenuPanel.OPTION_SELL:
					var sellMsg:MSGID_STORE_OPT_REQ = new MSGID_STORE_OPT_REQ();
					sellMsg.opt = BuyBackDict.SELL;
					sellMsg.id = (params as ItemCell).data.id;
					GameService.instance.send(MSGID.MSGID_STORE_OPT,sellMsg);
					break;
				// 私聊
				case MenuPanel.OPTION_CHAT_PRIVATE:
					trace("OPTION_CHAT_PRIVATE select: username:"+params.base.name+"userId:"+params.base.id);
					break;
				// 复制名称
				case MenuPanel.OPTION_COPY_NAME:
					Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT , params.base.name , false);
					break;
				// 移至黑名单
				case MenuPanel.OPTION_TO_BLACK:
					trace("OPTION_TO_BLACK select: username:"+params.base.name+"userId:"+params.id);
					break;
				//移除黑名单
				case MenuPanel.OPTION_REMOVE_BLACKFRIEND:
					trace("OPTION_REMOVE_BLACKFRIEND select: username:"+params.base.name+"userId:"+params.base.id);
					break;
				// 加为好友
				case MenuPanel.OPTION_ADD_FRIEND:
					trace("OPTION_ADD_FRIEND select: username:"+params.base.name+"userId:"+params.base.id);
					break;
				// 移除好友
				case MenuPanel.OPTION_REMOVE_FRIEND:
					trace("OPTION_REMOVE_FRIEND select: username:"+params.base.name);
					dispatch(new FriendEvent(FriendEvent.REMOVE_FRIEND_SUCCESS,params.base));
					break;
				//邀请组队
				case MenuPanel.OPTION_INVITE_REDDRAGON:
					
					break;
				// 转让族长
				case MenuPanel.OPTION_FAMILY_SET_PRESIDENT:
					
					break;
				// 转让副族长
				case MenuPanel.OPTION_FAMILY_SET_VICE_PRESIDENT:
					
					break;
				// 转让族员
				case MenuPanel.OPTION_FAMILY_SET_MEMBER:
					
					break;
				// 踢出家族
				case MenuPanel.OPTION_FAMILY_KICK_OUT:
					
					break;
			}
		}
		
		
	}
}