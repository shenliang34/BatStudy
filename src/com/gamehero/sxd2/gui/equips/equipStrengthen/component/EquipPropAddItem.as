package com.gamehero.sxd2.gui.equips.equipStrengthen.component
{
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.equips.model.EquipModel;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.manager.EquipStrengthenManager;
	import com.gamehero.sxd2.vo.EquipStrengthenVo;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	/**
	 * 属性加成
	 * @author weiyanyu
	 * 创建时间：2015-9-21 上午11:27:31
	 * 
	 */
	public class EquipPropAddItem extends Sprite
	{
		
		private var _propNum:Label;
		
		private var _propAddNum:Label;
		
		public function EquipPropAddItem()
		{
			super();
			
			var bmp:Bitmap = new Bitmap(Global.instance.getBD(EquipModel.inst.domain,"Triangle"));
			addChild(bmp);
			bmp.x = 87;
			
			_propNum = new Label();
			addChild(_propNum);
			
			_propAddNum = new Label();
			addChild(_propAddNum);
			_propAddNum.x = 106;
			_propAddNum.color = GameDictionary.GREEN;
		}
		
		public function setInfo(index:int,prop:PropBaseVo,addLevel:int):void
		{
			this.visible = (prop["prop" + index][0] == 0) ? false : true;
			var equipLv:EquipStrengthenVo = EquipStrengthenManager.getInstance().voList[addLevel];//当前等级的强化配置
			var baseNum:int = prop["prop" + index][1];//基础属性
			_propNum.text = Lang.instance.trans("item_prop_" + prop["prop" + index][0]) + "   " + int(baseNum + baseNum * equipLv.percent / 100);
			var equipNextLv:EquipStrengthenVo = EquipStrengthenManager.getInstance().voList[addLevel + 1];
			_propAddNum.text =  int(baseNum + baseNum * equipNextLv.percent / 100).toString();
		}
	}
}