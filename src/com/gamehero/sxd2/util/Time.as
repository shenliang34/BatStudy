package com.gamehero.sxd2.util
{
    import com.gamehero.sxd2.local.Lang;
    
    import bowser.utils.effect.NumberUtil;
	
	
	
	/**
	 * 将秒数转成时间字符串
	 * @author xuwenyi
	 * @create 2015-03-23
	 **/
	public class Time
	{
		
		
		/**
		 * 根据时间(秒)获取"00:00:00"这样的时间格式
		 * */
		public static function getStringTime1(time:int):String
		{
			var minute:int = Math.floor(time/60);
			var second:int = time - minute*60;
			var hour:int = Math.floor(minute/60);
			minute -= hour*60;
			return NumberUtil.getCompletionNumber(hour,2) + ":" + NumberUtil.getCompletionNumber(minute,2) + ":" + NumberUtil.getCompletionNumber(second,2);
		}
		
		
		
		/**
		 * 根据时间(秒)获取"(N天,N小时,N分钟等)"这样的时间格式
		 * */
		public static function getStringTime2(time:int):String
		{
			var minute:int = Math.floor(time/60);
			var second:int = time - minute*60;
			var hour:int = Math.floor(minute/60);
			minute -= hour*60;
			
			if(hour >= 24)
			{
				return Math.floor(hour/24) + Lang.instance.trans("AS_874");
			}
			else if(hour >= 1)
			{
				return hour + Lang.instance.trans("AS_146");
			}
			else if(minute >= 1)
			{
				return minute + Lang.instance.trans("AS_1470");
			}
			else
			{
				return second + Lang.instance.trans("AS_1471");
			}
		}
		
		
		
		/**
		 * 根据时间(秒)获取"年/月/日 00:00:00"这样的时间格式
		 * */
		public static function getStringTime3(time:int):String
		{
			var newDate:Date = new Date();
			newDate.setTime(time*1000);
			
			var year:String = newDate.fullYear+"";
			var month:String = NumberUtil.getCompletionNumber(newDate.month+1 , 2);
			var day:String = NumberUtil.getCompletionNumber(newDate.date , 2);
			var minute:String = NumberUtil.getCompletionNumber(newDate.minutes , 2);
			var second:String = NumberUtil.getCompletionNumber(newDate.seconds , 2);
			var hour:String = NumberUtil.getCompletionNumber(newDate.hours , 2);
			return year+"/"+month+"/"+day +" "+hour+":"+minute+":"+second;
		}
		
		
		
		
		/**
		 * 根据时间(秒)获取"00:00"这样的时间格式
		 * */
		public static function getStringTime4(time:int):String
		{
			var minute:int = Math.floor(time/60);
			var second:int = time - minute*60;
			return NumberUtil.getCompletionNumber(minute,2) + ":" + NumberUtil.getCompletionNumber(second,2);
		}
		
		
		
		
		/**
		 * 根据时间(秒)获取"(N天N小时N分钟)"这样的时间格式
		 * @param time 时间
		 * @param showZero 是否天数小时数为零时也显示
		 * */
		public static function getStringTime5(time:int, showZero:Boolean=false):String
		{
			var str:String = "";
			var days:int = int(time/60/60/24);
			var hours:int = int(time/60/60)%24;
			var mins:int = int(time/60)%60;
			
			if(days>0 || showZero){
				str += days+Lang.instance.trans("AS_874");
			}
			if((str!="" || hours>0) || showZero){
				str += hours+Lang.instance.trans("AS_146");
			}
			str += mins+Lang.instance.trans("AS_1470");
			return str;
		}
		
		
		
		
		/**
		 * 根据时间(秒)获取"(N小时N分钟)"这样的时间格式
		 * */
		public static function getStringTime6(time:int):String
		{
			var str:String = "";
			var hours:int = int(time/60/60);
			var mins:int = int(time/60)%60;
			
			if(hours>0){
				str += hours+Lang.instance.trans("AS_146");
			}
			if(str=="" || mins>0){
				str += mins+Lang.instance.trans("AS_1470");
			}
			return str;
		}
		
		
		
		
		/**
		 * 根据时间(秒)获取"(N小时N分钟N秒)"这样的时间格式
		 * */
		public static function getStringTime7(time:int):String
		{
			var str:String = "";
			var hours:int = int(time/60/60);
			var mins:int = int(time/60)%60;
			var second:int = int(time%3600)%60;
			
			if(hours>0){
				str += hours+Lang.instance.trans("AS_146");
			}
			if(mins>0){
				str += mins+Lang.instance.trans("AS_1470");
			}
			if(str=="" || second>0){
				str += second+Lang.instance.trans("AS_1471");
			}
			return str;
		}
		
		
		
		
		
		/**
		 * 根据时间(秒)获取"(N小时前，N天前)"这样的时间格式
		 * */
		public static function getStringTime8(time:int):String
		{
			var str:String = "";
			
			if(time <= 3600)
				str = "刚刚";
			else if(time < 86400)
				str = int(time / 3600) + "小时前";
			else if(time < 1296000)
				str = int(time / 86400) + "天前";
			else
				str = getStringTime1(time);
			return str;
		}
		
		
	}
}