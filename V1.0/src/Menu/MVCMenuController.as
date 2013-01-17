package Menu
{
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Vector3D;

public class MVCMenuController extends Sprite implements Destroyer
{
    private var _view : MVCMenuView;
    private var stringArray : Array = new Array();
    public function MVCMenuController()
    {
        stringArray.push('Старт');
        stringArray.push('Настройки');
        stringArray.push('Рейтинг');
        stringArray.push('Помощь');
        _view = new MVCMenuView(stringArray);
        addChild(_view);
        _view.addEventListener(Event.COMPLETE, _view_completeHandler);
        _view.addEventListener(Myevent.SETTING, _view_SettingHandler);
        _view.addEventListener(Myevent.HELP, _view_HelpHandler);
        _view.addEventListener(Myevent.RETING, _view_RetingHandler);


    }

    private function _view_completeHandler(event:Event):void
    {
        dispatchEvent(new Event(Event.COMPLETE));
        _view.removeEventListener(Event.COMPLETE, _view_completeHandler);
        _view.removeEventListener(Myevent.SETTING, _view_SettingHandler);
        _view.removeEventListener(Myevent.HELP, _view_HelpHandler);
        _view.removeEventListener(Myevent.RETING, _view_RetingHandler);

    }

    private function _view_SettingHandler(event:Event):void
    {
        dispatchEvent(new Event(Myevent.SETTING));
        _view.removeEventListener(Event.COMPLETE, _view_completeHandler);
        _view.removeEventListener(Myevent.SETTING, _view_SettingHandler);
        _view.removeEventListener(Myevent.HELP, _view_HelpHandler);
        _view.removeEventListener(Myevent.RETING, _view_RetingHandler);
    }

    private function _view_HelpHandler(event:Event):void
    {
        dispatchEvent(new Event(Myevent.HELP));
        _view.removeEventListener(Event.COMPLETE, _view_completeHandler);
        _view.removeEventListener(Myevent.SETTING, _view_SettingHandler);
        _view.removeEventListener(Myevent.HELP, _view_HelpHandler);
        _view.removeEventListener(Myevent.RETING, _view_RetingHandler);
    }
    public function destroy() : void
    {
        _view.destroy();
        removeChild(_view);
        _view= null;
    }

    private function _view_RetingHandler(event:Event):void {

        dispatchEvent(new Event(Myevent.RETING));
        _view.removeEventListener(Event.COMPLETE, _view_completeHandler);
        _view.removeEventListener(Myevent.SETTING, _view_SettingHandler);
        _view.removeEventListener(Myevent.HELP, _view_HelpHandler);
        _view.removeEventListener(Myevent.RETING, _view_RetingHandler);
    }
}
}