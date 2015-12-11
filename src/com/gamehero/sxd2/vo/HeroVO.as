package com.gamehero.sxd2.vo
{
	
	
	/**
	 * 伙伴VO数据
	 * @author xuwenyi
	 * @create 2013-11-12
	 **/
	public class HeroVO extends BaseVO
	{
		// 配置表属性
		public var id:String;
		public var job:int;
		public var race:String;
		public var symbol:String;
		public var name:String;
		public var display:String;//当前图鉴中是否显示
		public var item_id:String;//成品伙伴对应的item
		public var chips_id:String;//伙伴碎片对应的item

		public var force:String;
		public var intellect:String;
		public var skeleton:String;
		public var anti_dog:String;//命中
		public var anti_crit:String;//韧性
		public var anti_arp:String;//守护
		public var anti_parry:String;//破击
		public var anger:String;//怒气
		public var consume_anger:String;//绝技消耗气势
		public var maxanger:String;//气势上限
		public var uskill:String;//反击技能
		public var quality:String;// 品质
		
		public var normal_skill_id:String;//普攻技能id
		public var normal_rate:String;//
		public var special_skill_id:String;//
		public var passive_skill_id:String;//
		public var com_skill_id:String;//
		public var com_skill_hero_id:String;//
		public var url:String;//
		public var bgImage:String;//
		public var featureDes:String;//
		public var desc:String;//
		public var width:String;//
		public var height:String;//
		
		
		public var hpRe:String;
		public var dmgRe:String;
		public var defRe:String;
		public var mdmgRe:String;
		public var mdefRe:String;
		public var spdRe:String;
		
		public var dgpReInit:String;
		public var crtReInit:String;
		public var criReInit:String;
		public var parryReInit:String;
		public var dgpReMax:String;
		public var crtReMax:String;
		public var criReMax:String;
		public var parryReMax:String;
		
		
		
		public function HeroVO()
		{
		}
		
		
	}
}