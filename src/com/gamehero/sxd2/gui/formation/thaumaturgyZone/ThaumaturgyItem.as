package com.gamehero.sxd2.gui.formation.thaumaturgyZone
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.event.FormationEvent;
	import com.gamehero.sxd2.gui.formation.FormationSkin;
	import com.gamehero.sxd2.gui.formation.FormationType;
	import com.gamehero.sxd2.gui.heroHandbook.HeroHandbookSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.GTextButton;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ItemSkin;
	import com.gamehero.sxd2.manager.FormationManager;
	import com.gamehero.sxd2.pro.MSG_LEVELUP_MAGIC;
	import com.gamehero.sxd2.vo.FormationVo;
	import com.gamehero.sxd2.vo.MagicConfigVo;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import alternativa.gui.base.ActiveObject;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;

	/**
	 * @author Wbin
	 * 创建时间：2015-11-18 下午3:24:31
	 * 奇术玩法小单元
	 */
	public class ThaumaturgyItem extends ActiveObject
	{
		private var loader:BulkLoaderSingleton;
		/**
		 * 当前奇术数据
		 * */
		private var magConVo:MagicConfigVo;
		
		/**
		 * 阵法/功法
		 * */
		public var type:int;
		/**
		 * 编号
		 * */
		private var  id:int;
		/**
		 * 名字
		 * */
		public var nameLb:Label;
		/**
		 * 等级
		 * */
		public var levelLb:Label;
		public var lvNum:int = 0;
		/**
		 * 是否解锁
		 * */
		public var lock:Boolean = false;
		/**升级按钮*/
		private var lvUpBtn:GTextButton;
		/**
		 * 划入时候的高亮框
		 * */
		private var overBg:Bitmap;
		/**
		 * 图标
		 * */
		private var icon:Bitmap;
		/**
		 * 升级成功动画
		 * */
		private var sucessMc:MovieClip;
		
		public function ThaumaturgyItem(index:int,type:int)
		{
			super();
			
			this.type = type;
			this.id = index;
			this.loader = BulkLoaderSingleton.instance;
			
			var itemBgUp:Bitmap = new Bitmap(FormationSkin.QISHU_UP);
			this.addChild(itemBgUp);
			
			overBg = new Bitmap(FormationSkin.QISHU_OVER);
			overBg.visible = false;
			this.addChild(overBg);
			
			if(type == FormationType.GF_TYPE)
			{
				var iconBg:Bitmap = new Bitmap(ItemSkin.ITEM_BIG_BG);
				iconBg.x = 153 - iconBg.width >> 1;
				iconBg.y = 12;
				this.addChild(iconBg);
			}
			
			icon = new Bitmap();
			icon.x = 0;
			icon.y = 15;
			this.addChild(icon);
			
			sucessMc = new FormationSkin.LVUP_SUCESS() as MovieClip;
			sucessMc.x = 75;
			sucessMc.y = 37;
			sucessMc.stop();
			sucessMc.visible = false;
			this.addChild(sucessMc);
			
			nameLb = new Label();
			nameLb.color = GameDictionary.WHITE;
			nameLb.size = 14;
			nameLb.y = 95;
			nameLb.text = "生命";
			this.addChild(nameLb);

			levelLb = new Label();
			levelLb.color = GameDictionary.WHITE;
			levelLb.y = 120;
			levelLb.text = "等级：";
			this.addChild(levelLb);
			
			lvUpBtn = new GTextButton(CommonSkin.blueButton1Up,CommonSkin.blueButton1Down,CommonSkin.blueButton1Over);
			lvUpBtn.x = 153 - lvUpBtn.width >> 1;
			lvUpBtn.y = 140;
			lvUpBtn.label = "升级";
			this.addChild(lvUpBtn);
			
			if(this.type == 0)
			{
				this.loader.addWithListener(GameConfig.ITEM_ICON_URL  + "15010002_store.png", null, onIconLoaded, null, onIconError);
				this.loader.start();
			}
			else
			{
				this.icon.bitmapData = FormationSkin.formationVec[id];
				this.reLocation();
			}
		}
		
		/**
		 * over
		 * */
		public function overState():void
		{
			this.overBg.visible = true;
		}
		
		/**
		 * out
		 * */
		public function outState():void
		{
			this.overBg.visible = false;
		}
		
		/**
		 * 统一刷新数据
		 * */
		public function set data(vo:MagicConfigVo):void
		{
			this.magConVo = vo;
			
			nameLb.text = vo.name;
			levelLb.text = "等级：" + lvNum;
			
			this.reLocation();
			lvUpBtn.addEventListener(MouseEvent.CLICK,onLvUp);
		}
		
		/**
		 * 升级成功
		 * */
		public function sucess(val:*):void
		{
			lvNum ++;
			this.sucessMc.addFrameScript(this.sucessMc.totalFrames - 1, onPlayEnd);
			this.sucessMc.visible = true;
			this.sucessMc.play();
		}
		
		private function onPlayEnd():void
		{
			nameLb.text = "生命";
			levelLb.text = "等级：" + lvNum;
			lvUpBtn.locked = false;	
			this.sucessMc.visible = false;
			this.sucessMc.stop();
		}
		
		/**
		 * 即将开启
		 * lv 开启条件
		 * */
		public function unOpen():void
		{
			lock = true;
			this.levelLb.text = "" +"主角" + this.magConVo.open_lv + "级开启";
			this.levelLb.color = GameDictionary.RED;
			this.lvUpBtn.visible = false;
			this.reLocation();
		}
		
		/**
		 * 文本位置动态调整
		 * */
		private function reLocation():void
		{
			nameLb.x = 153 - nameLb.width >> 1;
			levelLb.x = 153 - levelLb.width >> 1;
			this.icon.x = 153 - this.icon.width >> 1;
		}
		
		/**
		 * 升级请求
		 * */
		private function onLvUp(evt:MouseEvent):void
		{
			lvUpBtn.locked = true;
			
			var msg:MSG_LEVELUP_MAGIC = new MSG_LEVELUP_MAGIC();
			msg.type = this.type;
			msg.id = this.id;
			this.dispatchEvent(new FormationEvent(FormationEvent.MSGID_LEVELUP_MAGIC,msg));
		}
		
		/**
		 * complete
		 * */
		private function onIconLoaded(event:Event):void
		{
			var imageItem:ImageItem = event.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE, onIconLoaded);
			this.icon.bitmapData = imageItem.content.bitmapData;
			this.reLocation();
		}
		
		/**
		 * error
		 * */
		private function onIconError(event:Event):void
		{
			this.icon.bitmapData = null;
		}
		
		/**
		 * 行间距
		 * */
		public function get rowDis():Number
		{
			return 198;
		}
		
		/**
		 * 列间距
		 * */
		public function get linDis():Number
		{
			return 178;
		}
		
		/**
		 * 销毁
		 * */
		public function clear():void
		{
			nameLb.text = "";
			levelLb.text = "";
			this.icon.bitmapData = null;
			lvUpBtn.removeEventListener(MouseEvent.CLICK,onLvUp);
			while(this.numChildren > 0)
			{
				this.removeChildAt(0);	
			}
		}
	}
}