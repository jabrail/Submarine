package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	import peace.Base;

	public class Submarine1 extends Base
	{
		[Embed(source="images/submarine.png")]
		private var Bg:Class;
		public var bmd : BitmapData;
		public var background : Bitmap;
		public var ds:DisplayObject;
		
		public function Submarine1()
		{
			ds = new Bg();
			
		

			bmd= new BitmapData(ds.width,ds.height,true,0)
				bmd.draw(ds);
				background = new Bitmap(bmd);
			addChild(background);
			this.addEventListener(Event.ENTER_FRAME, Enter_frame);
			
				this.z=0;
			this.transform.matrix3D.appendRotation(180,new Vector3D(0,1,0), new Vector3D(0,200,0));
		
		}
		public function Enter_frame (e:Event) : void
		{
			if (p1==0)
			{
			this.x+=4;
			this.y+=3;
			}
		}
		public function up(k:uint) : void
		{
			if (p1==0)
			{
			this.y-=k/5;
			this.x+=5;
			}
			
		}
		public function hit_event(): void
		{
			var k: int =0;
			k=Math.random()*10;
			if (k<5) {
				this.x+=40;
				this.y+=40;
				
			}
		}

	}
}