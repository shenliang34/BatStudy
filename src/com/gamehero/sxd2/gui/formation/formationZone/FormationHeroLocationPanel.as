package com.gamehero.sxd2.gui.formation.formationZone
{
	import com.gamehero.sxd2.event.FormationEvent;
	import com.gamehero.sxd2.gui.formation.FormationModel;
	import com.gamehero.sxd2.gui.formation.FormationSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.GTextButton;
	import com.gamehero.sxd2.manager.FormationManager;
	import com.gamehero.sxd2.pro.MSG_FORMATION_PUT_HERO_REQ;
	import com.gamehero.sxd2.pro.PRO_Formation;
	import com.gamehero.sxd2.pro.PRO_Hero;
	import com.gamehero.sxd2.vo.FormationVo;
	import com.gamehero.sxd2.vo.HeroVO;
	import com.greensock.TweenMax;
	import com.netease.protobuf.UInt64;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	
	import alternativa.gui.base.ActiveObject;
	
	import bowser.utils.effect.color.ColorTransformUtils;
	import com.gamehero.sxd2.gui.formation.fetterZone.FormationFetterBtn;

	/**
	 * @author Wbin
	 * 创建时间：2015-8-24 上午11:43:10
	 * @布阵面板
	 */
	public class FormationHeroLocationPanel extends ActiveObject
	{
		
		/**==========================================九宫格站位===============================================*/
		/**站位格子数*/
		public static const LOCA_NUM:int = 9;
		/**总阵型数*/
		public static const FORMATION_NUM:int = 8;
		/**伙伴羁绊显示单元数*/
		private static const FETTER_NUM:int = 5;
		
		/**伙伴布阵位置X,Y*/
		public static const POSTION:Array = [new Point(519.50,314),new Point(508,369),new Point(493.5,429.5)
											,new Point(422,313.5),new Point(403.5,368.5),new Point(383.5,429.5)
											,new Point(324.5,313.5),new Point(302,368.5),new Point(275.5,429)];
		/**阵上伙伴信息*/
		private var hero:HeroVO;
		/**阵上伙伴Id*/
		private var heroId:int;
		
		/**底部阵型显示*/
		private var formation:Vector.<Bitmap>;
		// 显示人物模型(因九宫格已被隐藏,用于在拖拽时显示格子上的人形)
		private var figureCells:Array = [];
		// 中部全部九宫格(用于触发拖拽)
		private var dragCells:Array = [];
		// 已激活的格子
		private var activeDragCells:Array = [];
		
		//阵型按钮
		private var formationCells:Array = [];
		//羁绊单元
		private var fetterCells:Array = [];
		
		//阵型选中后的高亮背景
		private var overBmp:Bitmap;
		//灰态控制参数
		private var gray:Boolean;
		
		//1-11号位置上伙伴信息
		private var allHero:Array = [];
		//1-5号位置上伙伴信息
		private var inBattleHero:Array = [];
		//6-11号位置上伙伴信息
		private var helpBattleHero:Array = [];
		//收缩按钮
		private var contractBtn:GTextButton;
		//天缘详细操作
		private var isDetail:Boolean = false;
		
		/**
		 * 羁绊buff控制参数
		 * */
		private var buffControl:Boolean = false;
		
		private var myMask:Sprite;
		
		
		/**================================================羁绊站位==================================================*/
		/**羁绊站位*/
//		private static const FETTER_POSINT:Array = [new Point(37,229),new Point(163,195),new Point(290,160),
//													new Point(416,160),new Point(550,195),new Point(669,229)];
		/**人物模型*/
//		private var fetterFigureCells:Array = [];
		/**拖拽模型*/
//		private var fetterDragCells:Array = [];
		
		/**
		 * 构造函数
		 * @
		 * */
		public function FormationHeroLocationPanel(figureCells:Array,dragCells)
		{
			this.myMask = new Sprite();    
			this.myMask.graphics.beginFill(0xFFFFFF);    
			this.myMask.graphics.drawRect(15,489,760,95);    
			this.myMask.graphics.endFill();    
			this.addChild(myMask);
			
			this.figureCells = figureCells;
			this.dragCells = dragCells;
			
			//阵型选中框
			overBmp = new Bitmap(FormationSkin.forOverBmp);
			
			contractBtn = new GTextButton(FormationSkin.CONTRACT_UP,FormationSkin.CONTRACT_DOWN,FormationSkin.CONTRACT_OVER);
			contractBtn.y = 510;
			contractBtn.visible = false;
			addChild(contractBtn);
			
			// 用于显示伙伴模型(鼠标事件相关优化) 
			var i:int;
			/*var p:Point;*/
			
			
			//九宫格子形象
			/*for(i = 0 ; i < LOCA_NUM ; i++)
			{
				p = POSTION[i];
				var c:FormationFigureCell = new FormationFigureCell(i);
				c.x = p.x;
				c.y = p.y;
				c.pos = i + 1;
				figureCells.push(c);
			}*/
			
			
			// 九宫拖拽用格子组件
			/*for(i=0;i<LOCA_NUM;i++)
			{
				var pos:Point = POSTION[i];
				var cell:FormationDragCell = new FormationDragCell(figureCells[i]);
				cell.x = pos.x;
				cell.y = pos.y;
				//位置
				cell.pos = i + 1;
				dragCells.push(cell);
			}*/
			
			// 九宫格子形象
			/*figureCells.sortOn("y" , Array.NUMERIC);
			for(i=0;i<figureCells.length;i++)
			{
				this.addChild(figureCells[i]);
			}
			figureCells.sortOn("pos" , Array.NUMERIC);*/
			
			// 九宫格子拖拽组件
			/*dragCells.sortOn("y" , Array.NUMERIC);
			for(i=0;i<dragCells.length;i++)
			{
				this.addChild(dragCells[i]);
			}
			dragCells.sortOn("pos" , Array.NUMERIC);*/
			
			
			// 下方阵型种类列表
			for(i = 0;i<FORMATION_NUM;i++)
			{
				//后端发送阵型从1开始
				var btn:FormationBtn = new FormationBtn(FormationSkin.formationVec[i],i);
				btn.x = 54 + i*88;
				btn.y = 507;
				btn.visible = false;
				addChild(btn);
				formationCells.push(btn);
			}
			
			//伙伴羁绊信息
			for( i = 0 ; i < FETTER_NUM ;i++ )
			{
				var fateBtnCell:FormationFetterBtn = new FormationFetterBtn();
				fateBtnCell.mask = this.myMask;
				fateBtnCell.x = 25 + i*148;
				fateBtnCell.y = 492;
				fateBtnCell.visible = false;
				addChild(fateBtnCell);
				fetterCells.push(fateBtnCell);
			}
			
		}
		
		
		
		
		/**
		 * 伙伴站位刷新
		 * @formationInfo  布阵信息
		 * @idList         已开启阵型
		 * @value 		      可拖拽/兼职灰态控制
		 * */
		public function upData(formationInfo:PRO_Formation,idList:Array,value:Boolean):void
		{
			this.clear();
			
			this.gray = value;
			this.contractBtn.addEventListener(MouseEvent.CLICK,onControl);
				
			var vo:FormationVo = FormationManager.instance.getPosById(formationInfo.id);
			for(var i:int = 0;i<LOCA_NUM;i++)
			{
				var inBattleCell:FormationDragCell = dragCells[i];
				inBattleCell.addEventListener(FormationEvent.EXCHANGE_HERO , onExchange);
				inBattleCell.addEventListener(FormationEvent.FIGURE_DRAW,onAdvance);
				inBattleCell.setBuff(false,false);
				/*ava.addEventListener(MouseEvent.DOUBLE_CLICK,heroOutBattle);*/
				
				var idx:int = vo.posList.indexOf(inBattleCell.pos);
				// 该格子是否开启
				inBattleCell.setDrag(idx >= 0,value);
				
				if(idx >= 0)
				{
					activeDragCells.push(inBattleCell);
				}
				this.grayMethod(inBattleCell);
			}
			
			// 显示格子上的伙伴形象
			for( i = 0 ; i < activeDragCells.length ; i++)
			{
				var cell:FormationDragCell = activeDragCells[i];
				// 取到伙伴唯一id
				var id:UInt64 = formationInfo["heroId_"+(i+1)];
				// 从数据中找到此伙伴的数据
				if(id.toString() != "0")
				{
					var heroPro:PRO_Hero = FormationModel.inst.getHeroInfo(id);
					this.inBattleHero.push(heroPro);
					if(heroPro)
					{
						cell.upData(heroPro);
					}
				}
			} 
			
			FormationModel.inst.inBattleHero = this.inBattleHero;
			
			//获取当前布阵所有伙伴信息
			for(i = 0 ;i < 11 ; i++)
			{
				id = FormationModel.inst.heroFormation["heroId_"+(i+1)];
				if(id.toString() != "0")
				{
					heroPro = FormationModel.inst.getHeroInfo(id);
					this.allHero.push(heroPro);
					if( i > FETTER_NUM - 1 )
					{
						this.helpBattleHero.push(heroPro);
					}
				}
			}
			
			if(FormationModel.inst.currentFormationNum <= 0)
			{
				FormationModel.inst.currentFormationNum = idList.length;
			}
			
			//羁绊或者布阵
			this.bottomPanel(idList,value);
			//刷新高亮状态
			this.setOverBmp(formationInfo.id);
			// 显示拖拽控件的模型
			this.setDragFigureVisible(value);
		}
		
		
		
		
		/**底部阵型、羁绊切换*/
		private function bottomPanel(idAry:Array,value:Boolean):void
		{
			//收缩按钮的互斥关系
			this.contractBtn.visible = !value && FormationModel.inst.isDetail;
			
			// 阵型
			for(var i:int = 0;i<idAry.length;i++)
			{
				//后端发送阵型从1开始
				var index:int = idAry[i] - 1;
				var btn:FormationBtn = this.formationCells[index];
				if(FormationModel.inst.currentFormationNum != idAry.length && (i > FormationModel.inst.currentFormationNum - 1))
				{
					btn.open = true;
				}
				btn.visible = value;
				btn.addListener();
			}
			FormationModel.inst.currentFormationNum = idAry.length;
			
			this.fateReDraw(value);
		}
		
		/**
		 * 羁绊
		 * */
		private function fateReDraw(value:Boolean):void
		{
			for(var i:int = 0; i < this.inBattleHero.length ; i++)
			{
				var heroPro:PRO_Hero = this.inBattleHero[i];
				var fateBtnCell:FormationFetterBtn = this.fetterCells[i];
				fateBtnCell.isSelected = false;
				if(heroPro)
				{
					//非详细信息展示操作中
					if(!FormationModel.inst.isDetail)
					{
						fateBtnCell.btnSelected = false;
						fateBtnCell.btnState(value);
						this.tween(fateBtnCell,25 + i*148,true,false);
					}
					
					fateBtnCell.visible = (true && !value);
					fateBtnCell.addEventListener(FormationEvent.FETTER_INFO,drawFetter);
					fateBtnCell.addEventListener(FormationEvent.FETTER_INFO_1,drawFetter1);
					fateBtnCell.upData(this.allHero,this.helpBattleHero,heroPro,i);
					
					if(fateBtnCell.btnSelected && this.contractBtn.visible && !this.gray)
					{
						fateBtnCell.onFetter();
					}
				}
				else 
				{
					fateBtnCell.visible = false;
				}
			}
		}
		
		/**面板刷新*/
		private function drawFetter(evt:FormationEvent):void
		{
			//羁绊相关buff
			this.fateBuff(evt.data);
			this.isDetail = true;
			
			FormationModel.inst.isDetail = true;
			var _x:int;
			for( var i:int = 0; i < this.inBattleHero.length ; i++)
			{
				var fetterCell:FormationFetterBtn = this.fetterCells[i];
				fetterCell.isSelected = fetterCell.btnSelected = (i == int(evt.data.index));
				if(!fetterCell.btnSelected || fetterCell.firstSelected ) 
				{
					fetterCell.setFetterInfo(false,false);
				}
					
				if(i <= int(evt.data.index))
				{
					_x =  25 + i*35;
				}
				else
				{
					_x = 775 - (this.inBattleHero.length - i)*35;
				}
				this.tween(fetterCell,_x,i == int(evt.data.index),fetterCell.btnSelected);
			}
			
			if(this.contractBtn.x != 797 - (this.inBattleHero.length - int(evt.data.index))*35)
			{
				this.contractBtn.visible = false;
				this.contractBtn.x =  797 - (this.inBattleHero.length - int(evt.data.index))*35;
			}
			
			setTimeout(end,500);
		}
		
		/**
		 *收缩按钮 
		 */
		private function end():void
		{
			this.contractBtn.visible = true;
		}
		
		/**
		 * 动态划入
		 * obj   活动对象
		 * x     活动对象X坐标
		 * bool1  文本显示/隐藏
		 * bool2  文本显示/隐藏
		 * */
		private function tween(obj:FormationFetterBtn,x:int,bool1:Boolean,bool2:Boolean):void
		{
			TweenMax.to(obj,.5,{x:x,onComplete:end});
			
			function end():void
			{
				obj.btnState(bool1);
				obj.setFetterInfo(!FormationModel.inst.isDetail,bool2);
			}
		}
		
		
		/**
		 * 显示/隐藏人物模型层
		 * */
		public function setDragFigureVisible(value:Boolean):void
		{
			for(var i:int=0;i<LOCA_NUM;i++)
			{
				var dragCell:FormationDragCell = dragCells[i];
				var figureCell:FormationFigureCell = figureCells[i];
				
				dragCell.setFigureVisible(value);
				figureCell.setFigureVisible(!value);
				
				if(!dragCell.hasBuff)
				{
					this.grayMethod(figureCell);
				}
			}
		}
		
		/**
		 * 羁绊buff
		 * */
		private function fateBuff(data:Object):void
		{
			var currIndex:int = data.index;
			var heroFate:Array = data.fateInBattle;
			var helpInFate:Array = data.helpInFate;
			
			//布阵位置buff
			for(var m:int = 0; m < LOCA_NUM ; m++)
			{
				var dragCell:FormationDragCell = dragCells[m];
				//清除所有的buff特效
				this.grayMethod(dragCell);
				dragCell.setBuff(false,false);
				
				for(var i:int = 0; i<heroFate.length;i++)
				{
					var fateHero:HeroVO = heroFate[i];
					if(dragCell.heroVO && (dragCell.heroVO.name == fateHero.name))
					{
						//再添加特效
						ColorTransformUtils.instance.clear(dragCell);
						dragCell.setBuff(i == 0,true);
					}
				}
			}
			
			//羁绊位置buff
			this.dispatchEvent(new FormationEvent(FormationEvent.INBATTLE_2_HELPBATTLE,helpInFate));
		}
		
		
		/**灰态处理*/
		private function grayMethod(obj:*):void
		{
			ColorTransformUtils.instance.clear(obj);
			//灰态处理
			if(!this.gray)
			{
				ColorTransformUtils.instance.addContrast(obj , -30);
				ColorTransformUtils.instance.addBrightness(obj , -20);
			}
		}
		
		
		/**阵型选中高亮状态*/
		private function setOverBmp(index:int):void
		{
			//保存当前设定的阵型
			FormationModel.inst.currentFormationId = index;
			
			var btn:FormationBtn;
			for(var i:int = 0;i<formationCells.length;i++)
			{
				if(i == (index - 1))
				{
					btn = this.formationCells[i];
					//保存当前选中阵型
					btn.setFormation();
				}
				else
				{
					//隐藏其他阵型的高亮
					btn = this.formationCells[i];
					btn.hideOver();
				}
			}
		}
		
		
		/**交换、上下阵伙伴*/
		private function onExchange(e:FormationEvent):void
		{
			var data:Object = e.data;
			var req:MSG_FORMATION_PUT_HERO_REQ = data.req;
			this.dispatchEvent(new FormationEvent(FormationEvent.MSGID_FORMATION_PUT_HERO , req));
		}
		
		/**双击伙伴下阵*/
		private function heroOutBattle(evt:MouseEvent):void
		{
			var avaCell:FormationDragCell = evt.target as FormationDragCell;
			if(avaCell.heroInfo)
			{
				var req:MSG_FORMATION_PUT_HERO_REQ = new MSG_FORMATION_PUT_HERO_REQ();
				req.id = avaCell.heroInfo.base.id;
				req.pos = 0;
				this.dispatchEvent(new FormationEvent(FormationEvent.MSGID_FORMATION_PUT_HERO , req));
			}
		}
		
		/**
		 * 提前绘制模型
		 * */
		private function onAdvance(evt:FormationEvent):void
		{
			var dragCell:FormationDragCell = dragCells[evt.data.pos - 1];
			dragCell.upData(evt.data.heroInfo as PRO_Hero);
		}
		
		/**收缩按钮*/
		private function onControl(evt:MouseEvent):void
		{
			this.reDraw();
		}
		
		private function drawFetter1(evt:FormationEvent):void
		{
			this.reDraw();
		}
		
		private function reDraw():void
		{
			//收缩按钮
			FormationModel.inst.isDetail = false;
			this.contractBtn.visible = false;
			this.bottomPanel(FormationModel.inst.formationList,false);
			this.clearAllEffect();
		}
		
		/**清除当前所有buff特效*/
		public function clearAllEffect():void
		{
			//九宫格位置
			for(var i:int = 0;i<LOCA_NUM;i++)
			{
				var inBattleCell:FormationDragCell = dragCells[i];
				inBattleCell.setBuff(false,false);
				this.grayMethod(inBattleCell);
			}
			
			//羁绊位置buff
			this.dispatchEvent(new FormationEvent(FormationEvent.INBATTLE_2_HELPBATTLE,[]));
		}
		
		
		/**数据清除*/
		private function clear():void
		{
			var i:int;
			for(i = 0 ; i < LOCA_NUM ; i++)
			{
				var dragCell:FormationDragCell = dragCells[i];
				dragCell.removeEventListener(FormationEvent.EXCHANGE_HERO , onExchange);
				dragCell.removeEventListener(FormationEvent.FIGURE_DRAW,onAdvance);
				/*dragCell.removeEventListener(MouseEvent.DOUBLE_CLICK, heroOutBattle);*/
				dragCell.clear();
				
				var figureCell:FormationFigureCell = figureCells[i];
				figureCell.clear();
			}
			
			for(i = 0; i < this.inBattleHero.length ; i++)
			{
				var fateBtnCell:FormationFetterBtn = this.fetterCells[i];
				if(fateBtnCell)
				{
					fateBtnCell.removeEventListener(FormationEvent.FETTER_INFO,drawFetter);
					fateBtnCell.removeEventListener(FormationEvent.FETTER_INFO_1,drawFetter1);
					fateBtnCell.clear();
				}
			}
			
			contractBtn.removeEventListener(MouseEvent.CLICK,onControl)
			activeDragCells = [];
			inBattleHero = [];
			helpBattleHero = [];
			allHero = [];
			
		}
		
		/**close*/
		public function close():void
		{
			this.clear();
			
			for(var i:int = 0;i< this.formationCells.length;i++)
			{
				var forBtn:FormationBtn =  this.formationCells[i];
				forBtn.clear();
			}
		}
	}
}