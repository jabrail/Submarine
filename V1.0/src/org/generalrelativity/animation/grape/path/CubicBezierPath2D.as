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

	public class CubicBezierPath2D extends QuadraticBezierPath2D
	{
		
		private var control2:Point;
		
		public function CubicBezierPath2D( anchor1:Point, control1:Point, control2:Point, anchor2:Point, reparametrize:Boolean = false )
		{
			
			
			this.control2 = control2;
			
			super( anchor1, control1, anchor2, reparametrize );
			
		}
		
		override protected function getPoint( t:Number, $X:Point ) : void
		{
			
			var tSq:Number = t * t;
			var tCu:Number = tSq * t;
			var omt:Number = 1 - t;
			var omtSq:Number = omt * omt;
			var omtCu:Number = omtSq * omt;
			
			$X.x = anchor1.x * omtCu + control1.x * 3 * omtSq * t + control2.x * 3 * omt * tSq + anchor2.x * tCu;
			$X.y = anchor1.y * omtCu + control1.y * 3 * omtSq * t + control2.y * 3 * omt * tSq + anchor2.y * tCu;
			
		}
		
		override protected function getDerivative( t:Number, $X:Point ) : void
		{
			
			var t3:Number = 3 * t;
			var t3Sq:Number = t3 * t3;
			
			var exp1:Number = -3 * ( 1 - t * 2 + t * t );
			var exp2:Number = t3 * ( 4 - t3 );
			var exp3:Number = t3 * ( 2 - t3 );
			
			$X.x = anchor1.x * exp1 - control1.x * exp2 + control2.x * exp3 + t3Sq * anchor2.x;
			$X.y = anchor1.y * exp1 - control1.y * exp2 + control2.y * exp3 + t3Sq * anchor2.y;
			
		}
		
		
	}
}