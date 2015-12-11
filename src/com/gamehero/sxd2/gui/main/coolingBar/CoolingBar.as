package com.gamehero.sxd2.gui.main.coolingBar
{
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.manager.FunctionManager;
	import com.gamehero.sxd2.vo.FunctionVO;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * 左中功能入口bar(冷却栏)
	 * @author weiyanyu
	 * 创建时间：2015-11-5 上午11:23:08
	 */
	public class CoolingBar extends Sprite
	{
		public function CoolingBar()
		{
			super();
		}
		/**
		 * 冷却栏显示的功能入口id列表 
		 */		
		private const FUNCTION_LIST:Vector.<int> = new <int>[30010];
		
		protected var _heght:int;
		
		private const SPACE_Y:int = 20;
		/**
		 * 文本列表 
		 */		
		protected var _labels:Array = [];
		
		public function init():void
		{
			var opened:Array = FunctionManager.inst.opendFunc.toArray();
			for(var i:int=0;i<opened.length;i++)
			{
				var funcVO:FunctionVO = opened[i];
				
				if(FUNCTION_LIST.indexOf(funcVO.id) == -1) continue;
				
				var coolingLb:CoolingBarLabel = new CoolingBarLabel();
				coolingLb.data = funcVO;
				coolingLb.addEventListener(MouseEvent.CLICK, onClickLb);
				this.addChild(coolingLb);
				_labels.push(coolingLb);
			}
			
			// 调整位置
			this.updatePosition();
		}
		
		
		
		
		protected function onClickLb(e:MouseEvent):void
		{
			var lb:CoolingBarLabel = e.currentTarget as CoolingBarLabel;
			var funcVO:FunctionVO = lb.data;
			MainUI.inst.openWindow(funcVO.name);
		}
		
		
		
		
		
		/**
		 * 开启新的功能
		 * */
		public function registerButton(funcVO:FunctionVO, callback:Function=null):void
		{
			var coolingLb:CoolingBarLabel = new CoolingBarLabel();
			coolingLb.data = funcVO;
			coolingLb.addEventListener(MouseEvent.CLICK, onClickLb);
			this.addChild(coolingLb);
			_labels.push(coolingLb);
			
			// 调整位置
			this.updatePosition();
			
			if(callback != null)
			{
				callback();
			}
		}
		
		
		
		
		
		
		public function removeButton(funcVO:FunctionVO):void
		{
			
		}
		
		
		
		
		
		/**
		 * 调整位置
		 * */
		private function updatePosition():void
		{
			// 对btn位置排序
			//btns.sortOn("position" , Array.NUMERIC);
			for(var i:int=0;i<_labels.length;i++)
			{
				_labels[i].y = i * SPACE_Y;
			}
			
			// 调整菜单整体宽度
			_heght = _labels.length * SPACE_Y;
		}
		
		
		
		
		
		override public function get height():Number
		{
			return _heght;
		}
		
	}
}