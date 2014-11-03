package com.shrimp.pakour.core
{
	import com.shrimp.pakour.constants.EngineStateEnum;
	import com.shrimp.pakour.interfaces.IRender;
	import com.shrimp.pakour.utils.RenderPool;
	
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.utils.OnDemandEventDispatcher;

	[Event(name="complete", type="flash.events.Event")]
	public class Engine extends EventDispatcher
	{
		/**	version*/
		public static const VERSION:String="0.0.1";
		/**	拿到舞台*/
		public static var stage:Stage;
		
		private var _gameTime:Number;
		private var _startTime:Number;
		private var _nowTime:Number;
		protected var _timeDelta:Number;
		
		/**	渲染器列表*/
		protected var _renderPool:RenderPool;
		
		/**	引擎是否准备投入使用状态*/
		public var isReady:Boolean=false;
		
		/**	前一个状态*/
		private var preState:int;
		
		private static const timer:Shape = new Shape();
		
		public function Engine(stage:Stage)
		{
			Engine.stage = stage;
		}
		
		/**	初始化引擎*/
		public function initEngine():void
		{
			
			_gameTime = _startTime = new Date().time;
			
			_renderPool = new RenderPool();
			
			isReady = true;
			
			if(hasEventListener("complete"))
			{
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		/**	引擎开始*/
		public function start():void
		{
			timer.removeEventListener(Event.ENTER_FRAME,update);
			timer.addEventListener(Event.ENTER_FRAME,update);
		}
		
		/**	引擎停止*/
		public function stop():void
		{
			timer.removeEventListener(Event.ENTER_FRAME,update);
		}
		
		/**	引擎恢复*/
		public function resume():void
		{
			state = EngineStateEnum.RESUME;
		}
		
		/**	引擎暂停*/
		public function pause():void
		{
			state = preState;
		}
		
		
		/**
		 *	更新函数 
		 * 
		 */		
		protected function update():void
		{
			_nowTime = new Date().time;
			_timeDelta = (_nowTime - _gameTime) * 0.001;
			_gameTime = _nowTime;
			
			//根据state,_timeDelta更新
			//根据state,得到对应的渲染器列表.进行渲染
			var arr:Array = _renderPool.getRenders(state);
			
			for each (var render:IRender in arr) 
			{
				render.update(_timeDelta);
			}
		}
		
		//=====================================================================//
		//																	   //
		//							getter & setter							   //
		//																	   //
		//=====================================================================//

		private var _state:int;
		/**	引擎当前所处状态*/
		public function get state():int
		{
			return _state;
		}

		public function set state(value:int):void
		{
			preState = _state;
			_state = value;
		}
	}
}