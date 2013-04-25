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
	

	public class CatmullRomSplinePath2D extends HermiteSplinePath2D
	{
		
		public function CatmullRomSplinePath2D( points:Vector.<Number> )
		{
			
			var n:int = points.length;
			
			var dpx:Number = points[ n - 2 ] - points[ 0 ];
			var dpy:Number = points[ n - 1 ] - points[ 1 ];
			
			var tangents:Vector.<Number> = new Vector.<Number>( points.length );
			
			for( var i:int = 0; i < n - 1; i += 2 )
			{
				
				var p0x:Number, p0y:Number, p1x:Number, p1y:Number;
				
				if( i == 0 )
				{
					p0x = points[ 0 ] - dpx;
					p0y = points[ 1 ] - dpy;
				}
				else
				{
					p0x = points[ i - 2 ];
					p0y = points[ i - 1 ];
				}
				
				if( i == n - 2 )
				{
					p1x = points[ n - 2 ] + dpx;
					p1y = points[ n - 1 ] + dpy;
				}
				else
				{
					p1x = points[ i + 2 ];
					p1y = points[ i + 1 ];
				}
				
				tangents[ i ] = ( p1x - p0x ) * 0.5;
				tangents[ i + 1 ] = ( p1y - p0y ) * 0.5;
				
				
			}
			
			super( points, tangents );
			
		}
	}
}