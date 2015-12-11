package com.gamehero.sxd2.world.HurdleMap.components
{
	import com.greensock.TweenMax;
	
	import flash.display.BitmapData;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.render.display.RenderItem;
	import bowser.render.display.SpriteItem;
	
	/**
	 * 战争迷雾
	 * @author weiyanyu
	 * 创建时间：2015-6-25 下午8:28:54
	 * 
	 */
	public class MapFogCellItem extends SpriteItem
	{
		/**
		 * 圈圈 
		 */		
		public var item:RenderItem;
		
		/**
		 * 是否绘制过 
		 */		
		public var isDraw:Boolean;
		/**
		 * 行 
		 */		
		public var row:int;
		/**
		 * 列 
		 */		
		public var col:int;
		
		private var _tween:TweenMax;
		
		public function MapFogCellItem(url:String=null, isBackground:Boolean=false, loader:BulkLoaderSingleton=null, loadProps:Object=null, isSWFCompress:Boolean=false)
		{
			item = new RenderItem();
			addChild(item);
		}
		/**
		 * 设置位图数据 
		 * @param bmd
		 * 
		 */		
		public function setSource(bmd:BitmapData):void
		{
			item.renderSource = bmd;
			item.x = -bmd.width >> 1;
			item.y = -bmd.height >> 1;
		}
		
		override public function set visible(value:Boolean):void
		{
//			_visible = value;
			isNeedRender = true;
			if(visible)
			{
				_tween = TweenMax.to(this , 4 , {alpha:0 , onComplete:onAlpha});
				
			}
		}
		
		protected function onAlpha():void
		{
			_visible = false;
			gc();
		}
		override public function gc(isCleanAll:Boolean=false):void
		{
			if(_tween) 
			{
				_tween.kill();
				_tween = null;
			}
			if(this.parent)
			{
				(this.parent as MapFogLayer).removeChild(this);
			}
			if(item) item.gc(true);
		}
		public static var FOG_LOC_XML:XML = <root>
				<item index='1' type='5' px='92' py='112' />
				<item index='2' type='5' px='92' py='424' />
				<item index='3' type='5' px='0' py='752' />
				<item index='4' type='5' px='76' py='912' />
				<item index='5' type='5' px='376' py='112' />
				<item index='6' type='5' px='272' py='376' />
				<item index='7' type='5' px='340' py='600' />
				<item index='8' type='5' px='424' py='872' />
				<item index='9' type='5' px='596' py='600' />
				<item index='10' type='5' px='676' py='344' />
				<item index='11' type='5' px='676' py='72' />
				<item index='12' type='5' px='988' py='72' />
				<item index='13' type='5' px='948' py='296' />
				<item index='14' type='5' px='948' py='600' />
				<item index='15' type='5' px='772' py='780' />
				<item index='16' type='5' px='772' py='912' />
				<item index='17' type='5' px='1096' py='820' />
				<item index='18' type='5' px='1224' py='543' />
				<item index='19' type='5' px='1224' py='296' />
				<item index='20' type='5' px='1332' py='72' />
				<item index='21' type='5' px='1572' py='112' />
				<item index='22' type='5' px='1496' py='424' />
				<item index='23' type='5' px='1496' py='700' />
				<item index='24' type='5' px='1396' py='912' />
				<item index='25' type='5' px='1724' py='968' />
				<item index='26' type='5' px='1808' py='659' />
				<item index='27' type='5' px='1748' py='424' />
				<item index='28' type='5' px='1748' py='240' />
				<item index='29' type='5' px='1872' py='72' />
				<item index='30' type='5' px='2132' py='112' />
				<item index='31' type='5' px='2052' py='316' />
				<item index='32' type='5' px='2132' py='568' />
				<item index='33' type='5' px='2132' py='752' />
				<item index='34' type='5' px='2084' py='912' />
				<item index='35' type='5' px='2408' py='912' />
				<item index='36' type='5' px='2408' py='636' />
				<item index='37' type='5' px='2408' py='400' />
				<item index='38' type='5' px='2460' py='112' />
				<item index='39' type='5' px='2732' py='112' />
				<item index='40' type='5' px='2732' py='424' />
				<item index='41' type='5' px='2672' py='600' />
				<item index='42' type='5' px='2672' py='820' />
				<item index='43' type='5' px='2852' py='968' />
				<item index='44' type='5' px='2996' py='700' />
				<item index='45' type='5' px='3072' py='424' />
				<item index='46' type='5' px='3072' py='112' />
				<item index='47' type='5' px='3368' py='168' />
				<item index='48' type='5' px='3368' py='376' />
				<item index='49' type='5' px='3260' py='636' />
				<item index='50' type='5' px='3260' py='872' />
				<item index='51' type='5' px='3208' py='1020' />
				<item index='52' type='5' px='3512' py='872' />
				<item index='53' type='5' px='3724' py='872' />
				<item index='54' type='5' px='3988' py='948' />
				<item index='55' type='5' px='4188' py='948' />
				<item index='56' type='5' px='4388' py='948' />
				<item index='57' type='5' px='4388' py='676' />
				<item index='58' type='5' px='4100' py='676' />
				<item index='59' type='5' px='3936' py='600' />
				<item index='60' type='5' px='3724' py='600' />
				<item index='61' type='5' px='3532' py='600' />
				<item index='62' type='5' px='3724' py='344' />
				<item index='63' type='5' px='3724' py='132' />
				<item index='64' type='5' px='4060' py='132' />
				<item index='65' type='5' px='3988' py='344' />
				<item index='66' type='5' px='4276' py='344' />
				<item index='67' type='5' px='4412' py='72' />
				<item index='68' type='5' px='4524' py='400' />
				</root>;
	}
}