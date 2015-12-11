package com.gamehero.sxd2.gui.tips
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.formation.thaumaturgyZone.ThaumaturgyItem;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ChatSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.GameHintSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.tooltip.GameHint;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import alternativa.gui.controls.text.Label;
	
	import org.bytearray.display.ScaleBitmap;

	/**
	 * @author Wbin
	 * 创建时间：2015-11-19 上午10:27:28
	 * 奇术tips
	 */
	public class ThaumaturgyTips
	{
		public function ThaumaturgyTips()
		{
		}
		
		
		/**
		 * 单个图鉴tips
		 * */
		public static function getThaumaTips(obj:ThaumaturgyItem):DisplayObject
		{
			var type:int = obj["type"];
			var lock:Boolean = obj.lock;
			var container:Sprite = new Sprite();
			var preHeight:int;
			var lineBM:ScaleBitmap;
			
			
			var namelLb:Label = new Label();
			namelLb.color = GameDictionary.WHITE;
			namelLb.x = 0;
			namelLb.y = 5;
			namelLb.text = obj.nameLb.text + "（" + obj.lvNum + "级）" ;
			container.addChild(namelLb);
			preHeight = namelLb.y + namelLb.height + 5;
			
			var descLb:Label = new Label();
			descLb.color = GameDictionary.WINDOW_BLUE;
			descLb.text = obj.nameLb.text;
			descLb.x = 0; 
			descLb.y = preHeight + 5;
			container.addChild(descLb);
			preHeight = descLb.y + descLb.height + 5;
			
			// 分割线
			lineBM = new ScaleBitmap(GameHintSkin.TIPS_LINE);
			lineBM.scale9Grid = ChatSkin.lineScale9Grid;
			lineBM.setSize(175, 2);
			lineBM.y = preHeight + 5;
			container.addChild(lineBM);
			preHeight = lineBM.y + lineBM.height + 10;
			
			//解锁
			var lockLb:Label = new Label();
			lockLb.color = GameDictionary.GREEN;
			lockLb.leading = 0.5;
			lockLb.x = 0;
			lockLb.y = preHeight + 5;
			lockLb.text = type == 0?(lock?"解锁需求： \n主角等级： 99级":"升级需求： 20\n主角等级：99级\n阅历： 99999"):(lock?"解锁需求： \n声望等级： 99级":"升级需求： 20\n主角等级：99级\n阅历： 99999");
			container.addChild(lockLb);
			
			var w:int = 180 - GameHint.paddingX * 2;
			var h:int = 137 - GameHint.paddingY * 2 - GameHintSkin.edge;
			container.graphics.beginFill(0,0);
			container.graphics.drawRect(0,0,w,h);
			container.graphics.endFill();
			
			return container;
		}
	}
}