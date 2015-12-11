package com.gamehero.sxd2.gui.chat
{
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.event.ChatEvent;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.system.IME;
	import flash.utils.setTimeout;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * 聊天表情面板
	 * @author xuwenyi
	 * @create 2013-10-15
	 **/
	public class ChatExpressionPanel extends Sprite
	{
		// 表情选中背景框
		private var selectBG:Bitmap;
		
		// 表情列表
		private var faces:Array = [];
		
		
		/**
		 * 构造函数
		 * */
		public function ChatExpressionPanel()
		{
			var global:Global = Global.instance;
			
			// 背景图
			var bg:ScaleBitmap = new ScaleBitmap(CommonSkin.windowInner2Bg as BitmapData);
			bg.x = -4;
			bg.y = -37;
			bg.scale9Grid = CommonSkin.windowInner2BgScale9Grid;
			bg.setSize(238 , 172);
			this.addChild(bg);
			
			// 表情背景框
			var bmd:BitmapData = global.getRes(ChatData.mainDomain, "FACE_SELECT_BG") as BitmapData;
			selectBG = new Bitmap(bmd);
			selectBG.visible = false;
			this.addChild(selectBG);
			
			// 排列表情
			for(var i:int=0;i<35;i++)
			{
				var face:MovieClip = global.getRes(ChatData.mainDomain, "eip"+(i+1)) as MovieClip;
				face.x = 32*(i%7);
				face.y = 32*Math.floor(i/7);
				face.buttonMode = true;
				face.useHandCursor = true;
				face.addEventListener(MouseEvent.CLICK , onFaceClick);
				face.addEventListener(MouseEvent.ROLL_OVER , onRollOver);
				face.addEventListener(MouseEvent.ROLL_OUT , onRollOut);
				this.addChild(face);
				
				faces.push(face);
			}
			
		}
		
		/**
		 * 显示时添加鼠标事件
		 * */
		override public function set visible(value:Boolean):void 
		{
			if(stage)
			{
				if(value == true)
				{
					setTimeout(function():void
					{
						stage.addEventListener(MouseEvent.CLICK , onClick);
					},1);
				}
				else
				{
					stage.removeEventListener(MouseEvent.CLICK , onClick);
				}
			}
			super.visible = value;
		}
		
		/**
		 * 鼠标在场景任何地方点击时触发
		 * */
		private function onClick(e:MouseEvent):void
		{
			selectBG.visible = false;
			this.visible = false;
		}
		
		/**
		 * 鼠标滑过表情
		 * */
		private function onRollOver(e:MouseEvent):void
		{
			var face:MovieClip = e.currentTarget as MovieClip;
			selectBG.x = face.x;
			selectBG.y = face.y - 33;
			selectBG.visible = true;
		}
		
		/**
		 * 鼠标滑出表情
		 * */
		private function onRollOut(e:MouseEvent):void
		{
			selectBG.visible = false;
		}
		
		/**
		 * 选择某个表情
		 * */
		private function onFaceClick(e:MouseEvent):void
		{
			// 终止事件流并开启输入法
			e.stopImmediatePropagation();
			IME.enabled = true;
			
			selectBG.visible = false;
			
			var face:MovieClip = e.currentTarget as MovieClip;
			var idx:int = faces.indexOf(face);
			var classname:String = "eip"+(idx+1);
			this.dispatchEvent(new ChatEvent(ChatEvent.FACE_SELECT , classname));
		}
		
	}
}