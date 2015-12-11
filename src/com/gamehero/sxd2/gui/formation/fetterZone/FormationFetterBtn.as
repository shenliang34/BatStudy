package com.gamehero.sxd2.gui.formation.fetterZone
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.event.FormationEvent;
	import com.gamehero.sxd2.gui.formation.ActiveBitmap;
	import com.gamehero.sxd2.gui.formation.FormationModel;
	import com.gamehero.sxd2.gui.formation.FormationSkin;
	import com.gamehero.sxd2.gui.player.hero.components.ActiveLabel;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.tabPanel.GTextTabButton;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.manager.HeroManager;
	import com.gamehero.sxd2.pro.PRO_Hero;
	import com.gamehero.sxd2.vo.HeroFateVo;
	import com.gamehero.sxd2.vo.HeroVO;
	
	import flash.events.MouseEvent;
	
	import alternativa.gui.base.ActiveObject;

	/**
	 * @author Wbin
	 * 创建时间：2015-9-25 下午4:26:36
	 * @羁绊
	 */
	public class FormationFetterBtn extends ActiveObject
	{
		//文本间隔调整
		private static const OFFSET:Number = 0.5;
		//名字固定长度
		private static const NAME_MAX_LENGTH:int = 6;
		
		private var fateBtn:GTextTabButton;
		/**与谁羁绊*/
		private var fataActLb:ActiveLabel;
		/**与谁羁绊详细信息*/
		private var fataDetActLb:ActiveLabel;
		/**上阵中存在羁绊伙伴*/
		private var fateInBattle:Array = [];
		/**助阵中存在羁绊伙伴*/
		private var helpInFate:Array = [];
		
		/**信息展示位编号*/
		private var index:int;
		/**按钮点击*/
		private var first:Boolean = true;
		
		public var isSelected:Boolean  = false;
		
		public function FormationFetterBtn()
		{
			this.fateBtn = new GTextTabButton(FormationSkin.J_UP,FormationSkin.J_OVER,FormationSkin.J_OVER);
			this.fateBtn.label = "";
			this.fateBtn.width = 30;
			this.fateBtn.height = 85;
			this.fateBtn.hint = Lang.instance.trans("formation_fate_tips");
			this.addChild(this.fateBtn);
			
			this.fataActLb = new ActiveLabel();
			this.fataActLb.label.leading = OFFSET;
			this.fataActLb.label.letterSpacing = OFFSET;
			this.fataActLb.mouseEnabled = true;
			this.fataActLb.mouseChildren = true;
			this.fataActLb.label.text = " ";
			this.addChild(fataActLb);
			
			this.fataDetActLb = new ActiveLabel();
			this.fataDetActLb.label.leading = OFFSET;
			this.fataDetActLb.label.letterSpacing = OFFSET;
			this.fataDetActLb.mouseEnabled = true;
			this.fataDetActLb.mouseChildren = true;
			this.fataDetActLb.label.text = " ";
			this.addChild(this.fataDetActLb);
		}
		
		/**
		 * @proList  阵中所有伙伴
		 * @helpHero 助阵伙伴
		 * @pro      当前伙伴
		 * @index    编号
		 * */
		public function upData(proList:Array,helpHero:Array,pro:PRO_Hero,index:int):void
		{
			this.clear();
			this.fateBtn.addEventListener(MouseEvent.CLICK,onFetter);
			this.fataActLb.addEventListener(MouseEvent.CLICK,onFetter);
			this.fataDetActLb.addEventListener(MouseEvent.CLICK,onFetter);
			/*this.fateBtn.addEventListener(MouseEvent.DOUBLE_CLICK,onFetter1);*/
			
			this.index = index;
			//当前伙伴详情
			var currentHeroInfo:HeroVO = HeroManager.instance.getHeroByID(pro.heroId.toString());
			//羁绊详情
			var heroFateInfo:HeroFateVo = HeroManager.instance.analysisFate(int(currentHeroInfo.job));
			//按钮
			var btnName:String = currentHeroInfo.name;
			for(var i:int = 0 ;i < btnName.length ; i++)
			{
				this.fateBtn.label += (btnName.charAt(i) + "\n");
			}
			
			//获得所有羁绊相关伙伴，不管是否获得该伙伴
			var fateList:Array = FormationModel.inst.getFetterNum(currentHeroInfo.id,heroFateInfo);
			
			//当前选中伙伴放在第一位
			this.fateInBattle.push(currentHeroInfo);
			
			if(fateList.length > 0)
			{
				for(i = 0 ; i < fateList.length ; i++)
				{
					var heroInfo:HeroVO = fateList[i];
					//羁绊详情
					var hasHero:Boolean = this.checkHero(proList,heroInfo);
					var str1:String = "";
					var str2:String = "";
					if(heroInfo.job.toString() == heroFateInfo.assistant_job1.toString())
					{
						str1 = "【" + GameDictionary.getJobName(heroInfo.job)  +"】" + this.addPoint(heroInfo.name) + "\n";
						str2 = "【" + Lang.instance.trans(heroFateInfo.fate_name1)  +"】" + heroInfo.name + "在场" +  "，" + GameDictionary.getHeroProperty(int(heroFateInfo.prop_1)) + "增加" + heroFateInfo.percent_1 + "%。\n";
						this.fateDetail(str1,str2,hasHero);
					}
					else if(heroInfo.job.toString() == heroFateInfo.assistant_job2.toString())
					{
						str1 = "【" + GameDictionary.getJobName(heroInfo.job)  +"】" + this.addPoint(heroInfo.name) + "\n";						
						str2 = "【" + Lang.instance.trans(heroFateInfo.fate_name2)  +"】" + heroInfo.name + "在场" +  "，" + GameDictionary.getHeroProperty(int(heroFateInfo.prop_2)) + "增加" + heroFateInfo.percent_2 + "%。\n";
						this.fateDetail(str1,str2,hasHero);
					}
					else if(heroInfo.job.toString() == heroFateInfo.assistant_job3.toString())
					{
						str1 = "【" + GameDictionary.getJobName(heroInfo.job)  +"】" + this.addPoint(heroInfo.name) + "\n";
						str2 = "【" + Lang.instance.trans(heroFateInfo.fate_name3)  +"】" + heroInfo.name + "在场" +  "，" + GameDictionary.getHeroProperty(int(heroFateInfo.prop_3)) + "增加" + heroFateInfo.percent_3 + "%。\n";
						this.fateDetail(str1,str2,hasHero);
					}
					else if(heroInfo.job.toString() == heroFateInfo.assistant_job4.toString())
					{
						str1 = "【" + GameDictionary.getJobName(heroInfo.job)  +"】" + this.addPoint(heroInfo.name) + "\n";
						str2 = "【" + Lang.instance.trans(heroFateInfo.fate_name4)  +"】" + heroInfo.name + "在场" +  "，" + GameDictionary.getHeroProperty(int(heroFateInfo.prop_4)) + "增加" + heroFateInfo.percent_4 + "%。\n";
						this.fateDetail(str1,str2,hasHero);
					}
					
					//助阵中有这个伙伴
					for(var n:int = 0; n < helpHero.length ; n++)
					{
						if(heroInfo.name == HeroManager.instance.getHeroByID(helpHero[n].heroId.toString()).name)
						{
							this.helpInFate.push(heroInfo);
						}
					}
					
					//上阵中有这个伙伴
					for(var m:int = 0; m < proList.length ;m++)
					{
						if(heroInfo.name == HeroManager.instance.getHeroByID(proList[m].heroId.toString()).name)
						{
							this.reDraw();
							this.fateInBattle.push(heroInfo);
						}
					}
				}
			}
			else
			{
				this.fataActLb.label.text += ("此伙伴单枪匹马!\n");
				this.fataDetActLb.label.text += ("此伙伴单枪匹马!\n");
				this.fataActLb.label.color = this.fataDetActLb.label.color = GameDictionary.WINDOW_BLUE_GRAY;
			}
			this.reDraw();
		}
		
		
		/**
		 * 文本用  . 补齐
		 * */
		private function addPoint(str:String):String
		{
			var newStr:String = "";
			
			for(var i:int = 0 ;i < NAME_MAX_LENGTH ; i++)
			{
				if( i < str.length)
				{
					newStr += str.charAt(i);
				}
				/*else
				{
					newStr += ".";
				}*/
			}
			
			return newStr;
		}
		
		/**
		 * 根据羁绊配置遍历当前阵中有无羁绊伙伴
		 * */
		private function checkHero(proList:Array,heroInfo:HeroVO):Boolean
		{
			var hasHero:Boolean = false;
			for(var m:int = 0; m < proList.length ;m++)
			{
				if(heroInfo.name == HeroManager.instance.getHeroByID(proList[m].heroId.toString()).name)
				{
					hasHero = true;
				}
			}
			return hasHero;
		}
		
		/**
		 * 羁绊详情信息展示
		 * @str1 
		 * @str2 
		 * @value  文本颜色控制
		 * */
		private function fateDetail(str1:String,str2:String,value:Boolean):void
		{
			if(value)
			{
				var strArr:Array = str2.split("，");
				this.fataActLb.label.text += (GameDictionary.WINDOW_BLUE_TAG + str1 + GameDictionary.COLOR_TAG_END);
				this.fataDetActLb.label.text += (GameDictionary.WINDOW_BLUE_TAG + strArr.shift()  + "，" + GameDictionary.COLOR_TAG_END
					+ GameDictionary.GREEN_TAG + strArr.shift() + GameDictionary.COLOR_TAG_END);
			}
			else
			{
				this.fataActLb.label.text += (GameDictionary.WINDOW_BLUE_GRAY_TAG + str1 + GameDictionary.COLOR_TAG_END);
				this.fataDetActLb.label.text += (GameDictionary.WINDOW_BLUE_GRAY_TAG + str2 + GameDictionary.COLOR_TAG_END);
			}
		}
		
		/**
		 * 显示/隐藏
		 * @value1  fateLabel
		 * @value2  detailFateLabel
		 * */
		public function setFetterInfo(value1:Boolean,value2:Boolean):void
		{
			this.fataActLb.visible = value1;
			this.fataDetActLb.visible = value2;
		} 
		
		/**设置按钮选中状态*/
		public function btnState(value:Boolean):void
		{
			this.fataDetActLb.visible = value;
			this.fateBtn.hint = this.isSelected?Lang.instance.trans("formation_fate_tips2"):Lang.instance.trans("formation_fate_tips");
		}
		
		
		/**设置伙伴选中*/
		public function set btnSelected(value:Boolean):void
		{
			this.fateBtn.selected = value;
		}
		
		/**伙伴是否选中*/
		public function get btnSelected():Boolean
		{
			return this.fateBtn.selected;
		}
		
		/**
		 * 点击按钮
		 * */
		public function get firstSelected():Boolean
		{
			return this.first;
		}
		
		/**天缘面板重排事件*/
		public function onFetter(evt:MouseEvent = null):void
		{
			if(this.isSelected)
			{
				//再次点击选中伙伴收缩处理
				this.dispatchEvent(new FormationEvent(FormationEvent.FETTER_INFO_1));
				return;
			}
			
			this.isSelected = true;
			this.fateBtn.hint = this.isSelected?Lang.instance.trans("formation_fate_tips2"):Lang.instance.trans("formation_fate_tips");
		
			var data :Object = new Object();
			data.index = this.index;
			data.fateInBattle = this.fateInBattle;
			data.helpInFate = this.helpInFate;
			this.dispatchEvent(new FormationEvent(FormationEvent.FETTER_INFO,data));
			this.first = false;
		}
		
		/*private function onFetter1(evt:MouseEvent):void
		{
			this.dispatchEvent(new FormationEvent(FormationEvent.FETTER_INFO_1));
		}*/
		
		/**
		 * 羁绊显示位置调整
		 * */
		private function reDraw():void
		{
			this.fataActLb.sethitArea(this.fateBtn.x + this.fateBtn.width,0,fataActLb.label.width,this.fateBtn.height,(85 - this.fataActLb.label.height) >> 1);
			this.fataDetActLb.sethitArea(this.fateBtn.x + this.fateBtn.width,0,fataDetActLb.label.width,this.fateBtn.height,(85 - this.fataDetActLb.label.height) >> 1);
		}
		
		
		public function clear():void
		{
			/*this.first = true;*/
			this.fateBtn.removeEventListener(MouseEvent.CLICK,onFetter);
			this.fataActLb.removeEventListener(MouseEvent.CLICK,onFetter);
			this.fataDetActLb.removeEventListener(MouseEvent.CLICK,onFetter);
			
			this.index = 0;
			this.fateBtn.label = "";
			this.fataActLb.label.text = "";
			this.fataDetActLb.label.text = "";
			this.fateInBattle = [];
			this.helpInFate = [];
		}
		
	}
}