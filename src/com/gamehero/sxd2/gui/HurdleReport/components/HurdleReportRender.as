package com.gamehero.sxd2.gui.HurdleReport.components
{
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.gui.hurdleGuide.model.HurdleGuideModel;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	import com.gamehero.sxd2.pro.PRO_InstanceBattle;
	import com.netease.protobuf.UInt64;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	
	import alternativa.gui.base.ActiveObject;
	import alternativa.gui.controls.text.Label;
	
	/**
	 * 战报条
	 * @author weiyanyu
	 * 创建时间：2015-8-27 下午4:41:01
	 * 
	 */
	public class HurdleReportRender extends ActiveObject
	{
		public function HurdleReportRender()
		{
			super();
			initUI();
		}
		/**
		 * 人名 
		 */		
		private var _nameLb:Label;
		/**
		 * 等级 
		 */		
		private var _levelLb:Label;
		/**
		 * 战报 
		 */		
		private var _repBtn:Button;
		
		private var _battleId:UInt64;
		
		
		private function initUI():void
		{
			
			_nameLb = new Label();
			addChild(_nameLb);
			_nameLb.x = 15;
			_nameLb.y = 5;
			
			_levelLb = new Label();
			_levelLb.x = 137;
			addChild(_levelLb);
			_levelLb.y = 5;
			var hurdleModel:HurdleGuideModel = HurdleGuideModel.inst;
			var global:Global = Global.instance;
			_repBtn = new Button(global.getBD(hurdleModel.reportDomain,"REPORT_BTN_UP"),global.getBD(hurdleModel.reportDomain,"REPORT_BTN_DOWN"),global.getBD(hurdleModel.reportDomain,"REPORT_BTN_OVER"));
			_repBtn.x = 230;
			addChild(_repBtn);
			
			this.width = 277;
			this.height = 22;
			_repBtn.addEventListener(MouseEvent.CLICK,onClick);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			SXD2Main.inst.battleReport(_battleId);
		}
		
		public function set data(pro:PRO_InstanceBattle):void
		{
			_nameLb.text = pro.playerName;
			_levelLb.text = pro.playerLevel + "级";
			_battleId = pro.id;
		}
		
		public function clear():void
		{
			_repBtn.removeEventListener(MouseEvent.CLICK,onClick);
		}
		
	}
}