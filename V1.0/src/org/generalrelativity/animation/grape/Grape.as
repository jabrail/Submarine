/*
Copyright (c) 2009 Drew Cummins

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/

package org.generalrelativity.animation.grape
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getTimer;
	
	import org.generalrelativity.animation.grape.binding.Binding2D;
	import org.generalrelativity.animation.grape.binding.PropertyBinding;
	import org.generalrelativity.animation.grape.curve.Curve;
	import org.generalrelativity.animation.grape.path.Path1D;
	import org.generalrelativity.animation.grape.path.Path2D;

	[Event(name="tick", type="Grape")]

	public class Grape extends EventDispatcher
	{
		
		public static const TICK:String = "tick";
		
		private static var instance:Grape;
		
		private var _poolSize:uint = 500;
		private var pool:Vector.<Vector.<Number>>;
		
		private var ticker:Sprite;
		private var animations:Vector.<Animation>;
		
		public function Grape( singletonEnforcer:SingletonEnforcer )
		{
			
			super();
			
			if( instance != null )
			{
				throw new Error( "Can't directly instantiate Animator" );
			}
			
			ticker = new Sprite();
			animations = new Vector.<Animation>();
			
			pool = new Vector.<Vector.<Number>>();
			resizePool();
			
		}
		
		public function addAnimation( animation:Animation ) : void
		{
			animations.push( animation );
			if( !ticker.hasEventListener( Event.ENTER_FRAME ) )
			{
				ticker.addEventListener( Event.ENTER_FRAME, onTick );
			}
		}
		
		public function removeAnimation( animation:Animation ) : void
		{
			var ai:int = animations.indexOf( animation );
			if( ai > -1 )
			{
				animations.splice( ai, 1 );
			}
			
			animation.destroy();
			
		}
		
		public function create2DAnimation( view:DisplayObject, path:Path2D, duration:uint, start:int = -1, curve:Curve = null, loop:Boolean = false, reverse:Boolean = false, reverseOnLoop:Boolean = false, autoAdd:Boolean = true ) : Animation
		{
			
			if( start < 0 ) start = getTimer();
			
			var animation:Animation = new Animation( path, duration, start, curve, loop, reverse, reverseOnLoop );
			animation.binding = new Binding2D( view );
			
			if( autoAdd ) addAnimation( animation );
			return animation;
			
		}
		
		public function createPropertyAnimation( object:Object, properties:Vector.<String>, targets:Vector.<Number>, duration:uint, start:int = -1, curve:Curve = null, loop:Boolean = false, reverse:Boolean = false, reverseOnLoop:Boolean = false, autoAdd:Boolean = true ) : Animation
		{
			
			if( start < 0 ) start = getTimer();
			
			var begin:Vector.<Number> = new Vector.<Number>();
			for each( var property:String in properties )
			{
				begin.push( object[ property ] );
			}
			
			var path:Path1D = new Path1D( begin, targets );
			
			var animation:Animation = new Animation( path, duration, start, curve, loop, reverse, reverseOnLoop );
			animation.binding = new PropertyBinding( object, properties );
			
			if( autoAdd ) addAnimation( animation );
			return animation;
			
		}
		
		private function onTick( event:Event ) : void
		{
			 
			var time:uint = getTimer();
			
			var n:int = animations.length;
			while( --n > -1 )
			{
				
				var animation:Animation = animations[ n ];
				
				if( time < animation.start ) continue;
				
				var t:Number = ( time - animation.start ) / animation.duration;
				var animationIsExpired:Boolean = false;
				
				if( t >= 1.0 )
				{
					
					if( animation.loop )
					{
						t -= uint( t );
						animation.start += animation.duration;
						if( animation.reverseOnLoop ) animation.reverse = !animation.reverse;
						animation.dispatchEvent( new Event( Animation.LOOP ) );
					}
					else
					{
						t = 1.0;
						animationIsExpired = true;
					}
					
				}
				
				animation.step( t );
				
				if( animationIsExpired )
				{
					animation.dispatchEvent( new Event( Event.COMPLETE ) );
					animation.destroy();
					animations.splice( n, 1 );
				}
				
			}
			
			dispatchEvent( new Event( TICK ) );
			
		}
		
		public function get pointerVector() : Vector.<Number>
		{
			if( !pool.length ) return new Vector.<Number>();
			return pool.pop();
		}
		
		public function returnToPool( pointerVector:Vector.<Number> ) : void
		{
			if( pool.length < _poolSize )
			{
				pool.push( pointerVector );
			}
		}
		
		public function set poolSize( value:uint ) : void
		{
			
			if( _poolSize != value )
			{
				_poolSize = value;
				resizePool();
			}
			
		}
		
		private function resizePool() : void
		{
			
			if( pool.length > _poolSize )
			{
				pool.splice( 0, _poolSize );
			}
			else
			{
				
				while( pool.length < _poolSize )
				{
					pool.push( new Vector.<Number>() );
				}
				
			}
			
		}
		
		public static function getInstance() : Grape
		{
			if( instance == null ) instance = new Grape( new SingletonEnforcer() );
			return instance;
		}
		
	}
}

class SingletonEnforcer{}