/**
 * Created with IntelliJ IDEA.
 * User: Jabrail
 * Date: 29.11.12
 * Time: 10:01
 * To change this template use File | Settings | File Templates.
 */
package MVCLevel
{
import flash.display.Loader;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLRequest;


public class LevelSetting  extends EventDispatcher
{
    public var setting : Array = new Array();

    public function LevelSetting(level : String)
    {
  /*      var loadset = new Loader();
        var url : URLRequest = new URLRequest(UrlSettings.mainUrl+'/submarine/games/images/'+level+'setting.xml');
        loadset.load(url);
        loadset.addEventListener(Event.COMPLETE, loadset_completeHandler);*/

    }


    private function loadset_completeHandler(event:Event):void
    {
        var xmltest : XML = new XML(event.currentTarget.data);

        for each(var property:XML in xmltest.setting)
        {

            if (property.setting()!=null)
                setting.push(new URLRequest(property.setting()));

        }

        dispatchEvent(new Event(Event.COMPLETE))
    }
}
}