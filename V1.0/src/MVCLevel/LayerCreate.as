package MVCLevel
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Bezier;
	import flash.geom.Point;
	import flash.text.TextField;
	

	public class LayerCreate extends Sprite
	{
		public var image : Bitmap;
		public var speed : Number;
		public var flag : Number=0;
		public var bitmapData : BitmapData;
		public var ds : DisplayObject;
		public var trajectory : Array;
		public var stattrajectory : Number=0;
		public var massArray : Array = new Array();
		public var masspoint : Array = new Array();
		public var roundObject : Shape = new Shape();
		public var bitmap : Bitmap;
		public var bitmapdata : BitmapData;
		public var indexTraj : int = 0;
		public var time : Number=0;
		public var trajsost : Number=1;
		public var bezier : Bezier;
		public var statusobj : Number = 0;
		public function LayerCreate(image:BitmapData,speed1:Number)
		{
			this.image = new Bitmap(image);
			addChild(this.image);
			speed = speed1;
            bitmapdata =  image;
			//this.visible=false;
			
		}
		public function enterFrame() : void
		{
		/*	if (statusobj==0)
			{
				if (flag==1)
				{
					this.x+=3;
					this.y+=3;
				}
				else {
					if (fitline)
						if (fitline.fitPoints.length+2>=indexTraj)
						{	stattrajectory = 0;
							indexTraj=0;
							if(trajsost==0)
								this.visible=false;
                        }

					if (stattrajectory==1)
					{
						if (time>=0)
						{
							bezier.start = fitline._fitPoints[indexTraj-2];
							bezier.control = fitline._fitPoints[indexTraj-1];
							bezier.end = fitline._fitPoints[indexTraj];
							var point : Point = bezier.getPoint(time)
							this.x=point.x;
							this.y=point.y;
							time-=0.009;
						}
						else if (time<0)
						{
							time=1;
							indexTraj-=2;

						}
					}

				}
			}
	*/	}
		public function onMove() : void
		{
			this.flag=1;
			
		}
		public function moveUp(x:Number) : void
		{
			this.x-=x;
			
		}
		public function trajectoryMove() : void
		{
			
		/*	massArray[0]=new Point(0,Math.random()*450);
			for (var m : int = 1; m<3;m++)
			{
				massArray[m] = new Point((m*300),((Math.random()*450)));
			}
			fitline = new FitLine(massArray);

			bezier = new Bezier();
			var time : Number=0;
			var indexmasspoint : int = 0;
			stattrajectory = 1;
			indexTraj = fitline.fitPoints.length;
			trajsost=1;
			this.visible=true;
		*/
        }
		
		
		
	}
}