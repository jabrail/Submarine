/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 09.01.13
 * Time: 15:38
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Bitmap;
import flash.display.Shader;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.net.SharedObject;
import flash.text.TextField;

public class LiderbordView extends  Sprite implements Destroyer{
    private var shareobj : SharedObject = SharedObject.getLocal('submarine');
    private var textColor : Number=0;
    private var arrayLid : Array = new  Array();
    private var text : TextField;
    public function LiderbordView() {


        var setting_window : Sprite = new Sprite();
        setting_window.graphics.beginFill(0x000000,0.6);
        setting_window.graphics.drawRoundRect(0,0,600,500,10,10);
        setting_window.x = 100;
        setting_window.y = 50;
        textColor=0xFFFFFF;

        if (shareobj.data.liderBord==null)
        {
            shareobj.data.liderBord=new Array(1,1);
            shareobj.flush();
        }
        addChild(setting_window);
        var main_menu : Bitmap = new Asset.Main_menu;
        var main_menu_sprite : Sprite = new Sprite();
        main_menu_sprite.addChild(main_menu);
        main_menu_sprite.y = 600 - main_menu_sprite.height;
        addChild(main_menu_sprite);
        main_menu_sprite.addEventListener(MouseEvent.MOUSE_UP, main_menu_sprite_mouseUpHandler);

    //    shareobj.data.liderBord;

        for (var i:int = 0; i<shareobj.data.liderBord.length;i++)
        {
            text  = new TextField();
            text.y = i*20;
            text.textColor = textColor;
            text.text = shareobj.data.liderBord[i];
            setting_window.addChild(text);
            text=null;
        }



    }

    private function main_menu_sprite_mouseUpHandler(event:MouseEvent):void
    {

        dispatchEvent(new Event(Myevent.MAIN_MENU));
        (event.target as Sprite).removeEventListener(MouseEvent.MOUSE_UP, main_menu_sprite_mouseUpHandler);
    }
    public function destroy() : void
    {



    }


}
}
