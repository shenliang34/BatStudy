package com.gamehero.sxd2.gui.arena
{
	import com.gamehero.sxd2.battle.data.BattleConfig;
	import com.gamehero.sxd2.battle.display.BattleFigureItem;
	import com.gamehero.sxd2.common.SpriteFigureItem;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.chat.ChatData;
	import com.gamehero.sxd2.gui.menu.MenuPanel;
	import com.gamehero.sxd2.gui.menu.OptionData;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.HtmlText;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.pro.PRO_PlayerBase;
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.utils.setTimeout;
	
	import alternativa.gui.enum.Align;
	import alternativa.gui.mouse.CursorManager;
	
	
	/**
	 * 竞技场人物显示组件
	 * @author xuwenyi
	 * @create 2015-09-30
	 **/
	public class ArenaFigure extends Sprite
	{
		// 姓名
		private var nameLabel:HtmlText;
		// 战力
		private var powerLabel:Label;
		// 模型
		private var figure:SpriteFigureItem;
		
		// 数据
		private var playerbase:PRO_PlayerBase;
		
		
		
		public function ArenaFigure()
		{
			nameLabel = new HtmlText();
			nameLabel.x = -20;
			nameLabel.y = -168;
			this.addChild(nameLabel);
			
			powerLabel = new Label();
			powerLabel.x = -60;
			powerLabel.y = -145;
			powerLabel.color = GameDictionary.ORANGE;
			powerLabel.width = 120;
			powerLabel.align = Align.CENTER;
			this.addChild(powerLabel);
		}
		
		
		
		
		
		public function update(base:PRO_PlayerBase , face:String , CHANGE_FIGURE:Class):void
		{
			this.clear();
			
			playerbase = base;
			
			nameLabel.text = GameDictionary.WHITE_TAG2 + "<u>" + base.name + "</u>" + GameDictionary.COLOR_TAG_END2;
			nameLabel.addEventListener(MouseEvent.CLICK , onLink);
			
			powerLabel.text = "战力: " + base.power;
			
			figure = new SpriteFigureItem(BattleConfig.LEADER_FIGURE_URL , false , BattleFigureItem.STAND);
			figure.alpha = 0;
			figure.frameRate = 18;
			figure.face = face;
			figure.play();
			figure.mouseEnabled = true;
			figure.addEventListener(MouseEvent.CLICK , onClick);
			figure.addEventListener(MouseEvent.ROLL_OVER , onOver);
			figure.addEventListener(MouseEvent.ROLL_OUT , onOut);
			this.addChild(figure);
			
			// 人物渐显
			TweenLite.to(figure , 1 , {alpha:1});
			
			// 播放人物切换动画
			var mc:MovieClip = new CHANGE_FIGURE();
			mc.gotoAndPlay(0);
			this.addChild(mc);
			setTimeout(over , 950);
			
			function over():void
			{
				mc.stop();
				removeChild(mc);
			}
		}
		
		
		
		
		
		
		
		/**
		 * 文本链接点击
		 * */
		private function onLink(e:MouseEvent):void
		{
			var options:Array = [];
			options.push(new OptionData(MenuPanel.OPTION_COPY_NAME , Lang.instance.trans(ChatData.ROLE_FILE)));
			MenuPanel.instance.initOptions(options);
			
			var paramObj:Object = new Object();
			paramObj.userID = playerbase.id.toString();
			paramObj.username = playerbase.name;
			
			MenuPanel.instance.show(paramObj , App.topUI);
		}
		
		
		
		
		
		/**
		 * 点击人物
		 * */
		private function onClick(e:MouseEvent):void
		{
			SXD2Main.inst.createBattle(3000001 , playerbase.id);
		}
		
		
		
		
		
		private function onOver(e:MouseEvent):void
		{
			CursorManager.cursorType = CursorManager.SWORD;
		}
		
		
		
		
		
		
		private function onOut(e:MouseEvent):void
		{
			CursorManager.cursorType = CursorManager.ARROW;
		}
		
		
		
		
		
		
		
		public function clear():void
		{
			playerbase = null;
			
			nameLabel.text = "";
			nameLabel.removeEventListener(TextEvent.LINK , onLink);
			
			powerLabel.text = "";
			
			if(figure)
			{
				figure.stop();
				figure.removeEventListener(MouseEvent.CLICK , onClick);
				figure.removeEventListener(MouseEvent.ROLL_OVER , onOver);
				figure.removeEventListener(MouseEvent.ROLL_OUT , onOut);
				this.removeChild(figure);
			}
			figure = null;
		}
	}
}