package MVCLevel
{
import GameComponets.loaders.Asset;
import GameComponets.loaders.CacheController;
import GameComponets.loaders.ImgBodyCache;
import GameComponets.loaders.MicroCalibrate;
import GameComponets.loaders.ModalContainer;
import GameComponets.loaders.ModalContainer;
import GameComponets.loaders.ModalContainer;
import GameComponets.loaders.PreloaderRef;
import GameComponets.loaders.ReviewWindow;
import GameComponets.loaders.SharedView;
import GameComponets.loaders.ShineMP3EncoderClone;
import GameComponets.loaders.SoundManager;
import GameComponets.loaders.TextFormats;
import GameComponets.loaders.Vk;

import Othe.Elements;

import Othe.Myevent;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.display.Shader;
import flash.display.Sprite;
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.events.ProgressEvent;
import flash.events.SampleDataEvent;
import flash.events.StatusEvent;
import flash.events.TimerEvent;
import flash.media.Microphone;
import flash.net.FileReference;
import flash.net.SharedObject;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.utils.ByteArray;
import flash.utils.Timer;

import fr.kikko.lab.ShineMP3Encoder;

import fr.kikko.lab.ShineMP3Encoder;

import implementation.Destroyer;

import nape.phys.Body;

import org.bytearray.micrecorder.MicRecorder;

import org.bytearray.micrecorder.encoder.WaveEncoder;
import org.bytearray.micrecorder.events.RecordingEvent;


import vk.APIConnection;
import vk.events.CustomEvent;

public class MVCLevelController extends Sprite   implements Destroyer
{
    public var gameStart : Boolean = false;
    public var micactivate : int = 0;
    private var allImgLoader : LoaderImg;
    private var _view : MVCLevelView;
    private var micUnmut : Boolean = true;
    public var micActive : Number =0;
    private var micActivate : Boolean = true;
    private var point : int = 0;
    private var timer : Timer = new Timer(30);
    private var sharedobj :SharedObject;
    private var cache  : CacheController;
    private var imgBodyCache : ImgBodyCache;
    private var soundOut : ByteArray = new ByteArray();
    private var complete : Boolean = false;
    private var recorder : MicRecorder;
    private var indexCurentTimer : int = 1;
    private var secondsTextField : TextField= new TextField();
    private var firstRound : int = 0;
    private var firstStartGame : Boolean = false;
    private var microCalibrate : MicroCalibrate = new MicroCalibrate();
    private var statusblink : Boolean = false;
    private var blincSecond : Number = 0;
    private  var review : ReviewWindow;
    private var pauseActivate : Boolean =false;
public var mic:Microphone  = Microphone.getMicrophone();
    public function MVCLevelController(levelName : String)
    {


        ModalContainer.levelName = levelName;
        if (Vk.flashVars['viewer_id']!=155685417)
        {
            if (ModalContainer.levelName=='Location_1/level_6_6_1')
            {
                SharedTracker.tracker.trackEvent("/StartFirstLevel","/StartFirstLevel");
            }
            else if (ModalContainer.levelName=='Location_1/level_6_6_2')
            {
                SharedTracker.tracker.trackEvent("/SecondLevelStart","/SecondLevelStart");
            }

        }
        cache = new CacheController();
        sharedobj = SharedObject.getLocal('submarine')
        if (sharedobj.data.microon==null)
        {
           var sost: Boolean = true;
            sharedobj.data.microon = sost;
        }
        ModalContainer.micSost = sharedobj.data.microon;
        micActivate = ModalContainer.micSost;
        cache.loadLevel(levelName);
        cache.addEventListener(Event.COMPLETE,allImgLoader_completeHandler);
        addChild(cache);

    }
    public function enterFrame(e:Event) : void
    {
        if (pauseActivate)
        {
            gameStart =false;
        }
        if (firstStartGame==false){
        if (firstRound==0)
        {
            _view.update(point);
            _view.reviewReposition();
            firstRound=1;
        }
        if ((e.target as Timer).currentCount*30 >indexCurentTimer*1000) {
            secondsTextField.defaultTextFormat= TextFormats.textFormat_2;
            secondsTextField.text = indexCurentTimer.toString();
            secondsTextField.x = 400;
            secondsTextField.y = 300;
            indexCurentTimer++;
            addChild(secondsTextField);
            if (indexCurentTimer>3) {
                secondsTextField.defaultTextFormat= TextFormats.textFormat_3;
                secondsTextField.width=800;
                secondsTextField.x=40;
                secondsTextField.text = '3'
                        //       secondsTextField.text = 'Давай, давай, детка, у тебя получится!!!'
            }
        }
        if (indexCurentTimer>4) {
            removeChild(secondsTextField);
            gameStart = true;
            firstStartGame = true;
        }
    }
        if (gameStart)
            _view.update(point);
        if (statusblink)
        {
            blincSecond++
            if (blincSecond>5)
            {
                if (LevelButtonView.shape.visible)
                {
                    LevelButtonView.shape.visible=false;
                }
                else
                {
                    LevelButtonView.shape.visible = true;
                }
                blincSecond=0;
            }
        }
    }

    public function up(act:Number):void
    {
        if (gameStart)
        {
            if (act>20)
            {
                _view.shipUp(act*2.5);
            }
            else {
                _view.shipDown(0);
            }
        }
    }
    private function allImgLoader_completeHandler(event:Event):void
    {
        if (Vk.flashVars['viewer_id']!=155685417)
        {
            SharedTracker.tracker.trackPageview('/Level_Loaded');
        }

        imgBodyCache = new ImgBodyCache(cache.getDictionary());
        cache.visible = false;
        _view = new MVCLevelView(imgBodyCache);
        _view.mapLength=cache.getLength();
        _view.speed=cache.getSpeed();
        //  removeChild(cache);
        // третий план
        addRemote();
        addRemote();
        addRemote();
        // второй план
        addSecondPlace();
        // слой камней
        addStone(false);
        addStone(false);
        addStone(false);
        addStone(false);
        addStone(false);
        addStone(false);
        // добавление монеток
        addCoin();
        // Добавление бонусов
        addBonus();
        // слой кораблей противника
        addEnemy();
        //Добавление корабля
        _view.addShip(imgBodyCache.getBody(Elements.ship));
        addChild(_view);
/*        var btm : Bitmap = new Asset.Mask();
        addChild(btm);*/
        _view.addEventListener(Myevent.FEILD, _view_FAILDHandler);
        _view.addEventListener(Event.COMPLETE, _view_completeHandler);
        _view.addEventListener(Myevent.PAUSE, _view_pauseHandler);
        _view.addEventListener(Myevent.COINS, _view_CoinsHandler);
        _view.addEventListener(Myevent.LIDERBOARD, _view_LiderbordHandler);
        _view.addEventListener(Myevent.ADDCOIN, _view_addCoinHandler);
        _view.addEventListener(Myevent.ADDENEMY, _view_addenemyHandler);
        _view.addEventListener(Myevent.ADDPlANT, _view_addPlantHandler);
        _view.addEventListener(Myevent.ADDREMOTE, _view_addRemoteHandler);
        _view.addEventListener(Myevent.ADDSTONE, _view_addStoneHandler);
        _view.addEventListener(Myevent.ADDBONUS, view_addBonusHandler);
       if (ModalContainer.micSost) {
        if (mic.muted)
        {
            mic.addEventListener(StatusEvent.STATUS,onMicStatus);
            mic.setUseEchoSuppression(true);
            mic.rate = 44;
            mic.addEventListener(SampleDataEvent.SAMPLE_DATA, onMicActivity);
        }
        else
        {
            micCalibrate();
            mic.setUseEchoSuppression(true);
            mic.rate = 44;
        }
    }
        else
       {
           countForStart();
       }
 //       ModalContainer.messegeView.y = 450;
        ModalContainer.textField.text = 'Разрешите доступ к микрофону.       Чтоб убрать окно нажмите на него';

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
            return null;
        }
    }

    private function _view_completeHandler(event:Event):void
    {
        if (Vk.flashVars['viewer_id']!=155685417)
        {
            if (ModalContainer.levelName=='Location_1/level_6_6_1')
            {
                SharedTracker.tracker.trackEvent("/FirstLevelComplete","/FirstLevelComplete");
            }
            else if (ModalContainer.levelName=='Location_1/level_6_6_2')
            {
                SharedTracker.tracker.trackEvent("/SecondLevelComplete","/SecondLevelComplete");
            }

        }
        ModalContainer.addPlayAgain();
        gameStart=false;
        complete = true;
        if (Vk.flashVars['viewer_id']!=155685417)
        {
            SharedTracker.tracker.trackEvent('/Complete','/Complete');
        }
        timer.removeEventListener(TimerEvent.TIMER, enterFrame);
        vawcreate();
    }
    public function onMicStatus(event:StatusEvent):void
    {
        trace(micUnmut);
        if (event.code == "Microphone.Unmuted")
        {
            micActive=1;
            this.micactivate=1;
            micUnmut=true;
            micCalibrate()


        }
        else if (event.code == "Microphone.Muted")
        {

            this.micactivate=0;
            micActivate=false;
            sharedobj.data.microon = false;
            sharedobj.flush();
            ModalContainer.micSost = false;
            countForStart();
        }

    }

    public function onMicActivity(e:SampleDataEvent) : void
    {
        //
        mic.gain=microCalibrate.gain;
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
            soundOut.writeFloat(sample);
            if (gameStart)
            recorder.onSampleData(e);

            sample = Math.abs(sample);
            a+=sample;
            num++;
        }
        ModalContainer.textField.text=mic.activityLevel.toString();
        var level : Number = mic.activityLevel;
        if (level>30)
        {

            if (level>90)
            {
                statusblink = true;
                level=90;
            }
            else
            {
                LevelButtonView.shape.visible = false;
                statusblink = false;
            }
            up(level);
        }
        else
        {
            up(0);
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

    private function _view_FAILDHandler(event:Event):void
    {
//        ModalContainer.addPlayAgain();
        if (Vk.flashVars['viewer_id']!=155685417)
        {
            if (ModalContainer.levelName=='Location_1/level_6_6_1')
            {
                SharedTracker.tracker.trackEvent("/FirstLevelFail","/FirstLevelFail");
            }
            else if (ModalContainer.levelName=='Location_1/level_6_6_2')
            {
                SharedTracker.tracker.trackEvent("/SecondLevelFail","/SecondLevelFail");
            }

        }

        timer.removeEventListener(TimerEvent.TIMER, enterFrame);
        if (Vk.flashVars['viewer_id']!=155685417)
        {
            SharedTracker.tracker.trackEvent('fail','fail');
        }
        complete = false;
        gameStart = false;
        vawcreate();

    }

    private function _view_pauseHandler(event:Event):void
    {
        gameStart = false;
        pauseActivate=true;
        dispatchEvent(new Event(Myevent.PAUSE))
    }

    public function keyDownHandler(event:KeyboardEvent):void
    {
        _view.shipUp(200);
    }

    public function keyUpHandler(event:KeyboardEvent):void
    {
        _view.shipDown(0);
    }
    public function _view_microphoneHandler():void
    {
        if (micActivate)
        {
            mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, this.onMicActivity);
            micActivate=false;
            ModalContainer.micSost  = false;
            sharedobj.data.microon = false;
            sharedobj.flush();
        }
        else
        {
            mic.addEventListener(SampleDataEvent.SAMPLE_DATA, onMicActivity);
            micActivate=true;
            ModalContainer.micSost  = true;
            sharedobj.data.microon = true;
            sharedobj.flush();
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
        _view.removeEventListener(Myevent.FEILD, _view_FAILDHandler);
        _view.removeEventListener(Event.COMPLETE, _view_completeHandler);
        _view.removeEventListener(Myevent.PAUSE, _view_pauseHandler);
        _view.removeEventListener(Myevent.MICROPHONE_EVENT, _view_microphoneHandler);
        _view.removeEventListener(Myevent.COINS, _view_CoinsHandler);
        _view.addEventListener(Myevent.LIDERBOARD, _view_LiderbordHandler)

        _view.removeEventListener(Myevent.ADDCOIN, _view_addCoinHandler);
        _view.removeEventListener(Myevent.ADDENEMY, _view_addenemyHandler);
        _view.removeEventListener(Myevent.ADDPlANT, _view_addPlantHandler);
        _view.removeEventListener(Myevent.ADDREMOTE, _view_addRemoteHandler);
        _view.removeEventListener(Myevent.ADDSTONE, _view_addStoneHandler);



        _view.destroy();
        imgBodyCache= null;
        cache.destroy();
        cache = null;
        _view=null;
        timer.removeEventListener(TimerEvent.TIMER, enterFrame);
        mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, onMicActivity);
        mic.removeEventListener(StatusEvent.STATUS,onMicStatus);
        for (var i : int = 0; i<numChildren;i++)
            removeChildAt(i);

    }

    private function _view_LiderbordHandler(event:Event):void {
        gameStart =false;
    }
    private function addStone(bool : Boolean):void {
        /*if (bool)
         {
         _view.addStone(imgBodyCache.getBody('/Stone/1'));
         }*/
        var layer : Body;

        layer =  imgBodyCache.getBody(Elements.plase1);
        if  (layer!==null)
        {
            _view.addStone(layer);
        }

        /*      if (bool)
         {
         _view.addStone(imgBodyCache.getBody('/Stone/2'));
         }*/
    }
    private function addSecondPlace(): void {
        _view.AddPlant(imgBodyCache.getLayer(Elements.plase2));
    }
    private function addRemote():void {

        _view.addRemote(imgBodyCache.getLayer(Elements.plase3));

    }
    private function addCoin():void {
        for (var i : int = 0; i<(Math.random()*30); i++)
        {
            _view.addCoins(imgBodyCache.getBody(Elements.coins));
        }
    }
    private function addBonus():void {
        _view.addBonus(imgBodyCache.getBody(Elements.bonus));
    }
    private function addEnemy(): void {
        _view.addEnemy(imgBodyCache.getBody(Elements.enemy));
    }
    private function _view_addenemyHandler(event:Event):void {
        addEnemy();
    }

    private function _view_addPlantHandler(event:Event):void {
        addSecondPlace();
    }

    private function _view_addRemoteHandler(event:Event):void {
        addRemote();
    }

    private function _view_addStoneHandler(event:Event):void {
        addStone(false);
    }

    private function view_addBonusHandler(event:Event):void {
        addBonus();
    }

    private function _view_addCoinHandler(event:Event):void {
        addCoin();
    }
    private function vawcreate() :  void {
        //
// Объявляем бинарный массив для данных .wav-файла
        recorder.stop();
        mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, onMicActivity);
        mic.removeEventListener(StatusEvent.STATUS,onMicStatus);

    }
    function onMP3EncoderProcess (e:ProgressEvent):void
    {
        trace("Encoding to mp3 ... " + Math.ceil(e.bytesLoaded * 100 / e.bytesTotal) + "%");
        PreloaderRef.setValue(Math.ceil(e.bytesLoaded * 100 / e.bytesTotal));
    }
//
// Обработчик завершения кодирования
    function onMP3EncoderComplete (e:Event):void
    {


        Vk.mp3File = (e.target as ShineMP3EncoderClone).mp3Data;
        ModalContainer.soundArray = (e.target as ShineMP3EncoderClone).mp3Data;
        /*        ModalContainer.soundArray = soundOut;
                soundOut.clear();*/
        (e.target as ShineMP3EncoderClone).mp3Data = null;
        Vk.tf.text = 'def';
//        ModalContainer.rootConteiner.addChild(SharedView.view);
        SharedView.view.x =  200;
        SharedView.view.y =  250;
        ModalContainer.eventDispatcher.dispatchEvent(new Event(Myevent.SOUND_COMPLETE_ENCODE));
        Vk.addSound();
    /*    if (complete)
        {
            dispatchEvent(new Event(Event.COMPLETE));
        }
        else
        {
            dispatchEvent(new Event(Myevent.FEILD));
        }*/


    }


    private function onRecording(event:RecordingEvent):void {


    }

    private function onRecordComplete(event:Event):void {

        var  sound_arr : ByteArray = recorder.output;
//        ModalContainer.soundArray=sound_arr;
        ModalContainer.preloaderInit();
        PreloaderRef.init();
        var tf : TextField = new TextField();
        tf.defaultTextFormat = TextFormats.textFormat_1;
        tf.text = 'Загрузка аудио';
        tf.y=-30;
        tf.x=150;
//        PreloaderRef.preloader.addChild(tf);

        ModalContainer.rootConteiner.addChild(PreloaderRef.preloader);
        sound_arr.position =0;
        try {
            var _mp3_encoder: ShineMP3EncoderClone = new ShineMP3EncoderClone(sound_arr);
            _mp3_encoder.addEventListener(Event.COMPLETE, onMP3EncoderComplete, false, 0, true);
            _mp3_encoder.addEventListener(ProgressEvent.PROGRESS, onMP3EncoderProcess, false, 0, true);
            _mp3_encoder.addEventListener(ErrorEvent.ERROR, mp3_encoder_errorHandler);
            _mp3_encoder.start();
            if (complete)
            {
                dispatchEvent(new Event(Event.COMPLETE));
            }
            else
            {
                dispatchEvent(new Event(Myevent.FEILD));
            }
        } catch (e:Error) {
            ModalContainer.textField.text = "Вы ошибаетесь, мой друг! " + e.message;
        }
    }

    private function mp3_encoder_errorHandler(event:ErrorEvent):void {
        ModalContainer.textField.text = "Вы ошибаетесь, мой друг! " + event.errorID;
    }
    private function countForStart() : void {
        if (micActivate)
        mic.addEventListener(SampleDataEvent.SAMPLE_DATA, onMicActivity);
        var volume : Number = 0.8;
        var wavEncoder : WaveEncoder = new WaveEncoder(volume);
        recorder  = new MicRecorder(wavEncoder,mic);
        recorder.addEventListener(RecordingEvent.RECORDING, onRecording);
        recorder.addEventListener(Event.COMPLETE, onRecordComplete);
        recorder.record();
        timer.start();
        timer.addEventListener(TimerEvent.TIMER, enterFrame);
    }
    private function  micCalibrate() : void {
        if (sharedobj.data.gain ==null)
        {  ModalContainer.rootConteiner.addChild(microCalibrate);
            microCalibrate.init(mic);
            microCalibrate.addEventListener(Event.COMPLETE, microCalibrate_completeHandler);
        }
        else
        {
            microCalibrate.gain=sharedobj.data.gain;
            countForStart();
        }


    }

    private function microCalibrate_completeHandler(event:Event):void {
        microCalibrate.removeEventListener(Event.COMPLETE, microCalibrate_completeHandler);
        ModalContainer.rootConteiner.removeChild(microCalibrate);
        sharedobj.data.gain= microCalibrate.gain;
        countForStart();
    }

    public function clickHandler():void {
        gameStart = false;
//        dispatchEvent(new Event(Myevent.PAUSE))
        microCalibrate.init(mic);
        ModalContainer.rootConteiner.addChild(microCalibrate);
        microCalibrate.addEventListener(Event.COMPLETE, microCalibrate_completeforgameHandler);
    }
    private function microCalibrate_completeforgameHandler(event:Event):void {
        microCalibrate.removeEventListener(Event.COMPLETE, microCalibrate_completeforgameHandler);
        ModalContainer.rootConteiner.removeChild(microCalibrate);
        sharedobj.data.gain= microCalibrate.gain;
        gameStart =true;
    }

    public function clickHandler_rewiew():void {
        mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, onMicActivity);
        gameStart=false;
        review  = new ReviewWindow(mic);
        review.addEventListener(Event.COMPLETE, review_completeHandler);
        ModalContainer.rootConteiner.addChild(review);


    }

    private function review_completeHandler(event:Event):void {
        ModalContainer.rootConteiner.removeChild(review);
        review.removeEventListener(Event.COMPLETE, review_completeHandler);
        review=null;
        ModalContainer.reviewButton.addEventListener(MouseEvent.CLICK, clickHandler_rewiew);
        gameStart = true;
    }
    public function pauseDeaactivate() : void {
        pauseActivate=false;
        gameStart=true;
    }
}
}