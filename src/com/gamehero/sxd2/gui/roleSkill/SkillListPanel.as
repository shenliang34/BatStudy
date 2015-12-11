package com.gamehero.sxd2.gui.roleSkill
{
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.gui.SButton;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.scrollPane.NormalScrollPane;
	import com.gamehero.sxd2.manager.SkillManager;
	
	import flash.display.Bitmap;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.system.ApplicationDomain;

	/**
	 * 技能面板
	 * @author Administrator
	 * 
	 */	
	public class SkillListPanel extends Sprite
	{
		private var domain:ApplicationDomain;// 资源
		private var global:Global;//全局变量
		private var typeBtnList:Array = [];//类型按钮数组
		private var allBtn:SButton;//全部按钮
		private var allSkillListSp:Sprite;//全部技能面板
		private var typeSkillListSp:Sprite;//类型技能面板
		private var allSkillItemList:Array = [];//技能全部数据
		private var typeSkillItemList:Array = [];//技能分类数据
		private var skillInfoList:Array;//玩家技能数据
		private var curType:int;//当前所选类型
		private var scrollPane:NormalScrollPane;
		
		/**
		 *构造 
		 * 
		 */		
		public function SkillListPanel()
		{
			super();
		}
		
		/**
		 *初始化UI 
		 * @param domain
		 * 
		 */		
		public function initUI(domain:ApplicationDomain):void
		{
			this.domain = domain;
			global = Global.instance;
			
			var bgImg:Bitmap = new Bitmap(global.getBD(domain , "skillListBg"));
			this.addChild(bgImg);
			
			initBtn("allBtn",290);
			initBtn("goldBtn",330);
			initBtn("woodBtn",370);
			initBtn("waterBtn",410);
			initBtn("fireBtn",450);
			initBtn("soilBtn",490);
			
			
			typeBtnList[0].status = SButton.Status_Over;
			typeBtnList[0].isResponse = true;
			
			initAllSkillListSp();
			initTypeSkillListSp();
			
			typeSkillListSp.visible = false;
		}
		
		/**
		 *初始化类型按钮 
		 * @param btnName
		 * @param x
		 * 
		 */		
		private function initBtn(btnName:String,x:int):void
		{
			var btn:SButton = new SButton(global.getRes(domain , btnName) as SimpleButton);
			btn.x = x;
			btn.y = -20;
			btn.name = btnName;
			btn.hint = SkillManager.instance.getSkillTypeByDescribe((x - 290) / 40);
			addChild(btn);
			btn.addEventListener(MouseEvent.CLICK,btnClickHandle);
			typeBtnList.push(btn);
		}	

		/**
		 *设置技能分类面板
		 * 
		 */		
		private function initTypeSkillListSp():void
		{
			typeSkillListSp = new Sprite();
			typeSkillListSp.x = 250;
			typeSkillListSp.y = 18;
			addChild(typeSkillListSp);
			
			for(var i:int; i < 5; i++)
			{
				var skillTypePanel:SkillTypePanel = new SkillTypePanel();
				skillTypePanel.x = skillTypePanel.width * i - 140;
				typeSkillListSp.addChild(skillTypePanel);
				typeSkillItemList.push(skillTypePanel);
			}
		}
		
		/**
		 *设置类型为全部的显示面板 
		 * 
		 */		
		private function initAllSkillListSp():void
		{
			allSkillListSp = new Sprite();
			
			scrollPane = new NormalScrollPane();
			scrollPane.width = 320;
			scrollPane.height = 100;
			scrollPane.stepScroll = 50;
			scrollPane.mouseDelta = 50;
			scrollPane.x = 260;
			scrollPane.y = 18;
			addChild(scrollPane); 
		}
		
		/**
		 *全部显示面板添加技能 
		 * @param list
		 * 
		 */		
		public function setPanelInfo(list:Array):void
		{
			skillInfoList = list;
			setAllSkillPanelInfo();
			setTypeSkillPanelInfo();
		}
		
		/**
		 *设置全系面板 
		 * 
		 */		
		private function setAllSkillPanelInfo():void
		{
			for(var i:int;i<allSkillItemList.length;i++)
			{
				allSkillItemList[i].clear();
				allSkillListSp.removeChild(allSkillItemList[i]);
				allSkillItemList[i] = null
			}
			allSkillItemList.splice(0);
			
			var posX:int;
			var posY:int;
			for(i=0;i<skillInfoList.length;i++)
			{
				var skillItemCell:SkillItemCell = new SkillItemCell();
				if(i%5 == 0 && i > 0)
				{
					posX += 5;
					posY += 50;
				}
				skillItemCell.x = (i - posX) * 60;
				skillItemCell.y = posY
				skillItemCell.isSlot = false;
				skillItemCell.data = SkillManager.instance.getSkillBySkillID(skillInfoList[i].skillId);
				allSkillListSp.addChild(skillItemCell);
				allSkillItemList.push(skillItemCell);
			}
			scrollPane.content = allSkillListSp;

		}
		
		/**
		 *设置分类面板 
		 * 
		 */		
		private function setTypeSkillPanelInfo():void
		{
			var list:Array = SkillManager.instance.getSkillByType(curType);
			for(var i:int;i<typeSkillItemList.length;i++){
				typeSkillItemList[i].clear();
				typeSkillItemList[i].setPanelInfo(list[i*7]);
			}
		}
		
		/**
		 * 类型按钮点击事件
		 * @param e
		 * 
		 */		
		private function btnClickHandle(e:MouseEvent):void
		{
			var btn:SButton = e.currentTarget as SButton;
			
			btn.status = SButton.Status_Over;
			btn.isResponse = true;
			
			setTypeBtnStatus(btn);
			
			if(btn.name == "allBtn")
			{
				curType = 0;
				allSkillListSp.visible = true;
				typeSkillListSp.visible = false;
			}
			else
			{
				switch(btn.name)
				{
					case "goldBtn":
					{
						curType = 1;
						break;
					}
					case "woodBtn":
					{
						curType = 2;	
						break;
					}
					case "waterBtn":
					{
						curType = 3;	
						break;
					}
					case "fireBtn":
					{
						curType = 4;	
						break;
					}
					case "soilBtn":
					{
						curType = 5;
						break;
					}
						
					default:
					{
						break;
					}
				}
				setTypeSkillPanelInfo();
				allSkillListSp.visible = false;
				typeSkillListSp.visible = true;
			}
		}
		
		/**
		 *设置类型按钮状态 
		 * @param btn
		 * 
		 */		
		private function setTypeBtnStatus(btn:SButton):void
		{
			for(var i:int = 0;i<typeBtnList.length;i++)
			{
				if(btn != typeBtnList[i])
				{
					typeBtnList[i].isResponse = false;
					typeBtnList[i].status = SButton.Status_Up;
					
				}
			}
		}	
	}
}