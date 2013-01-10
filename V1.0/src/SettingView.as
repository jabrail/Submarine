/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 19.12.12
 * Time: 12:35
 * To change this template use File | Settings | File Templates.
 */
package {
import UI.Checkbox;
import UI.Slider;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.net.SharedObject;
import flash.text.TextField;

import silin.zod.primitives.Sphere;


public class SettingView extends Sprite implements Destroyer{
    protected var sounValue : Slider;
    protected var microValue : Slider;
    protected var soundState : Checkbox;
    protected var microState : Checkbox;
    protected var textColor : Number;
    protected var shareobj : SharedObject;
    protected var  setting_window : Sprite = new Sprite();
    public function SettingView() {
        shareobj  =  SharedObject.getLocal('submarine');
        if (shareobj.data.MicroState==null)
        {
            shareobj.data.MicroState=false;
        }
        if (shareobj.data.SoundState==null)
        {
            shareobj.data.SoundState=false;
        }
        if (shareobj.data.MicroVolume==null)
        {
            shareobj.data.MicroVolume=0;
        }
        if (shareobj.data.SoundVolumwe==null)
        {
            shareobj.data.SoundVolumwe=0;
        }
        var setting_window : Sprite = new Sprite();
        setting_window.graphics.beginFill(0x000000,0.6);
        setting_window.graphics.drawRoundRect(0,0,600,500,10,10);
        setting_window.x = 100;
        setting_window.y = 50;
        textColor=0xFFFFFF;

        addChild(setting_window);
        var main_menu : Bitmap = new Asset.Main_menu;
        var main_menu_sprite : Sprite = new Sprite();
        main_menu_sprite.addChild(main_menu);
        main_menu_sprite.y = 600 - main_menu_sprite.height;
        addChild(main_menu_sprite);
        main_menu_sprite.addEventListener(MouseEvent.MOUSE_UP, main_menu_sprite_mouseUpHandler);
var textSound : TextField = new TextField();
        var textMicro : TextField = new TextField();
        textMicro.maxChars=200;
        textSound.maxChars=200;
        textMicro.width=300;
        textMicro.text='Громкость микрофона';
        textSound.text='Громкость звука';
        textMicro.textColor=textColor;
        textSound.textColor=textColor;
        soundState = new Checkbox('Включить/выключить звук',textColor,shareobj.data.SoundState);
        soundState.x =20;
        soundState.y =20;
        microState = new Checkbox('Включить/выключить микрофон',textColor,shareobj.data.MicroState);
        microState.x = 20;
        microState.y=soundState.y+40;
        sounValue = new Slider(100,shareobj.data.SoundVolume,textColor);
        sounValue.x=20;
        textSound.y = sounValue.y = microState.y+microState.height+20;
        textSound.x = sounValue.x+sounValue.width+20;

        microValue = new Slider(100,shareobj.data.MicroVolume,textColor);
        textMicro.y = microValue.y=sounValue.y+sounValue.height+20;
        microValue.x = 20;
        textMicro.x = microValue.x+microValue.width+20;
        setting_window.addChild(microValue);
        setting_window.addChild(microState);
        setting_window.addChild(textMicro);
        setting_window.addChild(textSound);
        setting_window.addChild(soundState);
        setting_window.addChild(sounValue);
        main_menu_sprite = null;
        main_menu =null;




    }

    private function main_menu_sprite_mouseUpHandler(event:MouseEvent):void
    {
                                       getValue();
        dispatchEvent(new Event(Myevent.MAIN_MENU));
        (event.target as Sprite).removeEventListener(MouseEvent.MOUSE_UP, main_menu_sprite_mouseUpHandler);
    }
    public function destroy() : void
    {

        getValue();
        microState =null;
        microValue=null;
        soundState = null;
        sounValue = null;

    }
    public function getValue():void {
       shareobj.data.MicroVolume=microValue.getValue();
       shareobj.data.SoundVolume=sounValue.getValue();
        shareobj.data.MicroState = microState.getValue();
        shareobj.data.SoundState = soundState.getValue();
        shareobj.flush();

    }
}
}
