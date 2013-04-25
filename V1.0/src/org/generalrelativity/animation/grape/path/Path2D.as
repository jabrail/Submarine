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
	import flash.display.Graphics;

	public class Path2D extends Path
	{
		public function Path2D()
		{
			super();
		}
		
		public function render( graphics:Graphics, resolution:uint = 150 ) : void
		{
			
			graphics.lineStyle( 1, 0x1199A1 );
			
			var X:Vector.<Number> = new Vector.<Number>();
			solve( 0.0, X );
			
			graphics.moveTo( X[ 0 ], X[ 1 ] );
			
			for( var i:int = 1; i <= resolution; i++ )
			{
				solve( i / resolution, X );
				graphics.lineTo( X[ 0 ], X[ 1 ] );
			}
			
		}
		
	}
}