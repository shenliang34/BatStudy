package com.gamehero.sxd2.login
{
	public class LoginErrorTip
	{
		//单例对象
		private static var _instance:LoginErrorTip;
		private var errorTip:Array;
		
		public function LoginErrorTip(){
			errorTip = new Array();
			setErrorTip(30000,"服务器内部出错");
			setErrorTip(30001,"登录时服务器不存在");
			setErrorTip(30002,"验证USERID失败");
			setErrorTip(30003,"昵称已存在！");
			setErrorTip(30004,"昵称超出长度！");
			setErrorTip(30005,"昵称含有非法字符！");
			setErrorTip(30006,"昵称太短！");
			setErrorTip(30007,"昵称不能为空！");
		}
		
		/**
		 * 设置对应的errorCode 和 errorTip
		 * */
		private function setErrorTip(key:int,value:String):void{
			var obj:Object = new Object();
			obj.key = key;
			obj.value = value;
			errorTip.push(obj);
		}
		
		/**
		 * 获取错误提示
		 * */
		public function getErrorTip(key:int):String{
			var i:int;
			var len:int = errorTip.length;
			for(i;i<len;i++){
				if(errorTip[i].key == key){
					return errorTip[i].value;
				}
			}
			return "";
		}
		
		/**
		 * 获取单例
		 * */
		public static function get inst():LoginErrorTip
		{
			return _instance ||= new LoginErrorTip();
		}
	}
}