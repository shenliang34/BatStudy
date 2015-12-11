package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.vo.HeroDecompsoeVo;
	
	import flash.utils.Dictionary;
	
	import bowser.logging.Logger;
	import bowser.utils.GameTools;

	/**
	 * @author Wbin
	 * 创建时间：2015-11-5 下午4:22:30
	 * 伙伴图鉴分解配置id
	 */
	public class HeroDecomposeManager
	{
		private static var _instance:HeroDecomposeManager;
		
		private var DECOMPOSE:Dictionary = new Dictionary();//以伙伴品质为Key
		private var decomposeXMLList:XMLList;
		
		public function HeroDecomposeManager()
		{
			var settingsXML:XML = GameSettings.instance.settingsXML;
			decomposeXMLList = settingsXML.hero_decompose.hero_decompose;
		}
		
		public static function get instance():HeroDecomposeManager 
		{
			return _instance ||= new HeroDecomposeManager();
		}
		
		/**
		 * 根据伙伴品质获得伙伴图鉴分解、合成
		 * */
		public function getComposeNum(value:int):HeroDecompsoeVo
		{
			var decomposeVo:HeroDecompsoeVo = DECOMPOSE[value];
			if( null == decomposeVo)
			{
				var xml:XML = GameTools.searchXMLList(decomposeXMLList,"quality",value);
				if(xml)
				{
					decomposeVo = new HeroDecompsoeVo();
					decomposeVo.quality = xml.@quality;
					decomposeVo.dec_fragment = xml.@dec_fragment;
					DECOMPOSE[decomposeVo.quality] = decomposeVo;
				}
				else
				{
					Logger.warn(HeroDecomposeManager , "没有找到品质相关分解数据...  = " + value);
					return null;
				}
			}
			
			return decomposeVo;
		}
	}
}