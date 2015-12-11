package com.gamehero.sxd2.logging {
	
	import com.pblabs.PBE;
	import com.pblabs.debug.Console;
	import com.pblabs.debug.LogEntry;
	
	import org.as3commons.logging.setup.ILogTarget;
	import org.as3commons.logging.util.LogMessageFormatter;
	
	
	/**
	 * PBE Console Trace Target
	 * @author Trey
	 * @create-date 2012-10-29
	 */
	public class PBEConsoleLogTarget implements ILogTarget {
		
		
		private const _formatter:LogMessageFormatter = new LogMessageFormatter("[{logLevel}] ({time}) <{shortName}> {message}");
		
		private var PBEConsole:Console;
		
		
		/**
		 *  
		 * @param name
		 * @param shortName
		 * @param level
		 * @param timeStamp
		 * @param message
		 * @param parameters
		 * @param person
		 * 
		 */
		public function log(name:String, shortName:String, level:int, timeStamp:Number,	message:*, parameters:Array, person:String):void {
			
			if(!PBEConsole) {
				
//				PBEConsole = PBEntry.console;
				PBEConsole = PBE._rootGroup.getManager(Console) as Console;
			}
			
//			PBEConsole.addLogMessage("", "", 
//				_formatter.format(
//					name, shortName, level, timeStamp,
//					message, parameters, person)
//			);
			
			// 使用LogEntey的LogLevel来控制Socket输出的颜色（便于识别）
			var customLevel:String = LogEntry.DEBUG;
			if(shortName == "RemoteClient") {
				
				if(String(message).indexOf("<SOCKET PROTO>") >= 0) {
					
					customLevel = LogEntry.WARNING;
				}
				else if(String(message).indexOf("<SOCKET SEND>") >= 0) {
					
					customLevel = LogEntry.ERROR;
				}
				else {
					
					customLevel = LogEntry.INFO;
				}
			}
			
			PBEConsole.addLogMessage(customLevel, "", 
				_formatter.format(
					name, shortName, level, timeStamp,
					message, parameters, person)
			);

		}
		
	}
}