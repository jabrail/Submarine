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
	

	public class Path1D extends Path
	{
		
		private var begin:Vector.<Number>;
		private var end:Vector.<Number>;
		
		public function Path1D( begin:Vector.<Number>, end:Vector.<Number> )
		{
			
			super();
			
			this.begin = begin;
			this.end = end;
			
		}
		
		override public function solve( t:Number, $solution:Vector.<Number> ) : void
		{
			
			var n:int = begin.length;
			var i:int = -1;
			
			while( ++i < n )
			{
				$solution[ i ] = begin[ i ] + ( end[ i ] - begin[ i ] ) * t;
			}
			
		}
		
	}
}