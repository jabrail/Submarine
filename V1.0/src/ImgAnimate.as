package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;

	public class ImgAnimate extends Sprite
	{
		public var imgArray  : Array = new  Array();
		public var speed : Number;
		public var cadr : Number=0;
		public var sum : Number=0;
		public var bitmapArray : Array = new Array();
		public function ImgAnimate(imgMass: Array,speed1 : Number)
		{
			for (var i : int=0;i<imgMass.length;i++)
			{
				bitmapArray[i] = new Bitmap(imgMass[i]);
				addChild(bitmapArray[i]);
				bitmapArray[i].visible = false;
			}
			imgArray = imgMass;
			this.speed = speed1;
			

		}
		public function enterFrame() : void
		{
			if (sum==speed)
			{
			
				for (var i : int=0; i<bitmapArray.length;i++)
				{
				if(i==cadr) 
				{bitmapArray[i].visible = true; }
				else
				{ bitmapArray[i].visible = false;  }
				}
				cadr++;
				sum=0;
				if (cadr==bitmapArray.length) cadr=0;
			}
			sum++;
		}	
	}
}