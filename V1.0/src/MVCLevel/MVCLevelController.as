package MVCLevel
{
import avmplus.INCLUDE_ACCESSORS;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.display.MovieClip;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.SampleDataEvent;
import flash.events.StatusEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.media.Microphone;
import flash.media.Sound;
import flash.net.SharedObject;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.utils.ByteArray;
import flash.utils.Dictionary;
import flash.utils.Timer;

public class MVCLevelController extends Sprite   implements Destroyer
{
    public var speed : Number;
    public var gameStart : Boolean = false;
    public var micactivate : int = 0;
    private var allImgLoader : LoaderImg;
    private var historyArray : Array = new Array();
    private var densityEnemies:Number;
    private var numberEnemies:Number;
    private var densityBarries:Number;
    private var numberBarries:Number;
    private var _height : Number = 600;
    private var _width : Number = 800;
    private var _view : MVCLevelView;
    private var micUnmut : Boolean = true;
    public var micActive : Number =0;
    private var micActivate : Boolean = true;
    private var point : int = 0;
    private var timer : Timer = new Timer(30);
    private var sharedobj :SharedObject;
    private var loader : Loader = new Loader();
    private var currentArrayPos : Array = new Array();
    private var currentIndexCoins : int=0;


    public var mic:Microphone  = Microphone.getMicrophone();
    public function MVCLevelController(levelName : String = 'DemoLevel')
    {
        sharedobj = SharedObject.getLocal('submarine')


        trace(levelName);
        allImgLoader = new LoaderImg(levelName);
        addChild(allImgLoader);

        if (!sharedobj.data.MicroState)
        {
            mic.addEventListener(StatusEvent.STATUS,onMicStatus);
        }
        else
        {
            onMicStatus2();
        }
    //    mic.setUseEchoSuppression(true);
        mic.addEventListener(SampleDataEvent.SAMPLE_DATA, onMicActivity);
        allImgLoader.addEventListener(Event.COMPLETE, allImgLoader_completeHandler);
        _view = new MVCLevelView();
    }
    public function enterFrame(e:Event) : void
    {
        if (gameStart)
        _view.update(point);
    }

    public function up(act:Number):void
    {
        if (gameStart)
        {
            _view.shipUp(act/15);
        }
    }
    private function allImgLoader_completeHandler(event:Event):void
    {


        var layer : LayerCreate;
        removeChild(allImgLoader);
        // третий план
        var current_x : int =0;
        layer = new LayerCreate(randomImg('/ThirdPlace/1'),0);
        layer.x = current_x;
        current_x +=layer.width;
        _view.addRemote(layer);
        var len : int = allImgLoader.allLoad['length']/layer.width;
        for (var i : int = 0; i<len; i++)
        {
             layer  = new LayerCreate(randomImg('/ThirdPlace'),0);
            layer.x = current_x;
            current_x +=layer.width;
            _view.addRemote(layer);
        }

         layer  = new LayerCreate(randomImg('/ThirdPlace/2'),0);
        layer.x = current_x;
        current_x +=layer.width;
        _view.addRemote(layer);


        // второй план
        current_x  =0;
        numberBarries = allImgLoader.allLoad['length']/randomImg('/SecondPlace').width;
        for (var i : int = 0; i<numberBarries; i++)
        {
             layer  = new LayerCreate(randomImg('/SecondPlace'),0);
            layer.x = current_x;
            layer.y = _height-layer.height;
            current_x +=layer.width;
            _view.AddPlant(layer);
        }

        // слой камней
        current_x =0;
         layer  = new LayerCreate(randomImg('/Stone/1'),0);
        layer.x = current_x;
        current_x +=layer.width;
        layer.y = _height -layer.height;
        _view.addStone(layer);
        numberBarries = allImgLoader.allLoad['length']/layer.width;
        for (var i : int = 0; i<numberBarries; i++)
        {
             layer  = new LayerCreate(randomImg('/Stone'),0);
            layer.x = current_x;
            current_x +=layer.width;
            layer.y = _height -layer.height;
            _view.addStone(layer);
        }

         layer  = new LayerCreate(randomImg('/Stone/2'),0);
        layer.x = current_x;
        current_x +=layer.width;
        layer.y = _height -layer.height;
        _view.addStone(layer);

        // добавление монеток
          current_x =_width;
        var current_y :Number;
        for (var j :int =0;j<10;j++)
        {   current_x+= Math.random()*1000;
            current_y=Math.random()*300;
            for (var i : int = 0; i<(Math.random()*20); i++)
            {

               currentArrayPos.push(new Point(current_x,current_y));
               returnMovie('/Coins');

            }
        }

        // слой кораблей противника
        current_x =_width;
        numberEnemies = allImgLoader.allLoad['numEnemy'];
        for (var i : int = 0; i<numberEnemies; i++)
        {
            layer  = new LayerCreate(randomImg('/Enemy'),0);
            layer.x = current_x;
            current_x +=layer.width+Math.random()*900+300;
            layer.y = Math.random()*350;
            _view.addEnemy(layer);
        }


        layer  = new LayerCreate(randomImg('/Ship'),0);
        layer.x=100;
        layer.y = 100;
        _view.addShip(layer);
        addChild(_view);
        layer = null;
        _view.addEventListener(Myevent.FEILD, _view_FEILDHandler);
        _view.addEventListener(Event.COMPLETE, _view_completeHandler);
        _view.addEventListener(Myevent.PAUSE, _view_pauseHandler);
        _view.addEventListener(Myevent.MICROPHONE_EVENT, _view_microphoneHandler);
        _view.addEventListener(Myevent.COINS, _view_CoinsHandler);
        _view.addEventListener(Myevent.LIDERBOARD, _view_LiderbordHandler)
        gameStart=true;
        stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
         stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
        timer.start();
        timer.addEventListener(TimerEvent.TIMER, enterFrame);

    }

    private function randomImg(dir : String) : BitmapData
    {
        if (allImgLoader.allLoad[dir])
        {
            var i : int = Math.random()*(allImgLoader.allLoad[dir].length-1);
            var bitm : BitmapData = new BitmapData((allImgLoader.allLoad[dir][i] as LoaderInfo).width,(allImgLoader.allLoad[dir][i] as LoaderInfo).height,true,0x00000000);
            bitm.draw((allImgLoader.allLoad[dir][i] as LoaderInfo).loader);
            return (bitm);
        }
        else
        {
            return (new BitmapData(100,100));
        }

    }
    private function returnMovie(dir : String) : void
    {
        if (allImgLoader.allLoad[dir])
        {
            var i : int = Math.random()*(allImgLoader.allLoad[dir].length-1);
            var loader_wsf : Loader = new Loader();
            loader_wsf.loadBytes((allImgLoader.allLoad[dir][i] as LoaderInfo).bytes);
            loader_wsf.contentLoaderInfo.addEventListener(Event.INIT, onSwfLoaded);


        }


    }




    private function _view_completeHandler(event:Event):void
    {
     dispatchEvent(new Event(Event.COMPLETE));
    }
    public function onMicStatus(event:StatusEvent):void
    {
        trace(micUnmut);
        if (event.code == "Microphone.Unmuted")
        {



            this.gameStart=true;
            micActive=1;
            this.micactivate=1;
            micUnmut=true;
        }
        else if (event.code == "Microphone.Muted")
        {

            this.gameStart=true;
            this.micactivate=0;
            micActivate=false;
        }

    }
    public function onMicActivity(e:SampleDataEvent) : void
    {

            var a:Number = 0;
            var num:int = 0;
            //samples.writeBytes(e.data);
            if(e.data==null)
            {
                return;
            }
            while(e.data.bytesAvailable)
            {
                var sample:Number = e.data.readFloat();


                sample = Math.abs(sample);
                a+=sample;
                num++;
            }


            if ((200 * (a/num))>3)
            {
                up(200 * (a/num));
            }


    }
    public function onMicStatus2():void
    {
        trace(micUnmut);
        if (micUnmut)
        {
           micActive=1;

        }
    }


    private function _view_FEILDHandler(event:Event):void
    {
        dispatchEvent(new Event(Myevent.FEILD));
    }

    private function _view_pauseHandler(event:Event):void
    {
        dispatchEvent(new Event(Myevent.PAUSE))
    }



    private function keyDownHandler(event:KeyboardEvent):void
    {
        _view.shipUp(12);
    }

    private function keyUpHandler(event:KeyboardEvent):void
    {
        _view.shipUp(0);

    }
    private function _view_microphoneHandler(event:Event):void
    {
        if (micActivate)
        {
            mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, this.onMicActivity);
            micActivate=false;
        }
        else
        {
            mic.addEventListener(SampleDataEvent.SAMPLE_DATA, onMicActivity);
            micActivate=true;
        }
    }

    private function _view_CoinsHandler(event:Event):void
    {
        point+=10;
    }
    public function destroy() : void
    {
        stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
        stage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
        mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, onMicActivity);
        _view.removeEventListener(Myevent.FEILD, _view_FEILDHandler);
        _view.removeEventListener(Event.COMPLETE, _view_completeHandler);
        _view.removeEventListener(Myevent.PAUSE, _view_pauseHandler);
        _view.removeEventListener(Myevent.MICROPHONE_EVENT, _view_microphoneHandler);
        _view.removeEventListener(Myevent.COINS, _view_CoinsHandler);
        _view.addEventListener(Myevent.LIDERBOARD, _view_LiderbordHandler);

        _view.destroy();
        _view=null;
        timer.removeEventListener(TimerEvent.TIMER, enterFrame);
        mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, onMicActivity);
        allImgLoader.removeEventListener(Event.COMPLETE, allImgLoader_completeHandler);
        mic.removeEventListener(StatusEvent.STATUS,onMicStatus);
        allImgLoader = null;
        for (var i : int = 0; i<numChildren;i++)
        removeChildAt(i);
    }


    private function _view_LiderbordHandler(event:Event):void {
           gameStart =false;
    }

    private function onSwfLoaded(event:Event):void {
        var movie : MovieClip = (event.target as LoaderInfo).loader.content as MovieClip;
        movie.x = (currentArrayPos[currentIndexCoins] as Point).x+movie.width*currentIndexCoins;
        (currentArrayPos[currentIndexCoins] as Point).x =movie.width+Math.random()+20;
        movie.y = (currentArrayPos[currentIndexCoins] as Point).y+Math.random()*30;
        _view.addCoins(movie);
        currentIndexCoins++;

    }
}
}