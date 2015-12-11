package com.gamehero.sxd2.guide.gui
{
    import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.event.ProduceGuideEvent;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.GTextButton;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.GText;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	import com.gamehero.sxd2.manager.FunctionInfo;
	import com.gamehero.sxd2.manager.FunctionsManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.ApplicationDomain;
	import flash.text.TextFormatAlign;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	
	/**
	 * 单个产出引导
	 * @author xuwenyi
	 * @create 2014-05-13
	 **/
	public class ProduceGuideArea extends Sprite
	{
		private var domain:ApplicationDomain;
		
		public var type:int;
//		public var funcInfo:FunctionInfo;
		
		private var overBP:Bitmap;
		private var outBP:Bitmap;
		// 功能icon容器
		private var iconPanel:Sprite;
		// 功能尚未开放文字
		private var hintLabel:Label;
		// 立即前往按钮
		private var goBtn:GTextButton;
		// 功能名文本
		private var nameLabel:GText;
		
		
		/**
		 * 构造函数
		 * */
		public function ProduceGuideArea(domain:ApplicationDomain)
		{
			this.domain = domain;
			
			// 高亮图
			overBP = new Bitmap(this.getSwfInstance("PRODUCE_OVER") as BitmapData);
			overBP.visible = false;
			this.addChild(overBP);
			
			outBP = new Bitmap(this.getSwfInstance("PRODUCE_OUT") as BitmapData);
			this.addChild(outBP);
			
			// 功能icon容器
			iconPanel = new Sprite();
			iconPanel.x = 12;
			iconPanel.y = 6;
			this.addChild(iconPanel);
			
			// 功能尚未开放文字
			hintLabel = new Label(false);
			hintLabel.width = 100;
			hintLabel.height = 20;
			hintLabel.x = 185;
			hintLabel.y = 29;
			hintLabel.color = GameDictionary.RED;
			hintLabel.text = Lang.instance.trans("AS_1393");
			hintLabel.visible = false;
			this.addChild(hintLabel);
			
			// 按钮
//			goBtn = new GTextButton(MainSkin.redButton2Up, MainSkin.redButton2Down, MainSkin.redButton2Over, MainSkin.button2Disable);
//			goBtn.label = Lang.instance.trans("AS_1394");
//			goBtn.x = 185;
//			goBtn.y = 21;
//			goBtn.visible = false;
//			goBtn.addEventListener(MouseEvent.CLICK , onGo);
//			this.addChild(goBtn);
			
			// 功能名
			nameLabel = new GText();
			nameLabel.x = 85;
			nameLabel.y = 25;
			nameLabel.size = 18;
			nameLabel.width = 85;
			nameLabel.height = 30;
			nameLabel.align = TextFormatAlign.CENTER;
			this.addChild(nameLabel);
			
			// 鼠标事件
			this.addEventListener(MouseEvent.ROLL_OVER , over);
			this.addEventListener(MouseEvent.ROLL_OUT , out);
		}
		
		
		
		
		
		/**
		 * 更新
		 * */
		public function update(functionID:String , type:int = 1):void
		{
			this.type = type;
			
			var url:String = "";
			if(functionID == null)
			{
				// 快速购买
				if(type == 1)
				{
//					url = GameConfig.MAIN_MENU_ICON_URL + "kuaisugoumai.swf";
				}
				// 体力购买
				else
				{
//					url = GameConfig.MAIN_MENU_ICON_URL + "tili.swf";
				}
				
				goBtn.visible = true;
				hintLabel.visible = false;
				
				// 功能名
				nameLabel.text = Lang.instance.trans("AS_1395");
			}
			else
			{
//				funcInfo = FunctionsManager.instance.getFuncInfo(int(functionID));
				/*if(funcInfo)
				{	
					// 功能是否已开放
					goBtn.visible = funcInfo.isOpen;
					hintLabel.visible = !goBtn.visible;
					
					// 功能名
					nameLabel.text = funcInfo.detail;
					
					// icon url
					url = GameConfig.MAIN_MENU_ICON_URL + funcInfo.buttonIcon + ".swf";
				}
				else
				{
					this.clear();
				}*/
			}
			
			// 加载功能icon
			if(url != "")
			{
				var loader:BulkLoaderSingleton = BulkLoaderSingleton.instance;
				loader.addWithListener(url , null , onLoaded);
			}
		}
		
		
		
		
		/**
		 * 功能icon加载完成
		 * */
		private function onLoaded(e:Event):void
		{
			var imageItem:ImageItem = e.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE , onLoaded);
			
			// 添加icon
			var PNGDataClass:Class = imageItem.getDefinitionByName("PNGData") as Class;
			var png:BitmapData = new PNGDataClass();
			Global.instance.removeChildren(iconPanel);
			iconPanel.addChild(new Bitmap(png));
		}
		
		
		
		
		/**
		 * 前往某个模块
		 * */
		private function onGo(e:MouseEvent):void
		{
			this.dispatchEvent(new ProduceGuideEvent(ProduceGuideEvent.GOTO_WINDOW));
		}
		
		
		
		
		
		/**
		 * 鼠标移入
		 * */
		private function over(e:MouseEvent = null):void
		{
			overBP.visible = true;
			outBP.visible = false;
		}
		
		
		
		
		
		/**
		 * 鼠标移出
		 * */
		private function out(e:MouseEvent = null):void
		{
			overBP.visible = false;
			outBP.visible = true;
		}
		
		
		
		
		
		
		/**
		 * 获得导出类实例 
		 */
		protected function getSwfInstance(className:String):*
		{	
			if(domain)
			{
				var clazz:Class = domain.getDefinition(className) as Class;
				return new clazz();
			}
			return null;
		}
		
		
		
		
		/**
		 * 清除
		 * */
		public function clear():void
		{
			type = 0;
//			funcInfo = null;
			
			this.removeEventListener(MouseEvent.ROLL_OVER , over);
			this.removeEventListener(MouseEvent.ROLL_OUT , out);
			
			goBtn.removeEventListener(MouseEvent.CLICK , onGo);
			
			Global.instance.removeChildren(this);
		}
		
	}
}