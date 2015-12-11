package com.gamehero.sxd2.battle.display
{
	import com.gamehero.sxd2.battle.data.BattleBuff;
	import com.gamehero.sxd2.battle.data.BattleConfig;
	import com.gamehero.sxd2.battle.data.BattleDataCenter;
	import com.gamehero.sxd2.battle.layer.BattleStLayer;
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.event.RenderItemEvent;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.manager.BuffManager;
	import com.gamehero.sxd2.pro.PRO_BattleBuff;
	import com.gamehero.sxd2.pro.PRO_BattlePlayer;
	import com.gamehero.sxd2.pro.PRO_BattlePlayerType;
	import com.gamehero.sxd2.pro.PRO_PlayerBase;
	import com.gamehero.sxd2.vo.BattleSkill;
	import com.gamehero.sxd2.vo.BuffVO;
	import com.gamehero.sxd2.world.display.DefaultFigureItem;
	
	import alternativa.gui.enum.Align;
	
	import bowser.render.display.RenderItem;
	import bowser.render.display.SpriteItem;
	import bowser.render.display.TextItem;
	import bowser.utils.data.Group;
	import bowser.utils.data.Vector2D;
	
	/**
	 * 战斗场景内的角色
	 * @author xuwenyi
	 * @create 2013-06-26
	 **/
	public class BPlayer extends SpriteItem
	{	
		include "BPlayerActLogic.as";
		include "BPlayerEfLogic.as";
		
		// 全局战斗数据
		protected var dataCenter:BattleDataCenter;
		// 时间管理器
		//protected var timeTick:TimeTick;
		// 角色资源url
		public var avatarURL:String;
		// 变身资源url
		protected var transformURL:String;
		
		// 角色id
		public var tempID:int;
		// 我方还是敌方
		public var camp:int;
		public var selfCamp:int;
		// 角色名
		public var name:String;
		public var quality:int;// 品质
		
		public var isLeader:Boolean = false;// 是否是主角
		public var isPlayer:Boolean = false;// 是否是玩家
		public var isHero:Boolean = false;// 是否是伙伴
		public var isMonster:Boolean = false;// 是否是怪物
		public var isBoss:Boolean = false;// 是否是boss
		public var isMonsterLeader:Boolean = false;// 是否怪物领袖
		public var isSkillMove:Boolean = true;// 是否受壳动画影响
		
		// 是否开场显示
		public var openingVisible:Boolean = true;
		
		// 角色阵型格子上的坐标
		public var position:Vector2D;
		// 角色在阵型中所在编号
		public var pos:int;
		// 深度
		public var zIndex:int;
		// 人物宽高度
		public var figureWidth:int = 0;
		public var figureHeight:int = 0;
		
		// 角色基本数据
		public var role:PRO_BattlePlayer;
		
		// 角色avatar
		private var avatarSprite:SpriteItem;
		public var avatar:BattleFigureItem;
		// 角色类型
		public var playerType:int;
		// 角色身上的buff
		public var buffs:Array = [];
		// 该角色携带的所有BattleSkill集合
		public var skills:Group;
		// 该角色携带的绝技技能
		public var angerSkill:BattleSkill;
		// 当前使用的技能
		public var curSkill:BattleSkill;
		// 曾经使用过的技能id
		private var usedSkills:Group = new Group();
		
		// 是否在原地
		public var stillness:Boolean = true;
		// 是否已经播放过死亡效果
		private var hasDead:Boolean = false;
		private var isDisappear:Boolean = false;
		
		// 血条
		private var bloodBar:BattleRoleBloodBar;
		// 怒气
		private var angerBar:BattleRoleAngerBar;
		// 姓名栏
		private var nameField:TextItem;
		
		// 自身se空中效果
		private var seAirItem:BattleEfItem;
		// 自身se地面效果
		private var seGroundItem:BattleEfItem;
		// 受击ua空中效果
		private var uaAirItem:BattleEfItem;
		// 受击ua地面效果
		private var uaGroundItem:BattleEfItem;
		
		// 准备释放技能效果
		private var preSkillItem:BattleEfItem;
		// 聚气效果
		private var juqiItem:BattleEfItem;
		// 防御类效果--穿透格挡
		private var defenseItem:BattleEfItem;
		// 死亡效果
		private var deathParticleItem:BattleEfItem;
		private var deathMaskItem:BattleDeathItem;
		// 受击效果时的阴影
		private var uaShadowItem:RenderItem;
		// 主角云效果
		private var cloudItem:BattleEfItem;
		private var cloudShadowItem:BattleEfItem;
		
		// 状态效果层
		private var stLayer:BattleStLayer;
		
		// 受击延时后恢复到站立状态的timer
		private var hitTimerID:int;
		
		
		
		
		/**
		 * 构造函数
		 * */
		public function BPlayer()
		{
			super();
			
			dataCenter = BattleDataCenter.instance;
			
			// 剧情对话框
			//this.initBubble();
		}
		
		
		
		/**
		 * 更新avatar
		 * */
		public function setAvatar(avatarURL:String):void
		{
			playerType = role.playerType;
			
			isPlayer = playerType == PRO_BattlePlayerType.PLAYER;// 是否是玩家 
			isHero = playerType == PRO_BattlePlayerType.HERO;// 是否是伙伴
			isMonster = playerType == PRO_BattlePlayerType.MONSTER;// 是否是怪物
			isMonsterLeader = playerType == PRO_BattlePlayerType.MONSTER;// 是否怪物领袖
			
			// 自身se地面效果
			seGroundItem = new BattleEfItem();
			seGroundItem.status = BattleEfItem.SELF_GROUND;
			seGroundItem.face = this.avatarFace;
			seGroundItem.visible = false;
			this.addChild(seGroundItem);
			
			// 受击ua地面效果
			uaGroundItem = new BattleEfItem();
			uaGroundItem.status = BattleEfItem.UNDERATTACK_GROUND;
			uaGroundItem.visible = false;
			this.addChild(uaGroundItem);
			
			// 受击时的人物阴影
			uaShadowItem = new RenderItem();
			uaShadowItem.visible = false;
			this.addChild(uaShadowItem);
			
			// 角色avatar容器
			avatarSprite = new SpriteItem();
			this.addChild(avatarSprite);
			
			// 角色avatar
			var clearMemory:Boolean = true;
			avatar = new BattleFigureItem(clearMemory);
			avatar.noResourceHandleMode = true;
			avatarSprite.addChild(avatar);
			
			// 准备放技能的圈圈
			preSkillItem = new BattleEfItem();
			preSkillItem.url = BattleConfig.PRE_ATK;
			preSkillItem.status = BattleEfItem.UNDERATTACK_GROUND;
			preSkillItem.frameRate = 14;
			preSkillItem.visible = false;
			this.addChild(preSkillItem);
			
			// 死亡火星蒙板
			deathMaskItem = new BattleDeathItem();
			deathMaskItem.url = BattleConfig.DEATH_MASK;
			deathMaskItem.status = BattleEfItem.UNDERATTACK_AIR;
			//deathMaskItem.face = this.avatarFace;
			deathMaskItem.visible = false;
			this.addChild(deathMaskItem);
			
			// 死亡粒子特效
			deathParticleItem = new BattleEfItem();
			deathParticleItem.url = BattleConfig.DEATH_PARTICLE;
			deathParticleItem.status = BattleEfItem.UNDERATTACK_AIR;
			//deathParticleItem.face = this.avatarFace;
			deathParticleItem.visible = false;
			this.addChild(deathParticleItem);
			
			// 自身技能效果上层
			seAirItem = new BattleEfItem();
			seAirItem.status = BattleEfItem.SELF_AIR;
			seAirItem.face = this.avatarFace;
			seAirItem.visible = false;
			this.addChild(seAirItem);
			
			// 受击空中效果
			uaAirItem = new BattleEfItem();
			uaAirItem.status = BattleEfItem.UNDERATTACK_AIR;
			uaAirItem.visible = false;
			this.addChild(uaAirItem);
			
			// 角色buff状态层
			stLayer = new BattleStLayer(this);
			this.addChild(stLayer);
			
			// 聚气
			//juqiItem = new EffectItem();
			//juqiItem.noResourceHandleMode = true;
			//juqiItem.url = BattleConfig.JUQI;
			//juqiItem.visible = false;
			//this.addChild(juqiItem);
			
			// 防御效果(格挡穿透)
			defenseItem = new BattleEfItem();
			defenseItem.status = BattleEfItem.UNDERATTACK_AIR;
			defenseItem.face = this.avatarFace;
			defenseItem.visible = false;
			this.addChild(defenseItem);
			
			// 非玩家才有血条和名字
			// 必须是活着的人
			if(this.alive == true && isPlayer == false)
			{
				// 角色血条
				bloodBar = new BattleRoleBloodBar();
				bloodBar.x = -30;
				bloodBar.y = -(avatar.itemHeight + 13);
				bloodBar.visible = false;
				this.addChild(bloodBar);
				
				// 角色怒气
				var consumeValue:int = angerSkill == null ? 1 : angerSkill.consumeAnger;
				angerBar = new BattleRoleAngerBar(consumeValue);
				angerBar.x = bloodBar.x;
				angerBar.y = bloodBar.y + 7;
				angerBar.visible = false;
				this.addChild(angerBar);
			}
			
			// 玩家添加云动画
			if(isPlayer == true)
			{
				cloudShadowItem = new BattleEfItem();
				cloudShadowItem.url = BattleConfig.LEADER_CLOUD2;
				cloudShadowItem.status = BattleEfItem.SELF_AIR;
				cloudShadowItem.face = this.avatarFace;
				cloudShadowItem.frameRate = 18;
				cloudShadowItem.visible = false;
				this.addChild(cloudShadowItem);
				
				cloudItem = new BattleEfItem();
				cloudItem.url = BattleConfig.LEADER_CLOUD1;
				cloudItem.status = BattleEfItem.SELF_AIR;
				cloudItem.face = this.avatarFace;
				cloudItem.frameRate = 18;
				cloudItem.visible = false;
				this.addChild(cloudItem);
			}
			
			// 姓名
			nameField = new TextItem(100,15);
			nameField.y = -(avatar.itemHeight + 33);
			nameField.visible = false;
			nameField.labelFilter = Label.TEXT_FILTER;
			nameField.text = this.name;
			nameField.align = Align.CENTER;
			nameField.color = GameDictionary.getColorByQuality(quality);
			this.addChild(nameField);
			
			// 默认显示血条和怒气
			this.showBlood(true);
			
			// 默认站立动作
			this.stand();
			
			// 最后加载人物形象
			this.avatarURL = avatarURL;
			this.loadAvatar(this.avatarURL);
			
			// 冒泡
			//this.addBubble();
		}
		
		
		
		
		
		/**
		 * 加载avatar资源
		 * */
		public function loadAvatar(url:String):void
		{
			if(avatar)
			{
				// 开始加载
				avatar.addEventListener(RenderItemEvent.FIRST_RENDER , avatarFirstRender);
				avatar.addEventListener(RenderItemEvent.LOADED , avatarLoaded);
				avatar.load(url , BattleDataCenter.instance.loader);
				// 保存url
				var dataCenter:BattleDataCenter = BattleDataCenter.instance;
				dataCenter.addResource(url , camp);
			}
		}
		
		
		
		
		
		/**
		 * 角色加载完成
		 * */
		private function avatarLoaded(e:RenderItemEvent):void
		{
			avatar.removeEventListener(RenderItemEvent.LOADED , avatarLoaded);
			
			// 角色朝向
			avatar.face = camp == 1 ? DefaultFigureItem.RIGHT : DefaultFigureItem.LEFT;
			avatar.setFigureStatus(BattleFigureItem.STAND);
			
			// 技能效果朝向
			seAirItem.face = avatar.face;
			seGroundItem.face = avatar.face;
			
			//更新对话位置
			//updateGossipPostion();
		}
		
		
		
		
		
		/**
		 * 角色第一次渲染
		 * */
		private function avatarFirstRender(e:RenderItemEvent):void
		{
			avatar.removeEventListener(RenderItemEvent.FIRST_RENDER , avatarFirstRender);
			
			// 血条位置
			if(bloodBar)
			{
				// 血条
				bloodBar.y = -(this.playerHeight + 13);
				
				// 角色怒气
				angerBar.y = bloodBar.y + 7;
				
				// 姓名位置
				nameField.y = bloodBar.y - 18;
			}
		}
		
		
		
		
		/**
		 * 设置角色buff数据
		 * */
		public function setBuff(buffs:Array):void
		{
			var isStopAction:Boolean = false;
			
			var arr:Array = [];
			if(buffs && buffs.length > 0)
			{
				for(var i:int=0;i<buffs.length;i++)
				{
					var buff:BattleBuff = new BattleBuff();
					var data:PRO_BattleBuff = buffs[i];
					var vo:BuffVO = BuffManager.instance.getBuff(data.buffId+"");
					// 此BUFF需要在战斗中显示
					if(vo && vo.isHide != "1")
					{
						buff.id = data.buffId;
						buff.triggerTime = data.triggerTime;
						buff.vo = vo;
						buff.data = data;
						
						arr.push(buff);
					}
					// 是否需要播放人物待机动画
					if(vo.isStopAction == "1")
					{
						isStopAction = true;
					}
				}
			}
			this.buffs = arr;
			
			// 更新buff效果
			stLayer.update(this.buffs);
			
			// 人物是否播放待机动作
			avatar.isPlaying = !isStopAction;
		}
		
		
		
		
		
		/**
		 * 更新角色属性
		 * */
		public function updateProperty(dmg:int , addAnger:int , addVolition:int):void
		{
			var base:PRO_PlayerBase = role.base;
			// hp
			var hp:int = base.hp;
			var maxhp:int = base.maxhp;
			hp = Math.max(hp - dmg , 0);
			hp = Math.min(hp , maxhp);
			base.hp = hp;
			// anger
			var anger:int = role.anger;
			var maxAnger:int = role.maxAnger;
			anger = Math.max(anger + addAnger , 0);
			anger = Math.min(anger , maxAnger);
			role.anger = anger;
		}
		
		
		
		
		
		/**
		 * 更新角色状态
		 * */
		public function updateStatus():void
		{
			if(role)
			{
				// 更新血条
				if(bloodBar)
				{
					var base:PRO_PlayerBase = role.base;
					bloodBar.update(base.hp , base.maxhp);
				}
				// 更新怒气
				if(angerBar)
				{
					angerBar.update(role.anger , role.maxAnger);
				}
			}
		}
		
		
		
		
		
		/**
		 * 显示/隐藏血条
		 * */
		public function showBlood(value:Boolean):void
		{
			if(bloodBar)
			{
				if(value == true && this.alive == true)
				{
					bloodBar.visible = value;
				}
				else
				{
					bloodBar.visible = value;
				}
			}
			if(angerBar)
			{
				if(value == true && this.alive == true)
				{
					angerBar.visible = value;
				}
				else
				{
					angerBar.visible = value;
				}
			}
		}
		
		
		
		
		/**
		 * 显示/隐藏姓名
		 * */
		public function showName(value:Boolean):void
		{
			if(nameField)
			{
				nameField.visible = value;
			}
		}
		
		
		
		
		
		/**
		 * 保存使用过的技能
		 * */
		public function addUsedSkill(skill:BattleSkill):void
		{
			if(usedSkills.contains(skill) == false)
			{
				usedSkills.add(skill);
			}
		}
		
		
		
		
		
		
		/**
		 * 检查某技能是否使用过
		 * */
		public function checkUsedSkill(skill:BattleSkill):Boolean
		{
			return usedSkills.contains(skill);
		}
		
		
		
		
		
		/**
		 * 判断战意是否满足释放第一个技能
		 * */
		public function get canUseSkill():Boolean
		{
			if(angerSkill != null)
			{
				if(role.anger >= angerSkill.consumeAnger)
				{
					return true;
				}
			}
			return false;
		}
		
		
		
		
		
		
		/**
		 * 是否存活
		 * */
		public function get alive():Boolean
		{
			if(role && role.base && role.base.hp > 0)
			{
				return true;
			}
			return false;
		}
		
		
		
		
		
		
		
		
		/**
		 * 角色宽度
		 * */
		public function get playerWidth():int
		{
			var w:int = 0;
			// 使用配置宽度
			if(figureWidth > 0)
			{
				w = figureWidth;
			}
			// 若配置表没有值,则使用素材高度
			else
			{
				w = avatar.itemWidth;
			}
			return w;
		}
		
		
		
		
		
		
		/**
		 * 角色高度
		 * */
		public function get playerHeight():int
		{
			var h:int = 0;
			// 如果是玩家,则固定高度
			if(isPlayer == true)
			{
				/*var base:GS_RoleBase_Pro = GameData.inst.roleInfo.roleBase;
				h = BattleConfig.PLAYER_HEIGHT[base.carrer];*/
			}
			// 伙伴或怪物的高度根据配置表获取
			else
			{
				// 使用配置高度
				if(figureHeight > 0)
				{
					h = figureHeight;
				}
				// 若配置表没有值,则使用素材高度
				else
				{
					h = avatar.itemHeight;
				}
			}
			return h;
		}
		
		
		
		
		/**
		 * 渲染组件
		 * */
		public function get figureItem():RenderItem
		{
			return avatar;
		}
		
		
		
		
		/**
		 * 角色朝向
		 * */
		public function get faceAngle():Number
		{
			if(avatar.face == DefaultFigureItem.RIGHT)
			{
				return 0;
			}
			else
			{
				return Math.PI;
			}
		}
		
		
		
		
		/**
		 * 角色朝向
		 * */
		public function get avatarFace():String
		{
			return camp == 1 ? DefaultFigureItem.RIGHT : DefaultFigureItem.LEFT;
		}
		
		
		
		
		
		/**
		 * 清除显示元素
		 * */
		private function clearUI():void
		{
			if(nameField)
			{
				nameField.visible = false;
			}
			if(bloodBar)
			{
				bloodBar.visible = false;
			}
			if(angerBar)
			{
				angerBar.visible = false;
			}
			if(preSkillItem)
			{
				preSkillItem.visible = false;
				preSkillItem.stop();
				preSkillItem.clear();
			}
			
			/*juqiItem.visible = false;
			juqiItem.stop();
			juqiItem.clear();*/
			
			defenseItem.visible = false;
			defenseItem.stop();
			defenseItem.clear();
			
			seAirItem.visible = false;
			seAirItem.stop();
			seAirItem.clear();
			
			seGroundItem.visible = false;
			seGroundItem.stop();
			seGroundItem.clear();
			
			uaAirItem.visible = false;
			uaAirItem.stop();
			uaAirItem.clear();
			
			uaGroundItem.visible = false;
			uaGroundItem.stop();
			uaGroundItem.clear();
			
			stLayer.clear();
		}
		
		
		
		
		
		/**
		 * 清空回收
		 * */
		public function clear():void
		{
			this.clearUI();
			
			if(bloodBar != null)
			{
				bloodBar.clear();
			}
			if(angerBar != null)
			{
				angerBar.clear();
			}
			
			dataCenter = null;
			isLeader = false;
			isPlayer = false;
			role = null;
			buffs = null;
			skills = null;
			angerSkill = null;
			curSkill = null;
			usedSkills = null;
			stillness = true;
			hasDead = false;
			bloodBar = null;
			nameField = null;
			figureWidth = 0;
			figureHeight = 0;
			
			if(avatar)
			{
				avatar.gc();
				avatar.removeEventListener(RenderItemEvent.FIRST_RENDER , avatarFirstRender);
				avatar.removeEventListener(RenderItemEvent.LOADED , avatarLoaded);
				avatar.removeEventListener(RenderItemEvent.PLAY_COMPLETE , actOver);
				avatar.removeEventListener(RenderItemEvent.PLAY_COMPLETE , showDeadEf);
				avatar = null;
			}
			if(seAirItem)
			{
				seAirItem.gc();
				seAirItem.removeEventListener(RenderItemEvent.PLAY_COMPLETE , effectOver);
				seAirItem = null;
			}
			if(seGroundItem)
			{
				seGroundItem.gc();
				seGroundItem.removeEventListener(RenderItemEvent.PLAY_COMPLETE , effectOver);
				seGroundItem = null;
			}
			if(uaAirItem)
			{
				uaAirItem.gc();
				uaAirItem.removeEventListener(RenderItemEvent.PLAY_COMPLETE , effectOver);
				uaAirItem = null;
			}
			if(uaGroundItem)
			{
				uaGroundItem.gc();
				uaGroundItem.removeEventListener(RenderItemEvent.PLAY_COMPLETE , effectOver);
				uaGroundItem = null;
			}
			if(preSkillItem)
			{
				// 命魂需要用到,所以结束时要置为false
				preSkillItem.visible = false;
				preSkillItem.stop();
				preSkillItem.gc();
				preSkillItem = null;
			}
			/*if(juqiItem)
			{
				juqiItem.gc();
				juqiItem = null;
			}*/
			if(defenseItem)
			{
				defenseItem.removeEventListener(RenderItemEvent.PLAY_COMPLETE , effectOver);
				defenseItem.gc();
				defenseItem = null;
			}
			if(deathParticleItem)
			{
				deathParticleItem.removeEventListener(RenderItemEvent.PLAY_COMPLETE , effectOver);
				deathParticleItem.gc();
				deathParticleItem = null;
			}
			if(deathMaskItem)
			{
				deathMaskItem.removeEventListener(RenderItemEvent.PLAY_COMPLETE , effectOver);
				deathMaskItem.gc();
				deathMaskItem = null;
			}
			if(cloudItem)
			{
				cloudItem.gc();
				cloudItem = null;
			}
			if(cloudShadowItem)
			{
				cloudShadowItem.gc();
				cloudShadowItem = null;
			}
			
			this.removeChildren();
		}
		
		
	}
}