package com.gamehero.sxd2.gui.quickUse
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.bag.component.ItemCell;
	import com.gamehero.sxd2.gui.bag.model.BagModel;
	import com.gamehero.sxd2.gui.bag.model.ItemTypeDict;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.player.hero.model.HeroModel;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.DialogSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ItemSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.QuickUseSkin;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.pro.PRO_Hero;
	import com.gamehero.sxd2.pro.PRO_Item;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * 快速使用道具
	 * @author weiyanyu
	 * 创建时间：2015-11-9 下午4:37:19
	 * 
	 */
	public class QuickUseWindow extends Sprite
	{
		public function QuickUseWindow()
		{
			initWindow();
		}
		/**
		 * 关闭按钮 
		 */		
		private var _closeButton:Button;
		/**
		 * 物品格子 
		 */		
		private var _itemCell:ItemCell;
		/**
		 * 名字文本0 
		 */		
		private var _nameLb:Label;
		/**
		 * 可使用数量文本 
		 */		
		private var _canUseLb:Label;
		/**
		 * 一键使用按钮 
		 */		
		private var _useBtn:Button;
		/**
		 * 推荐的数据 
		 */		
		private var _data:PRO_Item;
		
		private var _prop:PropBaseVo;
		
		protected function initWindow():void
		{
			var innerBg:ScaleBitmap = new ScaleBitmap(DialogSkin.DIALOG_BG);
			innerBg.scale9Grid = DialogSkin.DIALOG_BG_9GRID;
			this.addChild(innerBg);
			innerBg.setSize(227,150);//背景
			
			var bg:Bitmap = new Bitmap(QuickUseSkin.BG);
			addChild(bg);
			bg.x = 6;
			bg.y = 39;
			
			var title:Bitmap = new Bitmap(QuickUseSkin.TITLE);
			addChild(title);
			title.x = 6;
			title.y = 9;
			
			_itemCell = new ItemCell();
			addChild(_itemCell);
			_itemCell.x = 16;
			_itemCell.y = 42;
			_itemCell.setBackGroud(ItemSkin.BAG_ITEM_NORMAL_BG)
			
			_nameLb = new Label();
			addChild(_nameLb);
			_nameLb.x = 82;
			_nameLb.y = 50;

			_canUseLb = new Label();
			addChild(_canUseLb);
			_canUseLb.x = 82;
			_canUseLb.y = 70;
			
			_useBtn = new Button(CommonSkin.blueButton1Up,CommonSkin.blueButton1Down,CommonSkin.blueButton1Over,CommonSkin.blueButton1Disable);
			addChild(_useBtn);
			_useBtn.x = 71;
			_useBtn.y = 103;
			_useBtn.height = 32;
			_useBtn.width = 84;
			
			// 关闭按钮
			_closeButton = new Button(CommonSkin.windowCloseBtnUp, CommonSkin.windowCloseBtnDown, CommonSkin.windowCloseBtnOver, CommonSkin.windowCloseBtnDisable);
			this.addChild(_closeButton);
			_closeButton.x = 200;
			_closeButton.y = 14;
		}
		
		public function onShow(value:PRO_Item):void
		{
			
			_data = value;
			
			_prop = ItemManager.instance.getPropById(_data.itemId);
			
			_itemCell.propVo = _prop;
			
			_nameLb.color = GameDictionary.getColorByQuality(_prop.quality);//设置名字
			_nameLb.text = _prop.name;
			
			if(_prop.pileNum > 1)//
			{
				_useBtn.label = "一键使用";
				_canUseLb.visible = true;
				_canUseLb.text = "可使用数量 " +   //获取最大可用数量 
					(BagModel.inst.getItemNum(_data.itemId) > _prop.pileNum ? _prop.pileNum:BagModel.inst.getItemNum(_data.itemId));//
			}
			else
			{
				if(_prop.type == ItemTypeDict.EQUIP)
				{
					_canUseLb.visible = true;
					_canUseLb.text = "道具类型： " + GameDictionary.createCommonText(Lang.instance.trans("team_ui_" + (19 + _prop.subType)),GameDictionary.WHITE)
					_useBtn.label = "一键穿戴";
				}
				else
				{
					_canUseLb.visible = false;
					_useBtn.label = "一键使用";
				}
			}
			
			_closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
			_useBtn.addEventListener(MouseEvent.CLICK, onUseHandler);
		}
		
		protected function onUseHandler(event:MouseEvent):void
		{
			close();
			//使用的时候还需要再次验证一遍，
			if(_prop.type == ItemTypeDict.EQUIP)//如果是装备
			{
				if(BagModel.inst.getItemById(_data.id) == null)return;//如果道具已经不存在了，则不处理
				if(HeroModel.instance.heroInfoList.length == 0) return;//没有上阵的伙伴
				var proHero:PRO_Hero = HeroModel.instance.getNoEquipList(_prop.subType);//找到此位置没有装备，且战力最高的伙伴
				if(proHero)
				{
					HeroModel.instance.itemHeroEquip(_data.id,0,proHero.heroId);
				}
				else
				{
					proHero = HeroModel.instance.getMaxPowerHero();//如果所有伙伴都已经穿戴了该位置的装备，则给最大战力的伙伴替换掉
					if(proHero)
					{
						HeroModel.instance.itemHeroEquip(_data.id,0,proHero.heroId);
					}
					
				}
			}
			else
			{
				var proItem:PRO_Item = BagModel.inst.getMaxPileItem(_data.itemId);//
				if(proItem)
				{
					GameProxy.inst.itemUse(proItem.id,proItem.num);
				}
			}
		}
		protected function onCloseButtonClick(event:MouseEvent):void
		{
			close();
		}
		
		private function close():void
		{
			_closeButton.removeEventListener(MouseEvent.CLICK, onCloseButtonClick);
			_useBtn.removeEventListener(MouseEvent.CLICK, onUseHandler);
			_itemCell.clear();
			
			if(this.parent)
				this.parent.removeChild(this);
			QuickUseManager.inst.show(null);
		}
	}
}