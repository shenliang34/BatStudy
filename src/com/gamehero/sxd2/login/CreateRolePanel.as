package com.gamehero.sxd2.login
{
	import com.gamehero.sxd2.event.CreateRoleEvent;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import bowser.utils.effect.color.ColorTransformUtils;
	
	
	
	/**
	 * 3D角色显示面板
	 * @author xuwenyi
	 * @create 2013-09-22
	 **/
	public class CreateRolePanel extends Sprite
	{
		// 旋转持续时间
		private static const DURATION:Number = 0.4;
		
		
		// 发光颜色（按职业顺序）
		private const FILTER_COLOR:Array = [0x7B8CA0, 0xB30909, 0x89530A, 0x66CC33];
		
		
		// 角色显示对象列表
		private var roles:Array;
		// 角色面板层
		private var roleLayer:Sprite;
		
		/*
		// 效果层
		private var effectCircle:MovieClip;		// 光圈特效
		private var effectLight:MovieClip;		// 光芒特效
		private var effectLight2:MovieClip;		// 光芒特效2
		private var effectSolid1:MovieClip;		// 粒子特效1
		*/
		
		// 当前鼠标移入的对象
		private var over:Role3D;
		
		// 最前方的角色
		public var selectedIdx:int = 0;
		
		// 发光效果
		private var _glowTimer:Timer;
		private var _glowBlur:int = 20;
		private var _glowStrength:Number = .6;
		private var _glowSign:int = 1;
		private var _glowBlurOffset:int = 1;
		private var _glowStrengthOffset:Number = .03;
		
		
		
		/**
		 * 构造函数
		 * */
		public function CreateRolePanel(defaultCareer:int)
		{
			// 默认选中
			selectedIdx = defaultCareer - 1;

			var offsetX:int = -35;
			var offsetY:int = 35;
			
			// 地板
			/*var floor:Bitmap = new Bitmap(this.getRes("FLOOR_BD") as BitmapData);
			floor.x = (-floor.width >> 1) + offsetX;
			floor.y = 70;
			this.addChild(floor);*/
			
			/*
			// 光圈效果
			effectCircle = this.getRes("EFFECT_CIRCLE") as MovieClip;
			effectCircle.mouseChildren = effectCircle.mouseEnabled = false;
			effectCircle.blendMode = BlendMode.ADD;
			effectCircle.width = 441;
			effectCircle.height = 120;
			effectCircle.x = offsetX;
			effectCircle.y = 140 + offsetY;
			this.addChild(effectCircle);
			*/
			
			/*
			// 光芒效果
			effectLight = this.getRes("EFFECT_LIGHT") as MovieClip;
			effectLight.mouseChildren = effectLight.mouseEnabled = false;
			effectLight.blendMode = BlendMode.ADD;
			effectLight.x = offsetX + 5;
			effectLight.y = -135 + offsetY;
			effectLight.alpha = .3;
			this.addChild(effectLight);
			*/
			
			
			// 角色层
			roleLayer = new Sprite();
			roleLayer.x = -48;
			roleLayer.y = -20;
			this.addChild(roleLayer);
			
			// 角色
			roles = [];
			var role3D:Role3D;
			for(var i:int = 0; i < 4; i++)
			{
				// 外部加载
				role3D = new Role3D(getRes("JOB" + (i + 1)) as BitmapData , getRes("STONE") as MovieClip);
				
				role3D.y = -60;
				role3D.radius = 390;
				
				//role.angleY = 0.18 + Math.PI*0.5*(i+1);
//				// 默认第一个是游侠
//				role3D.angleY = Math.PI * 0.5 * (i - 1);
				role3D.angleY = (i - selectedIdx + 1) * Math.PI * 0.5;
				
				roleLayer.addChild(role3D);
				roles.push(role3D);
			}
			
			// 添加角色鼠标事件
			this.addRoleListeners();
			
			
//			// 手动决定加载顺序
//			roles[1].load();
//			roles[0].load();
//			roles[2].load();
//			roles[3].load();
			
			/*
			// 光芒效果2
			effectLight2 = this.getRes("EFFECT_LIGHT2") as MovieClip;
			effectLight2.mouseChildren = effectLight.mouseEnabled = false;
			effectLight2.blendMode = BlendMode.ADD;
			effectLight2.x = offsetX + 5;
			effectLight2.y = -135 + offsetY;
			effectLight2.alpha = .4;
			this.addChild(effectLight2);
			*/
			
		/*	
			// 光芒效果
			effectSolid1 = this.getRes("EFFECT_SOLID_1") as MovieClip;
			effectSolid1.mouseChildren = effectSolid1.mouseEnabled = false;
			effectSolid1.blendMode = BlendMode.ADD;
			effectSolid1.width = 200;
			effectSolid1.height = 218;
			effectSolid1.x = offsetX - 20;
			effectSolid1.y = 50 + offsetY;
			effectSolid1.alpha = .4;
			this.addChild(effectSolid1);
			*/
			
			
			// 摄像机视角
			var projection:PerspectiveProjection = new PerspectiveProjection();
			projection.fieldOfView = 90;
			projection.focalLength = 1000;
			projection.projectionCenter = new Point(0,-250);
			roleLayer.transform.perspectiveProjection = projection;
			
			// 默认选中
//			selectedIdx = 1;
			
			// 高亮选中
			this.focus();
			this.sortZ();
			
			/** TRICKY：需要等待Role3D中素材开始加载，主游戏才是开始加载 */
			SXD2Game.instance.load();
		}
		
		
		
		
		/**
		 * 单击某个角色
		 * */
		private function onRoleClick(e:MouseEvent):void
		{
			var role3D:Role3D = e.currentTarget as Role3D;
			var idx:int = roles.indexOf(role3D);
			
			// 非当前选中角色
			if(idx != selectedIdx)
			{
				// 计算该旋转多少角度
				var angle:Number = 0;
				var diff:int = idx - selectedIdx;
				
				if(diff == 1 || diff == -3)
				{
					angle = -Math.PI*0.5;
				}
				else if(diff == 2 || diff == -2)
				{
					angle = Math.PI;
				}
				else if(diff == 3 || diff == -1)
				{
					angle = Math.PI*0.5;
				}
				
				this.dispatchEvent(new CreateRoleEvent(CreateRoleEvent.SELECT , angle));
			}
		}
		
		
		
		
		/**
		 * 鼠标移入角色
		 * */
		private function onRoleOver(e:MouseEvent):void
		{
			var role3D:Role3D = e.currentTarget as Role3D;
			var idx:int = roles.indexOf(role3D);
			
			// 非当前选中角色
			if(idx != selectedIdx)
			{
				// 高亮
				//ColorTransformUtils.instance.clear(role3D);
				role3D.filters = [new GlowFilter(0xdeddc5)];
				// 保存
				over = role3D;
			}
		}
		
		
		
		
		/**
		 * 鼠标移出角色
		 * */
		private function onRoleOut(e:MouseEvent):void
		{
			var role3D:Role3D = e.currentTarget as Role3D;
			var idx:int = roles.indexOf(role3D);
			
			// 非当前选中角色
			if(idx != selectedIdx)
			{
				// 置灰
				//role3D.filters = [new BlurFilter()];
				//ColorTransformUtils.instance.changeColor(role3D , CreateRoleView.BRIGHT , 0 , CreateRoleView.SATURATION);
				role3D.filters = [];
				// 清除
				over = null;
			}
		}
		
		
		
		
		/**
		 * 旋转
		 * */
		public function rotate(angle:Number):void
		{
			// selectedIdx变化值
			var diff:int = Math.floor(-angle/(Math.PI*0.5));
			selectedIdx += diff;
			
			if(selectedIdx > 3)
			{
				selectedIdx -= 4;
			}
			else if(selectedIdx < 0)
			{
				selectedIdx += 4;
			}
			
			// 所有角色变灰
			this.unfocus();
			
			// 终止发光timer
			_glowTimer.stop();
			
			// 计算持续时间
			var duration:Number = DURATION * int(Math.abs(angle)/(Math.PI*0.5));
			// 旋转
			for(var i:int = 0; i < roles.length; i++)
			{
				var role:Role3D = roles[i];
				role.rotate(angle , duration);
			}
			// 监听事件
			roles[0].addEventListener(Event.COMPLETE , onRotated);
			
			// 排序
			this.addEventListener(Event.ENTER_FRAME , sortZ);
		}
		
		
		
		
		
		/**
		 * 旋转完毕
		 * */
		private function onRotated(e:Event):void
		{
			e.currentTarget.removeEventListener(Event.COMPLETE , onRotated);
			this.removeEventListener(Event.ENTER_FRAME , sortZ);
			
			// 高亮
			this.focus();
			// 派发事件
			this.dispatchEvent(e);
		}
		
		
		
		
		/**
		 * 高亮第一个角色
		 * */
		private function focus():void
		{
			if(!_glowTimer) {
				
				_glowTimer = new Timer(66);
				_glowTimer.addEventListener(TimerEvent.TIMER, onGlowTimer);
			}
			
			// 颜色工具
			var utils:ColorTransformUtils = ColorTransformUtils.instance;
			
			// 高亮主角色
			roles[selectedIdx].filters = [];
			utils.clear(roles[selectedIdx]);
			
			// 忽明忽暗
			_glowBlur = 20;
			_glowStrength = 1;
			// 最终值
			/*_filterBlur = 35;
			_filterStrength = 1.5;*/
			roles[selectedIdx].filters = [new GlowFilter(FILTER_COLOR[selectedIdx], .8, _glowBlur, _glowBlur, _glowStrength, BitmapFilterQuality.MEDIUM)];
			_glowTimer.reset();
			_glowTimer.start();
				
			// 其他角色变暗
			for(var i:int=0;i<roles.length;i++)
			{
				// 不是当前选中的角色, 并且鼠标没有选中他
				var role3D:Role3D = roles[i];
				if(i != selectedIdx && role3D != over)
				{
					//role3D.filters = [new BlurFilter()];
					//ColorTransformUtils.instance.changeColor(roles[i] , CreateRoleView.BRIGHT , 0 , CreateRoleView.SATURATION);
					role3D.filters = [];
				}
			}
		}
		
		
		/**
		 * Glow Timer Handler 
		 * @param event
		 * 
		 */
		private function onGlowTimer(event:TimerEvent):void
		{
			_glowBlur += _glowBlurOffset * _glowSign;
			_glowStrength += _glowStrengthOffset * _glowSign;
			if(_glowBlur > 35) {
			
				_glowSign = -1;
			}
			else if(_glowBlur < 20) {
				
				_glowSign = 1;
			}
				
			roles[selectedIdx].filters = [new GlowFilter(FILTER_COLOR[selectedIdx], .8, _glowBlur, _glowBlur, _glowStrength, BitmapFilterQuality.MEDIUM)];
		}		
		
		
		
		/**
		 * 取消所有角色高亮
		 * */
		private function unfocus():void
		{
			// 所有角色变灰
			for(var i:int=0;i<roles.length;i++)
			{
				var role:Role3D = roles[i];
				role.filters = [];
				//ColorTransformUtils.instance.clear(role);
				//ColorTransformUtils.instance.changeColor(role , CreateRoleView.BRIGHT , 0 , CreateRoleView.SATURATION);
			}
		}
		
		
		
		
		/**
		 * 排序
		 * 
		 */
		private function sortZ(e:Event = null):void
		{
			// 按Z轴排序
			var arr:Array = roles.concat();
			arr.sortOn("z" , Array.NUMERIC);
			arr.reverse();
			
			// 景深
			for(var i:int = 0;i < arr.length; i++)
			{
				roleLayer.setChildIndex(arr[i] , i);
			}
		}
		
		
		
		
		/**
		 * 添加角色鼠标事件
		 * */
		private function addRoleListeners():void
		{
			for(var i:int=0;i<4;i++)
			{
				var role3D:Role3D = roles[i];
				role3D.addEventListener(MouseEvent.CLICK , onRoleClick);
				role3D.addEventListener(MouseEvent.ROLL_OVER , onRoleOver);
				role3D.addEventListener(MouseEvent.ROLL_OUT , onRoleOut);
			}
			
		}
		
		
		
		
		
		/**
		 * 移除角色鼠标事件
		 * */
		private function removeRoleListeners():void
		{
			for(var i:int=0;i<4;i++)
			{
				var role3D:Role3D = roles[i];
				role3D.removeEventListener(MouseEvent.CLICK , onRoleClick);
				role3D.removeEventListener(MouseEvent.ROLL_OVER , onRoleOver);
				role3D.removeEventListener(MouseEvent.ROLL_OUT , onRoleOut);
			}
			
		}
		
		
		
		
		/**
		 * 加载的swf的导出类得到BitmapData 
		 * @param className
		 */
		private function getRes(className:String):Object
		{	
			if(CreateRoleView.DOMAIN)
			{	
				return new (CreateRoleView.DOMAIN.getDefinition(className) as Class)();
			}
			
			return null;
		}
		
	}
}