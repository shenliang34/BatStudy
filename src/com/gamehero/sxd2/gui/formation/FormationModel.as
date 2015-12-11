package com.gamehero.sxd2.gui.formation
{
	
	import com.gamehero.sxd2.manager.HeroManager;
	import com.gamehero.sxd2.pro.PRO_Formation;
	import com.gamehero.sxd2.pro.PRO_Hero;
	import com.gamehero.sxd2.vo.HeroFateVo;
	import com.gamehero.sxd2.vo.HeroVO;
	import com.gamehero.sxd2.world.display.data.GameRenderCenter;
	import com.netease.protobuf.UInt64;
	
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;

	/**
	 * @author Wbin
	 * 创建时间：2015-8-21 下午5:40:27
	 * 
	 */
	public class FormationModel
	{
		private static var _instance:FormationModel;
		/**全局量*/
		public var domain:ApplicationDomain;
		/**后端过来的伙伴数据*/
		public var heroList:Array;
		/**后端过来的当前阵型数据*/
		public var heroFormation:PRO_Formation;
		/**后端过来的已激活阵型*/
		public var formationList:Array;
		
		/**保存上一次布阵信息*/
		public var lastFormation:PRO_Formation;
		
		// 保存所有伙伴动画资源url,在阵容面板关闭时会清空
		private var resources:Array = [];
		
		/**
		 * 伙伴显示筛选
		 * */
		public var newHeroList:Array;
		
		// 当前是否拖拽状态
		public var isDraging:Boolean = false;
		//布阵灰态处理外部点击不可相应
		public var battleGray:Boolean = false;
		//羁绊灰态处理外部点击不可相应
		public var fetterGray:Boolean = false;
		
		/**当前选中阵型ID*/
		public var currentFormationId:int;
		/**当前已开启阵型数量*/
		public var currentFormationNum:int = 0;
		
		public var headIconDic:Dictionary  = new Dictionary();
		
		//1-5号位置上伙伴信息
		public var inBattleHero:Array = [];
		/**
		 * 天缘ing
		 * */
		public var isDetail:Boolean = false;
		
		/**
		 * 伙伴上下阵的时候信息交换
		 * */
		public var oneFormationDic:Dictionary = new Dictionary();
	
		public function FormationModel()
		{
		}
		
		
		
		public static function get inst():FormationModel
		{
			return _instance ||= new FormationModel();
		}
		
		/**伙伴背包排序*/
		public function sortHeroList(heroAry:Array):Array
		{
			var heroList:Array = new Array();
			
			//助阵的伙伴
			var helpBattleList:Array = new Array();
			//上阵的伙伴
			var inBattleList:Array = new Array();
			//非上阵的伙伴列表
			var outBattleList:Array = new Array();
			
			for(var i:int = 0;i<heroAry.length;i++)
			{
				var heroPro:PRO_Hero = heroAry[i];
				if(heroPro && this.checkHeroInHelp(heroPro.base.id))
				{
					//上阵的排到末尾
					helpBattleList.push(heroPro);
				}
				else if(heroPro && this.checkHeroInBattle(heroPro.base.id))
				{
					//上阵的排到中间
					inBattleList.push(heroPro);
				}
				else
				{
					//未上阵排到队首
					outBattleList.push(heroPro);
				}
			}
			//再排序
			helpBattleList.sort(sortMethod);
			inBattleList.sort(sortMethod);
			outBattleList.sort(sortMethod);
			
			heroList = outBattleList.concat(inBattleList).concat(helpBattleList);
			return heroList;
		}
		
		
		/**根据唯一ID判断是否上阵*/
		public function checkHeroInBattle(id:UInt64):Boolean
		{
			if(heroList && heroFormation)
			{
				if(heroFormation.heroId_1.toString() == id.toString()||
					heroFormation.heroId_2.toString() == id.toString()||
					heroFormation.heroId_3.toString() == id.toString()||
					heroFormation.heroId_4.toString() == id.toString()||
					heroFormation.heroId_5.toString() == id.toString())
				{ 
					return true;
				}
			}
			return false;
		}
		
		/**根据唯一ID判断是否助阵*/
		public function checkHeroInHelp(id:UInt64):Boolean
		{
			if(heroList && heroFormation)
			{
				if(heroFormation.heroId_6.toString() == id.toString()||
					heroFormation.heroId_7.toString() == id.toString()||
					heroFormation.heroId_8.toString() == id.toString()||
					heroFormation.heroId_9.toString() == id.toString()||
					heroFormation.heroId_10.toString() == id.toString()||
					heroFormation.heroId_11.toString() == id.toString())
				{ 
					return true;
				}
			}
			return false;
		}
		
		
		/**
		 * 通过伙伴唯一id获取伙伴数据
		 * */
		public function getHeroInfo(id:UInt64):PRO_Hero
		{
			for(var i:int = 0;i<heroList.length;i++)
			{
				var info:PRO_Hero = heroList[i];
				if(info.base.id.toString() == id.toString())
				{
					return info;
				}
			}
			return null;
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
		
		
		/**
		 * 伙伴显示筛选：同名伙伴只显示一个。
		 * */
		public function passSNHero():void
		{
			this.newHeroList = new Array();
			
			var name:Array = new Array();
			var pro:PRO_Hero;
			var newPro:PRO_Hero;
			var vo:HeroVO
			var sameHeroDic:Dictionary = new Dictionary();
			for(var i:int = 0 ;i < this.heroList.length;i++)
			{
				newPro = this.heroList[i];
				vo = HeroManager.instance.getHeroByID(newPro.heroId.toString());
				
				//伙伴第一次出现
				if( null == sameHeroDic[vo.name] )
				{
					sameHeroDic[vo.name] = newPro;
					name.push(vo.name);
				}
				else 
				{
					//已有伙伴，且上阵或者助阵，默认显示上阵或者助阵伙伴
					if(this.checkHeroInBattle(newPro.base.id) || this.checkHeroInHelp(newPro.base.id))
					{
						sameHeroDic[vo.name] = newPro;
					}
					else if(!this.checkHeroInBattle(newPro.base.id))
					{
						//已有伙伴，未上阵或者助阵，显示战力高的伙伴
						pro = sameHeroDic[vo.name];
						if((pro.base.power < newPro.base.power))
						{
							sameHeroDic[vo.name] = newPro;
						}
					}
				}
			}
			
			//筛选之后的数组
			for(i = 0;i<name.length;i++)
			{
				this.newHeroList.push(sameHeroDic[name[i]]);
			}
		}
		
		
		/**
		 * 获取当前伙伴所有的羁绊数
		 * @伙伴配置id
		 * @羁绊信息
		 * */
		public function getFetterNum(id:String,fate:HeroFateVo):Array
		{
			//当前伙伴配置
			var heroInfo:HeroVO = HeroManager.instance.getHeroByID(id);
			
			//获得所有羁绊相关伙伴，不管是否获得该伙伴
			var fateList:Array = new Array();
			
			var hero:Array = [];
			if(fate)
			{
				hero = HeroManager.instance.getHeroByRace(heroInfo.race,fate.assistant_job1.toString());
				fateList = this.getAllFateHero(fateList,hero);
				hero = HeroManager.instance.getHeroByRace(heroInfo.race,fate.assistant_job2.toString());
				fateList = this.getAllFateHero(fateList,hero);
				hero = HeroManager.instance.getHeroByRace(heroInfo.race,fate.assistant_job3.toString());
				fateList = this.getAllFateHero(fateList,hero);
				hero = HeroManager.instance.getHeroByRace(heroInfo.race,fate.assistant_job4.toString());
				fateList = this.getAllFateHero(fateList,hero);
			}
			
			return fateList;
		}
		
		/**
		 * 获取背包中伙伴羁绊数，与阵上伙伴
		 * */
		public function getFetterNumInBattle(pro:PRO_Hero,fate:HeroFateVo):Array
		{
			//当前伙伴配置
			var heroInfo:HeroVO = HeroManager.instance.getHeroByID(pro.heroId.toString());
			
			//获得阵上有羁绊的伙伴
			var fateList:Array = new Array();
			
			var hero:Array = [];
			if(fate)
			{
				for(var i:int = 0 ; i < this.inBattleHero.length;i++)
				{
					var hPro:PRO_Hero = this.inBattleHero[i] as PRO_Hero;
					var hVo:HeroVO = HeroManager.instance.getHeroByID(hPro.heroId.toString());
					if(heroInfo.race == hVo.race)
					{
						if(hVo.job.toString() == fate.assistant_job1 
						 ||hVo.job.toString() == fate.assistant_job2
						 ||hVo.job.toString() == fate.assistant_job3
						 ||hVo.job.toString() == fate.assistant_job4)
						{
							fateList.push(hVo);
						}
					}
				}
			}
			
			return fateList;
		}
		
		/**
		 * @ all     要返回的所有伙伴
		 * @ jobFate 相关职业羁绊伙伴
		 */
		private function getAllFateHero(all:Array,jobFate:Array):Array
		{
			for(var i:int = 0;i<jobFate.length;i++)
			{
				var hero:HeroVO = jobFate[i];
				all.push(hero);
			}
			
			return all;
		}
		
		/**
		 * 伙伴排序：
		 * 突破等级
		 * 合击
		 * 有无
		 * 缘分数目
		 * 卡牌品质
		 * 伙伴配置id
		 * 伙伴唯一Id（获得时间早晚）
		 * */
		private function sortMethod(hPro1:PRO_Hero,hPro2:PRO_Hero):int
		{
			//伙伴基础配置
			var vo1:HeroVO = HeroManager.instance.getHeroByID(hPro1.heroId.toString());
			var vo2:HeroVO = HeroManager.instance.getHeroByID(hPro2.heroId.toString());
			//等级   暂未开发
			/*if(hPro1.lv > hPro2.lv)
			{
				return 1;
			}
			else if(hPro1.lv < hPro2.lv)
			{
				return -1;
			}*/
			
			//合击  暂未开发
			/*if(hPro1.lv > hPro2.lv)
			{
				return 1;
			}
			else if(hPro1.lv < hPro2.lv)
			{
				return -1;
			}*/
			
			
			//羁绊相关
			var heroFateInfo1:HeroFateVo = HeroManager.instance.analysisFate(int(vo1.job));
			var heroFateInfo2:HeroFateVo = HeroManager.instance.analysisFate(int(vo2.job));
			if(heroFateInfo1 && heroFateInfo2)
			{
				var fateNum1:int = this.getFetterNumInBattle(hPro1,heroFateInfo1).length;
				var fateNum2:int = this.getFetterNumInBattle(hPro2,heroFateInfo2).length;
//				var fateNum1:int = this.getFetterNum(hPro1.heroId.toString(),heroFateInfo1).length;
//				var fateNum2:int = this.getFetterNum(hPro2.heroId.toString(),heroFateInfo2).length;
			}
			if(fateNum1 < fateNum2)
			{
				return 1;
			}
			else if(fateNum1 > fateNum2)
			{
				return -1;
			}
			
			
			//伙伴品质
			if(vo1.quality < vo2.quality)
			{
				return 1;
			}
			else if(vo1.quality > vo2.quality)
			{
				return -1;
			}
			
			//伙伴id
			if(int(vo1.id) < int(vo2.id))
			{
				return 1;
			}
			else if(int(vo1.id) > int(vo2.id))
			{
				return -1;
			}
			
			//伙伴获得时间（通过ID）
			/*if(hPro1.base.id < hPro2.base.id)
			{
				return 1;
			}
			else if(hPro1.base.id > hPro2.base.id)
			{
				return -1;
			}*/
			
			return 0;
		}
		
		
		/***
		 *根据伙伴的配置ID获取伙伴信息 
		 * */
		public function getPHero(heroid:int):PRO_Hero
		{
			for each(var pro:PRO_Hero in heroList)
			{
				if(pro.heroId == heroid)
				{
					return pro;
				}
			}
			
			return null;
		}
		
		
		/**数据清除*/
		public function clear():void
		{
			for(var i:int=0;i<resources.length;i++)
			{
				GameRenderCenter.instance.clearData(resources[i]);
			}
			inBattleHero = [];
			resources = [];
			newHeroList = [];
			lastFormation = null;
			isDraging = false;
			headIconDic = new Dictionary();
		}
		
	}
}