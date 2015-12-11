package com.gamehero.sxd2.gui.player.hero.model
{
	import com.gamehero.sxd2.core.SoundConfig;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.bag.model.EquipLocDict;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.gui.player.hero.HeroWindow;
	import com.gamehero.sxd2.manager.SoundManager;
	import com.gamehero.sxd2.pro.HERO_EQUIP_OPT_TYPE;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSG_HERO_PUT_ITEM;
	import com.gamehero.sxd2.pro.MSG_HREO_BATTLE_ACK;
	import com.gamehero.sxd2.pro.PRO_Hero;
	import com.gamehero.sxd2.services.GameService;
	import com.gamehero.sxd2.world.display.data.GameRenderCenter;
	import com.netease.protobuf.UInt64;
	
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	
	import bowser.remote.RemoteResponse;

	/**
	 * 伙伴数据model
	 * @author Wbin
	 * 创建时间：2015-7-29 下午3:11:53
	 * 
	 */
	public class HeroModel
	{
		private static var _instance:HeroModel;
		
		public var domain:ApplicationDomain;
		
		private var _heroInfoList:Array;//伙伴数组
		
		public var power:Dictionary = new Dictionary();//伙伴面板战力字典
		public var detailPower:Dictionary = new Dictionary();//详细信息面板战力字典
		/**
		 * 当前选中伙伴的索引 
		 */		
		public var curSelectedId:int;
		
		// 保存所有伙伴动画资源url,在阵容面板关闭时会清空
		private var resources:Array = [];
		
		public function HeroModel()
		{
		}
		
		/**上阵伙伴信息*/
		public function get heroInfoList():Array
		{
			var arr:Array = new Array();
			if(_heroInfoList == null) return arr;
			var pro:PRO_Hero;
			for(var i:int = 0; i < _heroInfoList.length; i++)
			{
				pro = _heroInfoList[i] as PRO_Hero;
				power[pro.heroId] = pro.base.power; //存入伙伴战力
				detailPower[pro.heroId] = pro.base.power;
				if(pro.index >= 1 && pro.index <= 5)//只有1 —— 5号位置为上阵伙伴
				{
					arr.push(pro);
				}
			}
			return arr;
		}
		
		/**
		 * 获取最大战力的伙伴 </br>
		 * (注意是否有上阵伙伴)
		 */		
		public function getMaxPowerHero():PRO_Hero
		{
			var heroList:Array = heroInfoList;
			heroList.sort(comparePower);
			return heroList[0] as PRO_Hero;
		}
		/**
		 * 获取完整的阵上伙伴(参战的，羁绊的)信息 
		 * @return 
		 * 
		 */		
		public function get fateHeroInfoList():Array
		{
			return _heroInfoList;
		}

		public static function get instance():HeroModel
		{
			return _instance ||= new HeroModel();
		}
		
		public function analysis(data:MSG_HREO_BATTLE_ACK):void
		{
			_heroInfoList = data.hero;
		}
		
		/**
		 * 战力排序 
		 */		
		public function heroListSort():void
		{
			_heroInfoList.sort(comparePower);
		}
		
		/**
		 * 获取需要快速穿戴的伙伴 
		 * @param loc
		 * 
		 */		
		public function getNoEquipList(loc:int):PRO_Hero
		{
			var noEquipList:Vector.<PRO_Hero> = new Vector.<PRO_Hero>();//
			var hasEquip:String;//该伙伴当前位置是否有穿装备
			for each(var heroPro:PRO_Hero in heroInfoList)//获取此部位没有装备的伙伴
			{
				switch(loc)
				{
					case EquipLocDict.LINT_JIE:
						hasEquip = heroPro.ring.toString();
						break;
					case EquipLocDict.HU_FU:
						hasEquip = heroPro.neck.toString();
						break;
					case EquipLocDict.WU_QI:
						hasEquip = heroPro.weapon.toString();
						break;
					case EquipLocDict.YU_GUAN:
						hasEquip = heroPro.head.toString();
						break;
					case EquipLocDict.YU_PAO:
						hasEquip = heroPro.cloth.toString();
						break;
					case EquipLocDict.XIE_ZI:
						hasEquip = heroPro.shoes.toString();
						break;
				}
				if(hasEquip == "0")
					noEquipList.push(heroPro);//将没有该位置装备的保存
			}
			if(noEquipList.length > 0)
			{
				noEquipList.sort(comparePower);//根据战力进行排序
				return noEquipList[0];
			}
			return null;
		}
		//战力排序
		private function comparePower(a:PRO_Hero , b:PRO_Hero):int
		{
			if(a.base.power < b.base.power)
			{
				return 1;
			}
			else if(a.base.power > b.base.power)
			{
				return -1;
			}
			else
			{
				return 0;
			}
		}
		/**
		 * 根据id获得伙伴信息 
		 * @param heroId
		 * @return 
		 * 
		 */		
		public function getHeroById(heroId:int):PRO_Hero
		{
			var hero:PRO_Hero;
			for each(var pro:PRO_Hero in _heroInfoList)
			{
				if(pro.heroId == heroId)
				{
					hero = pro;
					break;
				}
			}
			return hero;
		}
		
		//==============================通讯相关===========================
		/**
		 * @param itemId 装备id
		 * @param type 0-穿 1-脱
		 * @param id 伙伴配置id
		 */		
		public function itemHeroEquip(itemId:UInt64,type:int,id:int = -1):void
		{
			if(id == -1)
			{
				if(!WindowManager.inst.isWindowOpened(HeroWindow))
				{
					MainUI.inst.openWindow(WindowEvent.HERO_WINDOW,itemId);
					return;
				}
			}
	
			var hero:PRO_Hero = id != -1 ? getHeroById(id) : getHeroById(curSelectedId);
			if(hero)
			{
				// 发送穿戴请求
				var req:MSG_HERO_PUT_ITEM = new MSG_HERO_PUT_ITEM();
				req.id = hero.base.id;
				req.itemId = itemId;
				req.type = type;
				GameService.instance.send(MSGID.MSGID_HERO_PUT_ITEM,req,itemEquipCallBack);
				
				// 穿戴音效
				if(type == HERO_EQUIP_OPT_TYPE.HERO_EQUIP_PUT_ON)
				{
					SoundManager.inst.play(SoundConfig.EQUIP);
				}
				else
				{
					SoundManager.inst.play(SoundConfig.UNEQUIP);
				}
			}
		}
		
		/**
		 * 保存某伙伴模型资源url
		 * */
		public function addResource(url:String):void
		{
			if(resources.indexOf(url) < 0)
			{
				resources.push(url);
			}
		}
		
		private function itemEquipCallBack(r:RemoteResponse):void
		{
			if(r.errcode == "0")
			{
				trace("装备成功");
			}
		}
		
		public function clear():void
		{
			for(var i:int=0;i<resources.length;i++)
			{
				GameRenderCenter.instance.clearData(resources[i]);
			}
			power = new Dictionary();
			detailPower = new Dictionary();
		}
	}
}