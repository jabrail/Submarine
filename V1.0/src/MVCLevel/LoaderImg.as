/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 26.09.12
 * Time: 16:55
 * To change this template use File | Settings | File Templates.
 */
package MVCLevel
{
import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;
import flash.text.TextField;
import flash.utils.Dictionary;



public class LoaderImg extends Sprite
{
    private var currentloaded : int = 0;
    private var dir : Array;
    public var allLoad : Dictionary = new Dictionary();
    private var xmlImagesLoader : URLLoader;
    private var nameLevel : String = new String();
    private var colload : int= 0;
    private var text : TextField = new TextField();
    public function LoaderImg(nameLevel : String="location_1/DemoLevel")
    {
         addChild(text);
         dir = new Array();
         this.nameLevel =nameLevel;


        xmlImagesLoader  = new URLLoader();
        var request : URLRequest = new URLRequest('http://runaway.afterwar.ru/submarine/games/locations/'+nameLevel+'/Setting.xml');
        xmlImagesLoader.load(request);
        xmlImagesLoader.addEventListener(Event.COMPLETE,xmlImagesLoader_completeHandler);
        xmlImagesLoader.addEventListener(IOErrorEvent.IO_ERROR, xmlImagesLoader_ioErrorHandler);
        xmlImagesLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, xmlImagesLoader_securityErrorHandler);

    }
    private function loader_completeHandler(event:Event):void
    {
        allLoad[(event.target as MyLoader).dir] = (event.target as MyLoader).getOutputArray();
        currentloaded++;
        (event.target as MyLoader).removeEventListener(Event.COMPLETE,loader_completeHandler);
        var per : int = (currentloaded/dir.length*100);
        text.text= 'Загрузка '+per;
        if (currentloaded==dir.length) dispatchEvent(new Event(Event.COMPLETE));
    }
    private function xmlImagesLoader_completeHandler(event:Event):void
    {
        var xmltest : XML = new XML(event.currentTarget.data);

        for each(var property:XML in xmltest.images.directories)
        {

            if (property.attributes()!=null)
            {
                dir.push(property.toString());
                colload++;
            }
        }
        allLoad['length'] = xmltest.settings.length.toString();
        allLoad['numEnemy'] = xmltest.settings.numEnemy.toString();
        trace(allLoad['length']);


        for each (var index : String in dir)
        {
            var loader : MyLoader  = new MyLoader(nameLevel+index);
            loader.dir = index;
            loader.addEventListener(Event.COMPLETE, loader_completeHandler);
        }
        (event.target as URLLoader).removeEventListener(IOErrorEvent.IO_ERROR, xmlImagesLoader_ioErrorHandler);
        (event.target as URLLoader).removeEventListener(SecurityErrorEvent.SECURITY_ERROR, xmlImagesLoader_securityErrorHandler);
        (event.target as URLLoader).removeEventListener(Event.COMPLETE,xmlImagesLoader_completeHandler);
    }

    private function xmlImagesLoader_ioErrorHandler(event:IOErrorEvent):void
    {
        (event.target as URLLoader).removeEventListener(IOErrorEvent.IO_ERROR, xmlImagesLoader_ioErrorHandler);
        (event.target as URLLoader).removeEventListener(SecurityErrorEvent.SECURITY_ERROR, xmlImagesLoader_securityErrorHandler);
        (event.target as URLLoader).removeEventListener(Event.COMPLETE,xmlImagesLoader_completeHandler);

    }

    private function xmlImagesLoader_securityErrorHandler(event:SecurityErrorEvent):void
    {
        (event.target as URLLoader).removeEventListener(IOErrorEvent.IO_ERROR, xmlImagesLoader_ioErrorHandler);
        (event.target as URLLoader).removeEventListener(SecurityErrorEvent.SECURITY_ERROR, xmlImagesLoader_securityErrorHandler);
        (event.target as URLLoader).removeEventListener(Event.COMPLETE,xmlImagesLoader_completeHandler);
    }


}
}
