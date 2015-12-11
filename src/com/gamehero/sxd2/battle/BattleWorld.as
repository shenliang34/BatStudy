package com.gamehero.sxd2.battle
{
	import com.gamehero.sxd2.battle.data.BattleConfig;
	import com.gamehero.sxd2.battle.data.BattleDataCenter;
	import com.gamehero.sxd2.battle.data.BattleGrid;
	import com.gamehero.sxd2.battle.data.BattleMoveData;
	import com.gamehero.sxd2.battle.display.BBlack;
	import com.gamehero.sxd2.battle.display.BPlayer;
	import com.gamehero.sxd2.battle.display.BattleFigureItem;
	import com.gamehero.sxd2.battle.layer.BattleEfCanvas;
	import com.gamehero.sxd2.battle.layer.BattleEfLayer;
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.event.BattleTipsEvent;
	import com.gamehero.sxd2.event.BattleWorldEvent;
	import com.gamehero.sxd2.manager.BattleUnitManager;
	import com.gamehero.sxd2.manager.HeroManager;
	import com.gamehero.sxd2.manager.MonsterLeaderManager;
	import com.gamehero.sxd2.manager.MonsterManager;
	import com.gamehero.sxd2.manager.SkillEfManager;
	import com.gamehero.sxd2.pro.PRO_BattlePlayer;
	import com.gamehero.sxd2.pro.PRO_BattlePlayerType;
	import com.gamehero.sxd2.pro.PRO_PlayerBase;
	import com.gamehero.sxd2.vo.BattleSkill;
	import com.gamehero.sxd2.vo.BattleSkillEf;
	import com.gamehero.sxd2.vo.HeroVO;
	import com.gamehero.sxd2.vo.MonsterLeaderVO;
	import com.gamehero.sxd2.vo.MonsterVO;
	import com.gamehero.sxd2.world.display.data.GameRenderCenter;
	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilter;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.system.System;
	import flash.utils.setTimeout;
	
	import bowser.iso.display.IsoWorld;
	import bowser.loader.BulkLoaderSingleton;
	import bowser.render.display.DisplayItem;
	import bowser.render.display.RenderItem;
	import bowser.render.display.SpriteItem;
	import bowser.utils.data.Vector2D;
	import bowser.utils.effect.FilterEffect;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	
	
	
	
	/**
	 * 战斗渲染舞台
	 * @author xuwenyi
	 * @create 2013-07-08
	 **/
	public class BattleWorld extends IsoWorld
	{
		// 背景图URL
		private var bgURL:String;
		// 存放人物对象的容器
		private var worldLayer:SpriteItem;
		// 背景图
		private var bg:RenderItem;
		// 变黑效果组件
		private var black:BBlack;
		
		// 前一次鼠标选中的角色
		private var lastFocus:BPlayer;
		
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function BattleWorld(canvas:Sprite, width:Number, height:Number, transparent:Boolean=true)
		{
			super(canvas, width, height, transparent , 30);
			
			// 地面效果层
			var layer:BattleEfLayer = BattleEfLayer.instance;
			this.addChild(layer.groundLayer);
			
			// 人物层
			worldLayer = new SpriteItem();
			this.addChild(worldLayer);
			
			// 空中效果层
			this.addChild(layer.airLayer);
		}
		
		
		
		
		/**
		 * 加载战斗地图
		 * */
		public function loadBattleWorld():void
		{
			var battleID:int = BattleDataCenter.instance.battleID;
			var mapid:String = BattleUnitManager.inst.getMapID(battleID);
			var loader:BulkLoaderSingleton = BattleDataCenter.instance.loader;
			// 加载背景
			bgURL = GameConfig.BATTLE_URL + "maps/" + mapid + ".swf";
			loader.addWithListener(bgURL , null , onMapLoaded);
		}
		
		
		
		
		
		/**
		 * 战斗地图加载完成
		 * */
		private function onMapLoaded(e:Event):void
		{
			var imageItem:ImageItem = e.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE , onMapLoaded);
			
			var PNGDataClass:Class = imageItem.getDefinitionByName("PNGData") as Class;
			var png:BitmapData = new PNGDataClass();
			if(bg)
			{
				bg.renderSource = null;
				if(this.contains(bg) == true)
				{
					this.removeChild(bg);
				}
			}
			
			bg = new RenderItem(true);
			bg.renderSource = png;
			this.addChild(bg);
			// 场景尺寸
			this.resize(width , height);
		}
		
		
		
		
		
		/**
		 * 加载战斗玩家及怪物信息
		 * @param camp1 本方队员
		 * @param camp2 对方队员
		 * */
		public function loadBattlePlayer():void
		{
			var dataCenter:BattleDataCenter = BattleDataCenter.instance;
			// 批量加载人物图形数据
			var list:Array = dataCenter.allPlayers;
			// 批量加载
			for(var i:int=0;i<list.length;i++)
			{
				var player:BPlayer = list[i];
				// 若此角色已经在场景中了，则跳过
				if(worldLayer.contains(player) == true)
				{
					continue;
				}
				
				var role:PRO_BattlePlayer = player.role;
				var base:PRO_PlayerBase = role.base;
				var id:String = base.id.toString();
				var url:String = "";
				var needLoad:Boolean = true;
				
				// 主角
				if(role.playerType == PRO_BattlePlayerType.PLAYER)
				{
					url = BattleConfig.LEADER_FIGURE_URL;
					player.name = base.name;
					player.quality = 4;
					player.figureHeight = 120;
				}
				// 伙伴
				else if(role.playerType == PRO_BattlePlayerType.HERO)
				{
					var heroVO:HeroVO = HeroManager.instance.getHeroByID(id);
					url = GameConfig.BATTLE_FIGURE_URL + heroVO.url;
					player.name = heroVO.name;
					player.quality = int(heroVO.quality);
					player.figureHeight = int(heroVO.height);
				}
				// 怪物
				else if(role.playerType == PRO_BattlePlayerType.MONSTER)
				{
					var monsterVO:MonsterVO = MonsterManager.instance.getMonsterByID(id);
					url = GameConfig.BATTLE_FIGURE_URL + monsterVO.figureURL;
					player.name = monsterVO.monsterName;
					player.quality = 0;
					player.figureWidth = int(monsterVO.width);
					player.figureHeight = int(monsterVO.height);
					player.isSkillMove = monsterVO.isSkillMove != "" ? false : true;
				}
				// 怪物领袖
				else if(role.playerType == PRO_BattlePlayerType.MONSTER_OWNER)
				{
					var monsterLeader:MonsterLeaderVO = MonsterLeaderManager.inst.getLeader(id);
					player.name = monsterLeader.name;
					player.quality = 0;
					
					if(monsterLeader.url != "")
					{
						url = GameConfig.BATTLE_FIGURE_URL + monsterLeader.url;
					}
					else
					{
						needLoad = false;
					}
				}
				
				if(needLoad == true)
				{
					player.setAvatar(url);// 加载人物素材
					// 状态
					player.setBuff(role.buffs);
					player.updateStatus();
					
					// 加载技能效果
					var skills:Array = player.skills.toArray();
					for(var j:int=0;j<skills.length;j++)
					{
						var skill:BattleSkill = skills[j];
						var efs:Vector.<BattleSkillEf> = skill.efs;
						for(var k:int=0;k<efs.length;k++)
						{
							var skillEf:BattleSkillEf = efs[k];
							if(skillEf.efSE != "")
							{
								this.loadData(skillEf.getSeURL() , player.camp);
							}
							if(skillEf.efUA != "")
							{
								this.loadData(skillEf.getUaURL() , player.camp);
							}
							if(skillEf.efSUA != "")
							{
								this.loadData(skillEf.getSUaURL() , player.camp);
							}
							if(skillEf.efSK != "")
							{
								this.loadData(skillEf.getSkURL() , player.camp);
							}
						}
					}
					
					// 添加到场景中
					worldLayer.addChild(player);
				}
				else
				{
					// 移除该人物
					if(player.camp == 1)
					{
						dataCenter.grid1.removePlayer(player);
					}
					else
					{
						dataCenter.grid2.removePlayer(player);
					}
				}
			}
			
			// 加载人物特效资源
			//this.loadData(BattleConfig.JUQI);// 聚气
			this.loadData(BattleConfig.PRE_ATK);// 攻击预判
			this.loadData(BattleConfig.PARRY);// 格挡
			this.loadData(BattleConfig.PENETRATION);// 穿透
			this.loadData(BattleConfig.DEATH_PARTICLE);// 死亡粒子特效
			this.loadData(BattleConfig.DEATH_MASK);// 死亡火星蒙板
			this.loadData(BattleConfig.SOUL);// 命魂
			this.loadData(BattleConfig.LEADER_CLOUD1);// 主角云
			this.loadData(BattleConfig.LEADER_CLOUD2);// 主角云阴影
			
			// 角色站位
			this.updatePlayerPos();
			
			// 鼠标移动事件
			_canvas.addEventListener(MouseEvent.MOUSE_MOVE, onCanvasMouseMove);
		}
		
		
		
		
		
		
		
		/**
		 * 显示/隐藏 相应站位方的伙伴
		 * */
		public function showHeros(camp:int , visible:Boolean):void
		{
			var player:BPlayer;
			var dataCenter:BattleDataCenter = BattleDataCenter.instance;
			var grid:BattleGrid = camp == 1 ? dataCenter.grid1 : dataCenter.grid2;
			var childs:Array = grid.playerList.toArray();
			for(var i:int=0;i<childs.length;i++)
			{
				player = childs[i] as BPlayer;
				if(player.alive == true && player.isHero == true)
				{
					player.visible = visible;
				}
			}
		}
		
		
		
		
		
		
		/**
		 * 显示/隐藏 主角
		 * */
		public function showLeader(camp:int , visible:Boolean):void
		{
			var player:BPlayer;
			var dataCenter:BattleDataCenter = BattleDataCenter.instance;
			var leaders:Array = dataCenter.leaders;
			for(var i:int=0;i<leaders.length;i++)
			{
				var leader:BPlayer = leaders[i];
				if(leader.camp == camp)
				{
					leader.visible = visible;
				}
			}
		}
		
		
		
		
		
		
		/**
		 * 移除指定阵营的角色
		 * */
		public function removePlayers(camp:int):void
		{
			var player:BPlayer;
			var dataCenter:BattleDataCenter = BattleDataCenter.instance;
			var gird:BattleGrid = camp == 1 ? dataCenter.grid1 : dataCenter.grid2;
			var childs:Array = gird.playerList.toArray();
			for(var i:int=0;i<childs.length;i++)
			{
				player = childs[i] as BPlayer;
				if(worldLayer.contains(player) == true)
				{
					worldLayer.removeChild(player);
				}
			}
		}
		
		
		
		
		
		
		/**
		 * 鼠标移动事件
		 * */
		private function onCanvasMouseMove(e:MouseEvent):void
		{	
			var player:BPlayer;
			var childs:Array = BattleDataCenter.instance.allPlayers;
			
			var mouseTarget:BPlayer;
			for(var i:int=0;i<childs.length;i++)
			{
				player = childs[i] as BPlayer;
				var avatar:BattleFigureItem = player.avatar;
				if(avatar && avatar.drawRectangle.contains(e.localX, e.localY) == true)
				{
					mouseTarget = player;
					break;
				}
			}
			
			// 若没有选中角色
			if(mouseTarget == null)
			{
				// 前一次有,现在没有
				if(lastFocus != null)
				{
					// 关闭tips
					this.dispatchEvent(new BattleTipsEvent(BattleTipsEvent.CLOSE));
					//trace("close");
				}
				// 2次都没有
				else
				{
					//trace("no");
				}
			}
			else
			{
				// 之前没有选中过角色
				if(lastFocus == null)
				{
					// 产生tips
					this.dispatchEvent(new BattleTipsEvent(BattleTipsEvent.OPEN , mouseTarget));
					//trace("open");
				}
				else
				{
					// 选中角色有改变
					if(lastFocus != mouseTarget)
					{
						// 产生tips
						this.dispatchEvent(new BattleTipsEvent(BattleTipsEvent.OPEN , mouseTarget));
						//trace("open");
					}
					// 前后选中的是同一个对象
					else
					{
						// tips位置改变
						this.dispatchEvent(new BattleTipsEvent(BattleTipsEvent.UPDATE , mouseTarget));
						//trace("update");
					}
				}
			}
			// 保存
			lastFocus = mouseTarget;
			
		}
		
		
		
		
		
		
		
		/** =================================================================================================*/
		
		
		
		
		/**
		 * 往返移动
		 * @param isReturn 是否需要返回原地
		 * */
		public function move(moveData:BattleMoveData , isReturn:Boolean):void
		{
			var target:BPlayer = moveData.target;
			var avatar:RenderItem = target.avatar;
			var from:Vector2D = moveData.from;
			var to:Vector2D = moveData.to;
			var moveType:int = moveData.moveType;
			var duration:Number = moveData.duration;// 跑动持续时间
			var delay:Number = moveData.delay;// 跑动后在目标点等待的时间 (秒)
			
			if(moveType == 1)
			{
				// 跑动
				TweenMax.fromTo(target , duration , {x:from.x , y:from.y} , {x:to.x , y:to.y , ease:Cubic.easeInOut , onComplete:complete1});
			}
			else
			{
				// 跳跃
				var midPoint:Vector2D = to.getMidpoint(from);
				var verticalLine:Vector2D = midPoint.clone();
				verticalLine.angle += Math.PI*0.5;
				verticalLine.length = 80;
				var jumpPoint:Vector2D = midPoint.subtract(verticalLine);// 计算出跳跃最高点
				
				var bezier:Point = new Point(jumpPoint.x , jumpPoint.y);// 贝塞尔曲线
				var toPoint:Point = new Point(to.x , to.y);
				TweenMax.fromTo(target , duration , {x:from.x , y:from.y} , {bezier:{values:[bezier,toPoint]} , ease:Cubic.easeInOut , onComplete:complete1});
			}
			
			// 往返透明
			FilterEffect.instance.alpha(target , duration , 1 , 0);
			
			// 添加滤镜
			var filters:Vector.<BitmapFilter> = new Vector.<BitmapFilter>();
			filters.push(new BlurFilter(8,8,2));
			avatar.filters = filters;
			
			// 初次移动完成
			function complete1():void
			{
				sortZ();
				// 清除滤镜
				avatar.filters = null;
				// 发送抵达事件
				dispatchEvent(new BattleWorldEvent(BattleWorldEvent.PLAYER_MOVE_ARRIVE , moveData));
				
				if(isReturn == true)
				{
					// 停顿一段时间后返回原位置
					TweenMax.fromTo(target , duration , {x:to.x , y:to.y} , {x:from.x , y:from.y , delay:delay , onStart:start , ease:Cubic.easeInOut , onComplete:complete2});
				}
				else
				{
					// 待在原地不返回了
					setTimeout(complete2 , delay*1000);
				}
			}
			
			// 开始返回原位置
			function start():void
			{
				// 添加模糊滤镜
				avatar.filters = filters;
				// 发送返回事件
				dispatchEvent(new BattleWorldEvent(BattleWorldEvent.PLAYER_MOVE_BACK , moveData));
				// 往返透明
				FilterEffect.instance.alpha(target , duration , 1 , 0);
			}
			
			// 返回原位置完成
			function complete2():void
			{
				// 清除滤镜
				avatar.filters = null;
				// 发送抵达事件
				dispatchEvent(new BattleWorldEvent(BattleWorldEvent.PLAYER_MOVE_COMPLETE , moveData));
				
				sortZ();
			}
		}
		
		
		
		
		
		
		/**
		 * 主角释放撒豆成兵
		 * */
		public function openingMove():void
		{
			var leader:BPlayer;
			var heros:Array = [];
			
			// 找出伙伴
			var list:Array = BattleDataCenter.instance.allPlayers;
			for(var i:int=0;i<list.length;i++)
			{
				var p:BPlayer = list[i];
				if(p.isHero == true)
				{
					heros.push(p);
				}
			}
			
			// 主角释放撒豆成兵
			var leaders:Array = BattleDataCenter.instance.leaders;
			var skillEf:BattleSkillEf = SkillEfManager.instance.getEffects(["999999"])[0];
			for(i=0;i<leaders.length;i++)
			{
				leader = leaders[i];
				leader.y += 180;
				leader.visible = true;
				BattleEfCanvas.instance.playSwfSE(skillEf , leader);
				leader.attack(skillEf);
			}
			setTimeout(showCloud , 1200);
			
			// 伙伴渐显
			for(i=0;i<heros.length;i++)
			{
				var hero:BPlayer = heros[i];
				var effectID:String;
				
				switch(hero.pos)
				{
					case 1:
					case 2:
					case 3:
						effectID = "1000002";
						break;
					
					case 4:
					case 5:
					case 6:
						effectID = "1000001";
						break;
					
					case 7:
					case 8:
					case 9:
						effectID = "1000000";
						break;
				}
				skillEf = SkillEfManager.instance.getEffects([effectID])[0];
				BattleEfCanvas.instance.playSwfSE(skillEf , hero);
				
				setTimeout(showHero , skillEf.seDelay + 416 , hero);//延迟10帧伙伴出现
			}
			
			// 特效播放完后显示伙伴
			function showHero(hero:BPlayer):void
			{
				hero.visible = true;
				hero.changeColorMatrix(hero.avatar , BPlayer.OPENING_FILTERS);
			}
			
			// 主角腾云
			function showCloud():void
			{
				for(i=0;i<leaders.length;i++)
				{
					leader = leaders[i];
					// 主角腾云驾雾
					leader.playCloud();
				}
			}
		}
		
		
		
		
		
		
		/**
		 * 自适应(根据屏幕大小同比拉伸战场)
		 * */
		override public function resize(width:Number, height:Number):void
		{
			// 定位背景图位置
			var ww:int = BattleView.MAX_WIDTH;
			var hh:int = BattleView.MAX_HEIGHT;
			
			// 计算出最终偏移量
			var xx:int = (width - ww)>>1;
			var yy:int = (height - hh)>>1;
			
			bg.x = xx;
			bg.y = yy;
			
			// 调整角色站位
			worldLayer.x = xx;
			worldLayer.y = yy;
			
			// 调整特效层位置
			var layer:BattleEfLayer = BattleEfLayer.instance;
			layer.airLayer.x = xx;
			layer.airLayer.y = yy;
			
			layer.groundLayer.x = xx;
			layer.groundLayer.y = yy;
			
			super.resize(width , height);
		}
		
		
		
		
		
		/**
		 * 更新角色的位置
		 * @param width 战斗场景宽度
		 * @param height 战斗场景高度
		 * */
		public function updatePlayerPos():void
		{	
			var dataCenter:BattleDataCenter = BattleDataCenter.instance;
			var list:Array = dataCenter.allPlayers;
			
			var player:BPlayer;
			var POS1:Array = dataCenter.grid1.CAMP_POS_S;
			var POS2:Array = dataCenter.grid2.CAMP_POS_S;
			
			for(var i:int=0;i<list.length;i++)
			{
				player = list[i];
				var pos:int = player.pos - 1;
				if(pos >= 0)
				{
					var point:Vector2D = player.camp == 1 ? POS1[pos] : POS2[pos];
					player.position = point.clone();
					player.x = point.x;
					player.y = point.y;
				}
			}
			
			sortZ();
		}
		
		
		
		
		
		/** ============================↓防御链部分==============================*/
		
		
		
		
		
		
		
		
		
		/** ============================↑防御链部分==============================*/
		
		
		
		
		/**
		 * 启动黑屏
		 * */
		public function playBlack(players:Array , skillEf:BattleSkillEf):void
		{
			// 存在黑屏
			if(skillEf.blackDelay != "")
			{
				var delay:Number = int(skillEf.blackDelay);
				delay *= BattleDataCenter.instance.playSpeed;//播放速度系数
				// 延迟触发
				setTimeout(triggerBlack , delay , players , skillEf);
			}
		}
		
		
		
		
		
		
		/**
		 * 触发黑屏
		 * */
		private function triggerBlack(players:Array , skillEf:BattleSkillEf):void
		{
			var playSpeed:Number = BattleDataCenter.instance.playSpeed;//播放速度系数
			// 持续时间
			var duration1:Number = skillEf.blackDuration1 != 0 ? skillEf.blackDuration1 : 1000;
			duration1 *= 0.001*playSpeed;
			var duration2:Number = skillEf.blackDuration2 != 0 ? skillEf.blackDuration2 : 240;
			duration2 *= 0.001*playSpeed;
			var duration3:Number = 0.15*playSpeed;
			
			// 创建黑屏组件
			if(black == null)
			{
				black = new BBlack(BattleView.MAX_WIDTH , BattleView.MAX_HEIGHT);
				black.addEventListener(BattleWorldEvent.SCREEN_BLACK_COMPLETE , clearBlack);
			}
			black.clear();
			black.play(duration1 , duration2 , duration3);
			worldLayer.addChild(black);
			
			// 先隐藏所有角色
			var i:int=0;
			var player:BPlayer;
			var allplayers:Array = BattleDataCenter.instance.allPlayers;
			for(i=0;i<allplayers.length;i++)
			{
				player = allplayers[i];
				player.visible = false;
			}
			
			// 调整深度并显示相关角色
			var idx:int = worldLayer.numChildren-1;
			if(idx > 1)
			{
				var len:int = players.length;
				for(i=0;i<len;i++)
				{
					player = players[i];
					player.visible = true;
					worldLayer.setChildIndex(player , idx-i);
				}
				worldLayer.setChildIndex(black , idx-len);
			}
			
			// 重新深度排序
			this.sortZ();
		}
		
		
		
		
		
		
		/**
		 * 黑屏结束
		 * */
		public function clearBlack(e:BattleWorldEvent = null):void
		{
			if(black != null)
			{
				black.removeEventListener(BattleWorldEvent.SCREEN_BLACK_COMPLETE , clearBlack);
				
				if(worldLayer.contains(black) == true)
				{
					worldLayer.removeChild(black);
					
					// 重新深度排序
					this.sortZ();
				}
				
				black.clear();
				black = null;
				
				// 恢复显示所有角色
				var i:int=0;
				var player:BPlayer;
				var allplayers:Array = BattleDataCenter.instance.allPlayers;
				for(i=0;i<allplayers.length;i++)
				{
					player = allplayers[i];
					player.visible = true;
				}
			}
		}
		
		
		
		
		
		
		
		
		/**
		 * 角色深度排序
		 */
		private function sortZ():void
		{	
			worldLayer.childs.sort(compareRoleItems);
			worldLayer.isNeedRender = true;
		}
		
		
		
		
		/**
		 * 深度排序函数 
		 */
		private function compareRoleItems(item1:DisplayItem, item2:DisplayItem):Number
		{	
			return item1.y > item2.y ? 1 : -1;
		}
		
		
		
		
		
		/**
		 * 加载资源
		 * */
		private function loadData(url:String , camp:int = 0 , clearMemory:Boolean = true):void
		{
			var dataCenter:BattleDataCenter = BattleDataCenter.instance;
			var loader:BulkLoaderSingleton = dataCenter.loader;
			
			// 序列帧动画
			if(url.indexOf("png_") >= 0)
			{
				// 开始加载
				var renderCenter:GameRenderCenter = GameRenderCenter.instance;
				
				renderCenter.loadData(url , clearMemory , loader);
				// 保存url
				dataCenter.addResource(url , camp);
			}
			// swf动画
			else
			{
				loader.addWithListener(url);
			}
		}
		
		
		
		
		
		/**
		 * 清空场景数据
		 * */
		public function clear():void
		{
			lastFocus = null;
			_canvas.removeEventListener(MouseEvent.MOUSE_MOVE, onCanvasMouseMove);
			
			// 清空地图资源缓存
			var loader:BulkLoaderSingleton = BattleDataCenter.instance.loader;
			loader.remove(bgURL , true);
			
			// 清空角色层
			worldLayer.removeChildren();
			worldLayer.gc();
			
			// 清空防御链层
			//this.clearBattleChain();
			
			// 清空效果层
			var efLayer:BattleEfLayer = BattleEfLayer.instance;
			efLayer.clear();
			
			// 移除背景图
			if(bg)
			{
				if(this.contains(bg) == true)
				{
					this.removeChild(bg);
				}
				bg.renderSource = null;
			}
			bg = null;
			
			// 移除变黑效果
			this.clearBlack();
			
			// 去除残留图像
			if(renderer)
			{
				renderer.gc();
			}
			
			System.gc();
		}
		
	}
}