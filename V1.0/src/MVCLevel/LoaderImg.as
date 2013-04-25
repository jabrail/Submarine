/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 26.09.12
 * Time: 16:55
 * To change this template use File | Settings | File Templates.
 */
package MVCLevel
{
import GameComponets.loaders.Asset;
import GameComponets.loaders.UrlSettings;

import flash.display.Bitmap;

import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.MouseEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;
import flash.text.TextField;
import flash.utils.ByteArray;
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
    private var playButton : Sprite = new Sprite();
    private var sostButton : int=0;
    [Embed(source="/images/preloaders/preloader_250x250.swf", mimeType="application/octet-stream")]
    public var  preloader_data : Class;
    public static var mcPreloader: MovieClip;
    public var loader:Loader = new Loader();
    public function LoaderImg(nameLevel : String="location_1/DemoLevel")
    {
        loader.loadBytes( new preloader_data() as ByteArray );
        loader.contentLoaderInfo.addEventListener(Event.INIT, onSwfLoaded);
         dir = new Array();
         this.nameLevel =nameLevel;

        var btm : Bitmap = new Asset.Help();
        addChild(btm);
        xmlImagesLoader  = new URLLoader();
        var request : URLRequest = new URLRequest(UrlSettings.mainUrl+'/submarine/games/locations/'+nameLevel+'/Setting.xml');
        xmlImagesLoader.load(request);
        xmlImagesLoader.addEventListener(Event.COMPLETE,xmlImagesLoader_completeHandler);
        xmlImagesLoader.addEventListener(IOErrorEvent.IO_ERROR, xmlImagesLoader_ioErrorHandler);
        xmlImagesLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, xmlImagesLoader_securityErrorHandler);

    }
    private function loader_completeHandler(event:Event):void
    {
        allLoad[(event.target as MyLoader).dir] = (event.target as MyLoader).getOutputArray();
        (event.target as MyLoader).removeEventListener(Event.COMPLETE,loader_completeHandler);
        currentloaded++;
        var per : int = (currentloaded/dir.length*100);
        mcPreloader.gotoAndStop(per);
     //   mcPreloader.nextFrame();
        if (currentloaded==dir.length)
        {
            var btm : Bitmap = new Asset.PlayGame();
            btm.alpha=0;
            playButton.addChild(btm);
            playButton.x=660;
            playButton.y=460;
            playButton.addEventListener(MouseEvent.CLICK, sprite_clickHandler);
            addEventListener(Event.ENTER_FRAME, enterFrameHandler);
            addChild(playButton);
        }
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
        allLoad['speed'] = xmltest.settings.speed.toString();
        allLoad['numEnemy'] = xmltest.settings.numEnemy.toString();
        trace(allLoad['length']);
        trace(allLoad['speed']);
        trace(allLoad['numEnemy']);

        var i : int = 0;
        for each (var index : String in dir)
        {
            var loader : MyLoader  = new MyLoader(nameLevel+index,100/dir.length,i);
            loader.dir = index;
            i++;
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
    private function onSwfLoaded(e:Event):void
    {
        mcPreloader = loader.content as MovieClip;
        mcPreloader.stop();
        mcPreloader.x=0-(mcPreloader.width/2+140);
        mcPreloader.y=0-(mcPreloader.height/2+40);
        addChild(mcPreloader);
    }


    private function sprite_clickHandler(event:MouseEvent):void {
        removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
        dispatchEvent(new Event(Event.COMPLETE));
    }

    private function enterFrameHandler(event:Event):void {
       if (sostButton==0)
       {
           (playButton.getChildAt(0) as Bitmap).alpha+=0.05;
       }
        else
       {
           (playButton.getChildAt(0) as Bitmap).alpha-=0.05;
       }
        if (  (playButton.getChildAt(0) as Bitmap).alpha>1)
        sostButton=1;
        if (  (playButton.getChildAt(0) as Bitmap).alpha<0)
            sostButton=0;

    }

}
}
