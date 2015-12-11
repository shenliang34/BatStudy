package com.gamehero.sxd2.gui.main
{
	import com.gamehero.sxd2.common.BitmapNumber;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.utils.clearInterval;
	import flash.utils.clearTimeout;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	/**
	 *主UI战力保险面板 
	 * @author zhangxueyou
	 * @create 2015-9-15
	 */	
	
	public class MainBattlePanel extends Sprite
	{
		private static var _inst:MainBattlePanel; //单例对象
		private var _currentBattleEf:uint = 0;	// 当前战斗力
		private var _bEfCon:Sprite;
		private var _bEfNumbCon:Sprite;
		private var _bEfNumEffects:Vector.<NumberScrollEffect>;
		private var _bEfIntervalId:uint;
		private var _bEfGlow:GlowFilter;
		private var _numEffectCache:Vector.<NumberScrollEffect>;
		private var powerbBn:BitmapNumber;
		private var oldPower:int
		private var newPower:int;
		private var battlePowerMc:MovieClip;
		private var bitMapNumber:BitmapNumber;
		public function MainBattlePanel()
		{
			super();
		}
		
		public function init(isBg:Boolean,power:int):void
		{
			if(isBg)
			{
				var battlePowerBg:Bitmap = new Bitmap(MainSkin.battlePowerBg);
				addChild(battlePowerBg);
			}
			
			battlePowerMc = MainSkin.battlePowerMc;
			battlePowerMc.y = 130;
			addChild(battlePowerMc);
			battlePowerMc.gotoAndStop(19);
			
			bitMapNumber = new BitmapNumber();
			bitMapNumber.x = 45;
			bitMapNumber.y = 10;
			bitMapNumber.update(BitmapNumber.WINDOW_S_YELLOW, power.toString());
			this.addChild(bitMapNumber);
			
			_bEfCon = new Sprite();
			_bEfCon.mouseChildren = _bEfCon.mouseEnabled = false;
			
			_bEfNumbCon = new Sprite();
			_bEfNumbCon.mouseChildren = _bEfNumbCon.mouseEnabled = false;
			_bEfCon.addChild(_bEfNumbCon);
			
			_bEfNumEffects = new Vector.<NumberScrollEffect>();
			
			_bEfGlow = new GlowFilter(0xFFFFCC, 1, 0, 0, 0);
			addChild(_bEfCon);
			_bEfCon.x = -40;
			_bEfCon.y = -5;
			
			oldPower = power;
			newPower = 0;
			
//			bEfAnimation();
		}

		/**
		 * 战斗力特效 
		 * 
		 */
		public function bEfAnimation():void {
			newPower = GameData.inst.playerInfo.power;
			if(oldPower == newPower) return;
			
			if(bitMapNumber)
			{
				this.removeChild(bitMapNumber);
				bitMapNumber = null;
			}
			
			
			battlePowerMc.gotoAndPlay(1);
			
			/** 初始化 */
			clearInterval(_bEfIntervalId);
			clearTimeout(_bEfIntervalId);
			
			var i:int;
			for (i = _bEfNumEffects.length - 1; i >= 0; i--) {
				
				_bEfNumEffects[i].removeEventListener(Event.COMPLETE, onNumEffectComplete);
				_bEfNumEffects.splice(i,1);
			}
			_bEfNumEffects.length = 0;
			
			Global.instance.removeChildren(_bEfNumbCon);
			_bEfNumbCon.filters = [];
			
			
			var _scale:Number = .2;
			var _xx:Number = _bEfCon.x - (_bEfCon.width * _scale - _bEfCon.width) * .5;
			var _yy:Number = _bEfCon.y - (_bEfCon.height * _scale - _bEfCon.height) * .5;
			
			
			/** 设置 */
			var oldBattleEf:String = oldPower.toString();//GameData.inst.playerInfo.power.toString();
			var newBattleEf:String = newPower.toString();//GameData.inst.playerInfo.power.toString();
			
			var oneNumEffect:NumberScrollEffect;
			var j:int = 0;
			var n:int = Math.max(oldBattleEf.length, newBattleEf.length);		
			for (i = n - 1; i >= 0; i--)  {
				
				oneNumEffect = getNumEffect();
				oneNumEffect.x = i * 14 + 85;
				oneNumEffect.y = 15;
				oneNumEffect.update(oldBattleEf.substr(i, 1), newBattleEf.substr(i, 1));
				oneNumEffect.addEventListener(Event.COMPLETE, onNumEffectComplete);
				
				_bEfNumbCon.addChild(oneNumEffect);
				
				_bEfNumEffects.push(oneNumEffect);
			}
			
			// 开始
			onNumEffectComplete();
			oldPower = newPower;
		}
		
		private function getNumEffect():NumberScrollEffect 
		{
			
			if(_numEffectCache == null) {
				
				_numEffectCache = new Vector.<NumberScrollEffect>();
			}
			
			if(_numEffectCache.length <= 0) {
				var clz:Class = MainSkin.getSwfClass("NUMBER_MC");
				_numEffectCache.push(new NumberScrollEffect(new clz()));
			}
			
			var numScrollEffect:NumberScrollEffect = _numEffectCache[0];
			_numEffectCache.splice(0, 1);
			
			return numScrollEffect;
		}
		
		private function onNumEffectComplete(event:Event = null):void 
		{
			
			if(event) {
				
				event.target.removeEventListener(Event.COMPLETE, onNumEffectComplete);
				
				if(_bEfNumEffects.length > 0)
				{
					_numEffectCache.push(_bEfNumEffects[0]);
					_bEfNumEffects.splice(0, 1);
				}
				
				// 数字滚动结束，开始发亮动画
				if(_bEfNumEffects.length == 0) {
					
					_bEfGlow.blurX = _bEfGlow.blurY = 0;
					_bEfGlow.strength = 0;
					_bEfNumbCon.filters = [_bEfGlow];
					
					var d:int = 1;
					_bEfIntervalId = setInterval(
						function():void {
							
							_bEfNumbCon.filters = [_bEfGlow];
							_bEfGlow.blurX += .5 * d;
							_bEfGlow.blurY += .5 * d;
							_bEfGlow.strength += .2 * d;
							
							if(_bEfGlow.blurX == 8) {
								
								d = -1;
							}
							else if(_bEfGlow.blurX <= 0) {
								
								_bEfNumbCon.filters = [];
								clearInterval(_bEfIntervalId);
								
								_bEfIntervalId = setTimeout(
									function():void {
										
//										TweenLite.to(_bEfCon, 1, {alpha: 0, onComplete:function():void {_bEfCon.visible = false;} });
//										_bEfCon.visible = false;
									}
									, 2000);
								
							}
						}
						, 15);
					
				}
			}
			
			if(_bEfNumEffects.length > 0) {
				
				_bEfNumEffects[0].start();
			}
		}
		/**
		 * 获取单例
		 * 
		public static function get inst():MainBattlePanel
		{
			return _inst ||= new MainBattlePanel();
		}
		*/
	}
}