package com.gamehero.sxd2.util
{
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 *文本工具 
	 * @author wulongbin
	 * 
	 */	
	public class TextUtil
	{
		/**
		 *创建label 
		 * @param text
		 * @param color
		 * @param size
		 * @param x
		 * @param y
		 * @return 
		 * 
		 */		
		public static function createLabel(text:String, color:uint, size:uint, x:Number=0, y:Number=0):Label
		{
			var label:Label=new Label();
			label.text=text;
			label.color=color;
			label.size=size;
			label.x=x;
			label.y=y;
			return label;
		}
		
		public static function createTextField(text:String, color:uint ,size:uint,underline:Boolean=false):TextField
		{
			var tf:TextField = new TextField;
			tf.autoSize="left";
			tf.selectable =false;
			tf.defaultTextFormat = new TextFormat("Tahoma",size,color,null,null,underline);
			tf.text = text;
			return tf;
		}
	}
}