package com.gamehero.sxd2.gui.main
{	
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.event.PlayerEvent;
	import com.gamehero.sxd2.gui.chat.ChatData;
	import com.gamehero.sxd2.gui.core.money.ItemCost;
	import com.gamehero.sxd2.gui.core.money.MoneyDict;
	import com.gamehero.sxd2.gui.menu.MenuPanel;
	import com.gamehero.sxd2.gui.menu.OptionData;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ItemSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.tooltip.GameHint;
	import com.gamehero.sxd2.gui.tips.FloatTips;
	import com.gamehero.sxd2.local.GlobalFun;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSG_COMMON_BUY_REQ;
	import com.gamehero.sxd2.pro.PRO_PlayerBase;
	import com.gamehero.sxd2.pro.PRO_PlayerExtra;
	import com.gamehero.sxd2.pro.PRO_Property;
	import com.gamehero.sxd2.pro.STORE_TYPE;
	import com.gamehero.sxd2.services.GameService;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.ApplicationDomain;
	import flash.text.TextField;
	
	/**
	 * 主UI左上的主角面板
	 * @author zhangxueyou
	 * @create 2015-07-15
	 **/
	public class MainLeaderPanel extends Sprite
	{
		private static var _instance:MainLeaderPanel; //单例对象
		private var domain:ApplicationDomain; 			//资源作用域
		private var mainMc:MovieClip 					//主Mc
		private var userImg:MovieClip; 				//玩家头像
		private var userName:TextField;				//玩家名称
		private var userLevel:TextField;				//玩家等级
		private var userVip:MovieClip; 				//玩家VIP
		private var gold:MovieClip; 					//玩家金币
		private var money:MovieClip;					//玩家铜钱
		
		private var preGoldNum:Number = 0;//玩家更新前的金币数量
		private var preMoneyNum:Number = 0;//玩家更新前的铜钱数量
		
		private var power:TextField;					//玩家体力
		private var powerLoading:MovieClip;			//体力进度条
		private var _staminaNum:int;//体力进度
		
		private var _isFirst:Boolean = true;//是否是第一次初始化
		
		private var payBtn:SimpleButton;				//充值按钮
		private var mouseOverMc:MovieClip;				//鼠标移入mc
		private var gameHint:GameHint;					//体力提示
		
		private var otherPlayer:MovieClip;				//其他玩家面板
		private var otherUserName:TextField;			//其他玩家名称
		private var otherUserLevel:TextField;			//其他玩家等级
		
		private var itemId:int = 10010004; //体力的道具Id
		private var removeGold:int;//消耗的元宝
		public var buyCount:int;//购买的次数
		public var isBuy:Boolean;//是否购买体力标示
		
		/**
		 * 构造函数
		 * */
		public function MainLeaderPanel()
		{
		}
		
		/**
		 * 初始化
		 * */
		public function init(domain:ApplicationDomain):void
		{
			this.domain = domain;
			
			var global:Global = Global.instance;
			
			mainMc = global.getRes(domain,"leaderPanel") as MovieClip;
			addChild(mainMc);
			
			
			initPlayerUI();//初始化玩家头像UI
			
			initOtherPlayerUI();//初始化其他玩家头像UI

			initPlayerInfo() //设置玩家详细信息
			
			buyCount = GameData.inst.getItemCount(itemId);
			if(!buyCount)
				buyCount = 1;
		}
		
		/**
		 * 初始化玩家面板
		 * */
		private function initPlayerUI():void{
			var ownPlayer:MovieClip = mainMc.getChildByName("ownPlayer") as MovieClip;
			
			var rechargeBtn:* = ownPlayer.getChildByName("rechargeBtn");//充值按钮 测试数据接口延迟
			rechargeBtn.visible = false;
			rechargeBtn.addEventListener(MouseEvent.CLICK,rechargeBtnClickHandle);
			var buyBtn:* = ownPlayer.getChildByName("buyBtn");//购买体力按钮
			buyBtn.addEventListener(MouseEvent.CLICK,buyBtnClickHandle);
			buyBtn.addEventListener(MouseEvent.MOUSE_OVER,buyBtnOverHandle);
			buyBtn.addEventListener(MouseEvent.MOUSE_OUT,buyBtnOutHandle);
			
			userName = ownPlayer.getChildByName("userName") as TextField;
			userLevel = ownPlayer.getChildByName("userLevel") as TextField;
			userLevel.addEventListener(MouseEvent.MOUSE_OVER,userLevelOverHandle);
			userLevel.addEventListener(MouseEvent.MOUSE_OUT,userLevelOutHandle);
			
			userVip = ownPlayer.getChildByName("userVip") as MovieClip;
			gold = new ItemSkin.GOLD_FLASH() as MovieClip;
			mainMc.addChildAt(gold,this.numChildren);
			gold.icon.addChild(new Bitmap(ItemSkin.YUANBAO));
			gold.num.label.text = 0 + "";
			gold.x = 95;
			gold.y = 47;
			gold.addEventListener(MouseEvent.MOUSE_MOVE,goldMouseOverHandle);
			gold.addEventListener(MouseEvent.MOUSE_OUT,goldMouseOutHandle);
			
			money = new ItemSkin.GOLD_FLASH() as MovieClip;
			mainMc.addChildAt(money,this.numChildren);
			money.icon.addChild(new Bitmap(ItemSkin.TONGQIAN));
			money.num.label.text = 0 + "";
			money.x = 159;
			money.y = 47;
			money.addEventListener(MouseEvent.MOUSE_MOVE,moneyMouseOverHandle);
			money.addEventListener(MouseEvent.MOUSE_OUT,moneyMouseOutHandle);
			
			
			power = ownPlayer.getChildByName("power") as TextField;
			userImg = ownPlayer.getChildByName("userImg") as MovieClip;
			
			userImg.addEventListener(MouseEvent.MOUSE_MOVE,userImgMouseOverHandle);
			userImg.addEventListener(MouseEvent.MOUSE_OUT,userImgMouseOutHandle);
			
			powerLoading = ownPlayer.getChildByName("powerLoading") as MovieClip;
			powerLoading.addEventListener(Event.ENTER_FRAME,onPowerLoadingFrame);
			
			mouseOverMc = ownPlayer.getChildByName("mouseOverMc") as MovieClip;
			mouseOverMc.addEventListener(MouseEvent.MOUSE_MOVE,expLoadingMouseOverHandle);
			power.addEventListener(MouseEvent.MOUSE_OUT,powerMouseOutHandle);
			
			gameHint = new GameHint();
			addChild(gameHint);
			gameHint.visible = false;
			
			var options:Array = [];
			options.push(new OptionData(MenuPanel.OPTION_COPY_NAME , Lang.instance.trans(ChatData.ROLE_FILE)));
			MenuPanel.instance.initOptions(options);
			
		}
		//体力进度
		protected function onPowerLoadingFrame(event:Event):void
		{
			if(powerLoading.currentFrame >= _staminaNum) powerLoading.stop();
		}
		
		/**
		 * 初始化其它玩家面板
		 * */
		private function initOtherPlayerUI():void{
			otherPlayer =  mainMc.getChildByName("otherPlayer") as MovieClip;
			otherPlayer.visible = false;
			otherUserName = otherPlayer.getChildByName("userName") as TextField;
			otherUserLevel = otherPlayer.getChildByName("userLevel") as TextField;
		}
		
		/**
		 *玩家头像移入显示提示 
		 * @param e
		 * 
		 */	
		private function userImgMouseOverHandle(e:MouseEvent):void
		{
			var playerInfo:PRO_PlayerBase = GameData.inst.playerInfo;
			var property:PRO_Property = GameData.inst.playerInfo.property;
			var att_effect:int =  property.attack + (property.pdef + property.mdef) / 2.0 + playerInfo.maxhp / 7.0 + property.skillAtt + (property.crit + property.parry + property.dog + property.arp) * 10.0;// GameData.inst.playerInfo.property.att_effect;
			var str:String = "战力：" + playerInfo.power + "\n团队先攻：" + (int(att_effect / 20) + property.arpEffect);
			setGameHintHandle(e.stageX,e.stageY,str);
		}
		
		/**
		 *玩家头像移出隐藏提示 
		 * @param e
		 * 
		 */
		private function userImgMouseOutHandle(e:MouseEvent):void
		{
			gameHint.visible = false;
		}
		
		
		/**
		 *等级鼠标移入显示提示 
		 * @param e
		 * 
		 */	
		private function userLevelOverHandle(e:MouseEvent):void
		{
			setGameHintHandle(e.stageX,e.stageY,"角色等级：" + GameData.inst.playerInfo.level + "级");
		}
		
		/**
		 *等级鼠标移出隐藏提示 
		 * @param e
		 * 
		 */
		private function userLevelOutHandle(e:MouseEvent):void
		{
			gameHint.visible = false;
		}
		
		/**
		 *购买提示按钮鼠标移入 
		 * @param e
		 * 
		 */		
		private function buyBtnOverHandle(e:MouseEvent):void
		{
			setGameHintHandle(e.stageX,e.stageY,"点击购买体力");
		}
		
		/**
		 *购买提示按钮鼠标移出 
		 * @param e
		 * 
		 */
		private function buyBtnOutHandle(e:MouseEvent):void
		{
			gameHint.visible = false;
		}
		
		/**
		 * 鼠标移出经验数值 隐藏经验数值
		 * */
		private function powerMouseOutHandle(e:MouseEvent):void
		{
			power.visible = false;
			gameHint.visible = false;
		}
		
		/**
		 * 鼠标移入经验条 显示经验数值
		 * */
		private function expLoadingMouseOverHandle(e:MouseEvent):void
		{
			power.visible = true;
			
			setGameHintHandle(e.stageX,e.stageY,Lang.instance.trans("tips_10000"));
		}
		
		/**
		 *元宝文本鼠标移入 
		 * @param e
		 * 
		 */		
		private function goldMouseOverHandle(e:MouseEvent):void
		{
			setGameHintHandle(e.stageX,e.stageY,"元宝：" +　GameData.inst.playerExtraInfo.gold.toString());
		}
		
		/**
		 *元宝文本鼠标移出 
		 * @param e
		 * 
		 */
		private function goldMouseOutHandle(e:MouseEvent):void
		{
			gameHint.visible = false;
		}
		
		/**
		 *铜钱文本鼠标移入 
		 * @param e
		 * 
		 */
		private function moneyMouseOverHandle(e:MouseEvent):void
		{
			setGameHintHandle(e.stageX,e.stageY,"铜钱：" + GameData.inst.playerExtraInfo.coin);
		}
		
		/**
		 *铜钱文本鼠标移出 
		 * @param e
		 * 
		 */
		private function moneyMouseOutHandle(e:MouseEvent):void
		{
			gameHint.visible = false;
		}
		
		/**
		 * 设置提示
		 * @param x
		 * @param y
		 * @param str
		 * 
		 */		
		private function setGameHintHandle(x:int,y:int,str:String):void
		{
			gameHint.visible = true;
			gameHint.x = mouseX + 5;
			gameHint.y = mouseY + 5;
			gameHint.text = str;
		}
		
		/**
		 *设置左上玩家头像面板数据
		 * */
		public function initPlayerInfo():void
		{
			var playInfo:PRO_PlayerBase = GameData.inst.playerInfo;
			userName.text = playInfo.name;
			if(playInfo.level > int(userLevel.text))
				dispatchEvent(new PlayerEvent(PlayerEvent.LEVEL_UP));
			
			userLevel.text = playInfo.level.toString();
			userVip.gotoAndStop(1);
			var playExtraInfo:PRO_PlayerExtra = GameData.inst.playerExtraInfo;
			if(!_isFirst)//不是第一次刚进入游戏的时候
			{
				var goldAddNum:int = playExtraInfo.gold - preGoldNum;//最新的元宝数量与当前显示的差值
				if(goldAddNum > 0)
				{
					gold.gotoAndPlay("add");
					FloatTips.inst.show(Lang.instance.trans("Item_name_10010002") + " x" + goldAddNum);
				}
				else if(goldAddNum < 0)
				{
					gold.gotoAndPlay("deduct");
				}
				else
				{
					
				}
			}
			gold.num.label.text = GameDictionary.formatMoney(playExtraInfo.gold);
			preGoldNum = playExtraInfo.gold;
			
			if(!_isFirst)//
			{
				var coinAddNum:int = playExtraInfo.coin - preMoneyNum;
				if(coinAddNum > 0)
				{
					money.gotoAndPlay("add");
					FloatTips.inst.show(Lang.instance.trans("Item_name_10010001") + " x" + coinAddNum);
				}
				else if(coinAddNum < 0)
				{
					money.gotoAndPlay("deduct");
				}
				else
				{
					
				}
			}
			money.num.label.text =  GameDictionary.formatMoney(playExtraInfo.coin);
			preMoneyNum = playExtraInfo.coin;

			var stamina:int = int(GlobalFun.instance.trans("StaminaMAX"));//GameSettings.instance.settingsXML.global_param.StaminaMAX.@value;
			power.text = playExtraInfo.stamina + "/" + stamina;
			power.visible = false;
			
			var currentStamina:int = playExtraInfo.stamina;
			if(currentStamina < 1) currentStamina = 1;
			var staminaNum:int = Math.floor(playExtraInfo.stamina / 200 * 100);
			if(staminaNum > 100) staminaNum = 100;
			if(staminaNum > _staminaNum && !_isFirst)
			{
				powerLoading.play();
			}
			else
			{
				powerLoading.gotoAndStop(staminaNum);
			}
			_staminaNum = staminaNum;
			_isFirst = false;
		}
		
		/**
		 *设置左上其他玩家头像面板数据
		 * */
		public function initOtherPlayerInfo(playInfo:PRO_PlayerBase):void
		{
			otherPlayer.visible = true;
			otherUserName.text = playInfo.name;
			otherUserLevel.text = playInfo.level.toString();
		}
		
		/**
		 * 鼠标在场景任何地方点击时触发
		 * */
		public function stageClickHandle():void
		{
			otherPlayer.visible = false;
		}

		/**
		 * 获取单例
		 * */
		public static function get inst():MainLeaderPanel
		{
			return _instance ||= new MainLeaderPanel();
		}
		
		/**
		 *点击购买体力 
		 * @param e
		 * 
		 */		
		private function buyBtnClickHandle(e:MouseEvent):void
		{
			var quickBuy:XMLList = GameSettings.instance.settingsXML.quick_buy.quick_buy;	
			var power:int;
			for each(var xml:XML in quickBuy)
			{
				if(xml.@item_id == itemId)
				{
					if(buyCount <= xml.@count)
					{
						power = xml.@item_num;
						removeGold = xml.@remove_item.split("-")[1];
						break;
					}
				}
			}
			
			var str:String = Lang.instance.trans("quick_buy_1").replace("{gold}", removeGold).replace("{power}", power)
			ItemCost.showAlert("powerBuy",onFresh,str);
		}

		/**
		 *购买确定的点击事件
		 * 
		 */		
		private function onFresh():void
		{
			if(ItemCost.canUseSingItem([MoneyDict.YUANBAO,removeGold]))
			{
				var req:MSG_COMMON_BUY_REQ = new MSG_COMMON_BUY_REQ();
				req.type = STORE_TYPE.MSG_STORE_QUICK;
				req.itemId = itemId;
				GameService.instance.send(MSGID.MSGID_COMMON_BUY,req);
				isBuy = true;
			}
		}
		
		public function buyConutIncrease():void
		{
			if(isBuy)
			{
				buyCount++;
				isBuy = false;
			}
				
		}
			
		
		/**
		 *测试接口返回 
		 * @param e
		 * 
		 */		
		private function rechargeBtnClickHandle(e:MouseEvent):void
		{
			GameService.instance.saveDebugHandle();
		}
	}
}