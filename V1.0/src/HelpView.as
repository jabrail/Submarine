/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 19.12.12
 * Time: 13:47
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class HelpView extends Sprite implements Destroyer{
    public function HelpView() {
        var setting_window : Sprite = new Sprite();
        setting_window.graphics.beginFill(0x000000,0.6);
        setting_window.graphics.drawRoundRect(0,0,600,500,10,10);
        setting_window.x = 100;
        setting_window.y = 50;
        var btm : Bitmap = new Asset.Help
        btm.y+=50;
        setting_window.addChild(btm)
        addChild(setting_window);
        var main_menu : Bitmap = new Asset.Main_menu;
        var main_menu_sprite : Sprite = new Sprite();
        main_menu_sprite.addChild(main_menu);
        main_menu_sprite.y = 600 - main_menu_sprite.height;
        addChild(main_menu_sprite);
        main_menu_sprite.addEventListener(MouseEvent.MOUSE_UP, main_menu_sprite_mouseUpHandler)

    }

    private function main_menu_sprite_mouseUpHandler(event:MouseEvent):void
    {
        dispatchEvent(new Event(Myevent.MAIN_MENU));
    }
    public function destroy() : void
    {

    }
}
}
