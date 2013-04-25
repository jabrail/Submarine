/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 03.10.12
 * Time: 10:16
 * To change this template use File | Settings | File Templates.
 */
package Menu
{
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;

import implementation.Destroyer;

public class LevelSelectElement extends Sprite  implements Destroyer
{
	private var bitmap1 : Bitmap;
    public var number : int = 0;
    private var sprite : Hover;
    private var angle : Number = 0;
    private var duration : Number = 35;
    private var count : Number = 0;
    private var _z : Number = 1;
    private var _y : Number = 0;
    private var _x : Number = 0;
    private var cmp : Number = 0;
    private var pos : Point = new Point();
    private var dangle : Number = 10;
    private var current : int = 0;
    private var rad : Number = 0;
	public function LevelSelectElement(Bg : Bitmap,number : int,title : String)
	{

		bitmap1 = Bg;
		addChild(bitmap1);
	    this.number = number;
        sprite = new Hover(number);
/*        var textfild : TextField = new TextField();
        textfild.text=title;
        textfild.y = bitmap1.height/2;
        textfild.x =20;
        textfild.height=20;
        textfild.width = bitmap1.width-10;
        addChild(textfild);*/
        sprite.graphics.beginFill(0x000000,0.01);
        sprite.graphics.drawRect(0,0,bitmap1.width,bitmap1.height);
        addChild(sprite);

           sprite.addEventListener(MouseEvent.CLICK, sprite_clickHandler)
/*	  this.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
	  this.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);*/


        sprite = null;
 /*       textfild =null;*/
	}

	private function mouseOverHandler(event:MouseEvent):void
	{
        this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
    }

	private function mouseOutHandler(event:MouseEvent):void
	{
        this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
    }
    public function destroy() : void
    {
        this.removeEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
        this.removeEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
        bitmap1=null;

        for (var i : int =0;i<this.numChildren;i++)
        {
            this.removeChildAt(i);
        }
    }


    private function sprite_clickHandler(event:MouseEvent):void {
        dispatchEvent(new Event(Event.COMPLETE))
    }

    private function enterFrameHandler(event:Event):void {
        //count - счетчик
//duration - длительность текущей кривизны
//dangle - приращение к углу
//z - знак приращения
        count++;
        if(count>=duration){
            duration=Math.random()*6+6;// c этим
            dangle=Math.random()*9+3;// и этим параметрами можно варировать
            _z=Math.random()*3-1;
            count=0;
        }
//а это и был весь наш chaos
//вычислим где мы будем теперь
        current++;
        if (current>2)
        {
            current=0;
        angle+=_z*dangle;
        _x+=(Math.cos(angle*rad));
        _y+=(Math.sin(angle*rad));
// ---------------
// проверим спокойствие наших границ
        if((40)<Math.sqrt((_x-(pos.x+20))*(_x-(pos.x+20))+(_y-(pos.y+20))*(_y-(pos.y+20)))){_x-=(Math.cos(angle*rad));_y-=(Math.sin(angle*rad));angle+=180;}
//в данном случае это окружность радиусом 400
// с центром в 400,400
        x=_x;
        y=_y;
        }

    }

    public function start():void {
/*       this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
        _x = pos.x = this.x;
        _y = pos.y = this.y;

        angle=60;
        rad = (Math.PI/180)

        trace(pos)*/
    }
}
}
