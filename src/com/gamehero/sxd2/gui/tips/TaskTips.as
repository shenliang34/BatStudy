package com.gamehero.sxd2.gui.tips
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.bag.component.ItemCell;
	import com.gamehero.sxd2.gui.bag.model.ItemTypeDict;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ChatSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.GameHintSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ItemSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.tooltip.GameHint;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.manager.GiftBoxManager;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.manager.TaskManager;
	import com.gamehero.sxd2.pro.PRO_Item;
	import com.gamehero.sxd2.vo.GiftBoxVo;
	import com.gamehero.sxd2.vo.TaskInfoVo;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import alternativa.gui.base.GUIobject;
	
	import org.bytearray.display.ScaleBitmap;
	
	public class TaskTips extends Sprite
	{
		public function TaskTips():void
		{
		}
		/**
		 * 任务提示
		 */		
		public static function getTips(text:String):DisplayObject
		{
			var container:Sprite = new Sprite();
			var strList:Array = text.split("^");
			var taskId:String = strList[1].split('"')[0];
			var awardList:Array = text.split("^");
			var taskVo:TaskInfoVo = TaskManager.inst.getTaskDataById(int(taskId));
			
			var sp:GUIobject = new GUIobject();
			sp.x = 10;
			sp.y = 10;
			container.addChild(sp);
			
			var awardFormatStr:String = "<font size='12' face='宋体' color='#949ed3'>";//奖励样式 " + GameDictionary.WINDOW_BLUE_GRAY + "
			var awardExpFormatStr:String = "<font size='12' face='宋体' color='#2ce80e'>";//奖励经验
			var awardGoldFormatStr:String = "<font size='12' face='宋体' color='#f78c2d'>";//奖励金币
			var awardTextFormatStr:String = "<font size='12' face='宋体' color='#d7deed'>";//内容
			
			var awardTitleText:TextField = new TextField();
			awardTitleText.height = 18;
			awardTitleText.htmlText = awardFormatStr + Lang.instance.trans("task_reward") + ":" + "</font>";
			sp.addChild(awardTitleText);
			
			var lineBM:ScaleBitmap = new ScaleBitmap(GameHintSkin.TIPS_LINE);
			lineBM.scale9Grid = ChatSkin.lineScale9Grid;
			lineBM.setSize(105, 2);
			lineBM.y = 30;
			lineBM.x = 10;
			container.addChild(lineBM);
			
			sp = new GUIobject();
			sp.height = 55;
			container.addChild(sp);
			sp.x = 10;
			sp.y = lineBM.y + 5;
			
			var awardExpText:TextField = new TextField();
			awardExpText.height = 18;
			awardExpText.htmlText = awardGoldFormatStr + Lang.instance.trans("exp_text") + ":" + awardTextFormatStr + taskVo.EXP;
			sp.addChild(awardExpText);
			
			var awardGoldText:TextField = new TextField();
			awardGoldText.height = 18;
			awardGoldText.y = 20;
			awardGoldText.htmlText = awardGoldFormatStr + Lang.instance.trans("gold_text") + ":" + awardTextFormatStr + taskVo.gold;
			sp.addChild(awardGoldText);
			if(taskVo.boxId != "")
			{
				var list:Array = taskVo.boxId.split("^");
				var len:int = list.length;
				for(var i:int;i<len;i++){
					var awardBoxText:TextField = new TextField();
					awardBoxText.height = 18;
					awardBoxText.y = i * 20 + 40;
					var box:GiftBoxVo = GiftBoxManager.instance.getBoxById(list[i]);
					var boxId:int = box.itemArr[0];
					var item:PropBaseVo = ItemManager.instance.getPropById(boxId);
					
					if(item)
					{
						var awardCount:String;
						if(box.maxNumArr[0] == box.minNumArr[0])
							awardCount = "*" + box.maxNumArr;
						else
							awardCount = "*" + box.minNumArr + "~" + box.maxNumArr;
						
						awardBoxText.htmlText = awardGoldFormatStr + item.name + awardCount;
					}
					
					sp.addChild(awardBoxText);
				}
			}
			
			var bg:ScaleBitmap = new ScaleBitmap();
			bg = new ScaleBitmap(GameHintSkin.TIPS_BG);
			bg.scale9Grid = GameHintSkin.hintBgScale9Grid;
			
			var w:int = container.width + GameHint.paddingX * 2;
			var h:int = container.height + GameHint.paddingY * 2 + GameHintSkin.edge;
			
			bg.setSize(w , h);
			container.addChildAt(bg,0);
			
			return container;
		}
	}
}

