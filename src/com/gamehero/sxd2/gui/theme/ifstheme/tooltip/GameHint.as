package com.gamehero.sxd2.gui.theme.ifstheme.tooltip {
	
	import com.gamehero.sxd2.gui.core.components.McActiveObject;
	import com.gamehero.sxd2.gui.core.interFace.ICellData;
	import com.gamehero.sxd2.gui.formation.bagZone.FormationHeroIconCell;
	import com.gamehero.sxd2.gui.formation.fetterZone.FormationFetterDragCell;
	import com.gamehero.sxd2.gui.formation.formationZone.FormationBtn;
	import com.gamehero.sxd2.gui.formation.formationZone.FormationDragCell;
	import com.gamehero.sxd2.gui.formation.thaumaturgyZone.ThaumaturgyItem;
	import com.gamehero.sxd2.gui.heroHandbook.HeroHandbookLookBtn;
	import com.gamehero.sxd2.gui.heroHandbook.HerohandbookCell;
	import com.gamehero.sxd2.gui.main.MainTaskPanel;
	import com.gamehero.sxd2.gui.roleSkill.SkillItemCell;
	import com.gamehero.sxd2.gui.roleSkill.SkillTip;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.tree.TaskTreeLabel;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.GameHintSkin;
	import com.gamehero.sxd2.gui.tips.FormationTips;
	import com.gamehero.sxd2.gui.tips.HeroHandbookTips;
	import com.gamehero.sxd2.gui.tips.HurdleGuideTips;
	import com.gamehero.sxd2.gui.tips.ItemTipsManager;
	import com.gamehero.sxd2.gui.tips.TaskTips;
	import com.gamehero.sxd2.gui.tips.ThaumaturgyTips;
	import com.gamehero.sxd2.util.AssetUtil;
	import com.gamehero.sxd2.world.display.data.GameRenderCenter;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import alternativa.gui.alternativagui;
	import alternativa.gui.base.GUIobject;
	import alternativa.gui.mouse.IHint;
	import alternativa.gui.mouse.MouseManager;
	
	import org.bytearray.display.ScaleBitmap;
	
	use namespace alternativagui;
	
	/**
	 * Game Hint 
	 * @author Trey
	 * @modify-date 2013-8-26
	 */
	public class GameHint extends GUIobject implements IHint {
		
		// EN: content
		private var content:DisplayObject;//左侧tips
		private var content2:DisplayObject;//右侧tips
		
		// RU: внутренний отступ
		// EN: padding
		public static var paddingX:int = 10;
		public static var paddingY:int = 8;
		private var distance:int = 3;
		
		private var _label:Label;
		
		private var _available:Boolean = false;
		
		private var bg:ScaleBitmap;
	
		public function GameHint() {
			super();
			
			_label = new Label();
			_label.leading = 0.5;
			_label.color = 0xdeddc5;
		}
		
		
		override public function resize(width:int, height:int):void {
		}
		
		override public function set width(value:Number):void {
		}
		
		override public function set height(value:Number):void {
		}
		
		/**初始化Tips背景*/
		private function setBGQuantily(value:int = -1):void
		{
			if(this.bg)
			{
				if(this.bg.parent){
					this.bg.parent.removeChild(bg);
				}
				this.bg = null;
			}
			
			this.bg = new ScaleBitmap(GameHintSkin.TIPS_BG);
			this.bg.scale9Grid = GameHintSkin.hintBgScale9Grid;
		}
		
		// EN: set the text for hint
		public function set text(value:String):void 
		{
			// Modify by Trey, 2013-12-17, 为了解决空GameHint显示的问题
			if (content != null && contains(content)) {
				AssetUtil.instance.stopAll(content as DisplayObjectContainer);
				removeChild(content);
				content = null;
			}
			if (content2 != null && contains(content2)) {
				AssetUtil.instance.stopAll(content2 as DisplayObjectContainer);
				removeChild(content2);
				content2 = null;
			}
			_available = true;
			
			if(MouseManager.overed)
				if(MouseManager.overed.parent)		
					if(MouseManager.overed.parent is TaskTreeLabel)
						var taskTreeLabel:TaskTreeLabel = MouseManager.overed.parent as TaskTreeLabel;

			var isBg:Boolean;//标记是否自带背景

			// 背包格子tips
			if(MouseManager.overed is ICellData )
			{
				clearBg();
				content = ItemTipsManager.getTips((MouseManager.overed as ICellData).itemCellData);
			}
			// 其他自定义tips
			else
			{
				if(MouseManager.overed is McActiveObject)//剧情副本界面
				{
					var hgAo:McActiveObject = MouseManager.overed as McActiveObject;//hg  hurdleGuide
					switch(hgAo.type)
					{
						case McActiveObject.HurdleGuideNode:
							content = HurdleGuideTips.getTips(hgAo.data,hgAo.pro);
							break;
						case McActiveObject.HurdleGuideBox:
							content = HurdleGuideTips.getBoxTips(hgAo.data,hgAo.ent);//宝箱奖励数据，宝箱是领取条件
							break;
						default :
							if(" " != value)
							{
								this._label.text = value;
								this.content = _label;
							}
					}
				}
				else if(MouseManager.overed is FormationDragCell || MouseManager.overed is FormationHeroIconCell || MouseManager.overed is FormationFetterDragCell)
				{
					content = FormationTips.getFormationHeroTips(MouseManager.overed);
				}
				else if(MouseManager.overed is FormationBtn)
				{
					content = FormationTips.getFormationTips(MouseManager.overed as FormationBtn);
				}
				else if(MouseManager.overed is SkillItemCell)
				{
					var skillItem:SkillItemCell = MouseManager.overed as SkillItemCell;
					if(skillItem.skillData)
						content = SkillTip.getSkillCellTips(skillItem.skillData,skillItem.isAll);
					else
					{
						this._label.text = value;
						this.content = _label;
					}
				}
				else if(MouseManager.overed is HerohandbookCell || MouseManager.overed is HeroHandbookLookBtn)
				{
					content = HeroHandbookTips.getHeroHandbookTips(MouseManager.overed);
				}
				else if(MouseManager.overed is ThaumaturgyItem)
				{
					content = ThaumaturgyTips.getThaumaTips(MouseManager.overed as ThaumaturgyItem);
				}					
				// 任务tips
				else if(taskTreeLabel)
				{
//					clearBg();
					isBg = true;
					content = TaskTips.getTips(value);	
				}
				else if(" " != value)
				{
					this._label.text = value;
					this.content = _label;
				}
				
				//此处默认ActiveObject   Tips
				this.setBGQuantily();
				
				if(content && !isBg)
				{
					var w:int = content.width + GameHint.paddingX * 2 + GameHintSkin.edge;
					var h:int = content.height + GameHint.paddingY * 2 + GameHintSkin.edge;
					this.bg.setSize(w,h);
					addChildAt(this.bg, 0);
				}
			}
			
			
			// Modify by Trey, 2013-12-17, 为了解决空GameHint显示的问题
			if(_available == true && content != null) {
				
				content.addEventListener(Event.REMOVED_FROM_STAGE , onRemove);
				// 必须有内容
				if(content.width > 0 && content.height > 0)
				{
					this.addChild(content);
					if(content2)
					{
						this.addChild(content2);
					}
					
					this.redraw();
					
				}
			}
		}
		/**		 * 清掉自带的bg		 */		
		private function clearBg():void
		{
			if(this.bg)
			{
				if(this.bg.parent){
					this.bg.parent.removeChild(bg);
				}
				this.bg = null;
			}
		}
		// RU: изменяем размер фону
		// EN: change background size
		override protected function draw():void {
			
			super.draw();
			
			this.drawChildren();
		}
		// RU: позиционирование и изменение размеров
		// EN: set position and change sizes
		private function redraw():void {
			content.x = paddingX + 3;
			content.y = paddingY + 1;
			
			if(content2)
			{
				content2.x = content.x + content.width + paddingX*2 + distance;
				content2.y = content.y;
				_width = content.width + distance + content2.width + paddingX * 2;
				_height = Math.max(content.height, content2.height) + paddingY * 2;
			}else{
				_width = content.width + paddingX * 2;
				_height = content.height + paddingY * 2;
			}
			
			draw();
		}
		
		private  function onRemove(e:Event):void
		{
			content.removeEventListener(Event.REMOVED_FROM_STAGE , onRemove);
		}
		
		public function get available():Boolean
		{
			return _available;
		}
		
	}
}



