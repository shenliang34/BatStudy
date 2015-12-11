package com.gamehero.sxd2.gui.heroHandbook
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.manager.HeroManager;
	import com.gamehero.sxd2.pro.PRO_PhotoAppraisalInfo;
	import com.gamehero.sxd2.vo.HeroVO;
	import com.gamehero.sxd2.world.display.data.GameRenderCenter;
	
	import flash.utils.Dictionary;

	/**
	 * @author Wbin
	 * 创建时间：2015-11-3 下午1:55:49
	 * 图鉴相关全局属性
	 */
	public class HerohandbookModel
	{
		private static var _instance:HerohandbookModel
		public var resource:Array = [];
		//当前领取奖励档次
		public var rwdNum:Array = [];
		//激活的伙伴数量
		public var activeHeroNum:int = 0;
		//当前要显示的伙伴
		public var heroArr:Array = new Array();
		//当前激活的伙伴id
		public var activeHero:HeroVO;
		
		public function HerohandbookModel()
		{
		}
		
		
		public static function get inst():HerohandbookModel
		{
			return _instance ||= new HerohandbookModel();
		}
		
		public function getAllHero():void
		{
			for(var i:int = 0;i<5;i++)
			{
				var hArr:Array = HeroManager.instance.getHeroArrByRace("" + i);
				this.connect(hArr);
			}
		}
		
		private function connect(hArr:Array):void
		{
			for(var i:int = 0;i<hArr.length;i++)
			{
				heroArr.push(hArr[i]);
			}
		}
		
		
		public function clear():void
		{
			for(var i:int = 0;i<resource.length;i++)
			{
				var url:String = resource[i];
				if(url)
				{
					GameRenderCenter.instance.clearData(url);
				}
			}
			activeHero = null
			resource = [];
			activeHeroNum = 0;
		}
	}
}