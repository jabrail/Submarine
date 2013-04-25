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

	public class PhysicsPath2D extends Path2D
	{
		
		private var X:Point;
		private var v:Point;
		private var a:Point;
		private var seconds:Number;
		
		public function PhysicsPath2D( X:Point, v:Point, a:Point, seconds:Number )
		{
			
			super();
			
			this.X = X;
			this.v = v;
			this.a = a;
			this.seconds = seconds;
			
		}
		
		override public function solve( t:Number, $solution:Vector.<Number> ) : void
		{
			
			var ts:Number = t * seconds;
			var halfTsSq:Number = ts * ts * 0.5;
			
			$solution[ 0 ] = X.x + v.x * ts + a.x * halfTsSq;
			$solution[ 1 ] = X.y + v.y * ts + a.y * halfTsSq;
		}
		
	}
}