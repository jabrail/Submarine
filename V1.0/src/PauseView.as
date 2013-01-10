/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 14.12.12
 * Time: 14:52
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Bitmap;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class PauseView extends Sprite implements  Destroyer{
    private var _width : Number = 0;
    private var _height : Number = 0;
    public function PauseView(_width: Number,_height : Number,type : String) {
        this._width = _width;
        this._height = _height;
        var fon : Shape = new Shape();
        fon.graphics.beginFill(0x000000,0.6);
        fon.graphics.drawRect(0,0,_width,_height);
        addChild(fon);

        if (type=='complete_next')
        {
            var next_s :Sprite= new Sprite();
            var restart_s :Sprite= new Sprite();
            var main_menu_s :Sprite= new Sprite();
            var main_menu : Bitmap = new Asset.Main_menu;
            main_menu_s.addChild(main_menu);
            main_menu_s.x = 10;
            main_menu_s.y = 450;
            var restart : Bitmap = new Asset.Restert;
            restart_s.x =main_menu_s.x+ main_menu_s.width+30;
            restart_s.y = 450;
            restart_s.addChild(restart);
            var next : Bitmap = new Asset.Next;
            next_s.x = restart_s.x+restart_s.width+30;
            next_s.y = 450;
             addChild(main_menu_s);
            addChild(restart_s);
            addChild(next_s);
             next_s.addChild(next);
            var continue_button : Bitmap = new Asset.Continue;
            var continue_sprite : Sprite = new Sprite();
            continue_sprite.addChild(continue_button);
            continue_sprite.x = next_s.x+next_s.width+30;
            continue_sprite.y = 450;
            addChild(continue_sprite);

            continue_sprite.addEventListener(MouseEvent.MOUSE_UP, continue_sprite_mouseUpHandler)
            main_menu_s.addEventListener(MouseEvent.MOUSE_UP, main_menu_clickHandler);
            next_s.addEventListener(MouseEvent.MOUSE_UP, next_mouseUpHandler);
            restart_s.addEventListener(MouseEvent.MOUSE_UP, restart_mouseUpHandler);
        }
        else if (type=='complete')
        {
            var main_menu : Bitmap = new Asset.Main_menu;
            var main_menu_s : Sprite = new Sprite();
            main_menu_s.x = 10;
            main_menu_s.y = 450;
            addChild(main_menu_s);
            main_menu_s.addChild(main_menu);
            var restart : Bitmap = new Asset.Restert;
            var restart_s : Sprite = new Sprite();
            restart_s.x =main_menu_s.x+ main_menu_s.width+30;
            restart_s.y = 450;
            restart_s.addChild(restart);
            addChild(restart_s);

            var continue_button : Bitmap = new Asset.Continue;
            var continue_sprite : Sprite = new Sprite();
            continue_sprite.addChild(continue_button);
            continue_sprite.x = restart_s.x+restart_s.width+30;
            continue_sprite.y = 450;
            addChild(continue_sprite);

            continue_sprite.addEventListener(MouseEvent.MOUSE_UP, continue_sprite_mouseUpHandler)
            main_menu_s.addEventListener(MouseEvent.MOUSE_UP, main_menu_clickHandler);
            restart_s.addEventListener(MouseEvent.MOUSE_UP, restart_mouseUpHandler);
        }




    }

    private function main_menu_clickHandler(event:MouseEvent):void
    {
        dispatchEvent(new Event(Myevent.MAIN_MENU));
    }

    private function next_mouseUpHandler(event:MouseEvent):void
    {
        dispatchEvent(new Event(Myevent.NEXT));
    }

    private function restart_mouseUpHandler(event:MouseEvent):void
    {
        dispatchEvent(new Event(Myevent.RESTART));
    }

    private function continue_sprite_mouseUpHandler(event:MouseEvent):void
    {
        dispatchEvent(new Event(Myevent.CONTINUE));
    }
    public function destroy() : void
    {

    }
}
}
