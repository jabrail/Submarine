/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 17.12.12
 * Time: 14:36
 * To change this template use File | Settings | File Templates.
 */
package Menu {
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class MVCMenuView extends Sprite  implements Destroyer
{
    public function MVCMenuView(array : Array)
    {

        for (var i : int =0;i<array.length;i++)
        {
            var button : Button = new Button(array[i]);
            button.y = i*button.height+30*i+40;
            button.x = 40;
            button.addEventListener(Event.COMPLETE, button_mouseUpHandler);
            addChild(button);
            button = null;
        }
    }

    private function button_mouseUpHandler(event:Event):void
    {
        if ((event.target as Button).getValue()=='Старт')
        {
           dispatchEvent(new Event(Event.COMPLETE));
        }
        if ((event.target as Button).getValue()=='Настройки')
        {
            dispatchEvent(new Event(Myevent.SETTING));
        }
        if ((event.target as Button).getValue()=='Помощь')
        {
            dispatchEvent(new Event(Myevent.HELP));
        }
        if ((event.target as Button).getValue()=='Рейтинг')
        {
            dispatchEvent(new Event(Myevent.RETING));
        }
        (event.target as Button).removeEventListener(Event.COMPLETE, button_mouseUpHandler);
    }
    public function destroy() : void
    {
        for (var i : int =0;i<this.numChildren;i++)
        {
           this.removeChildAt(i);
        }
    }
}
}
