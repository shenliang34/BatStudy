package com.gamehero.sxd2.login
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.event.LoginEvent;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSG_CREATE_USER_REQ;
	import com.gamehero.sxd2.pro.MSG_RAND_NAME_ACK;
	import com.gamehero.sxd2.pro.MSG_RAND_NAME_REQ;
	import com.gamehero.sxd2.services.GameService;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.system.ApplicationDomain;
	import flash.text.TextField;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.logging.Logger;
	import bowser.remote.RemoteResponse;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	

	
	/**
	 * 创建角色界面 
	 * @author zhangxueyou
	 * @create-date 2015-7-10
	 */
	public class CreateRoleView extends Sprite
	{
		private var scaleW:Number;
		private var scaleH:Number;
		
		// 资源引用
		static public var DOMAIN:ApplicationDomain;
		// 加载Item
		private var imageItem:ImageItem;
		private var createRoleURL:String;
		private var usernameBG:Bitmap;
		private var defaultSex:int = 1;
		private var uiList:Array;
		private var textInputPos:Array = [];
		private var mainMc:MovieClip;
		private var boyMc:MovieClip;
		private var girlMc:MovieClip;
		private var usernameText:TextField;
		private var errorTip:TextField;
		private var errStr:String="";
		
		/**
		 * 构造函数
		 * */
		public function CreateRoleView(sex:int):void
		{	
			createRoleURL = GameConfig.RESOURCE_URL + "login/LoginView.swf";
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		/**
		 * 添加到舞台事件
		 * 
		 */
		protected function onAddToStage(event:Event):void
		{	
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			imageItem = BulkLoaderSingleton.instance.addWithListener(createRoleURL, null, onLoaded, onProgress) as ImageItem;
			BulkLoaderSingleton.instance.start();
			
			this.stage.addEventListener(Event.RESIZE,onResize);
			
		}
		
		/**
		 * 资源加载
		 * 
		 */
		protected function onProgress(event:ProgressEvent):void {
			var percent:int = int(event.bytesLoaded / event.bytesTotal * 100);
			Logger.debug(CreateRoleView, "Create Role Loading: " + percent + "%");
		}
		
		/**
		 * 资源加载完成
		 * 
		 */
		protected function onLoaded(e:Event):void
		{
			parent.dispatchEvent(new LoginEvent(LoginEvent.SHOW_CREATE_USER));
			DOMAIN = imageItem.loader.contentLoaderInfo.applicationDomain;
			initUI();
			var param:MSG_RAND_NAME_REQ = new MSG_RAND_NAME_REQ();
			param.sex  = Math.round(Math.random()) + 1;
			GameService.instance.send(MSGID.MSGID_RAND_NAME, param, onRandomNameEnd);
		}
		
		/**
		 * 初始化UI 
		 * 
		 */
		protected function initUI():void {
			
			mainMc = this.getRes("mainMc") as MovieClip;
			addChild(mainMc);
			
			usernameText = mainMc.getChildByName("usernameText") as TextField;
			this.stage.focus = usernameText;
			usernameText.addEventListener(Event.CHANGE,usernameTextChange);
			/*
			boyMc = mainMc.getChildByName("boyMc") as MovieClip;
			girlMc = mainMc.getChildByName("girlMc") as MovieClip;
			*/
			errorTip = mainMc.getChildByName("errorTip") as TextField;
			
			initBtnClickHandle();
//			setDefaultSex();//ui初始化完毕根据性别设置角色
			onResize();//ui初始化完毕自适应舞台大小
			
		}
		
		private function initBtnClickHandle():void{
			/*
			mainMc.getChildByName("boyBtn").addEventListener(MouseEvent.CLICK,changeSexHandle);
			mainMc.getChildByName("girlBtn").addEventListener(MouseEvent.CLICK,changeSexHandle);
			*/
			mainMc.getChildByName("randomBtn").addEventListener(MouseEvent.CLICK,randomName);
			mainMc.getChildByName("startBtn").addEventListener(MouseEvent.CLICK,onCreateClick);	
		}
		
		/**
		 * 自适应
		 * */
		private function onResize(event:Event = null):void
		{
			if(stage != null)
			{
				var w:int = stage.stageWidth;
				var h:int = stage.stageHeight;
				if(w < 1000) w = 1000;
				if(h < 600) h = 600;
				// 背景黑色
				
				this.graphics.clear();
				this.graphics.beginFill(0);
				this.graphics.drawRect(0, 0, w, h);
				this.graphics.endFill();
				mainMc.x = int((w - mainMc.width)/2);
				mainMc.y = int((h - mainMc.height)/2);
			}
		}
		
		/**
		 * 性别点击事件
		 * 
		private function changeSexHandle(e:Event):void{
			if(("boyBtn" == e.currentTarget.name && defaultSex == 1) || ("girlBtn" == e.currentTarget.name && defaultSex == 2)) return;
			setDefaultSex();
		}
		*/
		
		/**
		 * 改变性别
		 * 
		private function setDefaultSex():void{
			if(defaultSex == 1){
				defaultSex = 2;
				boyMc.gotoAndStop(1);
				girlMc.gotoAndPlay(1);
			}else{
				defaultSex = 1;
				boyMc.gotoAndPlay(1);
				girlMc.gotoAndStop(1);
			}
		}
		*/
		
		/**
		 * 返回随机名 
		 * @param response
		 * 
		 */
		private function onRandomNameEnd(response:RemoteResponse):void
		{
			if(response.errcode == "0")
			{
				var randomName:MSG_RAND_NAME_ACK = new MSG_RAND_NAME_ACK();
				randomName.mergeFrom(response.protoBytes);
				usernameText.text = randomName.name;
			}
		}		
		
		/**
		 * 检查姓名是否合法
		 * */
		private function checkName():Boolean
		{
			var username:String = usernameText.text;
			
			if(username.length > 6 || username.length == 0)
			{
				return false;
			}
			return true;
		}
		
		/**
		 * 创建角色
		 * 
		 */
		private function onCreateClick(e:MouseEvent = null):void {
			
			// 先检查姓名是否合法
			if(this.checkName())
			{	
				// 姓名,性别
				var createUser:MSG_CREATE_USER_REQ = new MSG_CREATE_USER_REQ();
				createUser.name = usernameText.text;
				createUser.sex = defaultSex;
				// 向服务器端发送创建请求
				parent.dispatchEvent(new LoginEvent(LoginEvent.CREATE_USER , createUser));
			}
			else
			{
				errorTip.text = LoginErrorTip.inst.getErrorTip(30007);
				errStr = usernameText.text;
			}
		}
		
		/**
		 * 创建随机名
		 * */
		protected function randomName(e:MouseEvent = null):void
		{
			errorTip.text = "";
			//根据性别获取名称
			var param:MSG_RAND_NAME_REQ = new MSG_RAND_NAME_REQ();
			param.sex  = Math.round(Math.random()) + 1;
			GameService.instance.send(MSGID.MSGID_RAND_NAME, param, onRandomNameEnd);
		}
		
		/**
		 * 服务端返回错误提示，记录错误昵称
		 * */
		public function setErrorTip(key:int):void{
			errorTip.text = LoginErrorTip.inst.getErrorTip(key);
			//名字包含非法字符 提示需特殊处理 记住非法字符 判断新名字不包含非法字符后 提示才消失
			if(key == 30005){
				errStr = usernameText.text;
			}
		}
		/**
		 * 判定errorTip是否显示
		 * */
		private function usernameTextChange(e:Event):void{
			var bool:Boolean = textIndexOf(usernameText.text,errStr);
			if(!bool){
				errorTip.text = "";
			}
		}
		/**
		 * 判断新昵称中是否包含之前的错误昵称
		 * */
		private function textIndexOf(str1:String,str2:String):Boolean{
			var len1:int = str1.length;
			var len2:int = str2.length;
			
			if(len1 != 0 && !len2) return false;
			for(var i:int = 0; i < len1 - len2; i++){ 
				if(str1.substr(i,len2)==str2){ 
					return true; 
				} 
			} 
			return false; 
		}
		
		/**
		 * 加载的swf的导出类得到BitmapData 
		 * @param className
		 */
		protected function getRes(className:String):Object
		{	
			if(DOMAIN)
			{	
				return new (DOMAIN.getDefinition(className) as Class)();
			}
			
			return null;
		}
		
		/**
		 * 获取class
		 * @param className
		 */
		protected function getClass(className:String):Class
		{	
			if(DOMAIN)
			{	
				return DOMAIN.getDefinition(className) as Class;
			}
			
			return null;
		}
		
		
		
		
		public function clear():void
		{
			DOMAIN = null;
			// 加载Item
			imageItem = null;
			usernameBG = null;
			uiList = [];
			textInputPos = [];
			mainMc = null;
			boyMc = null;
			girlMc = null;
			usernameText = null;
			errorTip = null;
			
			while(this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
		}
	}
}