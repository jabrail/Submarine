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

package org.generalrelativity.animation.grape
{
	import flash.events.EventDispatcher;
	
	import org.generalrelativity.animation.grape.binding.Binding;
	import org.generalrelativity.animation.grape.curve.Curve;
	import org.generalrelativity.animation.grape.path.Path;

	[Event(name="complete", type="flash.events.Event")]
	[Event(name="loop", type="Animation")]

	final public class Animation extends EventDispatcher
	{
		
		public static const LOOP:String = "loop";
		
		public var start:uint;
		public var duration:uint;
		
		public var loop:Boolean;
		public var reverse:Boolean;
		public var reverseOnLoop:Boolean;
		
		public var curve:Curve;
		public var path:Path;
		
		public var binding:Binding;
		
		public var state:Vector.<Number>;
		
		public function Animation( path:Path, duration:uint, start:uint, curve:Curve = null, loop:Boolean = false, reverse:Boolean = false, reverseOnLoop:Boolean = false )
		{
			
			super();
			
			this.start = start;
			this.duration = duration;
			this.path = path;
			this.curve = curve || new Curve();
			this.loop = loop;
			this.reverse = reverse;
			this.reverseOnLoop = reverseOnLoop;
			
			state = Grape.getInstance().pointerVector;
			
		}
		
		final internal function step( t:Number ) : void
		{
			
			if( reverse ) t = 1.0 - t;
			
			t = curve.getT( t );
			path.solve( t, state );
			
			if( binding ) binding.bind( state );
			
		}
		
		final internal function destroy() : void
		{
			binding = null;
			path = null;
			curve = null;
			Grape.getInstance().returnToPool( state );
			state = null;
		}
		
	}
}