/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 05.10.12
 * Time: 14:23
 * To change this template use File | Settings | File Templates.
 */
package MVCLevel
{
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;

public class MyLoader   extends EventDispatcher
{
	private var outputArray: Array = new Array()
	private var xmlImagesLoader : URLLoader;
	private var  requestArrat : Array = new Array();
	private var colload : Number =0;
	private var colloadcomplit :Number=0;
    public var procentloaded : Number=0;

    public var compl : Number =0;
    public var dir : String;

	public function MyLoader(urlstr : String)
	{
        trace(urlstr);
		xmlImagesLoader  = new URLLoader();
		var request : URLRequest = new URLRequest("http://runaway.afterwar.ru/submarine/games/");
		request.method = URLRequestMethod.POST;
		var variables : URLVariables = new URLVariables();
		variables.dir = urlstr;
		request.data = variables;
		xmlImagesLoader.load(request);
		xmlImagesLoader.addEventListener(Event.COMPLETE,xmlImagesLoader_completeHandler);
        xmlImagesLoader.addEventListener(IOErrorEvent.IO_ERROR, xmlImagesLoader_ioErrorHandler);
        xmlImagesLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, xmlImagesLoader_securityErrorHandler);
	}

	private function xmlImagesLoader_completeHandler(event:Event):void
	{
		var xmltest : XML = new XML(event.currentTarget.data);

		for each(var property:XML in xmltest.image)
		{

			if (property.attributes()!=null)
				requestArrat.push(new URLRequest(property.attributes()));

		}
		loadimg(requestArrat);
		requestArrat.splice(0,requestArrat.length);

        (event.target as URLLoader).removeEventListener(IOErrorEvent.IO_ERROR, xmlImagesLoader_ioErrorHandler);
        (event.target as URLLoader).removeEventListener(Event.COMPLETE,xmlImagesLoader_completeHandler);

	}
	private function loadimg(arrayurl : Array) : void
	{
        var imageLoaders : Array = new Array()
		for (var i:int=0;i<arrayurl.length;i++)
		{
			imageLoaders[i]=new Loader();
			imageLoaders[i].load(arrayurl[i]);
			(imageLoaders[i] as Loader).contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			(imageLoaders[i] as Loader).contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			(imageLoaders[i] as Loader).contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
		}
		colload=arrayurl.length;
	}

	private function completeHandler(event:Event):void
	{
		var bitmapdata : BitmapData;
		bitmapdata = new BitmapData(event.target.loader.content.width,event.target.loader.content.height,true,0x000000);
		bitmapdata.draw(event.target.loader.content);
		outputArray.push(bitmapdata);
		colloadcomplit++;
		if (colloadcomplit==colload)
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
	public function getOutputArray() : Array
	{
		return(outputArray);
	}
    private function xmlImagesLoader_ioErrorHandler(event:IOErrorEvent):void
    {
        var loader:URLLoader = (event.target as URLLoader);
        loader.removeEventListener(IOErrorEvent.IO_ERROR, xmlImagesLoader_ioErrorHandler);
        loader.removeEventListener(Event.COMPLETE,xmlImagesLoader_completeHandler);
        loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,xmlImagesLoader_securityErrorHandler);
    }

    private function ioErrorHandler(event:IOErrorEvent):void
    {
        trace('Ошибка загрузки');
        colloadcomplit++;
        var loader:URLLoader = (event.target as URLLoader);
        loader.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        loader.removeEventListener(Event.COMPLETE,completeHandler);
        loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
    }

    private function xmlImagesLoader_securityErrorHandler(event:SecurityErrorEvent):void
    {
        var loader:URLLoader = (event.target as URLLoader);
        loader.removeEventListener(IOErrorEvent.IO_ERROR, xmlImagesLoader_ioErrorHandler);
        loader.removeEventListener(Event.COMPLETE,xmlImagesLoader_completeHandler);
        loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,xmlImagesLoader_securityErrorHandler);
    }

    private function securityErrorHandler(event:SecurityErrorEvent):void
    {
        var loader:URLLoader = (event.target as URLLoader);
        loader.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        loader.removeEventListener(Event.COMPLETE,completeHandler);
        loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
    }


}
}
