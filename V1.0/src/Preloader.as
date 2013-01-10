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
import flash.utils.getDefinitionByName;

import mx.core.FlexMovieClip;
import mx.core.SpriteAsset;

import silin.gadgets.Preloader;

[SWF(width="807", height="600",frameRate="60")]

public class Preloader extends MovieClip
{
    private var text : TextField = new TextField();
    private var loadText : TextField = new TextField();
    private var loadSprite : Sprite = new Sprite();
    private var loadcomplitline : Sprite = new Sprite();
    private var currentPercent : int=0;

    [Embed(source="images/preloader.swf")]
    public var  preloader : Class;
    private var preloader_swf: MovieClip;
    public function Preloader()
    {
        //addChild(loadSprite);
        addChild(text);
        addChild(loadcomplitline);
        loadcomplitline.graphics.beginFill(0xffffff,0.7);
        loadcomplitline.graphics.lineStyle(2,0x000000);
        loadcomplitline.graphics.drawRoundRect(300,200,200,200,200);
        loadSprite.graphics.beginFill(0xffffff,0.8);
        loadSprite.graphics.lineStyle(0,0x000000);
        loadSprite.graphics.drawRoundRect(350,250,100,100,100);
        preloader_swf = new preloader();
        preloader_swf.stop();
        addChild(preloader_swf);
        this.addEventListener(Event.ENTER_FRAME, enterFrameHandler)


    }




    public function enterFrameHandler(event:Event):void
    {
        var percent : int = Math.round(loaderInfo.bytesLoaded/loaderInfo.bytesTotal*100);
        if (currentPercent<percent)
        {
          /*  preloader_swf.nextFrame();
            currentPercent = percent;*/
        }
        if (loaderInfo.bytesLoaded==loaderInfo.bytesTotal)
        {
            removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
            stop();
            var loadedClass:Class = getDefinitionByName("Main") as Class;
            parent.addChild(new loadedClass() as DisplayObject);
            removeChild(preloader_swf);
            parent.removeChild(this);
        }

    }
}
}