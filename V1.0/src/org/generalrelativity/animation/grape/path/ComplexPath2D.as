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
	

	public class ComplexPath2D extends Path2D
	{
		
		private var paths:Vector.<Path>;
		private var cues:Vector.<Number>;
		
		public function ComplexPath2D( paths:Vector.<Path>, cues:Vector.<Number> )
		{
			
			super();
			
			this.paths = paths;
			this.cues = cues;
			
			cues[ 0 ] = 0.0; //has to be first
			
			var lastCue:Number;
			
			for each( var cue:Number in cues )
			{
				if( cue < 0 || cue > 1.0 )
				{
					throw new Error( "Cues must be in range of 0 to 1" );
				}
				
				if( !isNaN( lastCue ) )
				{
					if( lastCue > cue )
					{
						throw new Error( "Cues must be chronological" );
					}
				} 
				
			}
			
			if( cues.length != paths.length )
			{
				throw new Error( "Path and cue length must be the same" );
			}
			
		}
		
		override public function solve( t:Number, $solution:Vector.<Number> ) : void
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
			
			paths[ index ].solve( ( t - cues[ index ] ) / weight, $solution );
			
		}
		
	}
}