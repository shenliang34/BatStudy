package com.gamehero.sxd2.battle.layer
{
	import com.gamehero.sxd2.battle.data.BattleBuff;
	import com.gamehero.sxd2.battle.data.BattleDataCenter;
	import com.gamehero.sxd2.battle.display.BPlayer;
	import com.gamehero.sxd2.battle.display.BattleEfItem;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.event.RenderItemEvent;
	import com.gamehero.sxd2.vo.BuffVO;
	
	import bowser.render.display.SpriteItem;
	import bowser.utils.data.Group;
	
	
	/**
	 * 战斗人物buff状态效果层
	 * @author xuwenyi
	 * @create 2013-12-11
	 **/
	public class BattleStLayer extends SpriteItem
	{
		// 角色
		private var player:BPlayer;
		
		// display = 1的效果
		private var mainEffectItem:BattleEfItem;
		
		// 触发后头顶循环播放(存在优先级,同一时间只能显示一个)
		private var mainList:Array = [];
		
		
		// 要显示的主vo
		private var needShowMainVO:BuffVO;
		// 要显示的其他vo
		private var needShowList:Array = [];
		// 上一次的buff数据
		private var oldBuffs:Group = new Group();
		
		
		/**
		 * 构造函数
		 **/
		public function BattleStLayer(player)
		{
			this.player = player;
		}
		
		
		
		
		
		/**
		 * 更新buff状态
		 * */
		public function update(newBuffs:Array):void
		{
			// 先清空
			this.clear();
			
			// 遍历buff, 检查是否有新的buff添加进来
			for(var i:int=0;i<newBuffs.length;i++)
			{
				var newBuff:BattleBuff = newBuffs[i];
				var newVO:BuffVO = newBuff.vo;
				// 该buff需要显示效果
				newVO.displayType = newVO.displayType == "" ? "3" : newVO.displayType;
				if(newVO.displayType != "")
				{
					// 检查原buff
					var oldBuff:BattleBuff = oldBuffs.getChildByParam("id" , newBuff.id) as BattleBuff;
					if(oldBuff)
					{
						// 新的buff
						if(newBuff.triggerTime != oldBuff.triggerTime)
						{
							// 显示效果
							this.addBuff(newVO);
						}
						// 旧的buff
						else
						{
							// 效果是循环的话也要显示
							var loop:Boolean = this.isLoop(newVO.displayType);
							if(loop)
							{
								// 显示效果
								this.addBuff(newVO);
							}
						}
					}
					else
					{
						// 显示效果
						this.addBuff(newVO);
					}
				}
			}
			
			// 过滤存在优先级的buff
			this.filterPriority();
			
			// 显示
			this.show();
			
			// 覆盖原buff数组
			oldBuffs = new Group(newBuffs);
		}
		
		
		
		
		
		/**
		 * 添加buff
		 * */
		private function addBuff(buff:BuffVO):void
		{
			// 触发后头顶循环播放(存在优先级,同一时间只能显示一个)
			if(buff.displayType == "1")
			{
				mainList.push(buff);
			}
			// 其他效果
			else if(buff.displayType != "")
			{
				needShowList.push(buff);
			}
		}
		
		
		
		
		
		/**
		 * 过滤存在优先级的buff,拿到需要显示的vo
		 * */
		private function filterPriority():void
		{
			var buff:BuffVO;
			
			// 触发后头顶循环播放(存在优先级,同一时间只能显示一个)
			if(mainList.length > 0)
			{
				// 对优先级排序
				mainList.sortOn("priority" , Array.NUMERIC);
				// 取出priority = 1的项
				var list:Array = [];
				for(var i:int=0;i<mainList.length;i++)
				{
					buff = mainList[i];
					if(buff.priority == "1")
					{
						list.push(buff);
					}
				}
				// 若有优先级是1的项
				// 取时间最新的
				if(list.length > 0)
				{
					list.sortOn("triggerTime" , Array.NUMERIC);
					needShowMainVO = list[0];
				}
				// 没有优先级是1的
				// 则显示优先级最高的
				else
				{
					needShowMainVO = mainList[0];
				}
			}
		}
		
		
		
		
		
		
		/**
		 * 显示
		 * */
		private function show():void
		{
			var buff:BuffVO;
			var loop:Boolean;
			var ef:SpriteItem;
			
			// 显示主效果
			if(needShowMainVO)
			{
				loop = this.isLoop(needShowMainVO.displayType);
				ef = this.createEffectItem(needShowMainVO , loop);
				this.addChild(ef);
			}
			
			// 显示其他效果
			for(var i:int=0;i<needShowList.length;i++)
			{
				buff = needShowList[i];
				// 非swf格式的显示
				if(buff.displayType != "2")
				{
					loop = this.isLoop(buff.displayType);
					ef = this.createEffectItem(buff , loop);
					this.addChild(ef);
				}
				else
				{
					// 通知 BattleEffectCanvas处理
					BattleEfCanvas.instance.playStEf(buff , player);
				}
			}
		}
		
		
		
		
		
		
		/**
		 * 创建一个效果
		 * */
		private function createEffectItem(buff:BuffVO , loop:Boolean , frameRate:int = 12):SpriteItem
		{
			var effectURL:String = GameConfig.BATTLE_BUFF_EFFECT_URL + "png/" + buff.efURL;
			var item:BattleEfItem = new BattleEfItem();
			item.status = BattleEfItem.UNDERATTACK_AIR;
			item.frameRate = frameRate;
			item.load(effectURL , BattleDataCenter.instance.loader);
			item.play(loop);
			// 若不需要循环,则需要添加回调
			// 播放完毕后自动移除
			if(loop == false)
			{
				item.addEventListener(RenderItemEvent.PLAY_COMPLETE , effectOver);
			}
			
			// 保存记录,退出战斗后清除缓存
			var dataCenter:BattleDataCenter = BattleDataCenter.instance;
			dataCenter.addResource(effectURL , player.camp);
			
			var sprite:SpriteItem = new SpriteItem();
			sprite.addChild(item);
			
			// 注册点位置
			var posY:int;
			var h:int = player.playerHeight;
			switch(buff.displayPos)
			{
				case "":
				case "1":
					posY = 0;
					break;
				case "2":
					posY = h>>1;
					break;
				case "3":
					posY = h;
					break;
			}
			sprite.y = -posY;
			
			return sprite;
		}
		
		
		
		
		
		
		/**
		 * 效果播放完毕
		 * */
		private function effectOver(e:RenderItemEvent):void
		{
			var item:BattleEfItem = e.data as BattleEfItem;
			if(item)
			{
				item.removeEventListener(RenderItemEvent.PLAY_COMPLETE , effectOver);
				
				var p:SpriteItem = item.parent as SpriteItem;
				if(p && this.contains(p) == true)
				{
					p.removeChild(item);
					this.removeChild(p);
				}
			}
		}
		
		
		
		
		
		
		/**
		 * 根据displayType判断loop
		 * */
		private function isLoop(displayType:String):Boolean
		{
			if(displayType == "1" || displayType == "3")
			{
				return true;
			}
			else if(displayType == "2" || displayType == "4")
			{
				return false;
			}
			return false;
		}
		
		
		
		
		
		/**
		 * 清空效果
		 * */
		public function clear():void
		{
			mainEffectItem = null;
			mainList = [];
			needShowMainVO = null;
			needShowList = [];
			
			this.removeChildren();
		}
		
		
		
	}
}