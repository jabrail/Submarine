package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
import flash.net.drm.VoucherAccessInfo;
import flash.sampler.NewObjectSample;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import mx.core.MovieClipAsset;
	import mx.core.MovieClipLoaderAsset;

	public class MenuView extends Sprite
	{
		[Embed(source="images/fish.swf", mimeType="application/octet-stream")]
		private var Bg1:Class;
		[Embed(source="images/1.png")]
		public var forArray1 : Class;
		[Embed(source="images/2.png")]
		public var forArray2 : Class;
		[Embed(source="images/3.png")]
		public var forArray3 : Class;
		[Embed(source="images/4.png")]
		public var forArray4 : Class;
		[Embed(source="images/5.png")]
		public var forArray5 : Class;
		public var forArrayObf1 : DisplayObject;
		public var forArrayObf2 : DisplayObject;
		public var forArrayObf3 : DisplayObject;
		public var forArrayObf4 : DisplayObject;
		public var forArrayObf5 : DisplayObject;
		public var massFish : Array = new Array();
		public var massMovie : Array = new Array();		
		public var massLoader : Array = new Array();
		public var otnPrirX:Number;
		public var otnPrirY:Number;
		private var dispobj1: MovieClip;
	
		public var clickPlace : Sprite = new Sprite();
		public var sostClick : Number = 0;
		public 	var loader : Loader;
		public var com : Number = 0;
		public var colMov : Number=0;
		public var colFish : Number;
		public var bitmapDataArray : Array = new Array();
		public var bitmapdata1 : BitmapData;
		public var bitmapdata2 : BitmapData;
		public var bitmapdata3 : BitmapData;
		public var bitmapdata4 : BitmapData;
		public var bitmapdata5 : BitmapData;
		
	
		
		public function MenuView()
		{
            var background : Bitmap = new Asset.background;
            addChild(background);
            background.width= 800;
            background.height=600;
			forArrayObf1 = new forArray1();
			forArrayObf2 = new forArray2();
			forArrayObf3 = new forArray3();
			forArrayObf4 = new forArray4();
			forArrayObf5 = new forArray5();
			bitmapdata1  = new BitmapData(forArrayObf1.width,forArrayObf1.height,true,0);
			bitmapdata2  = new BitmapData(forArrayObf2.width,forArrayObf2.height,true,0);
			bitmapdata3  = new BitmapData(forArrayObf3.width,forArrayObf3.height,true,0);
			bitmapdata4  = new BitmapData(forArrayObf4.width,forArrayObf4.height,true,0);
			bitmapdata5  = new BitmapData(forArrayObf5.width,forArrayObf5.height,true,0);
			bitmapdata1.draw(forArrayObf1);
			bitmapdata2.draw(forArrayObf2);
			bitmapdata3.draw(forArrayObf3);
			bitmapdata4.draw(forArrayObf4);
			bitmapdata5.draw(forArrayObf5);
			bitmapDataArray[0] = bitmapdata1;
			bitmapDataArray[1] = bitmapdata2;
			bitmapDataArray[2] = bitmapdata3;
			bitmapDataArray[3] = bitmapdata4;
			bitmapDataArray[4] = bitmapdata5;
		
	
			
		
			
		
			
		
		
		}
		public function update() :void
		{
			for (var i:int=0;i<massFish.length;i++)
			{
				massFish[i].enter();
			}
		}

		public function constr(mass_point : Array) : void
		{
			
			var j:int=0;
			for (var i : int =0; i<mass_point.length;i++)
			{
				if (massFish[j]==null)
				{
					
					
			
					massFish[j] = new FishView(bitmapDataArray,3);
					addChild(massFish[j]);	
		
					
				}
					
				if (j<massFish.length)
				{
					massFish[j].trajectoryMove(mass_point[i]);
					j++;
					
					
				}
			}
			
			
			if (j<massFish.length)
				for(j;j<massFish.length;j++)
				{
					massFish[j].trajectoryMove(new Point(0,0));
					massFish[j].trajsost=0;					
				}
			
			
		}
		public function reposition (mass_point: Array) : void 
		{
			
			
			var j:int=0;
				for (var i : int =0; i<mass_point.length;i++)
				{
					if (massFish[j]==null)
					{
						massFish[j] = new FishView(bitmapDataArray,3);
						addChild(massFish[j]);				
					}
				    if (j<massFish.length)
					{
					massFish[j].trajectoryMove(mass_point[i]);
					j++;
					
					
				}
				
				}
				if (j<massFish.length)
					for(j;j<massFish.length;j++)
					{
						massFish[j].trajectoryMove(new Point(0,0));
						massFish[j].trajsost=0;		
					}
						
				
				
			
			
		}
		
		public function Visible(Visible : Boolean):void
		{
			for (var i: int; i<massFish.length;i++)
			{
				massFish[i].visible = Visible;
				
			}
			clickPlace.visible = false;
		}
		private function down(e:Event) : void
		{
			sostClick=1;
		}
		private function Up(e:Event) : void
		{
			sostClick=0;
		}
	}
}