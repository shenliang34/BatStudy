package com.gamehero.sxd2.gui
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.TextArea;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.TextInput;
	import com.gamehero.sxd2.services.GameService;
	import com.gamehero.sxd2.world.display.data.GameRenderCenter;
	
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.system.System;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.logging.Logger;
	import bowser.render.utils.AnimationMgr;
	
	import br.com.stimuli.loading.BulkLoader;
	
	import net.hires.debug.Stats;
	
	import org.as3commons.logging.setup.LogSetupLevel;
	
	
	
	/**
	 * 调试窗口(Ctrl+Shift+Enter呼出) 
	 * @author Trey
	 * @create-date 2014-8-18
	 */
	public class DebugWindow extends Sprite
	{
		private static var _instance:DebugWindow;

		
		private var _textInput:TextInput;
		private var _fpsStats:Stats;
		
		private var _traceLabel:TextArea;
		private var _traceLabel2:TextArea;
		private var _printTimer:Timer;

		
		public function DebugWindow()
		{
			initWindow();
		}
		
		
		public static function get inst():DebugWindow {
			
			return _instance ||= new DebugWindow();;
		}
		
		
		
		protected function initWindow():void {
			
			_textInput = new TextInput();
			_textInput.width = 200;
			_textInput.height = 20;
			addChild(_textInput);
		}
		
		
		public function show():void {
			
			if(App.topUI.contains(this)) {
				
				close();
				
				return;
			}
			
			
			App.topUI.addChild(this);
			
			
			this.graphics.clear();
			this.graphics.beginFill(0, .3);
			this.graphics.drawRect(0, 0, App.stage.stageWidth, App.stage.stageHeight);
			this.graphics.endFill();
			

			
			App.stage.focus = _textInput.tf;
			_textInput.x = (App.stage.stageWidth - _textInput.width) >> 1;
			_textInput.y = (App.stage.stageHeight - _textInput.height) >> 1;
			
			_textInput.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		
		public function close():void {
			
			App.topUI.removeChild(this);
			
			
			_textInput.text = "";
			_textInput.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			App.stage.focus = null;
			
			
			if(_traceLabel) {
				
				_printTimer.stop();
				_printTimer.removeEventListener(TimerEvent.TIMER, onPrintTimer);
				
				
				_traceLabel.text = "";
				_traceLabel.visible = false;
				
				_traceLabel2.text = "";
				_traceLabel2.visible = false;
			}
			
			_textInput.visible = true;
			this.mouseEnabled = this.mouseChildren = this.tabChildren = true;
			this.graphics.clear();
			
		}
		
		
		/**
		 * 打印内存信息 
		 * 
		 */
		public function printMemroyInfo():void {
			
			if(!_traceLabel) {
				
				_traceLabel = new TextArea();
				_traceLabel.textInput.color = GameDictionary.YELLOW;
				_traceLabel.textInput.bold = true;
				_traceLabel.textInput.size = 14;
				addChild(_traceLabel);
				
				_traceLabel2 = new TextArea();
				_traceLabel2.textInput.color = GameDictionary.GREEN;
				_traceLabel2.textInput.bold = true;
				_traceLabel2.textInput.size = 14;
				addChild(_traceLabel2);
				
				_printTimer = new Timer(1000);
			}
			
			this.mouseEnabled = this.mouseChildren = this.tabChildren = false;
			
			_printTimer.addEventListener(TimerEvent.TIMER, onPrintTimer);
			_printTimer.start();
			
			_textInput.visible = false;
			
			_traceLabel.visible = true;
			_traceLabel.x = 200;
			_traceLabel.y = 110;
//			_traceLabel.width =  App.stage.stageWidth >> 1;
			_traceLabel.width =  300;
			_traceLabel.height = App.stage.stageHeight - _traceLabel.y;
			
			
			_traceLabel2.visible = true;
			_traceLabel2.x = _traceLabel.x + 50 + 200;
			_traceLabel2.y = 110;
			_traceLabel2.width =  300;
			_traceLabel2.height = App.stage.stageHeight - _traceLabel2.y;
		}
		
		private function onPrintTimer(event:TimerEvent):void {
			
			_traceLabel.text = "----- GameRenderCenter -----\n";
			_traceLabel.text += GameRenderCenter.instance.__debug_list();
			
			
			_traceLabel2.text = "----- AnimationMgr -----\n";
			_traceLabel2.text += AnimationMgr.__debug_list();
		}		
		
		
		/**
		 * 快捷键 
		 * @param event
		 * 
		 */
		private function onKeyDown(event:KeyboardEvent):void {
			
			if(event.keyCode == Keyboard.ENTER) {
				
				
				var texts:Array = _textInput.text.split(" ");
				var debugText:String = texts[0];
				var debugParam:String = texts[1];
				
				switch(debugText) {
					
					case "info":
						
						printMemroyInfo();
						return;
						break;
					
					
					case "debug":
						
						if(debugParam == null || debugParam == "on") {
							
							Logger.logLevel = LogSetupLevel.DEBUG;
							GameService.instance.isDebug = true;
						}
						else {
							
							Logger.logLevel = LogSetupLevel.INFO;
							GameService.instance.isDebug = false;
						}
						break;
					
					case "fps":
						
						if(_fpsStats && App.stage.contains(_fpsStats) ) {
					
							App.stage.removeChild(_fpsStats);
						}
						else {	
							
							if(_fpsStats == null) {
								
								_fpsStats = new Stats();
							}
							
							App.stage.addChild(_fpsStats);
						}
							
						break;

					
					case "gc":
						
						System.gc();
						break;
					
					
					case "ld":
						
						BulkLoaderSingleton.__debug_print_items();
						break;
					
					case "ld2":
						
						GameRenderCenter.instance.__debug_list();
						break;
					
					
					case "remove":
						
						BulkLoader.removeAllLoaders();
//						BulkLoader.
						break;
					
					
					case "remove2":
						
						GameRenderCenter.instance.__clearAll();
						break;
					
					
					case "battle":
						
						if(debugParam != null) {
							
							MainUI.inst.createBattle(int(debugParam));
						}
						break;
				}
				
				this.close();
			}
		}		
		
	}
}