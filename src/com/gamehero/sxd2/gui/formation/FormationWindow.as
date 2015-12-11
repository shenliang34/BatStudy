package com.gamehero.sxd2.gui.formation
{
	import com.gamehero.sxd2.battle.display.BattleFigureItem;
	import com.gamehero.sxd2.common.SpriteFigureItem;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.event.FormationEvent;
	import com.gamehero.sxd2.gui.core.GeneralWindow;
	import com.gamehero.sxd2.gui.formation.formationZone.FormationDragCell;
	import com.gamehero.sxd2.gui.formation.fetterZone.FormationFetterDragCell;
	import com.gamehero.sxd2.gui.formation.fetterZone.FormationFetterFigureCell;
	import com.gamehero.sxd2.gui.formation.fetterZone.FormationFetterPanel;
	import com.gamehero.sxd2.gui.formation.formationZone.FormationFigureCell;
	import com.gamehero.sxd2.gui.formation.bagZone.FormationHeroBagPanel;
	import com.gamehero.sxd2.gui.formation.formationZone.FormationHeroLocationPanel;
	import com.gamehero.sxd2.gui.formation.thaumaturgyZone.ThaumaturgyPanel;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.tabPanel.GTextTabButton;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.local.Lang;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	
	import org.bytearray.display.ScaleBitmap;

	/**
	 * @author Wbin
	 * 创建时间：2015-8-21 上午11:32:30
	 * @布阵
	 */
	public class FormationWindow extends GeneralWindow
	{
		private const WINDOW_WIDTH:int = 994;
		private const WINDOW_HEIGHT:int = 608;
		/**功能*/
		private const FUNCTION_NAME:Array = ["布阵","奇术"];
		
		/**伙伴背包*/
		private var heroBagPanel:FormationHeroBagPanel;
		/**伙伴布阵*/
		public var heroBattlePanel:FormationHeroLocationPanel;
		/**伙伴羁绊*/
		private var heroFetterPanel:FormationFetterPanel;
		/**伙伴奇术*/
		public var thaumaPanel:ThaumaturgyPanel;
		/**tabPanel*/
		private var tabPanels:Array = [];
		/**tabBtn*/
		private var tabBtns:Array = [];
		/**默认打开第一个玩法*/
		private var selected:int = 0;
		
		/**羁绊开关*/
		private var fetter:Boolean = false;
		/**阵型开关*/
		private var battle:Boolean = true;
		
		//选中布阵
		private var inBattleBtn:GTextTabButton;
		//未选中布阵
		private var battleBtn:GTextTabButton;
		
		//选中天缘
		private var inFetterBtn:GTextTabButton;
		//未选中天缘
		private var fetterBtn:GTextTabButton;
		
		// 鼠标刚点击拖拽格时,因为不能触发拖拽,模拟一个人形用于跟随鼠标
		private var dragMouseFigure:SpriteFigureItem;
		
		
		
		/**
		 * 滤镜
		 * */
		private var filters:Array = [];
		
		private var bg_1:Bitmap;
		private var bg_2:Bitmap;
		
		/**==========================================九宫格站位===============================================**/
		/**站位格子数*/
		public static const LOCA_NUM:int = 9;
		/**伙伴布阵位置X,Y*/
		public static const POSTION:Array = [new Point(519.50,314),new Point(508,369),new Point(493.5,429.5)
											,new Point(422,313.5),new Point(403.5,368.5),new Point(383.5,429.5)
											,new Point(324.5,313.5),new Point(302,368.5),new Point(275.5,429)];
		// 显示人物模型(因九宫格已被隐藏,用于在拖拽时显示格子上的人形)
		private var figureCells:Array = [];
		// 中部全部九宫格(用于触发拖拽)
		private var dragCells:Array = [];
		
		
		/**==========================================羁绊站位==================================================**/
		/**羁绊站位*/
		private static const FETTER_POSINT:Array = [new Point(22,229),new Point(148,195),new Point(275,160),
													new Point(401,160),new Point(535,195),new Point(654,229)];
		/**人物模型*/
		private var fetterFigureCells:Array = [];
		/**拖拽模型*/
		private var fetterDragCells:Array = [];
		
		/**
		 * 当前点击需要隐藏的格子对象
		 * */
		public static var OBJ:FormationFetterDragCell;
		
		public function FormationWindow(windowPosition:int,resourceURL:String = "FormationWindow.swf")
		{
			super(windowPosition,resourceURL,WINDOW_WIDTH,WINDOW_HEIGHT);
		}
		
		
		
		/**
		 * 复写
		 * */
		override protected function initWindow():void
		{
			super.initWindow();
			this.interrogation = Lang.instance.trans("tips_formation").replace(/\\n/gi,"\n");
			FormationModel.inst.domain = this.uiResDomain;
			FormationSkin.init(this.uiResDomain);
			// 初始化固定UI
			this.initUI();
		}
		
		
		
		override public function onShow():void
		{
			super.onShow();
			
			//打开面板默认显示第一个玩法
			this.showFunnyPanel(selected);
			
			// 事件
			this.addEventListener(FormationEvent.DRAG_CELL_VISIBLE , onDragCellVisible);
			this.addEventListener(FormationEvent.FORMATION_REMINDER , onReminder);
			this.addEventListener(FormationEvent.FETTER_DRAG_CELL_VISIBLE , onDragFetterVisible);
			this.addEventListener(FormationEvent.DRAG_MOUSE_FIGURE_VISIBLE , onDragMouseFigureVisible);
			this.addEventListener(FormationEvent.INBATTLE_2_HELPBATTLE,onBuffControl);
			this.battleBtn.addEventListener(MouseEvent.CLICK,switchPanel);
			this.fetterBtn.addEventListener(MouseEvent.CLICK,switchPanel);
			// 拖拽时人物模型跟随鼠标
			this.addEventListener(MouseEvent.MOUSE_DOWN , dragMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP , dragMouseUp);
			
			for(var i:int = 0;i<this.tabBtns.length;i++)
			{
				(this.tabBtns[i] as GTextTabButton).addEventListener(MouseEvent.CLICK,changeFunny);
			}
			//请求布阵信息
			this.dispatchEvent(new FormationEvent(FormationEvent.MSGID_FORMATION_INFO));
		}
		
		
		
		
		private function initUI():void
		{
			// 九宫格框
			var innerBg:ScaleBitmap;
			innerBg = new ScaleBitmap(CommonSkin.windowInner2Bg);
			innerBg.scale9Grid = CommonSkin.windowInner2BgScale9Grid;
			innerBg.setSize(974, 548);
			innerBg.x = 10;
			innerBg.y = 39;
			addChild(innerBg);
			
			//已开放玩法
			this.openFunny();
			//布阵、羁绊面板
			this.initFormationPanel();
			//奇术面板
			this.thaumaturgyPanel();
		}
		
		/**
		 * 布阵UI
		 * */
		private function initFormationPanel():void
		{
			var formationPanel:Sprite = this.tabPanels[0];
			
			bg_1 = new Bitmap(this.getSwfBD("bg_1"));
			bg_1.x = 17;
			bg_1.y = 77;
			bg_1.visible = false;
			formationPanel.addChild(bg_1);
			
			bg_2 = new Bitmap(this.getSwfBD("bg_2"));
			bg_2.x = 17;
			bg_2.y = 77;
			bg_2.visible = false;
			formationPanel.addChild(bg_2);
			
			var bg2:Bitmap = new Bitmap(this.getSwfBD("bg2"));
			bg2.x = 19;
			bg2.y = 489;
			formationPanel.addChild(bg2);
			
			var line:Bitmap = new Bitmap(this.getSwfBD("line_0"));
			line.x = 11;
			line.y = 69;
			formationPanel.addChild(line);
			
			/*line = new Bitmap(this.getSwfBD("line_1"));
			line.x = 785;
			line.y = 557;·
			formationPanel.addChild(line);*/
			
			var heroBagRect:ScaleBitmap = new ScaleBitmap(this.getSwfBD("bagBg"));
			heroBagRect.scale9Grid = new Rectangle(2, 2, 2, 2);
			heroBagRect.setSize(201, 503);
			heroBagRect.x = 783;
			heroBagRect.y = 78;
			formationPanel.addChild(heroBagRect);
			
			//上阵选中
			inBattleBtn = new GTextTabButton(FormationSkin.BS_DOWN,FormationSkin.BS_DOWN,FormationSkin.BS_OVER);
			inBattleBtn.name = "S";
			inBattleBtn.height = 25;
			inBattleBtn.x = 299;
			inBattleBtn.y = 470;
			inBattleBtn.visible = true;
			inBattleBtn.mouseChildren = inBattleBtn.mouseEnabled = false;
			formationPanel.addChild(inBattleBtn);
			//天缘未选中
			fetterBtn = new GTextTabButton(FormationSkin.TN_UP,FormationSkin.TN_UP,FormationSkin.TN_OVER);
			fetterBtn.name = "ZN";
			fetterBtn.height = 25;
			fetterBtn.x = 405;
			fetterBtn.y = 470;
			fetterBtn.visible = true;
			formationPanel.addChild(fetterBtn);
			
			
			//天缘选中
			inFetterBtn = new GTextTabButton(FormationSkin.TS_DOWN,FormationSkin.TS_DOWN,FormationSkin.TS_OVER);
			inFetterBtn.name = "Z";
			inFetterBtn.height = 25;
			inFetterBtn.x = 373;
			inFetterBtn.y = 470;
			inFetterBtn.visible = false;
			inFetterBtn.mouseChildren = inFetterBtn.mouseEnabled = false;
			formationPanel.addChild(inFetterBtn);
			//上阵未选中
			battleBtn = new GTextTabButton(FormationSkin.BN_UP,FormationSkin.BN_UP,FormationSkin.BN_OVER);
			battleBtn.name = "SN";
			battleBtn.height = 25;
			battleBtn.x = 300;
			battleBtn.y = 470;
			battleBtn.visible = false;
			formationPanel.addChild(battleBtn);
			
			
			//创建滤镜
			var glowFilter:GlowFilter = new GlowFilter(0xCCFF00,0.8);  
			//将该滤镜添加到数组中  
			filters = new Array(glowFilter);  
			
			
			// 用于显示伙伴模型(鼠标事件相关优化) 
			var i:int;
			var p:Point;
			
			//羁绊格子形象
			var inFetterCell:FormationFetterFigureCell;
			for(i = 0;i < FETTER_POSINT.length ; i++)
			{
				p = FETTER_POSINT[i];
				
				inFetterCell = new FormationFetterFigureCell(i);
				inFetterCell.x = p.x + 60;
				inFetterCell.y = p.y + 60;
				//位置
				inFetterCell.pos = i + 6;
				this.fetterFigureCells.push(inFetterCell);
			}
			
			
			//九宫格子形象
			for(i = 0 ; i < LOCA_NUM ; i++)
			{
				p = POSTION[i];
				var c:FormationFigureCell = new FormationFigureCell(i);
				c.x = p.x;
				c.y = p.y;
				c.pos = i + 1;
				figureCells.push(c);
			}
			
			
			// 九宫拖拽用格子组件
			for(i=0;i<LOCA_NUM;i++)
			{
				var pos:Point = POSTION[i];
				var cell:FormationDragCell = new FormationDragCell(figureCells[i]);
				cell.x = pos.x;
				cell.y = pos.y;
				//位置
				cell.pos = i + 1;
				dragCells.push(cell);
			}
			
			
			//羁绊拖拽用格子组件
			for(i = 0;i < FETTER_POSINT.length ; i++)
			{
				p = FETTER_POSINT[i];
				
				var dragObj:FormationFetterDragCell = new FormationFetterDragCell(this.fetterFigureCells[i]);
				dragObj.x = p.x + 60 ;
				dragObj.y = p.y + 60 ;
				//位置
				dragObj.pos = i + 6;
				this.fetterDragCells.push(dragObj);
			}
			
			
			//羁绊格子形象
			this.fetterFigureCells.sortOn("pos" , Array.NUMERIC);
			for(i = 0 ; i < this.fetterFigureCells.length ; i++)
			{
				formationPanel.addChild(this.fetterFigureCells[i]);
			}
			
			// 九宫格子形象
			figureCells.sortOn("y" , Array.NUMERIC);
			for(i=0;i<figureCells.length;i++)
			{
				formationPanel.addChild(figureCells[i]);
			}
			figureCells.sortOn("pos" , Array.NUMERIC);
			
			
			//羁绊格子拖拽组件
			this.fetterDragCells.sortOn("pos" , Array.NUMERIC);
			for(i = 0 ; i < this.fetterDragCells.length ; i++)
			{
				formationPanel.addChild(this.fetterDragCells[i]);
			}
			
			// 九宫格子拖拽组件
			dragCells.sortOn("y" , Array.NUMERIC);
			for(i=0;i<dragCells.length;i++)
			{
				formationPanel.addChild(dragCells[i]);
			}
			dragCells.sortOn("pos" , Array.NUMERIC);
				
			//羁绊站位
			this.heroFetterPanel = new FormationFetterPanel(this.fetterFigureCells,this.fetterDragCells);
			formationPanel.addChild(this.heroFetterPanel);
			
			//中间站位
			this.heroBattlePanel = new FormationHeroLocationPanel(this.figureCells,this.dragCells);
			formationPanel.addChild(this.heroBattlePanel);
			
			//右侧伙伴背包列表
			this.heroBagPanel = new FormationHeroBagPanel();
			this.heroBagPanel.width = 198;
			this.heroBagPanel.height = 500;
			this.heroBagPanel.x = 784;
			this.heroBagPanel.y = 80;
			formationPanel.addChild(this.heroBagPanel);
		}
		
		
		/**
		 * 奇术UI
		 * */
		private function thaumaturgyPanel():void
		{
			//奇术面板
			var thaumaturgyPanel:Sprite = this.tabPanels[1];
			
			var line:Bitmap = new Bitmap(this.getSwfBD("line_0"));
			line.x = 11;
			line.y = 69;
			thaumaturgyPanel.addChild(line);
			
			//奇术面板组件
			thaumaPanel = new ThaumaturgyPanel();
			thaumaturgyPanel.addChild(thaumaPanel);
		}
		
		
		/**面板数据更新*/
		public function update():void
		{
			this.refreshHeroLocation();
			this.refreashHerobag();
		}
		
		
		
		
		/**伙伴背包数据刷新*/
		private function refreashHerobag():void
		{
			this.heroBagPanel.updateHero();
		}
		
		
		
		
		/**伙伴站位面板刷新*/
		private function refreshHeroLocation():void
		{
			this.bg_1.visible = this.battle;
			this.bg_2.visible = this.fetter;
			
			//一定先刷新羁绊位置,再刷新战斗位置
			this.heroFetterPanel.upData(FormationModel.inst.heroFormation,this.fetter);
			this.heroBattlePanel.upData(FormationModel.inst.heroFormation,FormationModel.inst.formationList,this.battle);
	
			//拖拽立定以后  显示所有拖拽模型
			this.dispatchEvent(new FormationEvent(FormationEvent.DRAG_CELL_VISIBLE , true));
		}
		
		
		/**开启功能玩法*/
		private function openFunny():void
		{
			for(var i:int = 0;i<FUNCTION_NAME.length;i++)
			{
				//tabPanel
				var panel:Sprite = new Sprite();
				this.addChild(panel);
				this.tabPanels.push(panel);
				
				//tabBtn
				var funBtn:GTextTabButton = new GTextTabButton(CommonSkin.blueButton2Up,CommonSkin.blueButton2Down,CommonSkin.blueButton2Over);
				funBtn.label = FUNCTION_NAME[i];
				funBtn.x = 25 + 72*i;
				funBtn.y = 47;
				funBtn.selected = false;
				this.tabBtns.push(funBtn);
				this.addChild(funBtn);
			}
		}
		
		/**布阵面板切换玩法*/
		private function changeFunny(evt:MouseEvent):void
		{
			var btn:GTextTabButton = evt.target as GTextTabButton;
			var index:int = FUNCTION_NAME.indexOf(btn.label);
			if(index == 1)
			{
				//请求奇术信息
				this.dispatchEvent(new FormationEvent(FormationEvent.MSGID_MAGIC_INFO,0));
				this.dispatchEvent(new FormationEvent(FormationEvent.MSGID_MAGIC_INFO,1));
			}
			this.showFunnyPanel(index);
		}
		
		/**
		 * 玩法面板显示
		 * */
		private function showFunnyPanel(index:int):void
		{
			var panel:Sprite;
			//面板状态
			for(var i:int = 0;i<FUNCTION_NAME.length;i++)
			{
				panel = this.tabPanels[i] as Sprite;
				panel.visible = (index == i);
			}
			this.btnState(index);
		}
		
		
		/**
		 * 设置按钮状态
		 * */
		private function btnState(value:int):void
		{
			for(var i:int = 0 ; i<this.tabBtns.length;i++)
			{
				var btn:GTextTabButton = this.tabBtns[i];
				btn.selected = i == value;
			}
		}
		
		/**阵型、羁绊切换*/
		private function switchPanel(evt:MouseEvent):void
		{
			var btn:GTextTabButton = evt.target as GTextTabButton;
			
			if(btn.name == "ZN")
			{
				this.fetter = true;
				this.battle = false;
				this.inFetterBtn.visible = true;
				this.inFetterBtn.selected = true;
				
				this.fetterBtn.visible = false;
				this.fetterBtn.selected = false;
				
				this.inBattleBtn.visible = false;
				this.inBattleBtn.selected = false;
				
				this.battleBtn.visible = true;
				this.battleBtn.selected = false;
				
			}
			else if(btn.name == "SN")
			{
				this.battle = true;
				this.fetter = false;
				
				this.inFetterBtn.visible = false;
				this.inFetterBtn.selected = false;
				
				this.fetterBtn.visible = true;
				this.fetterBtn.selected = false;
				
				this.inBattleBtn.visible = true;
				this.inBattleBtn.selected = true;
				
				this.battleBtn.visible = false;
				this.battleBtn.selected = false;
			}
			
			this.refreshHeroLocation();
		}
		
		
		/**
		 * 拖拽时鼠标按下
		 * */
		private function dragMouseDown(e:MouseEvent):void
		{
			OBJ = null;
			
			var item:* = e.target;
			if(item is FormationDragCell && this.battle )
			{
				//阵型站位
				if(item && item.heroVO)
				{
					// 显示跟随鼠标的人形
					var url:String = GameConfig.BATTLE_FIGURE_URL + item.heroVO.url;
					this.dispatchEvent(new FormationEvent(FormationEvent.DRAG_MOUSE_FIGURE_VISIBLE , url));
					
					// 拖拽时自己格子的模型隐藏
					var data:Object = new Object();
					this.dispatchEvent(new FormationEvent(FormationEvent.DRAG_CELL_VISIBLE , false));
					(item as FormationDragCell).figureCell.setFigureVisible(false);
				}
			}
			else if(item is FormationFetterDragCell && this.fetter)
			{
				//羁绊站位
				if(item && item.heroVO)
				{
					url = GameConfig.BATTLE_FIGURE_URL + item.heroVO.url;
					this.dispatchEvent(new FormationEvent(FormationEvent.DRAG_MOUSE_FIGURE_VISIBLE , url));
					
					this.dispatchEvent(new FormationEvent(FormationEvent.FETTER_DRAG_CELL_VISIBLE , false));
					(item as FormationFetterDragCell).figureCell.setFigureVisible(false);
					OBJ = item as FormationFetterDragCell;
				}
			}
			
		}
		
		
		
		
		/**
		 * 拖拽时鼠标弹起
		 * */
		private function dragMouseUp(e:MouseEvent):void
		{
			// 移出跟随鼠标的人形
			this.dispatchEvent(new FormationEvent(FormationEvent.DRAG_MOUSE_FIGURE_VISIBLE));
			
			// 鼠标按下后没有移动时不会触发getDragObject()，因此也不会触发dragCancel(), 需要在这里将之前隐藏的人形复原
			if(FormationModel.inst.isDraging == false)
			{
				// 显示所有拖拽格子模型
				this.dispatchEvent(new FormationEvent(FormationEvent.DRAG_CELL_VISIBLE , true));
			}
		}
		
		
		
		
		
		/**
		 * 阵型上放置伙伴的请求
		 * */
		private function onPutHero(e:FormationEvent):void
		{
			this.dispatchEvent(e);
		}
		
		
		
		
		
		/**
		 * 显示阵型格子上的人形
		 * */
		private function onDragCellVisible(e:FormationEvent):void
		{
			//鼠标弹起后所有的格子模型都显示
			heroBattlePanel.setDragFigureVisible(e.data as Boolean);
			heroFetterPanel.setDragFigureVisible(e.data as Boolean);
		}
		
		/**
		 * 显示羁绊格子上的人形
		 * */
		private function onDragFetterVisible(e:FormationEvent):void
		{
			heroFetterPanel.setDragFigureVisible(e.data as Boolean);
		}
		
		
		/**
		 * 布阵、天缘提示
		 * */
		private function onReminder(evt:FormationEvent):void
		{
			switch (evt.data)
			{
				case FormationType.GO_TO_FETTER:
					this.fetterBtn.filters = [];
					this.battleBtn.filters = filters;
					break;
				case FormationType.GO_TO_BATTLE:
					this.fetterBtn.filters = filters;
					this.battleBtn.filters = [];
					break;
			}
			setTimeout(end,3300);
		}
		
		private function end():void
		{
			this.fetterBtn.filters = [];
			this.battleBtn.filters = [];
		}
		
		
		/**
		 * 显示/移出跟随鼠标的人形
		 * */
		private function onDragMouseFigureVisible(e:FormationEvent):void
		{
			if(dragMouseFigure)
			{
				dragMouseFigure.stop();
				dragMouseFigure.clear();
				this.removeChild(dragMouseFigure);
				dragMouseFigure = null;
			}
			
			var url:String = e.data as String;
			if(url != null)
			{
				dragMouseFigure = new SpriteFigureItem(url , false , BattleFigureItem.STAND);
				dragMouseFigure.frameRate = 18;
				dragMouseFigure.play();
				dragMouseFigure.x = mouseX;
				dragMouseFigure.y = mouseY;
				this.addChild(dragMouseFigure);
			}
		}
		
		
		/**助阵伙伴buff*/
		private function onBuffControl(evt:FormationEvent):void
		{
			heroFetterPanel.setEffect(evt.data as Array);
		}
		
		
		
		
		/**获取图片资源*/
		public function getRes(url:String):BitmapData
		{
			return this.getSwfBD((url));
		}
		
		
		/**
		 * close
		 * */
		override public function close():void
		{
			this.clear();
			for(var i:int = 0;i<this.tabBtns.length;i++)
			{
				(this.tabBtns[i] as GTextTabButton).removeEventListener(MouseEvent.CLICK,changeFunny);
			}
			super.close();
		}
		
		
		
		
		/**
		 * clear
		 * */
		private function clear():void
		{
			this.fetterBtn.filters = [];
			this.battleBtn.filters = [];
			
			if(dragMouseFigure)
			{
				dragMouseFigure.stop();
				dragMouseFigure.clear();
				this.removeChild(dragMouseFigure);
				dragMouseFigure = null;
			}
			
			this.removeEventListener(FormationEvent.DRAG_CELL_VISIBLE , onDragCellVisible);
			this.removeEventListener(FormationEvent.FETTER_DRAG_CELL_VISIBLE , onDragFetterVisible);
			this.removeEventListener(FormationEvent.DRAG_MOUSE_FIGURE_VISIBLE , onDragMouseFigureVisible);
			this.removeEventListener(FormationEvent.INBATTLE_2_HELPBATTLE,onBuffControl);
			
			// 拖拽时人物模型跟随鼠标
			this.removeEventListener(MouseEvent.MOUSE_DOWN , dragMouseDown);
			this.removeEventListener(MouseEvent.MOUSE_UP , dragMouseUp);
			
			//按钮事件移除
			this.battleBtn.removeEventListener(MouseEvent.CLICK,switchPanel);
			this.fetterBtn.removeEventListener(MouseEvent.CLICK,switchPanel);
			
			// clear
			heroBattlePanel.close();
			heroBagPanel.close();
			heroFetterPanel.close();
			thaumaPanel.close();
			
			FormationModel.inst.clear();
		}
		
	}
}