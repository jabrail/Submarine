package Menu
{
import GameComponets.loaders.Asset;
import GameComponets.loaders.Vk;

import Othe.Myevent;

import com.google.analytics.AnalyticsTracker;

import com.google.analytics.GATracker;

import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Vector3D;

import implementation.Destroyer;

public class MVCMenuController extends Sprite implements Destroyer
{
    private var _view : MVCMenuView;
    private var stringArray : Array = new Array();

    public function MVCMenuController()
    {
        var bg : Bitmap = new Asset.background_menu();
        addChild(bg);

        stringArray.push('Старт');
        /*      stringArray.push('Настройки');
          stringArray.push('Рейтинг');
        stringArray.push('Помощь');*/
        _view = new MVCMenuView(stringArray);
        addChild(_view);

        _view.addEventListener(Event.COMPLETE, _view_completeHandler);
        _view.addEventListener(Myevent.SETTING, _view_SettingHandler);
        _view.addEventListener(Myevent.HELP, _view_HelpHandler);
        _view.addEventListener(Myevent.RETING, _view_RetingHandler);


    }

    private function _view_completeHandler(event:Event):void
    {
        if (Vk.flashVars['viewer_id']!=155685417)
        {
            SharedTracker.tracker.trackEvent("/Start_Level","/Start_Level");
        }
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