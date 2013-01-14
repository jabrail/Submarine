package
{

import flash.display.AVM1Movie;
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.ProgressEvent;
import flash.net.URLRequest;
import flash.text.TextField;
import flash.utils.ByteArray;
import flash.utils.getDefinitionByName;

import mx.core.FlexMovieClip;
import mx.core.SpriteAsset;


[SWF(width="807", height="600",frameRate="60")]

public class Preloader extends MovieClip
{
    private var text : TextField = new TextField();
    private var loadText : TextField = new TextField();
    private var loadSprite : Sprite = new Sprite();
    private var loadcomplitline : Sprite = new Sprite();
    private var currentPercent : int=0;

    [Embed(source="images/preloader.swf", mimeType="application/octet-stream")]
    public var  preloader_data : Class;

    private var mcPreloader: MovieClip;

    public var loader:Loader = new Loader();

    public function Preloader()
    {
        addChild(text);

        loadcomplitline.graphics.beginFill(0xffffff,0.7);
        loadcomplitline.graphics.lineStyle(2,0x000000);
        loadcomplitline.graphics.drawRoundRect(300,200,200,200,200);
        loadSprite.graphics.beginFill(0xffffff,0.8);
        loadSprite.graphics.lineStyle(0,0x000000);
        loadSprite.graphics.drawRoundRect(350,250,100,100,100);

        loader.loadBytes( new preloader_data() as ByteArray );
        loader.contentLoaderInfo.addEventListener(Event.INIT, onSwfLoaded);
        this.addChild(loader);
        this.addEventListener(Event.ENTER_FRAME, enterFrameHandler)


    }


    private function onSwfLoaded(e:Event):void
    {
        mcPreloader = loader.content as MovieClip;
        mcPreloader.stop();
    }


    public function enterFrameHandler(event:Event):void
    {
        var percent : int = Math.round(loaderInfo.bytesLoaded/loaderInfo.bytesTotal*100);
            if (mcPreloader!=null)
            {
            mcPreloader.nextFrame();
            }

        if (loaderInfo.bytesLoaded==loaderInfo.bytesTotal)
        {
            removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
            stop();
            var loadedClass:Class = getDefinitionByName("Main") as Class;
            parent.addChild(new loadedClass() as DisplayObject);
            removeChild(loader);
            parent.removeChild(this);
        }

    }
}
}