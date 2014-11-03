package com.shrimp.pakour.utils
{
	import com.shrimp.pakour.interfaces.IRender;
	
	import flash.utils.Dictionary;

	/**
	 *	渲染器的池子 
	 * @author Sol
	 * 
	 */	
	public class RenderPool
	{
		private var dic:Dictionary = new Dictionary();
		public function RenderPool()
		{
		}
		
		/**
		 *	向渲染池内添加渲染器 
		 * @param state	引擎状态
		 * @param render	渲染器
		 * 
		 */		
		public function push(state:int,render:IRender):void
		{
			if(!dic[state])
			{
				dic[state] = [];
			}
			
			var renders:Array = dic[state];
			//如果渲染池子里没有该渲染器,则将其放入到字典里
			if(renders.indexOf(render) == -1)
			{
				renders.push(render);
			}
			
			dic[state] = renders;
		}
		
		/**
		 *	根据引擎状态返回渲染器列表 
		 * @param state	引擎状态
		 * @return 渲染器列表
		 * 
		 */		
		public function getRenders(state:int):Array
		{
			if(!dic[state])
			{
				return [];
			}
			
			return dic[state] as Array;
		}
		
		/**
		 *	根据引擎状态删除渲染器列表 
		 * @param state
		 * 
		 */		
		public function deleteRenders(state:int):void
		{
			if(!dic[state])
			{
				return;
			}
			
			var arr:Array = dic[state] as Array;
			
			for each(var iRender:IRender in arr)
			{
				iRender.destroy();
			}
			
			arr=[];
			dic[state]=[];
			delete dic[state];
		}
		
		/**
		 *	根据引擎状态删除渲染器 
		 * @param state	引擎状态
		 * @param render	渲染器实例
		 * 
		 */		
		public function deleteRenderByState(state:int,render:IRender):void
		{
			if(!dic[state])
			{
				return;
			}
			
			var arr:Array = dic[state] as Array;
			
			var index:int = arr.indexOf(render);
			
			if(index!=-1)
			{
				arr.splice(render,1);
			}
			
			dic[state] = arr;
		}
	}
}