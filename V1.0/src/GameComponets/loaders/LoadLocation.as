/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 12.12.12
 * Time: 11:52
 * To change this template use File | Settings | File Templates.
 */
package GameComponets.loaders {
import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;
import flash.utils.Dictionary;

public class LoadLocation extends Loader{
    private var xmlImagesLoader : URLLoader;
    private var arrayLocation : Array = new Array();
    private var levelDictionary : Dictionary = new Dictionary();
    private var index : int = 0;
    public function LoadLocation() {
        xmlImagesLoader  = new URLLoader();
        var request : URLRequest = new URLRequest(UrlSettings.mainUrl+"/submarine/games/index.php?pp=213123");
        request.method = URLRequestMethod.POST;
        var variables : URLVariables = new URLVariables();
        variables.dir = 'locations';
        variables.on= 'true';
        request.data = variables;
        xmlImagesLoader.load(request);
        xmlImagesLoader.addEventListener(Event.COMPLETE,xmlImagesLoader_completeHandler);
        xmlImagesLoader.addEventListener(IOErrorEvent.IO_ERROR, xmlImagesLoader_ioErrorHandler);
        xmlImagesLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, xmlImagesLoader_securityErrorHandler);
    }
    private function xmlImagesLoader_completeHandler(event:Event):void
    {
        var xmltest : XML = new XML(event.currentTarget.data);
        for each(var property:XML in xmltest.folder)
        {
            if (property.attributes()!=null)
            {
                arrayLocation.push(property.attributes());
                levelLoader(property.attributes());
            }
        }
        removeevent(event.target as URLLoader);
    }

    private function xmlImagesLoader_ioErrorHandler(event:IOErrorEvent):void
    {
        trace(event.errorID);
        removeevent(event.target as URLLoader);
    }

    private function xmlImagesLoader_securityErrorHandler(event:SecurityErrorEvent):void
    {
        removeevent(event.target as URLLoader);
    }

    public function getDictLocation() : Dictionary
    {
        return levelDictionary;
    }
    public function getArrayLocation() : Array
    {
        return arrayLocation;
    }
    private function removeevent(loader : URLLoader) : void
    {
        loader.removeEventListener(IOErrorEvent.IO_ERROR, xmlImagesLoader_ioErrorHandler);
        loader.removeEventListener(Event.COMPLETE,xmlImagesLoader_completeHandler);
        loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,xmlImagesLoader_securityErrorHandler);
    }

    private function levelLoader(location : String) : void
    {
        var loaderinlocation  = new URLLoader();
        var request : URLRequest = new URLRequest(UrlSettings.mainUrl+"/submarine/games/index.php");
        request.method = URLRequestMethod.POST;
        var variables : URLVariables = new URLVariables();
        variables.dir = 'locations/'+location;
        variables.on= 'true';
        request.data = variables;
        loaderinlocation.load(request);
        loaderinlocation.addEventListener(Event.COMPLETE, loaderinlocation_completeHandler);
        loaderinlocation.addEventListener(IOErrorEvent.IO_ERROR, xmlImagesLoader_ioErrorHandler);
        loaderinlocation.addEventListener(SecurityErrorEvent.SECURITY_ERROR, xmlImagesLoader_securityErrorHandler);
    }

    private function loaderinlocation_completeHandler(event:Event):void
    {
        var  arrayLevels : Array = new Array();
        try {
            var xmltest : XML = new XML(event.currentTarget.data);
        }
        catch (e: Error)
        {
            ModalContainer.textField.text = e.message;
        }

        for each(var property:XML in xmltest.folder)
        {
            if (property.attributes()!=null)
            {
                arrayLevels.push(property.attributes());
//                levelLoader('Location_1/'+property.attributes().toString());
            }
        }
        levelDictionary[arrayLocation[index]] = arrayLevels;
        index++;
        if (index==arrayLocation.length)
            dispatchEvent(new Event(Event.COMPLETE));

        removeevent(event.target as URLLoader);
    }
}
}
