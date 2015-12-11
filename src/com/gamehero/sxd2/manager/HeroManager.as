package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.vo.FateLevelVo;
	import com.gamehero.sxd2.vo.HeroFateVo;
	import com.gamehero.sxd2.vo.HeroVO;
	
	import flash.utils.Dictionary;
	
	import bowser.logging.Logger;
	import bowser.utils.GameTools;
	
	/**
	 * 伙伴配置表管理
	 * @author xuwenyi
	 * @create 2013-11-12
	 **/
	public class HeroManager
	{
		private static var _instance:HeroManager;
		
		/**伙伴配置*/
		private var HERO:Dictionary = new Dictionary();//以ID为key
		private var HERO_RACE2FATE:Array = new Array();//同种族才会有羁绊,取出相关羁绊伙伴
		private var heroXMLList:XMLList;
		
		/**伙伴羁绊配置*/
		private var HERO_FATE:Dictionary = new Dictionary();//以job 为Key
		private var heroFateXMLList:XMLList;
		
		/**伙伴羁绊开启*/
		private var HERO_FATE_OPEN:Dictionary = new Dictionary();//以pos 为Key
		private var heroFateLevelXMLList:XMLList;
		
		/**
		 * 构造函数
		 * */
		public function HeroManager()
		{
			var settingsXML:XML = GameSettings.instance.settingsXML;
			heroXMLList = settingsXML.hero_info.hero;
			heroFateXMLList = settingsXML.hero_fate.hero_fate;
			heroFateLevelXMLList = settingsXML.fate_level.fate_level;
			
			//伙伴羁绊配置
			for each(var x:XML in heroXMLList)
			{
				if(x)
				{
					var hero:HeroVO = new HeroVO();
					// 配置表属性
					hero.id = x.@ID;
					hero.job = x.@job;
					hero.race = x.@race;
					hero.display = x.@display;
					hero.force = x.@force;
					hero.intellect = x.@intellect;
					hero.skeleton = x.@skeleton;
					hero.symbol = Lang.instance.trans(x.@symbol);
					hero.name = Lang.instance.trans(x.@name);
					hero.item_id = x.@item_id;
					hero.chips_id = x.@chips_id;
					hero.anti_dog = x.@anti_dog;
					hero.anti_crit = x.@anti_crit;
					hero.anti_arp = x.@anti_arps;
					hero.anti_parry = x.@anti_parry;
					hero.anger = x.@anger;
					hero.consume_anger = x.@consume_anger;
					hero.maxanger = x.@maxanger;
					hero.uskill = x.@uskill;
					hero.quality = x.@quality;
					hero.normal_skill_id = x.@normal_skill_id;
					hero.normal_rate = x.@normal_rate;
					hero.special_skill_id = x.@special_skill_id;
					hero.passive_skill_id = x.@passive_skill_id;
					hero.com_skill_id = x.@com_skill_id;
					hero.com_skill_hero_id = x.@com_skill_hero_id;
					hero.url = x.@url;
					hero.bgImage = x.@bgImage;
					hero.featureDes = Lang.instance.trans(x.@featureDes);
					hero.desc = Lang.instance.trans(x.@desc);
					hero.width = x.@width;
					hero.height = x.@height;
					
					hero.hpRe = x.@hpRe;
					hero.dmgRe = x.@dmgRe;
					hero.defRe = x.@defRe;
					hero.mdmgRe = x.@mdmgRe;
					hero.mdefRe = x.@mdefRe;
					hero.spdRe = x.@spdRe;
					
					hero.dgpReInit = x.@dgpReInit;
					hero.crtReInit = x.@crtReInit;
					hero.criReInit = x.@criReInit;
					hero.parryReInit = x.@parryReInit;
					hero.dgpReMax = x.@dgpReMax;
					hero.crtReMax = x.@crtReMax;
					hero.criReMax = x.@criReMax;
					hero.parryReMax = x.@parryReMax;
					
					// 保存到字典中
					// 按id分类
					HERO[hero.id] = hero;
					//羁绊相关
					HERO_RACE2FATE.push(hero);
				}
				else
				{
					Logger.warn(HeroManager , "没有找到伙伴数据... ");
				}
			}
			
			
			//羁绊开启配置文件
			for each(x in heroFateLevelXMLList)
			{
				if(x)
				{
					var fatelevelVo:FateLevelVo = new FateLevelVo();
					fatelevelVo.pos = x.@fate_pos;
					fatelevelVo.lv = x.@level;
					
					HERO_FATE_OPEN[fatelevelVo.pos] = fatelevelVo;
				}
			}
		}
		
		
		
		public static function get instance():HeroManager 
		{
			return _instance ||= new HeroManager();
		}
		
		/**
		 *race  伙伴种族
		 * */
		public function getHeroArrByRace(race:String):Array
		{
			var sameRaceHero:Array = [];
			for(var i:int = 0;i<this.HERO_RACE2FATE.length;i++)
			{
				var heroVo:HeroVO = this.HERO_RACE2FATE[i];
				if(heroVo.race == race && heroVo.display == "1")
				{
					sameRaceHero.push(heroVo);
				}
			}
			
			return sameRaceHero;
		}
		
		/**
		 * @race 同种族达成羁绊
		 * @job  相关羁绊职业
		 * */
		public function getHeroByRace(race:String , job:String):Array
		{
			var hero:Array = new Array();
			for(var i:int = 0;i<this.HERO_RACE2FATE.length;i++)
			{
				var heroVo:HeroVO = this.HERO_RACE2FATE[i];
				if(heroVo.race == race &&　heroVo.job.toString() == job)
				{
					hero.push(heroVo);
				}
			}
			
			return hero;
		}
		
		/**
		 * 根据伙伴id获取伙伴对象
		 * */
		public function getHeroByID(id:String):HeroVO
		{
			var hero:HeroVO = HERO[id];
			if(hero == null)
			{
				Logger.warn(HeroManager , "没有找到伙伴数据... id = " + id);
			}
			return hero;
		}
		
		/**
		 * 根据羁绊位置获取开放等级
		 * */
		public function getFetterLevel(pos:int):int
		{
			var fateVo:FateLevelVo = HERO_FATE_OPEN[pos.toString()];
			return int(fateVo.lv);
		}
		
		
		/**解析伙伴羁绊配置信息*/
		public function analysisFate(job:int):HeroFateVo
		{
			var heroFate:HeroFateVo = HERO_FATE[job];
			if( null == heroFate )
			{
				var xml:XML = GameTools.searchXMLList(heroFateXMLList , "job" , job);
				if(xml)
				{
					heroFate = new HeroFateVo();
					
					heroFate.job = xml.@job;
					
					heroFate.fate_name1 = xml.@fate_name1;
					heroFate.assistant_job1 = xml.@assistant_job1;
					heroFate.prop_1 = xml.@prop_1;
					heroFate.percent_1 = xml.@percent_1;
					
					heroFate.fate_name2 = xml.@fate_name2;
					heroFate.assistant_job2 = xml.@assistant_job2;
					heroFate.prop_2 = xml.@prop_2;
					heroFate.percent_2 = xml.@percent_2;
					
					heroFate.fate_name3 = xml.@fate_name3;
					heroFate.assistant_job3 = xml.@assistant_job3;
					heroFate.prop_3 = xml.@prop_3;
					heroFate.percent_3 = xml.@percent_3;
					
					heroFate.fate_name4 = xml.@fate_name4;
					heroFate.assistant_job4 = xml.@assistant_job4;
					heroFate.prop_4 = xml.@prop_4;
					heroFate.percent_4 = xml.@percent_4;
					
					HERO_FATE[heroFate.job] = heroFate;
				}
				else
				{
					Logger.warn(HeroManager , "没有找到职业羁绊数据... job = " + job);
					return null;
				}
			}
			
			return heroFate;
		}
		
		
	}
}