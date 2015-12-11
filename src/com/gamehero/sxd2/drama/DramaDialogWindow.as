package com.gamehero.sxd2.drama
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.core.GameWindow;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.utils.effect.TextEf;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	
	/**
	 * 剧情对话框window
	 * @author xuwenyi
	 * @create 2015-09-08
	 **/
	public class DramaDialogWindow extends GameWindow
	{
		// 用于全屏点击触发
		private var clickPanel:Sprite;
		// 对话框背景
		private var dialogBG:Sprite;
		// 头像容器
		private var headPanel:Sprite;
		
		// 姓名
		private var nameLb:Label;
		// 对话文字
		private var textEf:TextEf;
		
		// 方向
		private var direction:int;
		// 对话完毕后的回调
		private var callback:Function;
		
		
		
		/**
		 * 构造函数
		 * */
		public function DramaDialogWindow(position:int, resourceURL:String = "DramaDialogWindow.swf")
		{
			super(position, resourceURL, 780, 130);
			
			canOpenTween = false;
			
			// 对话框背景图
			dialogBG = new Sprite();
			this.addChild(dialogBG);
			
			// 头像容器
			headPanel = new Sprite();
			
			// 姓名
			nameLb = new Label();
			nameLb.width = 100;
			nameLb.color = GameDictionary.ORANGE;
			this.addChild(nameLb);
			
			// 对话文字
			textEf = new TextEf();
			this.addChild(textEf);
		}
		
		
		
		
		override protected function initWindow():void
		{
			super.initWindow();
			
			var bmp:Bitmap = new Bitmap(Global.instance.getBD(uiResDomain , "BG"));
			bmp.x = -390;
			bmp.y = -65;
			dialogBG.x = 390;
			dialogBG.y = 65;
			dialogBG.addChild(bmp);
			
			// 头像容器
			headPanel.x = 268 - 390;
			headPanel.y = -382 - 65;
			dialogBG.addChild(headPanel);
			
			clickPanel = new Sprite();
			this.addChild(clickPanel);
		}
		
		
		
		
		override public function onShow():void
		{
			super.onShow();
			
			clickPanel.addEventListener(MouseEvent.CLICK , onClick);
			this.addEventListener(Event.RESIZE , resize);
			
			this.resize();
		}
		
		
		
		
		
		public function showMessage(head:String , name:String , message:String , direction:int , callback:Function):void
		{
			// 姓名
			if(name == "{me}")
			{
				name = GameData.inst.roleInfo.base.name;
			}
			nameLb.text = name;
			
			// 将对话内容出现主角名字的部分替换
			message = message.replace("{me}" , GameData.inst.roleInfo.base.name);
			
			// 对话内容
			var lb:Label = new Label();
			lb.width = 300;
			lb.height = 60;
			lb.leading = 0.4;
			textEf.show(lb , message);
			
			// 加载头像
			var loader:BulkLoaderSingleton = BulkLoaderSingleton.instance;
			loader.addWithListener(GameConfig.DRAMA_DIALOG_HEAD_URL + head + ".swf" , null , onLoad);
			
			this.direction = direction;
			this.callback = callback;
			
			this.resize();
		}
		
		
		
		
		
		/**
		 * 头像加载完成
		 * */
		private function onLoad(e:Event):void
		{
			var imageItem:ImageItem = e.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE , onLoad);
			
			var PNGDataClass:Class = imageItem.getDefinitionByName("PNGData") as Class;
			var png:BitmapData = new PNGDataClass();
			var bmp:Bitmap = new Bitmap(png);
			
			bmp.x = 0;
			bmp.y = 0;
			headPanel.addChild(bmp);
		}
		
		
		
		
		
		
		/**
		 * 点击快速结束对话
		 * */
		private function onClick(e:MouseEvent):void
		{
			if(textEf.isEnd == false)
			{
				textEf.showFull();
			}
			else
			{
				this.close();
				
				if(callback)
				{
					var tempfunc:Function = callback;
					callback = null;
					setTimeout(tempfunc , 1);
				}
			}
		}
		
		
		
		
		
		
		/**
		 * 自适应
		 * */
		private function resize(e:Event = null):void
		{
			if(stage)
			{
				var w:int = stage.stageWidth;
				var h:int = stage.stageHeight;
				
				// 右
				if(direction == 1)
				{
					x = w - width;
					y = h - height;
				}
				// 左
				else
				{
					x = 0;
					y = h - height;
				}
				
				clickPanel.x = -x;
				clickPanel.y = -y;
				clickPanel.graphics.clear();
				clickPanel.graphics.beginFill(0 , 0);
				clickPanel.graphics.drawRect(0 , 0 , w , h);
				clickPanel.graphics.endFill();
				
				// 背景
				dialogBG.scaleX = direction;
				
				// 姓名位置
				if(direction == 1)
				{
					nameLb.x = 470;
					nameLb.y = 30;
				}
				else
				{
					nameLb.x = 250;
					nameLb.y = 30;
				}
				
				// 对话内容位置
				if(direction == 1)
				{
					textEf.x = 200;
					textEf.y = 55;
				}
				else
				{
					textEf.x = 270;
					textEf.y = 55;
				}
			}
			
			
		}
		
		
		
		
		private function clear():void
		{
			Global.instance.removeChildren(headPanel);
			
			textEf.clear();
			
			clickPanel.removeEventListener(MouseEvent.CLICK , onClick);
			this.removeEventListener(Event.RESIZE , resize);
		}
		
		
		
		
		override public function close():void
		{
			this.clear();
			
			super.close();
		}
	}
}