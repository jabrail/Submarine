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

	public class HermiteSplinePath2D extends LinearSplinePath2D
	{
		
		//tangents
		protected var w:Vector.<Number>;
		
		public function HermiteSplinePath2D( points:Vector.<Number>, tangents:Vector.<Number> )
		{ 
			super( points );
			w = tangents;
		}
		
		final override protected function getPoint( index:uint, t:Number, $X:Point ) : void
		{
			
			var tSq:Number = t * t;
			var tCu:Number = tSq * t;
			var tSq3:Number = 3 * tSq;
			var tCu2:Number = 2 * tCu;
			
			var h1:Number =  tCu2 - tSq3 + 1;
			var h2:Number = -tCu2 + tSq3;
			var h3:Number =  tCu - 2 * tSq + t;
			var h4:Number =  tCu - tSq;
			
			$X.x = s[ index ] * h1 + s[ index + 2 ] * h2 + w[ index ] * h3 + w[ index ] * h4;
			$X.y = s[ index + 1 ] * h1 + s[ index + 3 ] * h2 + w[ index + 1 ] * h3 + w[ index + 3 ] * h4;
			
		}
	
		
	}
}