package com.gamehero.sxd2.gui.formation.formationZone
{
	import com.gamehero.sxd2.battle.display.BattleFigureItem;
	import com.gamehero.sxd2.common.SpriteFigureItem;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.event.FormationEvent;
	import com.gamehero.sxd2.gui.formation.FormationDragObject;
	import com.gamehero.sxd2.gui.formation.FormationType;
	import com.gamehero.sxd2.gui.formation.FormationModel;
	import com.gamehero.sxd2.gui.formation.FormationSkin;
	import com.gamehero.sxd2.manager.DialogManager;
	import com.gamehero.sxd2.manager.FormationManager;
	import com.gamehero.sxd2.manager.HeroManager;
	import com.gamehero.sxd2.pro.MSG_FORMATION_PUT_HERO_REQ;
	import com.gamehero.sxd2.pro.PRO_Hero;
	import com.gamehero.sxd2.vo.FormationVo;
	import com.gamehero.sxd2.vo.HeroVO;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;
	
	import alternativa.gui.base.ActiveObject;
	import alternativa.gui.event.DragEvent;
	import alternativa.gui.mouse.dnd.IDrag;
	import alternativa.gui.mouse.dnd.IDragObject;
	import alternativa.gui.mouse.dnd.IDrop;
	
	
	
	/**
	 * @author Wbin
	 * 创建时间：2015-8-24 下午1:53:45
	 * @阵中伙伴
	 */
	public class FormationDragCell extends ActiveObject implements IDrag, IDrop
	{
		/**拖拽数据*/
		private var _dragData:Object = new Object();
		
		/**阵上伙伴信息*/
		public var heroVO:HeroVO;
		public var heroInfo:PRO_Hero;
		
		/**伙伴路径*/
		public var figureCell:FormationFigureCell;
		private var figure:SpriteFigureItem;
		
		/**光圈*/
		private var round:MovieClip;
		/**粒子*/
		private var particles:MovieClip;
		/**是否处于buff状态中*/
		public var hasBuff:Boolean;
		
		
		/**阵上伙伴的位置*/
		public var pos:int;
		
		//可拖拽
		private var isDrag:Boolean;
		//可放下
		private var isDrop:Boolean;
		//锁定
		private var allLock:Boolean = false;
		
		
		public function FormationDragCell(figureCell:FormationFigureCell)
		{
			super();
			
			// 模型容器
			this.figureCell = figureCell;
			
			this.round = new FormationSkin.ROUND_MC() as MovieClip;
			round.stop();
			round.y = -30;
			round.visible = false;
			this.round.mouseChildren = false;
			this.round.mouseEnabled = false;
			this.addChild(round);
			
			this.particles = new FormationSkin.PARTICLE_MC() as MovieClip;
			particles.stop();
			particles.visible = false;
			this.particles.mouseChildren = false;
			this.particles.mouseEnabled = false;
			this.addChild(particles);
			
			this.doubleClickEnabled = true;
			
			// 默认画一个矩形
			this.graphics.beginFill(0,0);
			this.graphics.drawRect(-60,-30,120,60);
			this.graphics.endFill();
		}
		
		
		/**
		 * 设置此格子是否可拖拽
		 * lock 锁定布阵
		 * */
		public function setDrag(value:Boolean,lock:Boolean):void
		{
			allLock = lock;
			isDrag = isDrop = value&&lock;
			
			if(isDrag == true)
			{
				this.addEventListener(MouseEvent.ROLL_OVER , mouseOver);
				this.addEventListener(MouseEvent.ROLL_OUT , mouseOut);
				// 取消拖拽
				this.addEventListener(DragEvent.CANCEL , dragCancel);
			}
			else
			{
				this.removeEventListener(MouseEvent.ROLL_OVER , mouseOver);
				this.removeEventListener(MouseEvent.ROLL_OUT , mouseOut);
				// 取消拖拽
				this.removeEventListener(DragEvent.CANCEL , dragCancel);
			}
			
			figureCell.setDrag(isDrag);
		}
		
		
		
		
		/**伙伴信息更新*/
		public function upData(heroInfo:PRO_Hero):void
		{
			this.clearFigure();
			this.heroInfo = heroInfo;
			this.heroVO = HeroManager.instance.getHeroByID(heroInfo.heroId+"");
			// 伙伴形象
			if(heroVO)
			{
				var url:String = GameConfig.BATTLE_FIGURE_URL + heroVO.url;
				figure = new SpriteFigureItem(url , false , BattleFigureItem.STAND);
				figure.frameRate = 18;
				figure.play();
				this.addChild(figure);
				
				/*var glowFilter:GlowFilter = new GlowFilter(0xCCFF00,0.8);  
				var filtersArray:Array = new Array(glowFilter);  
				figure.filters = filtersArray;*/
				
				// 同时复制一份到figureCell中
				figureCell.upData(heroInfo);
				
				// 保存资源url,在阵容面板关闭时清除
				FormationModel.inst.addResource(url);
				
				/*FormationModel.inst.oneFormationDic[this.pos] = heroVO.id;*/
				
				this.hint = " ";
			}
			
		}
		
		public function checkHero(heroInfo:PRO_Hero):Boolean
		{
			var isRedraw:Boolean;
			if(this.heroInfo)
			{
				isRedraw = this.heroInfo.heroId.toString() == heroInfo.heroId.toString();
			}
			else
			{
				isRedraw = false; 
			}
			return isRedraw;
		}
		
		
		
		/**
		 * 显示/隐藏模型
		 * */
		public function setFigureVisible(value:Boolean):void
		{
			//先隐藏模型
			if(figure != null)
			{
				figure.visible = value;
			}
			
			this.mouseEnabled = this.mouseChildren = value;
		}
		
		
		/**
		 * 羁绊buff外发光
		 * @value1   被羁绊者
		 * @value2   羁绊者
		 * */
		public function setBuff(value1:Boolean,value2:Boolean):void
		{
			this.round.visible = value1;
			value1?this.round.play():this.round.stop();
			this.particles.visible = value2;
			value2?this.particles.play():this.particles.stop();
			
			//任意buff置为true
			if(value1 || value2)
			{
				this.hasBuff = true;
			}
			else
			{
				this.hasBuff = false;
			}
			
			if(figure)
			{
				this.setChildIndex(this.figure,1);
				//创建滤镜
				/*var glowFilter:GlowFilter = new GlowFilter(0xCCFF00,0.8);*/  
				//将该滤镜添加到数组中  
				/*var filtersArray:Array = new Array(glowFilter);*/  
				//将滤镜数组分配给显示对象以便应用滤镜  
				/*figure.filters = this.hasBuff?filtersArray:[];*/  
			}
		}
		
		
		/**
		 * 鼠标滑过处理
		 * */
		public function mouseOver(e:MouseEvent):void
		{
			if(FormationModel.inst.isDraging == true || figure)
			{
				// 加入高亮状态图
				figureCell.mouseOver();
			}
			
			if(figure)
			{
				figure.filters = [new ColorMatrixFilter([1,0,0,0,40,0,1,0,0,40,0,0,1,0,40,0,0,0,1,0])];
			}
		}
		
		
		
		
		/**
		 * 鼠标移出处理
		 * */
		public function mouseOut(e:MouseEvent):void
		{
			// 移除高亮状态图
			figureCell.mouseOut();
			
			if(figure)
			{
				figure.filters = [];
			}
		}
		
		
		
		
		
		public function isDragable():Boolean
		{
			return isDrag && heroInfo;
		}
		
		
		
		
		/**拖拽的伙伴信息*/
		public function getDragObject():IDragObject
		{
			FormationModel.inst.isDraging = true;
			
			// 移出跟随鼠标的人形
			this.dispatchEvent(new FormationEvent(FormationEvent.DRAG_MOUSE_FIGURE_VISIBLE));
			
			if(_dragData == null)
			{
				_dragData = new Object();
			}
			_dragData.heroInfo = heroInfo;
			_dragData.fromPos = pos;
			return new FormationDragObject(_dragData);
		}
		
		
		
		
		/**
		 *Drop
		 * */
		public function canDrop(dragObject:IDragObject):Boolean
		{
			return true;
		}
		
		
		
		
		
		/**
		 * Drop
		 * */
		public function drop(dragObject:IDragObject):void
		{
			FormationModel.inst.isDraging = false;
			//此处为了处理提示信息
			if(!this.isDrop)
			{
				this.dispatchEvent(new FormationEvent(FormationEvent.DRAG_CELL_VISIBLE , true));
				if(!this.allLock)
				{
					DialogManager.inst.showWarning("30042");
					this.dispatchEvent(new FormationEvent(FormationEvent.FORMATION_REMINDER , FormationType.GO_TO_FETTER));
				}
				return;
			}
			
			var data:Object = dragObject.data;
			var fromInfo:PRO_Hero = data.heroInfo;
			var fromPos:int = data.fromPos;
			
			//抛出事件被拖拽位上模型提前绘制
			if(fromPos != 0)
			{
				var prepareData:Object = new Object();
				prepareData.heroInfo = this.heroInfo ||= new PRO_Hero();
				prepareData.pos = fromPos;
				this.dispatchEvent(new FormationEvent(FormationEvent.FIGURE_DRAW , prepareData));
				this.clearFigure();
				figureCell.clear();
			}
			
			//伙伴形象提前绘制
			if(figure)
			{
				figure.stop();
				figure.filters= []; 
				this.removeChild(figure);
			}
			
			var hVo:HeroVO = HeroManager.instance.getHeroByID(fromInfo.heroId+"");
			var url:String = GameConfig.BATTLE_FIGURE_URL + hVo.url;
			figure = new SpriteFigureItem(url , false , BattleFigureItem.STAND);
			figure.filters = [new ColorMatrixFilter([1,0,0,0,40,0,1,0,0,40,0,0,1,0,40,0,0,0,1,0])];
			figure.frameRate = 18;
			figure.play();
			this.addChild(figure);
			
			if(fromPos != this.pos)
			{
				//拖拽过来的伙伴
				var exchangeData:Object = new Object();
				var req:MSG_FORMATION_PUT_HERO_REQ = new MSG_FORMATION_PUT_HERO_REQ();
				// 找到对应位置的索引
				var formationID:int = FormationModel.inst.heroFormation.id;
				var formationVO:FormationVo = FormationManager.instance.getPosById(formationID);
				req.pos = formationVO.getPosIndex(this.pos);
				req.id = fromInfo.base.id;
				exchangeData.req = req;
				
				this.dispatchEvent(new FormationEvent(FormationEvent.EXCHANGE_HERO , exchangeData));
			}
		}
		
		
		
		
		
		/**
		 * 取消拖拽
		 * */
		private function dragCancel(e:DragEvent):void
		{
			FormationModel.inst.isDraging = false;
			
			// 鼠标位置不在境内,则该伙伴下阵
			if(mouseX < -60 || mouseX > 60 || mouseY < -30 || mouseY > 30)
			{
				var exchangeData:Object = new Object();
				var req:MSG_FORMATION_PUT_HERO_REQ = new MSG_FORMATION_PUT_HERO_REQ();
				req.pos = 0;
				req.id = heroInfo.base.id;
				exchangeData.req = req;
				
				// 替换伙伴请求
				this.dispatchEvent(new FormationEvent(FormationEvent.EXCHANGE_HERO , exchangeData));
			}
			else
			{
				// 显示所有拖拽格子模型
				this.dispatchEvent(new FormationEvent(FormationEvent.DRAG_CELL_VISIBLE , true));
			}
		}
		
		
		public function clearFigure():void
		{
			if(figure && this.contains(figure))
			{
				figure.stop();
				figure.visible = false;
				this.figure.parent.removeChild(figure);
			}
			figure = null;
		}
		
		
		
		public function clear():void
		{
			this.hint = "";
			
			this.setDrag(false,false);
			
			this.round.visible = false;
			this.round.stop();
			this.particles.visible = false;
			this.particles.stop();
			
			heroVO = null;
			heroInfo = null;
			hasBuff  = false;
			
			this.clearFigure();
			// 同时清空figureCell
			figureCell.clear();
		}
	}
}