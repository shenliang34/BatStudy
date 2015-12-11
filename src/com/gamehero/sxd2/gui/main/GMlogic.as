import com.gamehero.sxd2.battle.data.BattleDataCenter;
import com.gamehero.sxd2.drama.DramaManager;
import com.gamehero.sxd2.event.MainEvent;
import com.gamehero.sxd2.manager.JSManager;
import com.gamehero.sxd2.services.GameService;
import com.netease.protobuf.UInt64;
import com.pblabs.PBE;
import com.pblabs.debug.ConsoleCommandManager;

/**
 * gm指令
 * @author xuwenyi
 * @create 2014-12-30
 **/


/******************************************************** CONFIG::DEBUG ********************************************************/
// GM命令
CONFIG::DEBUG 
{
	/**
	 * 注册GM指令 
	 */
	private function registerGM():void {
		
		if(JSManager.isDebug() == true)
		{	
			var ccm:ConsoleCommandManager = (PBE._rootGroup.getManager(ConsoleCommandManager) as ConsoleCommandManager);
			ccm.registerCommand("@battlereport", function(p:String):void{battleReport(p)}, "@battleReport id 战斗回放");
			ccm.registerCommand("@battlespeed", function(p:String):void{battleSpeed(p)}, "@battlespeed speed 战斗速度");
			ccm.registerCommand("@playdrama", function(p:String):void{playdrama(p)}, "@playdrama id 剧情id");
			
			ccm.registerCommand("@test", function(p:String):void{sendGM(p)}, "@test gm命令" , true);
			ccm.registerCommand("@setlevel", function(p:String):void{sendGM(p)}, "setlevel 等级：设置人物等级" , true);
			ccm.registerCommand("@addexp", function(p:String):void{sendGM(p)}, "addexp 经验：增加人物经验" , true);
			ccm.registerCommand("@additem", function(p:String):void{sendGM(p)}, "@additem 名字 数量：增加指定道具" , true);
			ccm.registerCommand("@delitem", function(p:String):void{sendGM(p)}, "@delitem 名字 数量：删除指定道具" , true);
			ccm.registerCommand("@clearitems", function(p:String):void{sendGM(p)}, "@clearitems 清除所有道具" , true);
			ccm.registerCommand("@addhero", function(p:String):void{sendGM(p)}, "@addhero id 添加伙伴" , true);
			ccm.registerCommand("@testbattle", function(p:String):void{sendGM(p)}, "@testbattle id 测试战斗" , true);
			ccm.registerCommand("@activiformation", function(p:String):void{sendGM(p)}, "@activiformation id 激活某阵型" , true);
			
			
			
			/** Client */
			// 开关debug日志
			ccm.registerCommand("@debug", 
				function(p1:String):void{
					
					if(p1 == "on") {
						
						GameService.instance.setDebug(true);
					}
					else if(p1 == "off") {
						
						GameService.instance.setDebug(false);
					}
				}, 
				"@debug on/off 开关debug日志"
			);
			
		}
	}	
	
	
	
	/**
	 * 发送gm命令请求
	 * */
	private function sendGM(command:String):void 
	{
		this.dispatchEvent(new MainEvent(MainEvent.GM , command));
	}
	
	
	
	
	/**
	 * 播放一场战斗录像
	 * */
	private function battleReport(p:String):void 
	{
		var reportId:UInt64 = UInt64.parseUInt64(p);
		SXD2Main.inst.battleReport(reportId);
	}
	
	
	
	
	/**
	 * 设置战斗速度
	 * */
	private function battleSpeed(p:String):void
	{
		BattleDataCenter.instance.playSpeed = Number(p);
	}
	
	
	
	/**
	 * 播放某剧情
	 * */
	private function playdrama(id:String):void
	{
		DramaManager.inst.playDrama(int(id));
	}
	
}