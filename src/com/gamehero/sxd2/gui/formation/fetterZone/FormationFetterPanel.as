package com.gamehero.sxd2.gui.formation.fetterZone
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.event.FormationEvent;
	import com.gamehero.sxd2.gui.formation.FormationModel;
	import com.gamehero.sxd2.gui.formation.FormationWindow;
	import com.gamehero.sxd2.manager.HeroManager;
	import com.gamehero.sxd2.pro.MSG_FORMATION_PUT_HERO_REQ;
	import com.gamehero.sxd2.pro.PRO_Formation;
	import com.gamehero.sxd2.pro.PRO_Hero;
	import com.gamehero.sxd2.vo.HeroVO;
	import com.netease.protobuf.UInt64;
	
	import flash.geom.Point;
	
	import alternativa.gui.base.ActiveObject;
	
	import bowser.utils.effect.color.ColorTransformUtils;

	/**
	 * @author Wbin
	 * 创建时间：2015-9-22 下午4:50:44
	 * @伙伴羁绊
	 */
	public class FormationFetterPanel extends ActiveObject
	{
		private static var _instance:FormationFetterPanel;
		
		/**羁绊站位*/
		private static const FETTER_POSINT:Array = [new Point(37,229),new Point(163,195),new Point(290,160),
												    new Point(416,160),new Point(550,195),new Point(669,229)];
		/**人物模型*/
		private var figureCells:Array = [];
		/**拖拽模型*/
		private var dragCells:Array = [];
		
		//灰态控制参数
		private var gray:Boolean;
		
		
		/**
		 * @figureCells 伙伴形象
		 * @dragCells   拖拽组件
		 * */
		public function FormationFetterPanel(figureCells:Array,dragCells:Array)
		{
			this.figureCells = figureCells;
			this.dragCells = dragCells;
			
			/*var p:Point;
			var inFetterCell:FormationFetterFigureCell;
			for(var i:int = 0;i<FETTER_POSINT.length;i++)
			{
				p = FETTER_POSINT[i];
				
				inFetterCell = new FormationFetterFigureCell(i);
				inFetterCell.x = p.x + 60;
				inFetterCell.y = p.y + 60;
				//位置
				inFetterCell.pos = i + 6;
				this.figureCells.push(inFetterCell);
				this.addChild(inFetterCell);
				
				var dragObj:FormationFetterDragCell = new FormationFetterDragCell(inFetterCell);
				dragObj.x = p.x + 60 ;
				dragObj.y = p.y + 60 ;
				//位置
				dragObj.pos = i + 6;
				dragCells.push(dragObj);
				this.addChild(dragObj);
			}
			
			figureCells.sortOn("pos" , Array.NUMERIC);
			dragCells.sortOn("pos" , Array.NUMERIC);*/
		}
		
		/**
		 * @formationInfo 布阵信息
		 * @value 		    是否可拖拽
		 * */
		public function upData(formationInfo:PRO_Formation,value:Boolean):void
		{
			this.clear();
			
			this.gray = value;
			
			//玩家等级
			var roleLevel:int = GameData.inst.roleInfo.base.level;
			
			// 显示格子上的伙伴形象
			for(var i:int = 0;i < dragCells.length ; i++)
			{
				var infetterCell:FormationFetterDragCell = dragCells[i];
				infetterCell.addEventListener(FormationEvent.EXCHANGE_HERO , onExchange);
				infetterCell.addEventListener(FormationEvent.FIGURE_DRAW , onAdvance);
				// 取到伙伴唯一id
				var id:UInt64 = formationInfo["heroId_"+(i+6)];
				// 从数据中找到此伙伴的数据
				if(id.toString() != "0")
				{
					var heroInfo:PRO_Hero = FormationModel.inst.getHeroInfo(id);
					if(heroInfo)
					{
						infetterCell.upData(heroInfo);
					}
				}
				var fetterOpen:int = HeroManager.instance.getFetterLevel(infetterCell.pos);
				infetterCell.setDrag(value , roleLevel >= fetterOpen);
				
				this.grayMethod(infetterCell);
			} 
			
			// 显示拖拽控件的模型
			this.setDragFigureVisible(value);
		}
		
		
		/**
		 * 显示/隐藏人物模型层
		 * */
		public function setDragFigureVisible(value:Boolean):void
		{
			for(var i:int=0;i<FETTER_POSINT.length;i++)
			{
				//拖拽控件
				var dragCell:FormationFetterDragCell = dragCells[i];
				dragCell.setFigureVisible(value);
				
				//形象元素
				var figureCell:FormationFetterFigureCell = figureCells[i];
				figureCell.setFigureVisible(!value);
				
				if(dragCell == FormationWindow.OBJ)
				{
					figureCell.setFigureVisible(false);
				}
				
				this.grayMethod(figureCell);
			}
		}
		
		
		/**灰态处理*/
		private function grayMethod(obj:*):void
		{
			ColorTransformUtils.instance.clear(obj);
			//灰态处理
			if(!this.gray)
			{
				ColorTransformUtils.instance.addContrast(obj , -60);
				ColorTransformUtils.instance.addBrightness(obj , -20);
			}
		}
		
		
		/**交换、上下阵伙伴*/
		private function onExchange(e:FormationEvent):void
		{
			var data:Object = e.data;
			var req:MSG_FORMATION_PUT_HERO_REQ = data.req;
			this.dispatchEvent(new FormationEvent(FormationEvent.MSGID_FORMATION_PUT_HERO , req));
		}
		
		/**
		 * 提前绘制模型
		 * */
		private function onAdvance(evt:FormationEvent):void
		{
			var dragCell:FormationFetterDragCell = dragCells[evt.data.pos - 6];
			dragCell.upData(evt.data.heroInfo as PRO_Hero);
		}
		
		
		
		/**羁绊 与 布阵不可拖拽*/
		/*private function unableExchange(e:FormationEvent):void
		{
			this.dispatchEvent(e);
		}*/
		
		
		
		/**buff控制*/
		public function setEffect(data:Array):void
		{
			for(var i:int = 0;i<dragCells.length;i++)
			{
				var cell:FormationFetterDragCell = dragCells[i];
				//清除所有的buff
				cell.setEffect(false);
				if(cell.heroVO)
				{
					for(var j:int = 0;j < data.length ; j++)
					{
						var heroInfo:HeroVO = data[j];
						//添加buff
						if(cell.heroVO.name == heroInfo.name)
						{
							cell.setEffect(true);
						}
					}
				}
			} 
		}
		
		
		public function clear():void
		{
			for(var i:int=0;i<FETTER_POSINT.length;i++)
			{
				var dragCell:FormationFetterDragCell = dragCells[i];
				dragCell.removeEventListener(FormationEvent.EXCHANGE_HERO , onExchange);
				dragCell.clear();
				
				var figureCell:FormationFetterFigureCell = figureCells[i];
				figureCell.clear();
			}
		}
		
		public function close():void
		{
			this.clear();
		}
	}
}