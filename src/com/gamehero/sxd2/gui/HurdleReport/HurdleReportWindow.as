package com.gamehero.sxd2.gui.HurdleReport
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.gui.HurdleReport.components.HurdleReportRender;
	import com.gamehero.sxd2.gui.core.GeneralWindow;
	import com.gamehero.sxd2.gui.hurdleGuide.event.HurdleGuideEvent;
	import com.gamehero.sxd2.gui.hurdleGuide.model.HurdleGuideModel;
	import com.gamehero.sxd2.gui.hurdleGuide.model.vo.HurdleVo;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.manager.HurdlesManager;
	import com.gamehero.sxd2.pro.MSG_INSTANCE_REPORT_ACK;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	
	import alternativa.gui.enum.Align;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * 战报界面
	 * @author weiyanyu
	 * 创建时间：2015-8-27 下午4:26:22
	 * 
	 */
	public class HurdleReportWindow extends GeneralWindow
	{
		
		private var _itemList:Vector.<HurdleReportRender>;
		public function HurdleReportWindow(position:int, resourceURL:String="HurdleReport.swf", width:Number=0, height:Number=0)
		{
			super(position, resourceURL, 322, 331);
		}
		private var _closeBtn:Button;
		
		private var _titleLabel:Label;
		override protected function initWindow():void
		{
			super.initWindow();
			HurdleGuideModel.inst.reportDomain = uiResDomain;
			// 九宫格框
			var innerBg:ScaleBitmap;
			innerBg = new ScaleBitmap(CommonSkin.windowInner2Bg);
			innerBg.scale9Grid = CommonSkin.windowInner2BgScale9Grid;
			innerBg.setSize(305, 275);
			innerBg.x = 9;
			innerBg.y = 39;
			addChild(innerBg); 
			var TEXT_BG:Bitmap = new Bitmap(getSwfBD("TEXT_BG"));
			addChild(TEXT_BG);
			TEXT_BG.x = 10;
			TEXT_BG.y = 85;
			
			_titleLabel = new Label();
			_titleLabel.align = Align.CENTER;
			_titleLabel.width = 205;
			add(_titleLabel,59,56);
			var label:Label = new Label();
			label.text = "玩家";
			add(label,46,93);
			label = new Label();
			label.text = "等级";
			add(label,164,93);
			label = new Label();
			label.text = "战报";
			add(label,264,93);
			
			_closeBtn = new Button(CommonSkin.blueButton1Up,CommonSkin.blueButton1Down,CommonSkin.blueButton1Over);
			addChild(_closeBtn);
			_closeBtn.width = 68;
			_closeBtn.height = 32;
			_closeBtn.x = 127;
			_closeBtn.y = 274;
			_closeBtn.label = "关闭";
		}
		
		override public function close():void
		{
			super.close();
			if(_itemList)
			{
				for(var i:int = _itemList.length - 1; i > 0; i --)
				{
					removeChild(_itemList[i]);
					_itemList[i].clear();
				}
			}
			_itemList = null;
			_closeBtn.removeEventListener(MouseEvent.CLICK,onCcloseHandler);
		}
		
		override public function onShow():void
		{
			super.onShow();
			var hurdleVo:HurdleVo = HurdlesManager.getInstance().getHurdleById(GameData.inst.curHurdleId);
			_titleLabel.text = "最近打败“" + hurdleVo.name + "”的玩家战报";
			dispatchEvent(new HurdleGuideEvent(HurdleGuideEvent.REPORT,GameData.inst.curHurdleId));
			
			_closeBtn.addEventListener(MouseEvent.CLICK,onCcloseHandler);
		}
		
		protected function onCcloseHandler(event:MouseEvent):void
		{
			close();
		}
		
		public function updata(message:MSG_INSTANCE_REPORT_ACK):void
		{
			_itemList = new Vector.<HurdleReportRender>();
			var item:HurdleReportRender;
			var log:Array;
			if( message.log.length > 5)
			{
				log = message.log.slice(0,5);
			}
			else
			{
				log = message.log;
			}
			for(var i:int = 0; i < log.length; i++)
			{
				item = new HurdleReportRender();
				addChild(item);
				item.data = log[i];
				_itemList.push(item);
				item.x = 24;
				item.y = i * 29 + 122;
			}
		}
	}
}