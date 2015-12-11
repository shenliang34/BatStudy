package com.gamehero.sxd2.gui.equips.equipStrengthen.component
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.bag.model.EquipLocDict;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.core.IPanel;
	import com.gamehero.sxd2.gui.core.money.ItemCost;
	import com.gamehero.sxd2.gui.core.money.MoneyDict;
	import com.gamehero.sxd2.gui.core.money.MoneyLabel;
	import com.gamehero.sxd2.gui.equips.event.EquipEvent;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.manager.EquipStrengthenManager;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.pro.PRO_Item;
	import com.gamehero.sxd2.vo.EquipStrengthenVo;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import bowser.utils.MovieClipPlayer;
	
	
	/**
	 * 有装备，没有强化到最高级 
	 * @author weiyanyu
	 * 创建时间：2015-9-14 下午2:04:31
	 * 
	 */
	public class EquipOprateContNoMaxLv extends EquipOprateContBase implements IPanel
	{
		
		
		private var _prop0:EquipPropAddItem;
		
		private var _prop1:EquipPropAddItem;
		
		private var _costLabel:MoneyLabel;
		
		private var _strenBtn:Button;
		
		private var _data:PRO_Item;
		
		
		private var _mp:MovieClipPlayer = new MovieClipPlayer();
		
		public function EquipOprateContNoMaxLv()
		{
			super();
			
			_prop0 = new EquipPropAddItem();
			addChild(_prop0);
			_prop0.x = 363;
			_prop0.y = 321;
			
			_prop1 = new EquipPropAddItem();
			addChild(_prop1);
			_prop1.x = 363;
			_prop1.y = 341;
			
			_costLabel = new MoneyLabel();
			addChild(_costLabel);
			_costLabel.x = 402;
			_costLabel.y = 374;
			
			_strenBtn = new Button(CommonSkin.blueButton1Up,CommonSkin.blueButton1Down,CommonSkin.blueButton1Over);
			addChild(_strenBtn);
			_strenBtn.x = 400;
			_strenBtn.y = 400;
			_strenBtn.label = "强化";
		}
		
		public function init():void
		{
			_strenBtn.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_MOVE));
			_strenBtn.addEventListener(MouseEvent.CLICK,onStren);
			_strenMc.gotoAndStop(_strenMc.totalFrames);
		}
		
		protected function onStren(event:MouseEvent):void
		{
			if(ItemCost.canUseSingItem([MoneyDict.TONG_QIAN,_itemCost.itemCostNum]))
				dispatchEvent(new EquipEvent(EquipEvent.STRENGTHEN,_data.id));
		}
		
		public function set data(value:PRO_Item):void
		{
			_data = value;
			
			var prop:PropBaseVo = ItemManager.instance.getPropById(value.itemId);
			_prop0.setInfo(0,prop,value.addLevel);//设置属性加成的文本
			_prop1.setInfo(1,prop,value.addLevel);
			
			_itemCell.data = value;

			
			if(value.addLevel > 0)
			{
				setLabel(prop.name + "  " + value.addLevel + "级",GameDictionary.getColorByQuality(prop.quality));
			}
			else
			{
				setLabel(prop.name,GameDictionary.getColorByQuality(prop.quality));
			}
			
			var equipLv:EquipStrengthenVo = EquipStrengthenManager.getInstance().voList[value.addLevel];//当前等级强化配置
			switch(prop.subType)
			{
				case EquipLocDict.LINT_JIE:
					_itemCost = equipLv.ring;
					break;
				case EquipLocDict.HU_FU:
					_itemCost = equipLv.neck;
					break;
				case EquipLocDict.WU_QI:
					_itemCost = equipLv.weapon;
					break;
				case EquipLocDict.YU_GUAN:
					_itemCost = equipLv.head;
					break;
				case EquipLocDict.YU_PAO:
					_itemCost = equipLv.clothes;
					break;
				case EquipLocDict.XIE_ZI:
					_itemCost = equipLv.shoes;
					break;
			}
			_costLabel.iconId = _itemCost.itemId;
			if(GameData.inst.playerExtraInfo.coin >= _itemCost.itemCostNum)
			{
				_costLabel.lb.color = GameDictionary.ORANGE;
			}
			else
			{
				_costLabel.lb.color = GameDictionary.RED;
			}
			_costLabel.text = "" + _itemCost.itemCostNum;
		}
		/**
		 * 播放升级动画 
		 */		
		public function playMc():void
		{
			_mp.play(_strenMc , _strenMc.totalFrames/24 , 1 , _strenMc.totalFrames - 1);
			_mp.addEventListener(Event.COMPLETE , playerOvered);
		}
		
		private function playerOvered(e:Event):void
		{
			_mp.removeEventListener(Event.COMPLETE , playerOvered);
			_strenMc.gotoAndStop(_strenMc.totalFrames);
		}
		
		
		public function clear():void
		{
			_itemCell.clear();
			_strenBtn.removeEventListener(MouseEvent.CLICK,onStren);
			_mp.removeEventListener(Event.COMPLETE , playerOvered);
		}
	}
}