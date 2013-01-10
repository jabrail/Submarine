/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 03.10.12
 * Time: 10:16
 * To change this template use File | Settings | File Templates.
 */
package MVCLevel
{
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

public class LevelSelectElement extends Sprite  implements Destroyer
{
	private var bitmap1 : Bitmap;
    public var number : int = 0;
    private var sprite : Hover;
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
	  this.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
	  this.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
        sprite = null;
 /*       textfild =null;*/
	}

	private function mouseOverHandler(event:MouseEvent):void
	{

        bitmap1.width += 10;
        bitmap1.height += 10;
        bitmap1.x -= 5;
        bitmap1.y -= 5;

	}

	private function mouseOutHandler(event:MouseEvent):void
	{

        bitmap1.width -= 10;
        bitmap1.height -= 10;
        bitmap1.x += 5;
        bitmap1.y += 5;
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
}
}
