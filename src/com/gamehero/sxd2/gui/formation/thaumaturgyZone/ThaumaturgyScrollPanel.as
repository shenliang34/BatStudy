package com.gamehero.sxd2.gui.formation.thaumaturgyZone
{
	import com.gamehero.sxd2.gui.formation.FormationSkin;
	import com.gamehero.sxd2.gui.formation.FormationType;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.scrollPane.NormalScrollPane;
	import com.gamehero.sxd2.manager.MagicManager;
	import com.gamehero.sxd2.pro.MSG_LEVELUP_MAGIC;
	import com.gamehero.sxd2.pro.MSG_MAGIC_INFO;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * @author Wbin
	 * 创建时间：2015-11-18 下午3:28:26
	 * 奇术玩法面板
	 */
	public class ThaumaturgyScrollPanel extends NormalScrollPane
	{
		private var panelContent:Sprite;
		/**
		 * 奇术Items  功法
		 * */
		private var gongItems:Array;
		/**
		 * 奇术Items  阵法
		 * */
		private var zhenItems:Array;
		//阵法
		private var zf:Bitmap;
		//位置动态调整参数
		private var h:int = 0;
		
		public function ThaumaturgyScrollPanel()
		{
			super();
			
			panelContent = new Sprite();
			this.content = panelContent;
			
			this.gongItems = [];
			this.zhenItems = [];
			
			//功法
			var gf:Bitmap = new Bitmap(FormationSkin.GF);
			gf.x = 230;
			gf.y = 5;
			panelContent.addChild(gf);
			
			//阵法
			this.zf = new Bitmap(FormationSkin.ZF);
			zf.x = 230;
			zf.y = 420;
			panelContent.addChild(zf);
		}
		
		/**
		 * 奇术
		 * */
		public function update(data:MSG_MAGIC_INFO):void
		{
			var type:int = data.type;
			//功法
			var thamuItem:ThaumaturgyItem;
			if(type == FormationType.GF_TYPE)
			{
				this.clearGf();
				var prors:Array = MagicManager.init.getOpenProp();
				var len:int = prors.length;
				for(var i:int = 0 ; i < (len + 1) ; i++)
				{
					thamuItem = new ThaumaturgyItem(i,FormationType.GF_TYPE);
					thamuItem.x = 50 + i%5*thamuItem.linDis;
					thamuItem.y = 35 + int(i/5)*thamuItem.rowDis;
					
					panelContent.addChild(thamuItem);
					gongItems.push(thamuItem);
					
					//即将开启
					if(i == len)
					{
						thamuItem.data = MagicManager.init.magicPropArr[i];
						thamuItem.unOpen();
						h = thamuItem.y + 182;
					}
					else
					{
						thamuItem.data = prors[i];
					}
					
					thamuItem.hint = " ";
					thamuItem.addEventListener(MouseEvent.ROLL_OVER,onOver);
					thamuItem.addEventListener(MouseEvent.ROLL_OUT,onOut);
				}
			}
			
			//阵法title动态调整
			this.zf.y = h + 10;
			h = this.zf.y + this.zf.height + 10;
			//阵法
			if(type ==  FormationType.ZF_TYPE)
			{
				this.clearZf();
				var fors:Array = MagicManager.init.getOpenFor();
				len = fors.length;
				//阵法
				for(i = 0 ; i < (len + 1) ; i++)
				{
					if(i == 8)
					{
						this.refresh();
						return;
					}
					
					thamuItem = new ThaumaturgyItem(i,FormationType.ZF_TYPE);
					thamuItem.x = 50 + i%5*thamuItem.linDis;
					thamuItem.y = h + int(i/5)*thamuItem.rowDis;
					
					panelContent.addChild(thamuItem);
					zhenItems.push(thamuItem);
					
					//即将开启
					if(i == len)
					{
						thamuItem.data = MagicManager.init.magicForArr[i];
						thamuItem.unOpen();
					}
					else
					{
						thamuItem.data = fors[i];
					}
					
					thamuItem.hint = " ";
					thamuItem.addEventListener(MouseEvent.ROLL_OVER,onOver);
					thamuItem.addEventListener(MouseEvent.ROLL_OUT,onOut);
				}
			}
			//滚动面板重绘
			this.refresh();
		}
		
		/**
		 * 升级
		 * */
		public function upDataLvUp(data:MSG_LEVELUP_MAGIC):void
		{
			var id:int = data.id;
			var thamu:ThaumaturgyItem;
			switch(data.type)
			{
				case 0:
					thamu = gongItems[id] as ThaumaturgyItem;
					break;
				case 1:
					thamu = zhenItems[id] as ThaumaturgyItem;
					break
			}
			thamu.sucess(data.id);
		}
		
		private function onOver(evt:MouseEvent):void
		{
			(evt.target as ThaumaturgyItem).overState();
		}
		
		private function onOut(evt:MouseEvent):void
		{
			(evt.target as ThaumaturgyItem).outState();
		}
		
		/**分开清理  功法*/
		private function clearGf():void
		{
			var thamuItem:ThaumaturgyItem;
			for(var i:int = 0;i<gongItems.length;i++)
			{
				thamuItem = gongItems[i];
				thamuItem.removeEventListener(MouseEvent.ROLL_OVER,onOver);
				thamuItem.removeEventListener(MouseEvent.ROLL_OUT,onOut);
				thamuItem.clear();
				panelContent.removeChild(thamuItem);
			}
			gongItems = [];
		}
		
		/**分开清理 阵法*/
		private function clearZf():void
		{
			var thamuItem:ThaumaturgyItem;
			for(var i:int = 0;i<zhenItems.length;i++)
			{
				thamuItem = zhenItems[i];
				thamuItem.removeEventListener(MouseEvent.ROLL_OVER,onOver);
				thamuItem.removeEventListener(MouseEvent.ROLL_OUT,onOut);
				thamuItem.clear();
				panelContent.removeChild(thamuItem);
			}
			zhenItems = [];
		}
		
		/**
		 * 销毁
		 * */
		public function clear():void
		{
			this.clearGf();
			this.clearZf();
		}
	}
}