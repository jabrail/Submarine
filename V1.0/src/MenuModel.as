package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	

	public class MenuModel extends Sprite
	{
		public var mass_point : Array = new Array;
		public var Width : Number;
		public var Height : Number;
		public var positionX:Number;
		public var positionY:Number;
	

		public function MenuModel(menu_text : Bitmap,positionX : Number,positionY : Number)
		{
			this.positionX = positionX;
			this.positionY = positionY;
			var l:int=0;
			for (var i:int=0; i<menu_text.width;i+=4)
			{
				for (var k:int=0;k<menu_text.height;k+=4)
				{
					if (menu_text.bitmapData.getPixel32(i,k)>0) 
					{				
						 
						mass_point[l] = new Point(i+positionX,k+positionY);
						l++;
                        k++;
						
					}
				}
		}
			Width = menu_text.width;
			Height = menu_text.height;


		
		}
	
	
	}
}