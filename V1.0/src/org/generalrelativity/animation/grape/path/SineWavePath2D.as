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

	/**
	 * Value on sine wave S at t [0,1] = S(t) = sin( freq * t ) * amplitude 
	 * Point on sine wave S at t [0,1] deviating from the line segment, L and normal vector (to L) w:
	 * S(t) = L(t) + sin( freq * t ) * amplitude * w
	 * */
	public class SineWavePath2D extends LinearPath2D
	{
		
		protected var frequency:Number;
		protected var amplitude:Number;
		
		protected var normal:Point;
		
		//frequency is # of wavelenghths traversed
		public function SineWavePath2D( A:Point, B:Point, frequency:Number = 1.0, amplitude:Number = 20.0 )
		{
			
			super( A, B );
			
			this.frequency = frequency * Math.PI * 2;
			this.amplitude = amplitude;
			
			normal = new Point( -v.y, v.x );
			if( normal.x == 0 && normal.y == 0 )
			{
				normal.y = 1.0;
			}
			else normal.normalize( 1 );
			
		}
		
		override public function solve( t:Number, $solution:Vector.<Number> ) : void
		{
			
			var sine:Number = Math.sin( frequency * t ) * amplitude;
			
			$solution[ 0 ] = A.x + v.x * t + normal.x * sine;
			$solution[ 1 ] = A.y + v.y * t + normal.y * sine;
			
		}
		
		
	}
}