package com.gamehero.sxd2.gui.theme.ifstheme.controls.dropDownList
{
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.gui.theme.ifstheme.container.list.List;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	import com.gamehero.sxd2.util.FiltersUtil;
	
	import flash.events.MouseEvent;
	
	import alternativa.gui.base.ActiveObject;
	import alternativa.gui.data.DataProvider;
	import alternativa.gui.event.ListEvent;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * 自定义的下拉框
	 */
	public class DropDownList extends ActiveObject
	{
		//===================DATA=======================
		/** 下拉选择框最大能显示的条目数量 **/
		private var m_maxItemNum:int = 4;
		/** 下拉选择框的显隐状态 **/
		private var m_listVisible:Boolean;
		/** 组件的宽度 **/
		private var m_width:Number = 150;
		/** 下拉选择的数据 **/
		private var m_dataSource:Array;
		/** 当前选中状态的索引 **/
		private var m_selectedIndex:uint;
		
		//===================UI========================
		/** 文本面板 **/
		private var labelAO:ActiveObject;
		/** 文本背景 **/
		private var labelBg:ScaleBitmap;
		/** 文本 **/
		private var titleLabel:Label;
		
		/** 下拉按钮 **/
		private var downBtn:Button;
		/** 上拉按钮 **/
		private var upBtn:Button;
		
		/** 列表背景 **/
		private var listBg:ScaleBitmap;
		/** 列表 **/
		private var list:List;
		
		public function DropDownList()
		{
			super();
			init();
		}
		
		/**
		 * 初始化
		 */
		private function init():void
		{
			labelAO = new ActiveObject();
			labelAO.addEventListener(MouseEvent.CLICK, onDownBtnClick);
			this.addChild(labelAO);
			
			labelBg = new ScaleBitmap(MainSkin.windowInner3Bg);
			labelBg.scale9Grid = MainSkin.windowInner3BgScale9Grid;
			labelAO.addChild(labelBg);
			
			titleLabel = new Label();
			labelAO.addChild(titleLabel);
			
			downBtn = new Button(MainSkin.downArrowUp, MainSkin.downArrowDown, MainSkin.downArrowOver);
			downBtn.addEventListener(MouseEvent.CLICK, onDownBtnClick);
			this.addChild(downBtn);
			
			upBtn = new Button(MainSkin.upArrowUp, MainSkin.upArrowDown, MainSkin.upArrowOver);
			upBtn.addEventListener(MouseEvent.CLICK, onDownBtnClick);
			this.addChild(upBtn);
			
			listBg = new ScaleBitmap(MainSkin.windowInner3Bg);
			listBg.scale9Grid = MainSkin.windowInner3BgScale9Grid;
			this.addChild(listBg);
			
			list = new List();
			list.itemRenderer = DropDownListItem;
			list.addEventListener(ListEvent.SELECT_ITEM, onItemSelected);
			this.addChild(list);
			
			dataSource = [];
		}
		
		/**
		 * 更新布局
		 */
		private function draw():void
		{
			labelBg.setSize(width, 23);
			
			titleLabel.x = 10;
			titleLabel.y = 5;
			
			upBtn.x = downBtn.x = width - downBtn.width - 3;
			upBtn.y = downBtn.y = (labelBg.height - downBtn.height) / 2;
			
			var num:int = Math.min(maxItemNum, m_dataSource.length);
			listBg.y = labelBg.height + 3;
			listBg.setSize(width, num*(DropDownListItem.HEIGHT+1)+2);
			
			list.x = listBg.x;
			list.y = listBg.y + 1;
			list.resize(DropDownListItem.WIDTH, listBg.height-5);
		}
		
		override public function get width():Number
		{
			return m_width;
		}
		override public function set width(value:Number):void
		{
			m_width = value;
			DropDownListItem.WIDTH = m_width;
			dataSource = dataSource;	//更新列表宽度
		}
		
		/**
		 * 下拉选择框最大能显示的条目数量
		 */
		public function get maxItemNum():int
		{
			return m_maxItemNum;
		}
		public function set maxItemNum(value:int):void
		{
			if(value<2){
				throw new Error("DropDownList：maxItemNum不能小于2");
			}
			m_maxItemNum = value;
			draw();
		}
		
		/**
		 * 选中信息的索引
		 */
		public function get selectedIndex():uint
		{
			return m_selectedIndex;
		}
		public function set selectedIndex(value:uint):void
		{
			if(value>=m_dataSource.length){
				throw new Error("DropDownList：selectIndex索引溢出！");
			}
			m_selectedIndex = value;
			list.selectedIndex = m_selectedIndex;
		}
		
		/**
		 * 单击下拉按钮
		 */
		private function onDownBtnClick(evt:MouseEvent):void
		{
			this.listVisible = !listVisible;
		}
		
		/**
		 * 选中了列表项
		 */
		private function onItemSelected(evt:ListEvent):void
		{
//			this.selectedIndex = list.selectedIndex;
			m_selectedIndex = list.selectedIndex;
			titleLabel.text = (list.selectedItem as DropDownListVO).title;
			this.listVisible = false;
			
			dispatchEvent(new ListEvent(ListEvent.LIST_CHANGE, evt));
		}
		
		/**
		 * 下拉列表的显隐
		 */
		private function get listVisible():Boolean
		{
			return m_listVisible;
		}
		private function set listVisible(value:Boolean):void
		{
			m_listVisible = value;
			
			list.visible = value;
			listBg.visible = value;
			upBtn.visible = value;
			downBtn.visible = !value;
		}
		
		/**
		 * 下拉选择的数据
		 */
		public function get dataSource():Array
		{
			return m_dataSource;
		}
		public function set dataSource(value:Array):void
		{
			this.listVisible = false;
			m_dataSource = value;
			
			if(!m_dataSource || m_dataSource.length==0){
				this.locked = true;
				titleLabel.text = "";
			}else{
				this.locked = false;
				
				var i:int;
				var len:int = m_dataSource.length;
				var listData:DataProvider = new DataProvider();
				for(i=0; i<len; i++)
				{
					listData.addItem(m_dataSource[i]);
				}
				list.dataProvider = listData;
				this.selectedIndex = 0;
			}
			
			draw();
		}
		
		/**
		 * 是否锁定组件
		 */
		override public function set locked(value:Boolean):void
		{
			super.locked = value;
			
			FiltersUtil.grayFilter(this, value);
			upBtn.locked = downBtn.locked = value;
			if(value){
				this.listVisible = false;
			}
		}
		
		/**
		 * 清除
		 */
		public function clear():void
		{
			list.removeEventListener(ListEvent.SELECT_ITEM, onItemSelected);
			Global.instance.removeChildren(this);
			list = null;
		}
		
	}
}