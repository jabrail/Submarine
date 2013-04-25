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

package org.generalrelativity.animation.grape.path
{
	import flash.geom.Point;

	public class QuadraticBezierPath2D extends Path2D
	{
		
		protected var anchor1:Point;
		protected var anchor2:Point;
		protected var control1:Point;
		
		private var reparametrize:Boolean;
		private var arcLength:Number;
		private var reparametrizedTable:Vector.<Number>;
		
		protected var X:Point;
		
		public function QuadraticBezierPath2D( anchor1:Point, control1:Point, anchor2:Point, reparametrize:Boolean = false )
		{
			
			super();
			
			this.anchor1 = anchor1;
			this.anchor2 = anchor2;
			
			this.control1 = control1;
			this.reparametrize = reparametrize;
			
			if( reparametrize )
			{
				
				arcLength = getArcLength( 1.0 );
				reparametrizedTable = new Vector.<Number>();
				
				for( var i:int = 0; i < 300; i++ )
				{
					reparametrizedTable[ i ] = getReparametrizedT( i / 300 );
				}
				
			}
			
			X = new Point();
			
		}
		
		override public function solve( t:Number, $solution:Vector.<Number> ) : void
		{
			
			if( reparametrize )
			{
				
				var indexFloat:Number = ( reparametrizedTable.length ) * t;
				var index:uint = uint( indexFloat );
				
				var t0:Number;
				var t1:Number;
				
				if( index != 0 )
				{
					
					if( index >= reparametrizedTable.length )
					{
						t0 = reparametrizedTable[ index - 1 ];
						t1 = 1.0;
					}
					else
					{
						t0 = reparametrizedTable[ index - 1 ];
						t1 = reparametrizedTable[ index ];
					}
					
				}
				else
				{
					t0 = 0.0;
					t1 = reparametrizedTable[ 0 ];
				}
				
				t = t0 + ( t1 - t0 ) * ( indexFloat - index );
				
			}
			
			getPoint( t, X );
			
			$solution[ 0 ] = X.x;
			$solution[ 1 ] = X.y;
			
		}
		
		final private function getArcLength( s:Number ) : Number
		{
			
			const RESOLUTION:uint = 30;
			
			var step:Number = s * ( 1 / RESOLUTION );
			var t:Number = 0;
			
			var last:Point = anchor1.clone();
			var next:Point = new Point();
			
			var length:Number = 0;
			
			for( var i:int = 1; i <= RESOLUTION; i++ )
			{
				
				getPoint( t, next );
				
				var dx:Number = next.x - last.x;
				var dy:Number = next.y - last.y;
				
				length += Math.sqrt( dx * dx + dy * dy );
				
				last.x = next.x;
				last.y = next.y;
				
				t += step;
				
			}
			
			return length;
			
		}
		
		protected function getPoint( t:Number, $X:Point ) : void
		{
			
			var tSq:Number = t * t;
			var omt:Number = 1 - t;
			var tOmt2:Number = t * omt * 2;
			var omtSq:Number = omt * omt;
			
			$X.x = anchor1.x * omtSq + control1.x * tOmt2 + tSq * anchor2.x;
			$X.y = anchor1.y * omtSq + control1.y * tOmt2 + tSq * anchor2.y;
			
		}
		
		protected function getDerivative( t:Number, $X:Point ) : void
		{
			
			var P0:Point = control1.subtract( anchor1 );
			var P1:Point = anchor2.subtract( control1 );
			
			$X.x = ( 1 - t ) * P0.x + t * P1.x;
			$X.y = ( 1 - t ) * P0.y + t * P1.y;
			
		}
		
		final private function getReparametrizedT( s:Number ) : Number
		{
			
			const MAX_ITERATIONS:uint = 30;
			const EPSILON:Number = 1E-2;
			
			s *= arcLength;
			
			var t:Number = s / arcLength;
			var DX:Point = new Point();
			
			for( var i:int = 0; i < MAX_ITERATIONS; i++ )
			{
				
				var f:Number = getArcLength( t ) - s;
				if( Math.abs( f ) < EPSILON ) return t;
				
				getDerivative( t, DX );
				t -= f / ( DX.length / t );
				
			}
			
			return t;
			
		}
		
		
	}
}