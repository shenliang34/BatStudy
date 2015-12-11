package com.gamehero.sxd2.gui.theme.ifstheme.controls.text {
	
	
	import com.gamehero.sxd2.data.GameDictionary;
	
	import flash.filters.GlowFilter;
	
	import alternativa.gui.controls.text.Label;
	import alternativa.gui.enum.Align;
	import alternativa.gui.theme.defaulttheme.skin.NumericConst;


	/**
	 * 自定义Lable控件<br/>
	 * 增加自定义一些属性
	 * @author Trey
	 * 
	 */
	public class Label extends alternativa.gui.controls.text.Label {
		
		// 字体黑灰色描边
		static public const TEXT_FILTER:GlowFilter = new GlowFilter(GameDictionary.STROKE, 1, 2, 2, 8);

		
		/**
		 * Constructor 
		 * @param autosize
		 * 
		 */
		public function Label(autosize:Boolean=true) {
			
			super(autosize);

			size = NumericConst.textSize;
			color = GameDictionary.WHITE;
			
			this.filters = [TEXT_FILTER];
			leading = .5;//默认行间距是半个文字高度
		}
		
		
		/**
		 * 居中、居右必须设置autosize为false才起效 
		 * @param value
		 * 
		 */
		override public function set align(value:Align):void {
			
			if(value != Align.LEFT) {
				
				this.autosize = false;
			}
			else {
				
				this.autosize = true;
			}
			
			super.align = value;
		}
		
		
//		override public function update():void {
//			
//			super.update();
//			
//			graphics.clear();
//			graphics.beginFill(0xFF0000, 1);
//			graphics.drawRect(0, 0, this.width, this.height);
//			
//		}
		
	}
}
