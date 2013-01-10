package MVCLevel
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display3D.IndexBuffer3D;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class StoneCreate 
	{
		[Embed(source="../images/Stone/1.png")]
		public var BgStone1:Class;
		[Embed(source="../images/Stone/2.png")]
		public var BgStone2:Class;
		[Embed(source="../images/Stone/3.png")]
		public var BgStone3:Class;
		[Embed(source="../images/Stone/4.png")]
		public var BgStone4:Class;
		[Embed(source="../images/Stone/5.png")]
		public var BgStone5:Class;
		[Embed(source="../images/Stone/6.png")]
		public var BgStone6:Class;
		[Embed(source="../images/Stone/7.png")]
		public var BgStone7:Class;
		[Embed(source="../images/Stone/8.png")]
		public var BgStone8:Class;
		[Embed(source="../images/Stone/9.png")]
		public var BgStone9:Class;
		[Embed(source="../images/Stone/10.png")]
		public var BgStone10:Class;
		[Embed(source="../images/Stone/11.png")]
		public var BgStone11:Class;
		[Embed(source="../images/Stone/12.png")]
		public var BgStone12:Class;
		[Embed(source="../images/Stone/13.png")]
		public var BgStone13:Class;
		[Embed(source="../images/Stone/14.png")]
		public var BgStone14:Class;
		[Embed(source="../images/Stone/15.png")]
		public var BgStone15:Class;
		[Embed(source="../images/Stone/st/1.png")]
		public var BgStoneStart1:Class;
		[Embed(source="../images/Stone/st/2.png")]
		public var BgStoneStart2:Class;
		[Embed(source="../images/Stone/st/3.png")]
		public var BgStoneFinish1:Class;
		[Embed(source="../images/Stone/st/4.png")]
		public var BgStoneFinish2:Class;
		public var arrayStoneBitmap: Array = new Array();
		public var start1 : Bitmap;
		public var start2 : Bitmap;
		public var finish1 : Bitmap;
		public var finish2 : Bitmap;
		public var urlRequest : URLRequest;
		public var urlLoader : Loader;
		public var xmlUrlLoader : URLLoader;
		public var xmltest : XML;
		public var bitmap :Bitmap;
		public var bitmapdata :BitmapData;
		
		
		
		public function StoneCreate()
		{
			
			urlRequest = new URLRequest('test.xml');
			xmlUrlLoader = new URLLoader(urlRequest);
			urlLoader = new Loader();
			//urlLoader.load(urlRequest);
			xmlUrlLoader.addEventListener(Event.COMPLETE,loadComplite);
			
			
			
			
		}
		public function loadComplite(e:Event):void
		{
			

		}
		public function returnclass(index : int) : Class
		{
			if (index==0) return(BgStone1)
			else if (index==1) return(BgStone2);
			else if (index==2) return(BgStone3);
			else if (index==3) return(BgStone4);
			else if (index==4) return(BgStone5);
			else if (index==5) return(BgStone6);
			else if (index==6) return(BgStone7);
			else if (index==7) return(BgStone8);
			else if (index==8) return(BgStone9);
			else if (index==9) return(BgStone10);
			else if (index==10) return(BgStone11);
			else if (index==11) return(BgStone12);
			else if (index==12) return(BgStone13);
			else if (index==13) return(BgStone14);
			else if (index==14) return(BgStone15);
			else return(BgStone15);
			
		}
	}
}