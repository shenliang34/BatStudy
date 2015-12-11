package com.gamehero.sxd2.battle.layer
{
	import com.gamehero.sxd2.battle.data.BattleDataCenter;
	import com.gamehero.sxd2.battle.data.BattleGrid;
	import com.gamehero.sxd2.battle.display.BPlayer;
	import com.gamehero.sxd2.battle.display.BattleChain;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.BattleSkin;
	import com.gamehero.sxd2.pro.GS_DefenseChain_Pro;
	import com.gamehero.sxd2.world.display.MovieItem;
	import com.greensock.TweenMax;
	
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	
	import bowser.render.display.RenderItem;
	import bowser.render.display.SpriteItem;
	import bowser.utils.data.Vector2D;
	
	
	/**
	 * 防御链显示层
	 * @author xuwenyi
	 * @create 2014-01-03
	 **/
	public class BattleChainLayer extends SpriteItem
	{
		// 流光顺序
		private static const SEQ1:Array = [[1,10],[6],[2,11],[7],[3,12],[8],[4,13]];
		private static const SEQ2:Array = [[5],[1,10],[6,14],[2,11],[7,15],[3,12],[8,16],[4,13],[9]];
		// 单排流光过度到下一排时的延迟(毫秒)
		private static const flashDelay:int = 150;
		
		// 阵型背景格
		private var bg1:RenderItem;
		private var bg2:RenderItem;
		
		// 防御链格子数组
		public var chains1:Dictionary = new Dictionary();
		public var chains2:Dictionary = new Dictionary();
		
		// 防御链组件面板
		private var chainPanels:Dictionary = new Dictionary();
		
		// 受击区域面板
		private var uaPanel:SpriteItem;
		
		// 防御链更新时延迟关闭
		private var closeTween:TweenMax;
		
		// 显示开关
		public var isShow:Array = [null , true , true];
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleChainLayer()
		{	
			chainPanels[1] = new SpriteItem();
			this.addChild(chainPanels[1]);
			chainPanels[2] = new SpriteItem();
			this.addChild(chainPanels[2]);
			
			// 防御链晶格受击
			uaPanel = new SpriteItem();
			this.addChild(uaPanel);
		}
		
		
		
		
		/**
		 * 初始化
		 * */
		public function init():void
		{
			// 遍历双方角色
			var dataCenter:BattleDataCenter = BattleDataCenter.instance;
			var grid1:BattleGrid = dataCenter.grid1;
			var grid2:BattleGrid = dataCenter.grid2;
			
			var panel:SpriteItem;
			var chain:BattleChain;
			var player:BPlayer;
			var selfChian:GS_DefenseChain_Pro;
			var levels:Object;
			
			// 我方
			panel = chainPanels[1];
			panel.visible = false;
			
			// 白色七宫格底图
			bg1 = new RenderItem();
			bg1.renderSource = BattleSkin.CHAIN_BG;
			panel.addChild(bg1);
			
			levels = grid1.getChainLevels();
			var ps:Array = grid1.CAMP_POS_S;
			for(var i:int=0;i<ps.length;i++)
			{
				if(ps[i] != null)
				{
					// 判断该位置上是否有角色
					player = grid1.getPlayerByPos(i+1);
					if(player && player.isAngel == false)// 非天使
					{
						chain = new BattleChain();
						chain.pos = i+1;
						panel.addChild(chain);
						chains1[chain.pos] = chain;
						
						if(player.alive == true)
						{
							selfChian = player.selfChain;
							chain.hasPlayer = true;
							chain.updateStatus(selfChian.length , levels.minLevel , levels.maxLevel);
						}
						else
						{
							chain.hasPlayer = false;
							chain.updateStatus();
						}
					}
				}
			}
			
			// 敌方
			panel = chainPanels[2];
			panel.visible = false;
			
			// 白色七宫格底图
			bg2 = new RenderItem();
			bg2.renderSource = BattleSkin.CHAIN_BG;
			panel.addChild(bg2);
			
			levels = grid2.getChainLevels();
			ps = grid2.CAMP_POS_S;
			for(i=0;i<ps.length;i++)
			{
				if(ps[i] != null)
				{
					// 判断该位置上是否有角色
					player = grid2.getPlayerByPos(i+1);
					if(player && player.isAngel == false)// 非天使
					{
						chain = new BattleChain();
						chain.pos = i+1;
						panel.addChild(chain);
						chains2[chain.pos] = chain;
						
						if(player.alive == true)
						{
							selfChian = player.selfChain;
							chain.hasPlayer = true;
							chain.updateStatus(selfChian.length , levels.minLevel , levels.maxLevel);
						}
						else
						{
							chain.hasPlayer = false;
							chain.updateStatus();
						}
					}
				}
			}
		}
		
		
		
		
		/**
		 * 显示/隐藏防御链网格
		 * */
		public function show(camp:int , visible:Boolean):void
		{
			var panel:SpriteItem = chainPanels[camp];
			if(isShow[camp] == true && visible == true)
			{
				panel.visible = true;
			}
			else
			{
				panel.visible = false;
			}
		}
		
		
		
		
		/**
		 * 隐藏
		 * */
		/*public function hide(camp:int):void
		{
			var panel:SpriteItem = chainPanels[camp];
			if(panel.visible == true)
			{
				TweenMax.to(panel , 0.2 , {alpha:0 , onComplete:over});
				
				function over():void
				{
					//panel.alpha = 1;
					panel.visible = false;
				}
			}
		}*/
		
		
		
		
		
		/**
		 * 更新防御链
		 * */
		public function update(newChains:Array):void
		{
			var dataCenter:BattleDataCenter = BattleDataCenter.instance;
			var grid1:BattleGrid = dataCenter.grid1;
			var grid2:BattleGrid = dataCenter.grid2;
			var chain:BattleChain;
			var player:BPlayer;
			var levels:Object;
			
			// 先隐藏将死亡角色的防御链
			this.reset();
			
			// 此次产生防御链变化的角色
			var players:Array = [];
			for(var i:int=0;i<newChains.length;i++)
			{
				var newChain:GS_DefenseChain_Pro = newChains[i];
				player = dataCenter.getPlayer(newChain.tempID);
				if(player && players.indexOf(player) < 0)
				{
					// 更新该角色的防御链
					player.selfChain = newChain;
					players.push(player);
				}
			}
			
			//防御链最高等级
			var levels1:Object = grid1.getChainLevels();
			var levels2:Object = grid2.getChainLevels();
			
			// 防御链碎裂及属性变化
			for(i=0;i<players.length;i++)
			{
				player = players[i];
				// 天使不参与防御链计算
				if(player.isAngel == false)
				{
					var selfChain:GS_DefenseChain_Pro = player.selfChain;
					
					// 更新防御链组件
					chain = player.camp == 1 ? chains1[player.pos] : chains2[player.pos];
					levels = player.camp == 1 ? levels1 : levels2;
					if(chain)
					{
						// 格子上的角色仍然存活
						if(chain.hasPlayer == true)
						{
							chain.updateStatus(selfChain.length , levels.minLevel , levels.maxLevel);
						}
						else
						{
							// 碎裂
						}
						
						if(selfChain.property)
						{
							// 属性变化
						}
					}
				}
			}
		}
		
		
		
		
		
		/**
		 * 闪光
		 * */
		public function flash(camp:int):void
		{
			if(camp == 1)
			{
				// 阵型1的流光
				this.singleFlash(0 , chains1 , SEQ1);
			}
			else if(camp == 2)
			{
				// 阵型2的流光
				this.singleFlash(0 , chains2 , SEQ2);
			}
		}
		
		
		
		
		
		// 单次流光
		private function singleFlash(idx:int , chains:Dictionary , seq:Array):void
		{
			/*if(idx < seq.length)
			{
				var x:int;
				var pos:int;
				var chain:BattleChain;
				
				var arr:Array = seq[idx];
				for(x=0;x<arr.length;x++)
				{
					pos = arr[x];
					// 找到对应位置的框
					chain = chains[pos];
					if(chain.focus == true)
					{
						chain.flash();
					}
				}
				idx++;
				
				setTimeout(this.singleFlash , flashDelay , idx , chains , seq);
			}*/
		}
		
		
		
		
		
		/**
		 * 晶格受击
		 * */
		public function chainAttack(player:BPlayer , chainUaType:String):void
		{
			// 防御链晶格受击类型
			if(chainUaType != null && chainUaType != "")
			{
				var type:String = chainUaType;
				// 若为身后溅射,则需要判断方向
				if(type == "3")
				{
					type += "_" + player.camp;
				}
				
				var resource:MovieClip = BattleSkin.CHAIN_UA_ITEMS[type];
				var movie:MovieItem = new MovieItem(resource);
				movie.frameRate = 24/BattleDataCenter.instance.playSpeed;//播放速度系数
				movie.x = player.x;
				movie.y = player.y;
				movie.play(false , over);
				uaPanel.addChild(movie);
				
				// 播放完毕
				function over():void
				{
					if(movie)
					{
						if(uaPanel.contains(movie) == true)
						{
							uaPanel.removeChild(movie);
						}
						movie.renderSource = null;
					}
				}
			}
		}
		
		
		
		
		
		/**
		 * 布局
		 * */
		public function resize():void
		{
			// 遍历双方角色
			var dataCenter:BattleDataCenter = BattleDataCenter.instance;
			var grid1:BattleGrid = dataCenter.grid1;
			var grid2:BattleGrid = dataCenter.grid2;
			
			var chain:BattleChain;
			var ps:Array = grid1.CAMP_POS_S;
			var pos:Vector2D;
			
			for each(chain in chains1)
			{
				pos = ps[chain.pos - 1];
				pos = pos.add(grid1.offset);
				chain.x = pos.x;
				chain.y = pos.y;
			}
			
			// 背景1位置
			if(bg1)
			{
				var pos1:Vector2D = ps[6].add(grid1.offset);
				bg1.x = pos1.x - (177);
				bg1.y = pos1.y - (86);
			}
			
			ps = grid2.CAMP_POS_S;
			for each(chain in chains2)
			{
				pos = ps[chain.pos - 1];
				pos = pos.add(grid2.offset);
				chain.x = pos.x;
				chain.y = pos.y;
			}
			
			// 背景2位置
			if(bg2)
			{
				var pos2:Vector2D = ps[6].add(grid2.offset);
				bg2.x = pos2.x - (177);
				bg2.y = pos2.y - (86);
			}
		}
		
		
		
		
		
		/**
		 * 将死亡角色的防御链隐藏
		 * */
		public function reset():void
		{
			var dataCenter:BattleDataCenter = BattleDataCenter.instance;
			var player:BPlayer;
			var chain:BattleChain;
			var chains:Dictionary;
			var list:Array = dataCenter.allPlayers;
			for(var i:int=0;i<list.length;i++)
			{
				player = list[i];
				// 将死亡角色的防御链隐藏
				if(player.alive == false)
				{
					chains = player.camp == 1 ? chains1 : chains2;
					chain = chains[player.pos];
					if(chain)
					{
						chain.hasPlayer = false;
						chain.updateStatus();
					}
				}
			}
		}
		
		
		
		
		
		/**
		 * 清空
		 * */
		public function clear():void
		{
			// 清空防御链
			var chain:BattleChain;
			for each(chain in chains1)
			{
				chain.clear();
			}
			for each(chain in chains2)
			{
				chain.clear();
			}
			chains1 = new Dictionary();
			chains2 = new Dictionary();
			
			var panel:SpriteItem = chainPanels[1];
			panel.removeChildren();
			panel = chainPanels[2];
			panel.removeChildren();
			
			uaPanel.removeChildren();
			
			isShow[1] = true;
			isShow[2] = true;
		}
		
	}
}