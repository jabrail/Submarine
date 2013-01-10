package
{
import MVCLevel.MyLoader;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.display.Shape;
import flash.display.Sprite;
import flash.display3D.IndexBuffer3D;
import flash.events.Event;
import flash.geom.Bezier;
import flash.geom.Point;
import flash.geom.Vector3D;
import flash.net.FileFilter;

import silin.geom.FitLine;

public class FishView extends Sprite
{

	public var background1 : Bitmap;
	public var z1 : Number =0;
	public var start_move : Number=0;
	public var shag : Point = new Point;
	public var speedMove : Point= new Point;
	public var stattrajectory : Number=0;
	public var massArray : Array = new Array();
	public var masspoint : Array = new Array();
	public var roundObject : Shape = new Shape();
	public var bitmap : Bitmap;
	public var bitmapdata : BitmapData;
	public var indexTraj : int = 0;
	public var bezier : Bezier;
	public var time : Number = 0;
	public var fitline : FitLine;
	private var a : Number;
	private var x1 : Number;
	private var y1 : Number;
	public var alpha1 : Number = 0;
	public var trajsost : Number=1;
	public var fishObj : Shape;
	private var statusEnd : int = 0;



	public function FishView(Bg1 : Array,speed:Number)
	{


		fishObj = new Shape();
        fishObj.graphics.beginFill(0x000000);
        fishObj.graphics.drawRect(0,0,2,2);
		addChild(fishObj);
		/*fishObj.scaleX=0.7;
		fishObj.scaleY=0.7;
		fishObj.x=11.2;
		fishObj.rotationZ = 180;
		this.rotation=30;*/




	}
	public function rotat(n:Number) : void
	{
		this.rotation= n;
	}
	public function enter() : void
	{
	//	fishObj.enterFrame();


		if (fitline)
			if (fitline.fitPoints.length-2<=indexTraj)
			{	stattrajectory = 0;
				indexTraj=0;
				if(trajsost==0)
					this.visible=false;


			}

		if (stattrajectory==1)
		{


			if (time<1.02)
			{
				bezier.start = fitline._fitPoints[indexTraj];
				bezier.control = fitline._fitPoints[indexTraj+1];
				bezier.end = fitline._fitPoints[indexTraj+2];
				var point : Point = bezier.getPoint(time)
				this.x=point.x;
				this.y=point.y;

				time+=0.02;
				alpha1+=0.002;
				x1 = bezier.getPoint(time).x;
				y1 = bezier.getPoint(time).y;
				if (this.rotation>360) this.rotation=0;
				if (this.rotation<-360) this.rotation=0;
				a=Math.atan2(y1-this.y,x1-this.x)*180/Math.PI;
				a=this.rotation-a;

				if (a > 180) a = -360 + a;
				else if (a < -180) a = 360 + a;

				if (Math.abs(a) < 8) this.rotation -= a;
				else if (a > 0) this.rotation += 8;
				else this.rotation -= 8;
				statusEnd = 1;






			}
			else if (time>1)
			{
				time=0;
				indexTraj+=2;


			}





		}
		else if (statusEnd==1)
		{
			x1 = 0;
			y1 = 0;
			for (var i: int=0;i<30;i++)
			{
			if (this.rotation>360) this.rotation=0;
			if (this.rotation<-360) this.rotation=0;
			a=Math.atan2(y1-this.y,x1-this.x)*180/Math.PI;
			a=this.rotation-a;

			if (a > 180) a = -360 + a;
			else if (a < -180) a = 360 + a;

			if (Math.abs(a) < 8) this.rotation -= a;
			else if (a > 0) this.rotation += 8;
			else this.rotation -= 8;
			statusEnd = 0;


		}
		}


		/*	if (this.x>persp_p.x)
		 start_move=5;
		 */	}


	public function constr() : void
	{
		start_move=7;
	}
	public function coordPlace1 () : void
	{
		this.x+=speedMove.x;
		this.y-=speedMove.y;

	}
	public function coordPlace2 () : void
	{
		this.x+=speedMove.x;
		this.y+=speedMove.y;
	}
	public function coordPlace3 () : void
	{
		this.x-=speedMove.x;
		this.y+=speedMove.y;
	}
	public function coordPlace4 () : void
	{
		this.x-=speedMove.x;
		this.y-=speedMove.y;
	}
	public function trajectoryMove(lastPoint: Point) : void
	{

		massArray[0]=new Point(this.x,this.y);

		for (var m : int = 1; m<3;m++)
		{
			var random : Number = Math.random()*4;
			if (random<1)
			{
				if (m<2)
					massArray[m] = new Point((this.x+(Math.random()*(Math.random()*800*(m)))),(this.y+(Math.random()*(Math.random()*600*(m)))));
				else
					massArray[m] = new Point((lastPoint.x+(Math.random()*(Math.random()*800*(2-m)))),(lastPoint.y+(Math.random()*(Math.random()*600*(2-m)))));

			} else if (random<2) {
				if (m<2)
					massArray[m] = new Point((this.x+(Math.random()*(Math.random()*(-800)*(m)))),(this.y+(Math.random()*(Math.random()*(600)*(m)))));
				else
					massArray[m] = new Point((lastPoint.x+(Math.random()*(Math.random()*(-800)*(2-m)))),(lastPoint.y+(Math.random()*(Math.random()*(600)*(2-m)))));
			}
			else if (random<3) {
				if (m<2)
					massArray[m] = new Point((this.x+(Math.random()*(Math.random()*(800)*(m)))),(this.y+(Math.random()*(Math.random()*(-600)*(m)))));
				else
					massArray[m] = new Point((lastPoint.x+(Math.random()*(Math.random()*(800)*(2-m)))),(lastPoint.y+(Math.random()*(Math.random()*(-600)*(2-m)))));
			}
			else if (random<4) {
				if (m<2)
					massArray[m] = new Point((this.x+(Math.random()*(Math.random()*(-800)*(m)))),(this.y+(Math.random()*(Math.random()*(-600)*(m)))));
				else
					massArray[m] = new Point((lastPoint.x+(Math.random()*(Math.random()*(-800)*(2-m)))),(lastPoint.y+(Math.random()*(Math.random()*(-600)*(2-m)))));
			}
		}





		fitline = new FitLine(massArray);

		bezier = new Bezier();
		var time : Number=0;
		var indexmasspoint : int = 0;
		stattrajectory = 1;
		alpha1=0;
		trajsost=1;
		this.visible=true;


	}


}
}