package com.shrimp.pakour.interfaces
{
	public interface IRender
	{
		/**
		 *	更新函数 
		 * @param advanced	过去的时间
		 * 
		 */		
		function update(advanced:Number):void;
		
		/**
		 *	渲染器名字 
		 * @return 返回类型
		 * 
		 */		
		function get type():String;
		
		/**
		 *	销毁 
		 * 
		 */		
		function destroy():void;
		
		
	}
}