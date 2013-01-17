/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 10.12.12
 * Time: 18:02
 * To change this template use File | Settings | File Templates.
 */
package Menu {
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class LevelFeild extends Sprite implements Destroyer{

    public function LevelFeild()
    {
        var blackFon : Shape = new Shape();
        blackFon.graphics.beginFill(0x000000,0.5);
        blackFon.graphics.drawRect(0,0,800,600);
        addChild(blackFon);

        var bitmap = new Asset.Gameover();
        addChild(bitmap);
        bitmap.x=100;
        bitmap.y=15;

        var menucont : Sprite = new Sprite();
        var menu : Bitmap = new Asset.Main_menu;
        menu.y = 400;
        menucont.addChild(menu);
        addChild(menucont);
        menucont.addEventListener(MouseEvent.MOUSE_DOWN, menu_clickHandler);
        bitmap = null;
        menucont = null;
        menu = null;

        var restartcont : Sprite = new Sprite();
        var restart : Bitmap = new Asset.Restert;
        restart.x =800-restart.width;
        restart.y = 400;
        restartcont.addChild(restart);
        addChild(restartcont);
        restartcont.addEventListener(MouseEvent.MOUSE_DOWN, restart_clickHandler);
        restartcont =null;
        restart = null;




    }

    private function menu_clickHandler(event:MouseEvent):void
    {
        this.dispatchEvent(new Event(Myevent.MAIN_MENU));
        (event.target as DisplayObject).removeEventListener(MouseEvent.MOUSE_DOWN, menu_clickHandler);

    }

    private function restart_clickHandler(event:MouseEvent):void
    {
        this.dispatchEvent(new Event(Myevent.RESTART));
        (event.target as DisplayObject).removeEventListener(MouseEvent.MOUSE_DOWN, restart_clickHandler);
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
