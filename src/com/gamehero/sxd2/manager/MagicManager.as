package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.vo.MagicConfigVo;
	
	import flash.utils.Dictionary;
	
	import bowser.utils.GameTools;

	/**
	 * @author Wbin
	 * 创建时间：2015-11-24 下午5:58:34
	 * 奇术配置管理器
	 */
	public class MagicManager
	{
		private static var _instance:MagicManager;
		
		/**
		 * 奇术配置总表
		 * */
		private var magicConfigXMLList:XMLList;
		private var magicConfigDic:Dictionary = new Dictionary();
		public var magicPropArr:Array = new Array();
		public var magicForArr:Array = new Array();
		
		
		/**
		 * 阵法
		 * */
		private var magicPropXMLList:XMLList;
		private var magicPropDic:Dictionary = new Dictionary();
		
		
		/**
		 * 阵法
		 * */
		private var magicForXMLList:XMLList;
		private var magicForDic:Dictionary = new Dictionary();
		
		public function MagicManager()
		{
			var settingsXML:XML = GameSettings.instance.settingsXML;
			
			this.magicConfigXMLList = settingsXML.magic_config.magic_config;
			this.magicForXMLList = settingsXML.magic_formation.magic_formation;
			this.magicPropXMLList = settingsXML.magic_prop.magic_prop;
			
			this.initXML();
		}
		
		public static function get init():MagicManager
		{
			return _instance||= new MagicManager();
			
		}
		
		private function initXML():void
		{
			var magicConfigVo:MagicConfigVo;
			
			for each(var x:XML in this.magicConfigXMLList)
			{
				if(x)
				{
					magicConfigVo = new MagicConfigVo();
					
					magicConfigVo.id = x.@id;
					magicConfigVo.type = x.@type;
					magicConfigVo.name = Lang.instance.trans(String(x.@name));
					magicConfigVo.open_type = x.@open_type;
					magicConfigVo.open_lv = x.@open_lv;
					
					var prop:Array = String(x.@prop).split("^");
					var proStr:String = prop.shift();
					
					magicConfigVo.prop =  proStr.split("-");;
					magicConfigVo.position = x.@position;
					if(magicConfigVo.type == 1)
					{
						this.magicForArr.push(magicConfigVo);
					}
					else
					{
						this.magicPropArr.push(magicConfigVo);
					}
					
					this.magicConfigDic[magicConfigVo.id] = magicConfigVo;
				}
			}
			
			this.magicForArr.sortOn("position",Array.NUMERIC);
			this.magicPropArr.sortOn("position",Array.NUMERIC);
		}
		
		/**
		 * 获取奇术配置总表
		 * */
		public function getMagicById(id:int):MagicConfigVo
		{
			var magicConfigVo:MagicConfigVo;
			if(this.magicConfigDic[id])
			{
				magicConfigVo = this.magicConfigDic[id];
			}
			return magicConfigVo;
		}
		
		/**
		 * 获取开放的功法
		 * */
		public function getOpenProp():Array
		{
			//开启条件 主角等级
			var roleLv:int = GameData.inst.roleInfo.base.level;
			var propArr:Array = [];
			for(var i:int = 0;i<this.magicPropArr.length;i++)
			{
				var vo:MagicConfigVo = this.magicPropArr[i] as MagicConfigVo;
				if(vo.open_lv <= roleLv)
				{
					propArr.push(vo);
				}
			}
			propArr.sortOn("position",Array.NUMERIC);
			return propArr;
		}
		
		
		/**
		 * 获取开放的阵法
		 * */
		public function getOpenFor():Array
		{
			//开启条件 主角等级
			var roleLv:int = GameData.inst.roleInfo.base.level;
			var forArr:Array = [];
			for(var i:int = 0;i<this.magicForArr.length;i++)
			{
				var vo:MagicConfigVo = this.magicForArr[i] as MagicConfigVo;
				if(vo.open_lv <= roleLv)
				{
					forArr.push(vo);
				}
			}
			forArr.sortOn("position",Array.NUMERIC);
			return forArr;
		}
		
	}
}