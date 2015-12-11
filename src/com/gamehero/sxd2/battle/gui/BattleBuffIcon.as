package com.gamehero.sxd2.battle.gui
{
	import com.gamehero.sxd2.battle.data.BattleBuff;
	import com.gamehero.sxd2.battle.data.BattleDataCenter;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.pro.GS_BattleBuff_Pro;
	import com.gamehero.sxd2.vo.BuffVO;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	
	import alternativa.gui.base.ActiveObject;
	import alternativa.gui.enum.Align;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	
	/**
	 * 战斗中的BUFF ICON
	 * @author xuwenyi
	 * @create 2013-12-09
	 **/
	public class BattleBuffIcon extends ActiveObject
	{
		public var buff:BattleBuff;
		
		// icon panel
		private var iconPanel:Sprite
		private var iconURL:String;
		
		// 叠加层数
		private var numLabel:Label;
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleBuffIcon()
		{
			iconPanel = new Sprite();
			iconPanel.mouseEnabled = false;
			iconPanel.mouseChildren = false;
			iconPanel.filters = [new DropShadowFilter()];
			this.addChild(iconPanel);
			
			// 叠加层数
			numLabel = new Label(false);
			numLabel.x = 14;
			numLabel.y = 14;
			numLabel.width = 12;
			numLabel.height = 12;
			numLabel.align = Align.CENTER;
			numLabel.visible = false;
			this.addChild(numLabel);
		}
		
		
		
		
		/**
		 * 显示icon
		 * */
		public function update(buff:BattleBuff):void
		{
			this.buff = buff;
			
			if(buff)
			{
				this.hint = " ";
				
				// 叠加数字
				var data:GS_BattleBuff_Pro = buff.data;
				var vo:BuffVO = buff.vo;
				
				if(data.num > 1)
				{
					var color:int = 0;
					switch(vo.buffClass)
					{
						// 增益
						case "1":
							color = GameDictionary.BLUE;
							break;
						// 减益
						case "2":
							color = GameDictionary.RED;
							break;
						// 特殊
						case "3":
							color = GameDictionary.ORANGE;
							break;
					}
					numLabel.color = color;
					numLabel.text = data.num + "";
					numLabel.visible = true;
					
					// 绘制数字背景
					this.drawNumBG(data.num > 9 ? 2 : 1);
				}
				else
				{
					numLabel.visible = false;
				}
				
				// 加载技能图标
				iconURL =  GameConfig.ICON_URL + "buff/" + vo.Bufficon + ".jpg";
				var loader:BulkLoaderSingleton = BattleDataCenter.instance.loader;
				loader.addWithListener(iconURL , null , onLoaded);
			}
			else
			{
				this.clear();
			}
		}
		
		
		
		
		
		/**
		 * icon加载完成
		 * */
		private function onLoaded(e:Event):void
		{
			var imageItem:ImageItem = e.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE , onLoaded);
			
			// 添加头像
			var bmp:Bitmap = imageItem.content;
			if(bmp)
			{
				var icon:Bitmap = new Bitmap(bmp.bitmapData);
				var global:Global = Global.instance;
				global.removeChildren(iconPanel);
				iconPanel.addChild(icon);
			}
		}
		
		
		
		
		/**
		 * 绘制数字背景
		 * @param num 位数
		 * */
		private function drawNumBG(num:int):void
		{
			numLabel.graphics.clear();
			numLabel.graphics.beginFill(0);
			if(num == 1)
			{
				numLabel.graphics.drawRoundRect(2,1,6,10,2,2);
			}
			else
			{
				numLabel.graphics.drawRoundRect(-1,1,12,10,2,2);
			}
			numLabel.graphics.endFill();
		}
		
		
		
		
		/**
		 * 清除
		 * */
		public function clear():void
		{
			this.hint = "";
			this.buff = null;
			
			Global.instance.removeChildren(iconPanel);
		}
		
	}
}