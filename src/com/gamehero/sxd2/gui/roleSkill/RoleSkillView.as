package com.gamehero.sxd2.gui.roleSkill
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.SButton;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.manager.SkillManager;
	import com.gamehero.sxd2.pro.PRO_Skill;
	import com.gamehero.sxd2.pro.PRO_SkillSlot;
	import com.gamehero.sxd2.vo.BattleSkill;
	
	import flash.display.Bitmap;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.ApplicationDomain;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	/**
	 * 主角技能
	 * @author zhangxueyou
	 * @create 2015-10-26
	 **/
	public class RoleSkillView extends Sprite
	{
		private static var _instance:RoleSkillView;//单例对象
		private var domain:ApplicationDomain;// 资源
		private var bgImg:Bitmap;// 背景图
		private var btnSp:Sprite; //按钮区域
		private var quitBtn:SButton;//退出按钮
		private var skillBtn:Button;//技能
		private var destinyBtn:Button;//命途
		private var equipBtn:Button;//装备
		private var otherBtn1:Button;//其他1
		private var otherBtn2:Button;//其他2
		
		private var slotPosList:Array = [[435,530],[570,565],[705,538],[1188,535],[1330,565],[1470,530]]; //插槽位置
		private var slotItemList:Array = [];//插槽对象数组
		public var skillListPanel:SkillListPanel;//下方技能面板
		private var skillList:Array;//玩家已经技能Id数组
		
		/**
		 *构造 
		 * 
		 */		
		public function RoleSkillView()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE , onAdd);
			this.addEventListener(Event.REMOVED_FROM_STAGE , onRemove);
		}
		
		/**
		 *加载资源 
		 * @param e
		 * 
		 */		
		private function onAdd(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE , onAdd);
			
			var loader:BulkLoaderSingleton = BulkLoaderSingleton.instance;
			loader.addWithListener(GameConfig.GUI_URL + "roleSkillView.swf" , null , onShow);
		}
		
		/**
		 *移除资源 
		 * @param e
		 * 
		 */		
		private function onRemove(e:Event):void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE , onRemove);
			
			var loader:BulkLoaderSingleton = BulkLoaderSingleton.instance;
			loader.remove(GameConfig.GUI_URL + "roleSkillView.swf");
		}
		
		/**
		 *加载完成 
		 * @param e
		 * 
		 */		
		private function onShow(e:Event):void
		{
			if(domain == null)
			{
				var imageItem:ImageItem = e.currentTarget as ImageItem;
				imageItem.removeEventListener(Event.COMPLETE , onShow);
				
				domain = imageItem.loader.contentLoaderInfo.applicationDomain;
				
				this.initWindow();
			}

			stage.addEventListener(Event.RESIZE , resize);
			this.resize();			
		}
		
		/**
		 *初始化窗口 
		 * 
		 */		
		private function initWindow():void
		{
			var global:Global = Global.instance;
			
			// 背景图
			bgImg = new Bitmap(global.getBD(domain , "bgImg"));
			addChild(bgImg);
			
			quitBtn = new SButton(global.getRes(domain , "QUIT_BTN") as SimpleButton);
			addChild(quitBtn);
			quitBtn.addEventListener(MouseEvent.CLICK , onQuitClick);
			
			btnSp = new Sprite();
			addChild(btnSp);
			
			skillBtn = new Button(global.getBD(domain , "btnUp"),null,global.getBD(domain , "btnOver"));
			skillBtn.icon = new Bitmap(global.getBD(domain , "skillIcon"));
			skillBtn.x = 200;
			skillBtn.y = 20;
			btnSp.addChild(skillBtn);
			
			destinyBtn = new Button(global.getBD(domain , "btnUp"),null,global.getBD(domain , "btnOver"));
			destinyBtn.icon = new Bitmap(global.getBD(domain , "destinyIcon"));
			destinyBtn.x = 0;
			destinyBtn.addEventListener(MouseEvent.CLICK,destinyBtnClickHandle);
			btnSp.addChild(destinyBtn);
			
			equipBtn = new Button(global.getBD(domain , "btnUp"),null,global.getBD(domain , "btnOver"));
			equipBtn.icon = new Bitmap(global.getBD(domain , "equipIcon"));
			equipBtn.x = 100;
			btnSp.addChild(equipBtn);
			
			otherBtn1 = new Button(global.getBD(domain , "btnUp"),null,global.getBD(domain , "btnOver"));
			otherBtn1.icon = new Bitmap(global.getBD(domain , "otherIcon"));
			otherBtn1.x = 300;
			btnSp.addChild(otherBtn1);
			
			otherBtn2 = new Button(global.getBD(domain , "btnUp"),null,global.getBD(domain , "btnOver"));
			otherBtn2.icon = new Bitmap(global.getBD(domain , "otherIcon"));
			otherBtn2.x = 400;
			btnSp.addChild(otherBtn2);
			
			for(var i:int;i<6;i++)
			{
				var skillItemCell:SkillItemCell = new SkillItemCell();
				skillItemCell.x = slotPosList[i][0];
				skillItemCell.y = slotPosList[i][1];
				skillItemCell.isSlot = true;
				addChild(skillItemCell);
				slotItemList.push(skillItemCell);
			}
			
			skillListPanel = new SkillListPanel();
			skillListPanel.initUI(domain);
			addChild(skillListPanel);
			
			initWindowInfo()
		}
		
		
		
		/**
		 *初始化面板数据 
		 * 
		 */		
		public function initWindowInfo():void
		{
			var info:PRO_Skill = GameData.inst.roleSkill;
			skillList = info.skills;
			setSkillListInfo(skillList);
			
			var slots:Array = new Array();
			for(var i:int;i<skillList.length;i++)
			{
				if(skillList[i].pos > 0)
				{
					slots.push(skillList[i]);
				}
			}
			setSkillSlotsInfo(slots,info.slots);
		}
		
		/**
		 *设置技能槽数据 
		 * @param list
		 * 
		 */		
		private function setSkillSlotsInfo(skills:Array,slots:Array):void
		{
			var i:int;
			var len:int = 6;
			for(i = 0; i < len; i++)
			{
				slotItemList[i].clear();
			}
			for(i = 0; i < len; i++)
			{
				var bool:Boolean
				var item:SkillItemCell = slotItemList[i];
				var soltInfo:PRO_SkillSlot = slots[i];
				item.slotInfo = soltInfo;
				
				for(var j:int = 0; j < skills.length; j++)
				{
					if(soltInfo.slotId == skills[j].pos)
					{
						var skillVo:BattleSkill = SkillManager.instance.getSkillBySkillID(skills[j].skillId);
						item.data = skillVo;
					}
				}
				if(!item.skillData)
					item.data = null; 
			}
		}
		
		/**
		 *设置技能面板数据 
		 * @param list
		 * 
		 */		
		private function setSkillListInfo(list:Array):void
		{
			skillListPanel.setPanelInfo(list);
		}
		
		/**
		 * 退出
		 * */
		private function onQuitClick(e:MouseEvent):void
		{
			dispatchEvent(new WindowEvent(WindowEvent.HIDE_FULLSCREEN_VIEW , WindowEvent.ROLESKILL_VIEW));
		}
		
		/**
		 *自适应 
		 * @param e
		 * 
		 */		
		private function resize(e:Event = null):void
		{
			if(stage)
			{
				//舞台宽高
				var w:int = stage.stageWidth;
				var h:int = stage.stageHeight;
				
				//自适应偏移
				var offsetW:int = int((w/1920 - 1) * 960);
				var offsetH:int = int((h/1080 - 1) * 633);
				
				//技能槽位置
				for(var i:int;i<slotPosList.length;i++)
				{
					slotItemList[i].x = slotPosList[i][0] + offsetW;
					slotItemList[i].y = slotPosList[i][1] + offsetH;
				}
				// 背景图
				bgImg.x = offsetW;
				bgImg.y = offsetH;
				//退出按钮
				quitBtn.x = w - quitBtn.width;
				quitBtn.y = 15;
				//上方按钮列表
				btnSp.x = w - btnSp.width >> 1;
				btnSp.y = 15;
				//技能区域
				skillListPanel.x = w - skillListPanel.width >> 1;
				skillListPanel.y = h - 150;//skillListPanel.height;
			}
			
		}

		/**
		 * 根据groupID获取技能对象
		 * */
		public function getSkillByGroupID(groupId:int):BattleSkill
		{
			var i:int;
			var len:int = skillList.length
			for(i; i < len; i++)
			{
				var skill:BattleSkill = SkillManager.instance.getSkillBySkillID(skillList[i]);
				if(int(skill.groupId) == groupId)
				{
					return skill;
				}
			}
			return null;
		}
		
		private function destinyBtnClickHandle(e:MouseEvent):void
		{
			MainUI.inst.openWindow(WindowEvent.FATE_WINDOW);	
		}
		
		/**
		 *获取单例 
		 * @return 
		 * 
		 */		
		public static function get inst():RoleSkillView
		{
			return _instance ||= new RoleSkillView();
		}
	}
}