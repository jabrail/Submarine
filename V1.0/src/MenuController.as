package
{
import MVCLevel.LevelSelect;
import MVCLevel.MVCLevelController;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.ActivityEvent;
import flash.events.Event;
import flash.events.FullScreenEvent;
import flash.events.MouseEvent;
import flash.events.SampleDataEvent;
import flash.events.StatusEvent;
import flash.media.Microphone;

import silin.bitmap.DistortBitmap;

public class MenuController extends Sprite
{

	public var massTextImg : Array = new Array();
	public var massPointText : Array = new Array();
	public var massFishView : Array = new Array();
	public var massOtput : Array = new Array();
	public var clickElementIndex : Number=0;

	public var start : MenuModel;
	public var ramka : MenuModel;
	public var help : MenuModel;
	public var option : MenuModel;
	public var fishview : MenuView;
	public var clickStart : Sprite = new Sprite;
	public var ramkaSprite : Sprite = new Sprite;
	public var helpSprite : Sprite = new Sprite;
	public var optionSprite : Sprite = new Sprite;
	public var alphastart : Number=0;

    public var numSelectLevel : int = 0;


	public function MenuController(massTextImg:Array)
	{


		this.massTextImg=massTextImg;

		start= new MenuModel(massTextImg[0],250,100);
		option=new MenuModel(massTextImg[1],240,200);
		help=new MenuModel(massTextImg[2],190,300);
		ramka = new MenuModel(massTextImg[5],100,50);



		var j : int=0;
		for (var i : int = 0;i<start.mass_point.length;i++)
		{
			massOtput[j]=start.mass_point[i];
			j++
		}
		for ( i = 0;i<option.mass_point.length;i++)
		{
			massOtput[j]=option.mass_point[i];
			j++
		}
		for ( i = 0;i<help.mass_point.length;i++)
		{
			massOtput[j]=help.mass_point[i];
			j++
		}
		clickStart.graphics.beginFill(0x000000,0.0);
		clickStart.graphics.drawRect(start.positionX,start.positionY,start.Width,start.Height);
		helpSprite.graphics.beginFill(0x000000,0.0);
		helpSprite.graphics.drawRect(help.positionX,help.positionY,help.Width,help.Height);
		optionSprite.graphics.beginFill(0x000000,0.0);
		optionSprite.graphics.drawRect(option.positionX,option.positionY,option.Width,option.Height);
		fishview = new MenuView();
		addChild(fishview);
		fishview.constr(massOtput);
		addChild(clickStart);
		addChild(optionSprite);
		addChild(helpSprite);






		optionSprite.addEventListener(MouseEvent.CLICK,clickOption)
		helpSprite.addEventListener(MouseEvent.CLICK,clickHelpEvent);
		clickStart.addEventListener(MouseEvent.CLICK,clickStarEvent);
		ramkaSprite.addEventListener(MouseEvent.CLICK,clickramkaSprite);




	}

	public function enterFrame() : void
	{
		fishview.update();
		for (var i:int=0;i<massPointText.length;i++)
		{
			if (massFishView[i].sostClick==1)
			{


			}

		}



		if(alphastart==1)
			ramkaSprite.alpha=fishview.massFish[4].alpha1;

	}



	public function move(x1:Number,y1:Number) : void
	{


	/*	mouse_move(fishview.massFish,x1,y1);*/


	}

	public  function mouse_move(mass_f : Array,x1:Number,y1:Number):void
	{
		/*var a:Number;
		for ( var i: int=0; i<mass_f.length; i++)
		{
			if (mass_f[i].rotation>360) mass_f[i].rotation=0;
			if (mass_f[i].rotation<-360) mass_f[i].rotation=0;
			a=Math.atan2(y1-mass_f[i].y,x1-mass_f[i].x)*180/Math.PI;
			a=mass_f[i].rotation-a;

			if (a > 180) a = -360 + a;
			else if (a < -180) a = 360 + a;

			if (Math.abs(a) < 8) mass_f[i].rotation -= a;
			else if (a > 0) mass_f[i].rotation += 8;
			else mass_f[i].rotation -= 8;





		}*/
	}

	public function clickramkaSprite(e:Event) : void
	{
		fishview.reposition(massOtput);
		clickStart.visible=true;
		ramkaSprite.visible = false;
		optionSprite.visible = true;
		helpSprite.visible=true;
		clickStart.graphics.beginFill(0x000000,0.0);
		clickStart.graphics.drawRect(start.positionX,start.positionY,start.Width,start.Height);



	}
	public function clickStarEvent(e:Event) : void
	{
		fishview.reposition(ramka.mass_point);
		clickStart.visible=false;
		ramkaSprite.visible = false;
		optionSprite.visible = false;
		helpSprite.visible=false;
		ramkaSprite.graphics.beginFill(0x000000,1);
		ramkaSprite.alpha=0;
		ramkaSprite.graphics.drawRoundRect(ramka.positionX+30,ramka.positionY+30,ramka.Width-60,ramka.Height-60,10);
		addChild(ramkaSprite);
		alphastart=1;
		fishview.Visible(false);
        dispatchEvent(new Event(Event.COMPLETE));

	}
	public function clickHelpEvent(e:Event) : void
	{
		fishview.reposition(ramka.mass_point);
		clickStart.visible=false;
		ramkaSprite.visible = true;
		optionSprite.visible = false;
		helpSprite.visible=false;
		ramkaSprite.graphics.beginFill(0x000000,1);
		ramkaSprite.alpha=0;
		ramkaSprite.graphics.drawRoundRect(ramka.positionX+30,ramka.positionY+30,ramka.Width-60,ramka.Height-60,10);
		addChild(ramkaSprite);
		alphastart=1;
	}
	public function clickOption(e:Event) : void
	{
		fishview.reposition(ramka.mass_point);
		clickStart.visible=false;
		ramkaSprite.visible = true;
		optionSprite.visible = false;
		helpSprite.visible=false;
		ramkaSprite.graphics.beginFill(0x000000,1);
		ramkaSprite.alpha=0;
		ramkaSprite.graphics.drawRoundRect(ramka.positionX+30,ramka.positionY+30,ramka.Width-60,ramka.Height-60,10);
		addChild(ramkaSprite);
		alphastart=1;
	}






	private function lev_completeHandler(event:Event):void
	{/*
        var screen : BitmapData = new BitmapData(800,600);
        screen.draw(this);
        var screenbtm : Bitmap = new Bitmap(screen);
        addChild(screenbtm);*/
	/*	this.removeChild(lev);
		lev = null;
        levelselect.visible=true;*/

	/*	fishview.reposition(massOtput);
		clickStart.visible=true;
		ramkaSprite.visible = false;
		optionSprite.visible = true;
		helpSprite.visible=true;*/
	}
}

}