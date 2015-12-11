package com.gamehero.sxd2.gui.player.hero
{
	import com.gamehero.sxd2.common.BitmapNumber;
	import com.gamehero.sxd2.core.Global;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.gui.main.NumberScrollEffect;
	import com.gamehero.sxd2.gui.player.hero.model.HeroModel;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	import com.greensock.TweenLite;
	
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
	 * 复用主面板战力显示动画逻辑
	 * */
	public class HeroBattlePowerPanel extends Sprite
	{
		private var _currentBattleEf:uint = 0;	// 当前战斗力
		private var _bEfCon:Sprite;
		private var _bEfNumbCon:Sprite;
		private var _bEfNumEffects:Vector.<NumberScrollEffect>;
		private var _bEfIntervalId:uint;
		private var _bEfGlow:GlowFilter;
		private var _numEffectCache:Vector.<NumberScrollEffect>;
		private var oldPower:int
		private var newPower:int;
		
		//加载两个mc 防止两个面板同时调用播放不完整
		private var battlePowerMc_Hero:MovieClip;
		private var battlePowerMc_HeroDetail:MovieClip;
		//数字长度  为了数字居中显示
		private var numwid:Number;
		
		private var bitMapNumber:BitmapNumber;
		
		public function HeroBattlePowerPanel()
		{
			super();
		}
		
		public function init():void
		{
			/*var battlePowerBg:Bitmap = new Bitmap(MainSkin.battlePowerBg);
			addChild(battlePowerBg);*/
			
			var clz:Class = MainSkin.getSwfClass("battlePowerMc");
			battlePowerMc_Hero = new clz() as MovieClip;
			battlePowerMc_Hero.y = 130;
			addChild(battlePowerMc_Hero);
			
			battlePowerMc_HeroDetail = new clz() as MovieClip;
			battlePowerMc_HeroDetail.y = 130;
			addChild(battlePowerMc_HeroDetail);
			
			battlePowerMc_Hero.gotoAndStop(battlePowerMc_Hero.totalFrames);
			battlePowerMc_HeroDetail.gotoAndStop(battlePowerMc_HeroDetail.totalFrames);
			
			_bEfCon = new Sprite();
			_bEfCon.mouseChildren = _bEfCon.mouseEnabled = false;
			
			_bEfNumbCon = new Sprite();
			_bEfNumbCon.mouseChildren = _bEfNumbCon.mouseEnabled = false;
			_bEfCon.addChild(_bEfNumbCon);
			
			bitMapNumber = new BitmapNumber();
			bitMapNumber.x = 0;
			bitMapNumber.y = 10;
			this.addChild(bitMapNumber);
			
			_bEfNumEffects = new Vector.<NumberScrollEffect>();
			
			_bEfGlow = new GlowFilter(0xFFFFCC, 1, 0, 0, 0);
			addChild(_bEfCon);
			_bEfCon.x = -40;
			_bEfCon.y = -5;
			
			oldPower = 0;
			newPower = 0;
			/*bEfAnimation();*/
		}
		
		/**
		 * 战斗力特效 
		 * @type 0:伙伴面板   1:伙伴详细信息面板
		 * power 新战力
		 * id    伙伴id
		 * first  第一次打开
		 */
		public function bEfAnimation(power:int,id:int,type:int,first:Boolean):void {
			
			var bool1:Boolean = HeroModel.instance.power[id] == power;
			var bool2:Boolean = HeroModel.instance.detailPower[id] == power;
			
			//第一次打开  或者伙伴战力无变化
			if(first || (bool1&&type == 0) || (bool2&&type == 1) )
			{
				battlePowerMc_Hero.gotoAndStop(battlePowerMc_Hero.totalFrames);
				battlePowerMc_HeroDetail.gotoAndStop(battlePowerMc_HeroDetail.totalFrames);
				if(bitMapNumber)
				{
					bitMapNumber.update(BitmapNumber.WINDOW_S_YELLOW, power.toString());
					bitMapNumber.x = 156 - bitMapNumber.width >> 1;
					this.numLen =  power.toString().length * 15;
				}
				this.clearNumEffect();
				oldPower = power;
				return;
			}
			
			newPower = power;
			//面板上一次战力显示无变化
			if(oldPower == newPower) return;
			if(bitMapNumber)
			{
				bitMapNumber.clear();
			}
			switch (type)
			{
				case 0:
					HeroModel.instance.power[id] = newPower;
					battlePowerMc_Hero.gotoAndPlay(1);
				break;
				case 1:
					HeroModel.instance.detailPower[id] = newPower;
					battlePowerMc_HeroDetail.gotoAndPlay(1);
				break;
			}
			
			/** 初始化 */
			clearInterval(_bEfIntervalId);
			clearTimeout(_bEfIntervalId);
			
			this.clearNumEffect();
			
			var _scale:Number = .2;
			var _xx:Number = _bEfCon.x - (_bEfCon.width * _scale - _bEfCon.width) * .5;
			var _yy:Number = _bEfCon.y - (_bEfCon.height * _scale - _bEfCon.height) * .5;
			
			
			/** 设置 */
			var oldBattleEf:String = oldPower.toString();//GameData.inst.playerInfo.power.toString();
			var newBattleEf:String = newPower.toString();//GameData.inst.playerInfo.power.toString();
			
			var i:int;
			var oneNumEffect:NumberScrollEffect;
			var j:int = 0;
			var n:int = Math.max(oldBattleEf.length, newBattleEf.length);		
			this.numLen = n*15;
			for (i = n - 1; i >= 0; i--)  {
				
				oneNumEffect = getNumEffect();
				oneNumEffect.x = i * 14 + 85;
				oneNumEffect.y = 15;
				oneNumEffect.update(oldBattleEf.substr(i, 1), newBattleEf.substr(i, 1));
				oneNumEffect.addEventListener(Event.COMPLETE, onNumEffectComplete);
				
				_bEfNumbCon.addChild(oneNumEffect);
				
				_bEfNumEffects.push(oneNumEffect);
			}
			oldPower = newPower;
			// 开始
			onNumEffectComplete();
		}
		
		private function clearNumEffect():void
		{
			var i:int;
			for (i = _bEfNumEffects.length - 1; i >= 0; i--) {
				
				_bEfNumEffects[i].removeEventListener(Event.COMPLETE, onNumEffectComplete);
				_bEfNumEffects.splice(i,1);
			}
			_bEfNumEffects.length = 0;
			
			Global.instance.removeChildren(_bEfNumbCon);
			_bEfNumbCon.filters = [];	
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
		
		/**设置数字长度*/
		public function set numLen(wid:Number):void
		{
			this.numwid = wid;
		}
		/**获取数字长度*/
		public function get numLen():Number
		{
			return this.numwid;
		}
	}
}