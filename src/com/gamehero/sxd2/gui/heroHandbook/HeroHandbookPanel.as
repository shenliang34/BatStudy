package com.gamehero.sxd2.gui.heroHandbook
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.SButton;
	import com.gamehero.sxd2.gui.formation.ActiveBitmap;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.GTextButton;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ItemSkin;
	import com.gamehero.sxd2.manager.DialogManager;
	import com.gamehero.sxd2.manager.HeroManager;
	import com.gamehero.sxd2.pro.MSG_PHOTOAPPRAISAL_BREAK_REQ;
	import com.gamehero.sxd2.pro.MSG_PHOTOAPPRAISAL_RWD_REQ;
	import com.gamehero.sxd2.pro.PRO_PhotoAppraisalRwd;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import alternativa.gui.controls.text.Label;
	

	/**
	 * @author Wbin
	 * 创建时间：2015-11-2 下午9:10:01
	 * 
	 */
	public class HeroHandbookPanel extends Sprite
	{
		static private var _instance:HeroHandbookPanel
		
		/**
		 * 阵营按钮集合
		 * */
		private var raceBtnArr:Array = [];
		/**
		 * 图鉴显示伙伴
		 * */
		private var heroArr:Array;
		/**
		 * 展示图鉴集合
		 * */
		private var bookArr:Array = [];
		/**
		 * 当前伙伴阵营
		 * */
		private var heroRace:int = 3;
		/**
		 * 灵蕴
		 * */
		private var yhBg:ActiveBitmap;
		private var yhLabel:Label;
		
		private var currentHeroBook:HerohandbookCell;
		
		private var rwdNumLb:Label;
		private var getRwdBtn:GTextButton;
		
		//元魂按钮
		private var soulBtn:SButton;
		//分解按钮
		private var resolveBtn:SButton;
		//取消按钮
		private var cancelBtn:SButton;
		//切页按钮
		private var pageBtn:SButton;
		//进度条
		private var progressBar:MovieClip;
		//当前进度条在的帧数
		private var frame:int  = 0;
		private var stopFrame:int = 0;
		private var percent:Number;
		//宝箱
		private var box:MovieClip;
		private var boxArea:ActiveBox;
		
		private var triangleBtn1:SButton;
		private var triangleBtn2:SButton;
		//当前第几页
		private var index:int = 0;
		
		public function HeroHandbookPanel()
		{
			this.init();
		}
		
		public static function get inst():HeroHandbookPanel
		{
			return _instance ||= new HeroHandbookPanel();
		}
		
		/**
		 * init
		 * */
		private function init():void
		{
			this.heroArr = [];
			
			var bg:Bitmap = new Bitmap(HeroHandbookSkin.BG_2);
			bg.x = 26;
			bg.y = 53;
			this.addChild(bg);
			
			
			yhBg = new ActiveBitmap(ItemSkin.LINGYUN);
			yhBg.x = 77;
			yhBg.y = 540;
			yhBg.hint = "";
			this.addChild(yhBg);
			
			yhLabel = new Label();
			yhLabel.text =  GameDictionary.createCommonText("" + 99999);
			yhLabel.x = 102;
			yhLabel.y = 545;
			this.addChild(yhLabel);
						
			//按钮
			for(var i:int = 0; i<HeroHandbookSkin.BOOK_BTN_NUM;i++)
			{
				var raceBtn:SButton =  HeroHandbookSkin.BTN_ARR[i] as SButton;
				var p:Point = HeroHandbookSkin.BTN_POINT[i];
				raceBtn.x = p.x;
				raceBtn.y = p.y;
				this.addChild(raceBtn);
				raceBtn.hint = GameDictionary.getRaceHint(i);
				this.raceBtnArr.push(raceBtn);
			}
			
			soulBtn = HeroHandbookSkin.BTN_ARR[5] as SButton;
			soulBtn.x = 506;
			soulBtn.y = 540;
			soulBtn.visible = true;
			this.addChild(soulBtn);
			
			resolveBtn = HeroHandbookSkin.BTN_ARR[10] as SButton;
			resolveBtn.x = 466;
			resolveBtn.y = 540;
			resolveBtn.visible = false;
			this.addChild(resolveBtn);
			
			cancelBtn = HeroHandbookSkin.BTN_ARR[9] as SButton;
			cancelBtn.x = 576;
			cancelBtn.y = 540;
			cancelBtn.visible = false;
			cancelBtn.addEventListener(MouseEvent.CLICK,onResolve);
			this.addChild(cancelBtn);
			
			var barBg:Bitmap = new Bitmap(HeroHandbookSkin.BAR_BG);
			barBg.width = 200;
			barBg.x = 770;
			barBg.y = 65;
			barBg.visible = false;
			this.addChild(barBg);
			
			this.progressBar = new HeroHandbookSkin.PROGRESS_BAR() as MovieClip;
			this.progressBar.x = 771;
			this.progressBar.y = 66;
			this.progressBar.gotoAndStop(0);
			this.progressBar.visible = false;
			this.addChild(progressBar);
			
			this.box = new HeroHandbookSkin.BOX() as MovieClip;
			this.box.x = 980;
			this.box.y = 50;
			this.box.visible = false;
			this.addChild(box);
			this.boxArea = new ActiveBox();
			this.boxArea.initBox(this.box.width,this.box.height);
			this.boxArea.x = 980;
			this.boxArea.y = 50;
			this.boxArea.visible = false;
			this.addChild(boxArea);
			
			this.rwdNumLb = new Label();
			this.rwdNumLb.color = GameDictionary.WINDOW_BLUE;
			this.rwdNumLb.y = 67;
			this.rwdNumLb.visible = false;
			this.addChild(this.rwdNumLb);
			
			this.triangleBtn1 = HeroHandbookSkin.BTN_ARR[11] as SButton;
			this.triangleBtn1.scaleX = -1;
			this.triangleBtn1.x = 21 + triangleBtn1.width;
			this.triangleBtn1.y = 294;
			this.triangleBtn1.visible = false;
			this.addChild(this.triangleBtn1);
			
			this.triangleBtn2 = HeroHandbookSkin.BTN_ARR[12] as SButton;
			this.triangleBtn2.x = 1021;
			this.triangleBtn2.y = 294;
			this.triangleBtn2.visible = false;
			this.addChild(this.triangleBtn2);
			
			this.pageBtn = HeroHandbookSkin.BTN_ARR[13] as SButton;
			this.pageBtn.status = SButton.Status_Down;
			this.pageBtn.visible = false;
			this.addChild(this.pageBtn);
		}
		
		/**
		 * 伙伴信息
		 * */
		public function updata():void
		{
			this.clearData();
			this.heroArr = HeroManager.instance.getHeroArrByRace("" + this.heroRace);
			this.setTypeBtnStatus(HeroHandbookSkin.BTN_ARR[this.heroRace] as SButton);
			
			for(var i:int = 0 ; i < HeroHandbookSkin.BOOK_NUM ; i++)
			{
				var heroBookCell:HerohandbookCell = new HerohandbookCell();
				var p:Point =  HeroHandbookSkin.BOOK_POINT[i];
				heroBookCell.hint = " ";
				heroBookCell.setData(this.heroArr[i + HeroHandbookSkin.BOOK_NUM*index]);
				heroBookCell.x = p.x;
				heroBookCell.y = p.y;
				bookArr.push(heroBookCell);
				this.addChild(heroBookCell);
			}
			
			this.boxArea.updata();
			//元魂数量
			yhLabel.text =  GameDictionary.createCommonText("" + GameData.inst.playerExtraInfo.spirit);
			yhBg.hint = "灵蕴：" + yhLabel.text;
			this.frame = this.progressBar.currentFrame;
			this.setProgress();
		}
		
		
		public function setProgress():void
		{
			this.rwdNumLb.text = HerohandbookModel.inst.activeHeroNum + "/" + ((HerohandbookModel.inst.rwdNum[this.heroRace] as PRO_PhotoAppraisalRwd).getRwdMaxID + 4);
			this.rwdNumLb.x  = 870 - this.rwdNumLb.width/2;
			
			this.percent = HerohandbookModel.inst.activeHeroNum / ((HerohandbookModel.inst.rwdNum[this.heroRace] as PRO_PhotoAppraisalRwd).getRwdMaxID + 4);
			if(int(this.progressBar.totalFrames*percent) != this.frame)
			{
				//要停止的帧数
				stopFrame = int(this.progressBar.totalFrames*percent);
				this.progressBar.addEventListener(Event.ENTER_FRAME,onFrame);
			}
			
			if((HerohandbookModel.inst.activeHeroNum  < (HerohandbookModel.inst.rwdNum[this.heroRace] as PRO_PhotoAppraisalRwd).getRwdMaxID + 4))
			{
				this.box.gotoAndStop(0);
				this.boxArea.removeEventListener(MouseEvent.CLICK,onGetRwd);
			}
			else
			{
				this.box.gotoAndStop(2);
				this.boxArea.addEventListener(MouseEvent.CLICK,onGetRwd);
			}
		}
		
		
		/**
		 * 添加监听
		 * */
		public function addlistener():void
		{
			for(var i:int = 0;i<this.raceBtnArr.length;i++)
			{
				var sBtn:SButton = this.raceBtnArr[i] as SButton;
				//图鉴
				sBtn.addEventListener(MouseEvent.CLICK,onHandbook);
			}
			
			this.soulBtn.addEventListener(MouseEvent.CLICK,onResolve);
			this.resolveBtn.addEventListener(MouseEvent.CLICK,onResolve);
			this.cancelBtn.addEventListener(MouseEvent.CLICK,onResolve);
			this.triangleBtn1.addEventListener(MouseEvent.CLICK,onChanePage);
			this.triangleBtn2.addEventListener(MouseEvent.CLICK,onChanePage);
		}
		
		private function onFrame(evt:Event):void
		{
			if(this.frame == this.stopFrame)
			{
				this.progressBar.addEventListener(Event.ENTER_FRAME,onFrame);
				this.frame = this.stopFrame
				return;
			}
			else if(this.frame < this.stopFrame)
			{
				this.progressBar.gotoAndStop(this.frame++);
			}
			else if(this.frame > this.stopFrame)
			{
				this.progressBar.gotoAndStop(this.frame--);
			}
		}
		
		//图鉴
		private function onHandbook(evt:MouseEvent):void
		{
			var btn:SButton = evt.currentTarget as SButton;
			
			var race:int = this.raceBtnArr.indexOf(btn);
			this.heroRace = race;
			//伙伴信息刷新
			this.updata();
		}
		
		//领取奖励
		private function onGetRwd(evt:MouseEvent):void
		{
			this.box.gotoAndStop(3);
			
			var msg:MSG_PHOTOAPPRAISAL_RWD_REQ = new MSG_PHOTOAPPRAISAL_RWD_REQ();
			msg.race = this.heroRace;
			msg.num = ((HerohandbookModel.inst.rwdNum[this.heroRace] as PRO_PhotoAppraisalRwd).getRwdMaxID) + 4;
			this.dispatchEvent(new HeroHandbookEvent(HeroHandbookEvent.MSGID_PHOTO_APPRAISAL_RWD,msg));
		}
		
		/**
		 *设置类型按钮状态 
		 * @param btn
		 * 
		 */		
		private function setTypeBtnStatus(btn:SButton):void
		{
			for(var i:int = 0;i<this.raceBtnArr.length;i++)
			{
				if(btn != raceBtnArr[i])
				{
					(this.raceBtnArr[i] as SButton).isResponse = false;
					(this.raceBtnArr[i] as SButton).status = SButton.Status_Up;
				}
				else
				{
					btn.status = SButton.Status_Down;
				}
			}
		}	
		
		
		private function onChanePage(evt:MouseEvent):void
		{
			if(evt.currentTarget == this.triangleBtn2)
			{
				//下一页
				this.index++;
			}
			else
			{
				//上一页
				this.index = this.index<=0?0:--this.index;
			}
			this.updata();
		}
		
		
		//分解
		private function onResolve(evt:MouseEvent):void
		{
			//点击元魂按钮
			if(evt.currentTarget == this.soulBtn)
			{
				this.soulBtn.visible = false;
				this.resolveBtn.visible = true;
				this.cancelBtn.visible = true;
				
				for(var i:int = 0; i< this.bookArr.length;i++)
				{
					var book:HerohandbookCell = this.bookArr[i];
					book.seleceted = true;
				}
			}
			else if(evt.currentTarget == this.resolveBtn)
			{
				if(evt.currentTarget == this.resolveBtn)
				{
					var idArr:Array = new Array();
					for(i = 0;i<this.bookArr.length;i++)
					{
						book = this.bookArr[i];	
						if(book.seleceted)
						{
							idArr.push(book.heroPro.base.id);
						}
					}
					
					if(idArr.length > 0)
					{
						DialogManager.inst.showCost(DialogManager.ONCE,"是否分解选中伙伴残灵！",function():void
						{
							sendBreak(idArr);
						});
					}
				}
			}
			else if(evt.currentTarget == this.cancelBtn)
			{
				this.soulBtn.visible = true;
				this.resolveBtn.visible = false;
				this.cancelBtn.visible = false;
				
				for(i = 0;i<this.bookArr.length;i++)
				{
					book = this.bookArr[i];	
					book.seleceted = false;
				}
			}
		}
		
		private function sendBreak(arr:Array):void
		{
			for(var i:int = 0;i<arr.length;i++ )
			{
				var msg:MSG_PHOTOAPPRAISAL_BREAK_REQ = new MSG_PHOTOAPPRAISAL_BREAK_REQ();
				msg.id = arr[i];
				this.dispatchEvent(new HeroHandbookEvent(HeroHandbookEvent.MSGID_PHOTO_APPRAISAL_BREAK,msg));
			}
		}
		
		private function clearData():void
		{
			this.soulBtn.visible = true;
			this.resolveBtn.visible = false;
			this.cancelBtn.visible = false;
			for(var i:int = 0 ; i < this.bookArr.length ; i++)
			{
				 var book:HerohandbookCell = this.bookArr[i];
				 book.seleceted = false;
				 this.removeChild(book);
			}
			HerohandbookModel.inst.activeHeroNum = 0;
			this.bookArr = [];
		}
		
		/**
		 * 销毁
		 * */
		public function clear():void
		{
			this.clearData();
			
			for(var i:int = 0;i<this.raceBtnArr.length;i++)
			{
				var sBtn:* = this.raceBtnArr[i];
				if(i == this.raceBtnArr.length - 1)
				{
					//分解
					sBtn.removeEventListener(MouseEvent.CLICK,onResolve);
				}
				else
				{
					//图鉴
					sBtn.removeEventListener(MouseEvent.CLICK,onHandbook);
				}
			}
			
			for(i = 0;i<this.raceBtnArr.length;i++)
			{
				(this.raceBtnArr[i] as SButton).isResponse = false;
				(this.raceBtnArr[i] as SButton).status = SButton.Status_Up;
			}
			
			this.soulBtn.removeEventListener(MouseEvent.CLICK,onResolve);
			this.resolveBtn.removeEventListener(MouseEvent.CLICK,onResolve);
			this.cancelBtn.removeEventListener(MouseEvent.CLICK,onResolve);
			this.progressBar.removeEventListener(Event.ENTER_FRAME,onFrame);
			this.boxArea.removeEventListener(MouseEvent.CLICK,onGetRwd);
			this.triangleBtn1.removeEventListener(MouseEvent.CLICK,onChanePage);
			this.triangleBtn2.removeEventListener(MouseEvent.CLICK,onChanePage);
			this.progressBar.gotoAndStop(0);
			this.heroRace = 3;
			this.heroArr = [];
		}
	}
}