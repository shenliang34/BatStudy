package com.gamehero.sxd2.gui.formation.formationZone
{
	import com.gamehero.sxd2.pro.MSG_FORMATION_INFO_REQ;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	
	import alternativa.gui.base.ActiveObject;
	import com.gamehero.sxd2.event.FormationEvent;
	import com.gamehero.sxd2.gui.formation.FormationModel;
	import com.gamehero.sxd2.gui.formation.FormationSkin;

	/**
	 * @author Wbin
	 * 创建时间：2015-8-24 下午2:09:18
	 * @底部阵型按钮
	 */
	public class FormationBtn extends ActiveObject
	{
		/**阵型底图*/
		private var icon:Bitmap;
		/**阵型ID*/
		public var ID:int;
		/**高亮框*/
		private var lightRect:Bitmap;
		
		/**是否为开放的新阵型*/
		private var isNew:Boolean;
		
		//新阵型开始标识
		private var openIcon:Bitmap;
		
		public function FormationBtn(iconBmd:BitmapData,index:int)
		{
			super();
			
			this.ID = index;
			
			this.icon = new Bitmap(iconBmd);
			this.icon.x = x;
			this.icon.y = y;
			this.hint = String(index);
			addChild(this.icon);
			
			//阵型选中框
			lightRect = new Bitmap(FormationSkin.forOverBmp);
			lightRect.visible = false;
			lightRect.x = -2;
			lightRect.y = -2;
			addChild(this.lightRect);
			
			//新阵型开启标识
			this.openIcon = new Bitmap(FormationSkin.newIcon);
			this.openIcon.x = 23;
			this.openIcon.y = 0;
			this.openIcon.visible = false;
			addChild(this.openIcon);
		}
		
		//只是为了设置监听
		public function addListener():void
		{
			this.addEventListener(MouseEvent.CLICK,onFormationChange);
			this.addEventListener(MouseEvent.ROLL_OVER,overORout);
			this.addEventListener(MouseEvent.ROLL_OUT,overORout);
		}
		
		/**设置当前选中高亮*/
		public function setFormation():void
		{
			this.lightRect.visible = true;
		}
		
		/**隐藏高亮*/
		public function hideOver():void
		{
			this.lightRect.visible = false;
		}
		
		/**新阵型开始标识*/
		public function set open(value:Boolean):void
		{
			this.isNew = value;
			this.openIcon.visible = value;
		}
		
		public function get open():Boolean
		{
			return this.isNew;
		}
		
		/**获取当前为哪一个阵型*/
		public function get slot():int
		{
			return this.ID;
		}
		
		
		/**点击切换布阵*/
		private function onFormationChange(evt:MouseEvent = null):void
		{
			//阵型选中时点击不再请求
			if((this.slot + 1) != FormationModel.inst.currentFormationId)
			{
				var msg:MSG_FORMATION_INFO_REQ = new MSG_FORMATION_INFO_REQ();
				msg.id = this.slot+1;
				//点击切换阵型
				this.dispatchEvent(new FormationEvent(FormationEvent.MSGID_FORMATION_INFO , msg));
			}
			if(this.open)
			{
				this.open = false;
			}
		}
		
		/**阵型高亮状态*/
		private function overORout(evt:MouseEvent):void
		{
			if((this.slot + 1) == FormationModel.inst.currentFormationId)
			{
				return;
			}
			lightRect.visible = (evt.type == MouseEvent.ROLL_OVER?true:false);
		}
		
		
		/**数据清除*/
		public function clear():void
		{
			this.removeEventListener(MouseEvent.CLICK,onFormationChange);
			this.removeEventListener(MouseEvent.ROLL_OVER,overORout);
			this.removeEventListener(MouseEvent.ROLL_OUT,overORout);
		}
	}
}