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
	import flash.geom.Point;
	

	public class LinearSplinePath2D extends Path2D
	{
		
		private var X:Point;
		
		protected var s:Vector.<Number>;
		protected var cues:Vector.<Number>;
		
		public function LinearSplinePath2D( points:Vector.<Number> )
		{
			
			super();
			
			X = new Point();
			this.points = points;
			
		}
		
		public function set points( value:Vector.<Number> ) : void
		{
			
			s = value;
            cues = new Vector.<Number>();
           
            var length:Number = 0.0;
           
            var lx:Number = s[ 0 ];
            var ly:Number = s[ 1 ];
           
            for( var i:int = 2; i < s.length - 1; i += 2 )
            {
               
                var x:Number = s[ i ];
                var y:Number = s[ i + 1 ];
               
                var dx:Number = x - lx;
                var dy:Number = y - ly;
               
                var segmentLength:Number = Math.sqrt( dx * dx + dy * dy );
               
                cues.push( segmentLength );
               
                length += segmentLength;
               
                lx = x;
                ly = y;
               
            }
           
            var marker:Number = 0.0;
            for( i = 0; i < cues.length; i++ )
            {
                cues[ i ] /= length;
                marker += cues[ i ];
                cues[ i ] = marker - cues[ i ];
            }
			
		}
		
		final override public function solve( t:Number, $solution:Vector.<Number> ) : void
		{
			
			var n:int = cues.length;
            var index:uint = n - 1;
            var weight:Number = 1.0 - cues[ index ];
           
            for( var i:int = 1; i < n; i++ )
            {
               
                if( cues[ i ] > t )
                {
                    index = i - 1;
                    weight = cues[ i ] - cues[ index ];
                    break;
                }
               
            }
           
            t = ( t - cues[ index ] ) / weight;
            getPoint( index * 2, t, X );
           
            $solution[ 0 ] = X.x;
            $solution[ 1 ] = X.y;
			
		}
		
		protected function getPoint( index:uint, t:Number, $X:Point ) : void
		{
			$X.x = s[ index ] + ( s[ index + 2 ] - s[ index ] ) * t;
			$X.y = s[ index + 1 ] + ( s[ index + 3 ] - s[ index + 1 ] ) * t;
		}
		
		override public function render( graphics:Graphics, resolution:uint = 150 ) : void
		{
			
			super.render( graphics, resolution );
			
			var n:int = s.length;
			
			graphics.lineStyle( 3, 0x880000 );
			for( var i:int = 0; i < n - 1; i += 2 )
			{
				graphics.moveTo( s[ i ] - 3, s[ i + 1 ] - 3 );
				graphics.lineTo( s[ i ] + 3, s[ i + 1 ] + 3 );
				graphics.moveTo( s[ i ] + 3, s[ i + 1 ] - 3 );
				graphics.lineTo( s[ i ] - 3, s[ i + 1 ] + 3 );
			}
			
		}
		
	}
}