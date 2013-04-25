/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 05.10.12
 * Time: 14:23
 * To change this template use File | Settings | File Templates.
 */
package MVCLevel
{
import GameComponets.loaders.LoaderFile;
import GameComponets.loaders.ModalContainer;
import GameComponets.loaders.UrlSettings;

import flash.display.BitmapData;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.media.Sound;
import flash.net.FileReference;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;
import flash.utils.ByteArray;

public class MyLoader   extends EventDispatcher
{
	private var outputArray: Array = new Array()
	private var xmlImagesLoader : URLLoader;
	private var  requestArray : Array = new Array();
	private var colload : Number =0;
	private var colloadcomplit :Number=0;
    public var procentloaded : int=0;
    private var index : int;
    private var allloaders : int;
    private var currentProcent : int =0;
    private var imageLoaders : Array = new Array();
    private var currrentIndex : int =0;
    private var currentAttenp : int = 0;


    public var compl : Number =0;
    public var dir : String;

	public function MyLoader(urlstr : String,count : int=1,index : int=0)
	{
        allloaders = count;
        this.index = index;
        trace(urlstr);
		xmlImagesLoader  = new URLLoader();
		var request : URLRequest = new URLRequest(UrlSettings.mainUrl+"/submarine/games/");
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
				requestArray.push(new URLRequest(property.attributes()));

		}
		loadimg(requestArray);
//		requestArrat.splice(0,requestArrat.length);

        (event.target as URLLoader).removeEventListener(IOErrorEvent.IO_ERROR, xmlImagesLoader_ioErrorHandler);
        (event.target as URLLoader).removeEventListener(Event.COMPLETE,xmlImagesLoader_completeHandler);

	}
	private function loadimg(arrayurl : Array) : void
	{


        procentloaded = arrayurl.length;

            trace(arrayurl[currrentIndex].url);
           /* if((arrayurl[i] as URLRequest).url.search('mp3')>0)
            {
                var fr : FileReference
                var sound : Sound = new Sound();
                sound.load(arrayurl[i]);
                sound.addEventListener(Event.COMPLETE, sound_completeHandler);
                sound=null;
            }
            else
            {*/
			imageLoaders[currrentIndex]=new Loader();
//            (imageLoaders[i] as URLLoader).dataFormat  = URLLoaderDataFormat.BINARY;
			(imageLoaders[currrentIndex] as Loader).load(arrayurl[currrentIndex]);
			(imageLoaders[currrentIndex] as Loader).contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			(imageLoaders[currrentIndex] as Loader).contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			(imageLoaders[currrentIndex] as Loader).contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
      /*      }*/


		colload=arrayurl.length;
	}

	private function completeHandler(event:Event):void
	{
        colloadcomplit++;
        currrentIndex++;
        currentAttenp =0;
        outputArray.push((event.target as LoaderInfo).bytes);
        if (colloadcomplit==colload)
        {
            dispatchEvent(new Event(Event.COMPLETE));
        }
        else
        {
            loadimg(requestArray)
        }
        /*
        var loader : Loader = new Loader();
        loader.loadBytes((event.target as URLLoader).data);
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_completeHandler);
*/
	}
	public function getOutputArray() : Array
	{
		return(outputArray);
        outputArray=null;
        xmlImagesLoader=null;
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
        currentAttenp++;
        (event.target as LoaderInfo).loader.unload();
        if (currentAttenp==4) {
            ModalContainer.textField.text='Нет соединения с интернетом.       Что бы убрать окно нажмите на него';
//            ModalContainer.messegeView.y = 450;
        }
        loadimg(requestArray);


        trace('Ошибка загрузки==',event.errorID);
        trace('Ошибка загрузки==',event.type);
/*        var loader:URLLoader = (event.target as URLLoader);
        loader.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        loader.removeEventListener(Event.COMPLETE,completeHandler);
        loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);*/
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
        /*colloadcomplit++;
        if (colloadcomplit==colload)
        {
            dispatchEvent(new Event(Event.COMPLETE));
        }*/
        var loader:URLLoader = (event.target as URLLoader);
        loader.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        loader.removeEventListener(Event.COMPLETE,completeHandler);
        loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
    }


    private function initHandler(event:Event):void {
        var percent : int = Math.round((event.target as Loader).loaderInfo.bytesLoaded/(event.target as Loader).loaderInfo.bytesTotal*100);
        trace(percent);
    }

    private function loader_completeHandler(event:Event):void {
      /*  LoaderImg.mcPreloader.gotoAndStop(index+colloadcomplit)
        currentProcent++;*/
        outputArray.push((event.target as LoaderInfo).bytes);
        if (colloadcomplit==colload)
        {
            dispatchEvent(new Event(Event.COMPLETE));
        }
        colloadcomplit++;
    }

    private function sound_completeHandler(event:Event):void {
        var bytes : ByteArray = new ByteArray();
        (event.target as Sound).extract(bytes,44100*(event.target as Sound).length/1000);
        bytes.position =0;
        outputArray.push(bytes);
/*
        colloadcomplit++;
        if (colloadcomplit==colload)
        {
            dispatchEvent(new Event(Event.COMPLETE));
        }
*/

    }
}
}
