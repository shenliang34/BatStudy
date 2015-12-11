package com.gamehero.sxd2.gui.menu
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.event.MenuEvent;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.list.MenuList;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.list.MenuListObject;
	import com.gamehero.sxd2.gui.theme.ifstheme.panel.SimplePanel;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import alternativa.gui.data.DataProvider;
	import alternativa.gui.event.ListEvent;
	
	
	/**
	 * 菜单
	 * @author xuwenyi
	 * @create 2013-10-24
	 **/
	public class MenuPanel extends SimplePanel
	{
		/** 单例 **/
		public static var _instance:MenuPanel;
		
		// option宽度：适应5个字的宽度
		public static const OPTION_WIDTH:int = 80;
		// option高度
		public static const OPTION_HEIGHT:int = 18;
		
		/** 各种Option的id **/
		/**
		 * 装备 
		 */	
		public static const OPTION_EQUIP:String = "option_equip";// 装备
		/**
		 * 伙伴装备 
		 */		
		public static const OPTION_HERO_EQUIP:String = "option_hero_equip";// 伙伴装备
		/**
		 * 展示 
		 */		
		public static const OPTION_SHOW:String = "option_show";// 展示
		/**
		 * 使用道具 
		 */		
		public static const OPTION_USE:String = "option_use";// 使用
		/**
		 * 卸下装备 
		 */		
		public static const OPTION_UNSNATCH:String = "option_unsnatch";// 卸下
		/**
		 * 出售道具 
		 */		
		public static const OPTION_SELL:String = "option_sell";// 出售
		/**
		 * 回购 
		 */		
		public static var BUY_BACK:String = "buy_back";//
		/**
		 * 打开 
		 */		
		public static var BUY_BACK_SELL:String = "BUY_BACK_SELL";
		
		public static const OPTION_CHECK_STATE:String = "option_check_state";// 查看信息
		public static const OPTION_CHAT_PRIVATE:String = "option_chat_private";// 发起私聊
		public static const OPTION_TO_BLACK:String = "option_to_black";// 移至黑名单
		public static const OPTION_INVITE_REDDRAGON:String = "option_invite_reddragon";// 邀请组队红龙宝藏
		public static const OPTION_ADD_FRIEND:String = "option_add_friend";// 加为好友
		public static const OPTION_REMOVE_FRIEND:String = "option_remove_friend";// 移除好友
		public static const OPTION_REMOVE_BLACKFRIEND:String = "option_remove_blackFriend";// 移除好友
		public static const OPTION_COPY_NAME:String = "option_copy_name";// 复制名称
		public static const OPTION_ADD_AUDIENCE:String = "option_add_audience";// 关注
		public static const OPTION_REMOVE_AUDIENCE:String = "option_remove_audience";// 取消关注
		public static const OPTION_CALL_TRADE:String = "option_call_trade";// 发起交易
		
		public static const OPTION_FAMILY_SET_PRESIDENT:String = "option_familiy_set_president";	// 设置族长
		public static const OPTION_FAMILY_SET_VICE_PRESIDENT:String = "option_familiy_set_vice_president";	// 设置副族长
		public static const OPTION_FAMILY_SET_MEMBER:String = "option_familiy_set_member";	// 设置成员
		public static const OPTION_FAMILY_KICK_OUT:String = "option_family_kick_out";	// 踢出家族
		
		public var params:Object;//参数
		
		private var list:MenuList;
		private var listDataProvider:DataProvider;
		
		
		
		private var timeOut:int;
		/**
		 * 构造函数
		 * */
		public function MenuPanel()
		{
			listDataProvider = new DataProvider();
			
			list = new MenuList();
			list.itemRenderer = MenuListObject;
			list.dataProvider = listDataProvider;
			
			list.addEventListener(ListEvent.CLICK_ITEM, listSelected);
			this.addEventListener(Event.ADDED_TO_STAGE, onAdd);
			
			this.content = list;
			this.width = OPTION_WIDTH;
		}
		
		
		
		
		public static function get instance():MenuPanel
		{
			if(_instance == null)
			{
				_instance = new MenuPanel();
			}
			return _instance;
		}
		
		
		
		
		/**
		 * 添加到场景时响应
		 */
		private function onAdd(e:Event):void
		{	
			setTimeout(function():void
			{
				if(stage)
				{
					stage.addEventListener(MouseEvent.MOUSE_UP , onClick);
				}
			},1);
		}
		
		
		
		
		/**
		 * 初始化options  
		 */		
		public function initOptions(options:Array):void
		{
			listDataProvider.removeAll();
			
			for(var i:int=0;i<options.length;i++)
			{
				var option:OptionData = options[i];
				listDataProvider.addItem(option);
			}
		}
		
		
		
		
		/**
		 * 选择某个option
		 */	
		protected function listSelected(e:ListEvent):void
		{
			e.stopImmediatePropagation();
			
			var option:OptionData = e.object as OptionData;
			option.params = params;
			this.dispatchEvent(new MenuEvent(MenuEvent.OPEN_OPTION , option));
			
			this.hide();
		}
		
		
		
		
		
		/**
		 * 移除
		 */
		private function onClick(e:Event):void
		{	
			this.hide();
		}
		/**
		 * 延迟显示 
		 * @param params
		 * @param parent
		 * 
		 */		
		public function showLater(params:Object, parent:DisplayObjectContainer):void
		{
			clearDelay();
			timeOut = setTimeout(show, GameConfig.MOUSE_DOUBLE_CLICK_TIME, params, parent);
		}
		
		
		/**
		 * 显示menuPanel 
		 */		
		public function show(params:Object, parent:DisplayObjectContainer):void
		{
			clearDelay();
			// 参数
			this.params = params;
			
			parent.addChild(this);
			// 设置菜单高度
			height = OPTION_HEIGHT * listDataProvider.length + 15;//
			
			// 定位
			x = parent.mouseX - 10;
			y = parent.mouseY - 10;
			
			var mstage:Stage = parent.stage;
			if(mstage.mouseY + height > mstage.stageHeight)
			{
				y = y - height + 10;
			}
			
		}
		
		
		private function clearDelay():void
		{
			if(timeOut > 0)
			{
				clearTimeout(timeOut);
				timeOut = 0;
			}
		}
		
		/**
		 * 隐藏菜单 
		 */
		public function hide():void
		{	
			clearDelay();
			if(stage)
			{
				stage.removeEventListener(MouseEvent.MOUSE_UP , onClick);
			}
			if(this.parent && this.parent.contains(_instance))
			{	
				this.parent.removeChild(_instance);
			}
		}
	}
}