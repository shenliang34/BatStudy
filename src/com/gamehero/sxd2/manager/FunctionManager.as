package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.core.GameSettings;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.gui.main.coolingBar.CoolingBar;
	import com.gamehero.sxd2.gui.main.menuBar.MenuBar;
	import com.gamehero.sxd2.gui.main.menuBar.MenuBarDict;
	import com.gamehero.sxd2.gui.main.menuBar.MenuButton;
	import com.gamehero.sxd2.pro.PRO_FunctionInfo;
	import com.gamehero.sxd2.services.GameService;
	import com.gamehero.sxd2.vo.FunctionVO;
	import com.gamehero.sxd2.world.views.GameWorld;
	import com.gamehero.sxd2.world.views.RoleLayer;
	import com.gamehero.sxd2.world.views.SceneViewBase;
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import bowser.utils.GameTools;
	import bowser.utils.data.Group;

	/**
	 * 功能按钮工具类
	 * @author zhangxueyou
	 * @create-date 2015-9-9
	 */
	public class FunctionManager extends EventDispatcher
	{
		private static var _instance:FunctionManager;
		
		// p配置表
		private var functionXMLList:XMLList;
		private var FUNC:Dictionary = new Dictionary();
		
		// 已开放的功能
		private var opened1:Group = new Group();//右下
		private var opened2:Group = new Group();//右上
		private var opened3:Group = new Group();//npc功能
		
		// 即将播放功能开放的function队列(需要每次提取第一个播放功能开放动画)
		private var willopens:Array = [];
		// 是否正在播放功能开放动画
		private var isPlayOpen:Boolean = false;
		
		
		
		
		
		public function FunctionManager()
		{
			var settingsXML:XML = GameSettings.instance.settingsXML;
			functionXMLList = settingsXML.functions.func;
		}
		
		
		
		/**
		 * 获取单例
		 */
		public static function get inst():FunctionManager 
		{
			return _instance ||= new FunctionManager();
		}

		

		
		
		
		/**
		 * 获取功能数据
		 * */
		public function getFunctionVO(id:int):FunctionVO
		{
			var vo:FunctionVO = FUNC[id];
			if(vo == null)
			{
				var x:XML = GameTools.searchXMLList(functionXMLList , "id" , id);
				if(x)
				{
					vo = new FunctionVO();
					vo.fromXML(x);
					
					FUNC[id] = vo;
				}
			}
			return vo;
		}
		
		
		
		
		/**
		 * 初始化已开放的功能
		 * */
		public function initOpenFunction(funcs:Array):void
		{
			for(var i:int=0;i<funcs.length;i++)
			{
				var info:PRO_FunctionInfo = funcs[i];
				var vo:FunctionVO = this.getFunctionVO(info.id);
				var opened:Group = getOpendList(vo.positionType);// 获取对应类型开放列表
				opened.add(vo);
			}
			
			MainUI.inst.menuBar1.init();
			MainUI.inst.menuBar2.init();
			MainUI.inst.coolingBar.init();
		}
		
		
		
		
		/**
		 * 更新开放的功能
		 */
		public function updateOpenFunction(funcs:Array):void
		{
			willopens = willopens.concat(funcs);
			
			// 停止任务自动寻路
			TaskManager.inst.colseAutoTaskHandle();
			// 停止主角移动
			var view:SceneViewBase = SXD2Main.inst.currentView;
			var world:GameWorld = view.gameWorld;
			var layer:RoleLayer = world.roleLayer;
			layer.role.stop();
			
			// 终止通信
			GameService.instance.pending = true;
			
			
			if(isPlayOpen == false)
			{
				// 播放功能开启动画
				playOpen();
			}
			
			function playOpen():void
			{
				if(willopens.length > 0)
				{
					isPlayOpen = true;
					
					var info:PRO_FunctionInfo = willopens.shift();
					var funcVO:FunctionVO = getFunctionVO(info.id);
					var opened:Group = getOpendList(funcVO.positionType);// 获取对应类型开放列表
					var menuBar:MenuBar;
					var coolingBar:CoolingBar;
					
					switch(funcVO.positionType)
					{
						// 右下
						case MenuBarDict.RIGHT_BOTTOM:
							menuBar = MainUI.inst.menuBar1;
							break;
						
						// 右上
						case MenuBarDict.RIGHT_TOP:
							menuBar = MainUI.inst.menuBar2;
							break;
						
						// 其他
						default:
							coolingBar = MainUI.inst.coolingBar;
							break;
						
					}
					
					if(info.isOpen == true)
					{
						// 功能开放
						if(opened.contains(funcVO) == false)
						{
							opened.add(funcVO);
							
							// 注册按钮
							if(menuBar)
							{
								menuBar.registerButton(funcVO , playOpen);
							}
							else if(coolingBar)
							{
								coolingBar.registerButton(funcVO , playOpen);
							}
							else
							{
								playOpen();
							}
						}
						// 更新功能点
						else
						{
							
						}
					}
					// 功能关闭
					else
					{
						if(opened.contains(funcVO) == true)
						{
							opened.remove(funcVO);
							
							if(menuBar)
							{
								menuBar.removeButton(funcVO);
							}
						}
						
						playOpen();
					}
					
					menuBar = null;
					coolingBar = null;
				}
				else
				{
					isPlayOpen = false;
					
					// 开启通信
					GameService.instance.pending = false;
				}
			}
		}
		
		
		
		
		
		
		/**
		 * 功能是否开放 
		 */		
		public function isFuncOpen(id:uint):Boolean
		{
			var opened:Group = opened1.concat(opened2).concat(opened3);
			var child:Object = opened.getChildByParam("id" , id);
			return child != null;
		}

		
		
		
		
		/**
		 * 根据id获得FunctionInfo的button
		 */
		public function getFuncBtn1(id:uint):MenuButton 
		{
			var opened:Array = opened1.concat(opened2).concat(opened3).toArray();
			var len:int = opened.length;
			var i:int;
			for(i;i<len;i++)
			{
				if(opened[i].id == id)
					return opened[i].menuBtn;
			}
			return null;
		}
		
		
		
		
		
		/**
		 * 根据name获得FunctionInfo的button
		 */
		public function getFuncBtn2(name:String):MenuButton 
		{
			var opened:Array = opened1.concat(opened2).concat(opened3).toArray();
			var len:int = opened.length;
			var i:int;
			for(i;i<len;i++)
			{
				if(opened[i].name == name)
					return opened[i].menuBtn;
			}
			return null;
		}
		
		
		
		

		/**
		 * 获得功能点数 
		 */
		public function getFuncNum(id:uint):uint {

			return null;
		}
		
		
		
		
		/**
		 * 获取对应类型功能数组
		 * */
		public function getOpendList(type:int):Group
		{
			switch(type)
			{
				case MenuBarDict.RIGHT_BOTTOM:
					return opened1;
				case MenuBarDict.RIGHT_TOP:
					return opened2;
				default:
					return opened3;
			}
		}
		/**
		 * 获取所有的开启功能 
		 * @return 
		 * 
		 */		
		public function get opendFunc():Group
		{
			return opened1.concat(opened2).concat(opened3);
		}
		
	}
}