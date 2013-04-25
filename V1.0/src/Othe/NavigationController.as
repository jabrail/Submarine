/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 10.12.12
 * Time: 14:41
 * To change this template use File | Settings | File Templates.
 */
package Othe {
import GameComponets.loaders.Asset;
import GameComponets.loaders.CacheController;
import GameComponets.loaders.LoadLocation;
import GameComponets.loaders.ModalContainer;
import GameComponets.loaders.SharedView;
import GameComponets.loaders.TextFormats;
import GameComponets.loaders.Vk;

import MVCLevel.PauseView;

import Menu.CompleteGameView;

import Menu.HelpView;
import Menu.LevelFeild;
import Menu.LevelFeild;
import Menu.LevelFeild;
import Menu.LevelSelect;
import MVCLevel.MVCLevelController;

import Menu.LiderbordView;
import Menu.MVCMenuController;
import Menu.SettingView;

import Othe.Myevent;

import com.google.analytics.AnalyticsTracker;

import com.google.analytics.GATracker;
import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.greensock.plugins.BlurFilterPlugin;
import com.greensock.plugins.ColorTransformPlugin;
import com.greensock.plugins.TintPlugin;
import com.greensock.plugins.TweenPlugin;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import flash.text.TextField;
import flash.utils.ByteArray;
import flash.utils.Dictionary;
import flash.utils.Timer;

import implementation.Destroyer;

public class NavigationController extends Sprite{

    public var menu : MVCMenuController;

    public var bitmap : Bitmap;
    public var bitmapdata : BitmapData;
    public var currentLevel : int = 0;
    private var level : MVCLevelController;
    private var location : Dictionary;
    private var currentLocation : String= new String('Location_1');
    private var arrayLocation : Array;
    private var _width : Number = 800;
    private var _height : Number = 600;
    private var transitionDisplayobjec  : DisplayObject;
    private var transitionFirstObject  : DisplayObject;
    private var animate : Boolean = true;
    private  var settings : SettingView;
    private var help : HelpView;
    private var levelfeild : LevelFeild;
    private var levelComplete : CompleteGameView;
    private var selectLevel:LevelSelect;
    private var liderboarView : LiderbordView;
    private var timeline : TimelineLite = new TimelineLite();
    private var timer : Timer = new Timer(1000);
    private var hoverFon : Sprite = new Sprite();
    private var typeAnimate : int=0;
    private var pause : PauseView;




    public function NavigationController()  {

        TweenPlugin.activate([BlurFilterPlugin]);
        addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        var location_f : LoadLocation = new LoadLocation();
        location_f.addEventListener(Event.COMPLETE, location_completeHandler);
        var background : Bitmap = new Asset.BackgroundMenu;
        addChild(background);
    }

    private function menu_completeHandler(event:Event):void
    {
        if (animate)
        {
            levelSelect('start',menu);
        }
    }


    private function level_completeHandler(event:Event):void
    {
        if (animate)
        {
                levelComplete = new CompleteGameView();
                levelComplete.addEventListener(Myevent.MAIN_MENU, levelComplete_main_menuHandler,false, 0,true);
                levelComplete.addEventListener(Myevent.NEXT, levelComplete_nextHandler);
                level.gameStart=false;
                addChild(levelComplete);
                addEventLevel(false);


           /* level.gameStart=false;
            addEventLevel(false);

            if (location[arrayLocation[0]][currentLevel+1]!=null)
            {
                levelSelect('complete_next',(event.target as MVCLevelController));
                trace(location[arrayLocation[currentLevel+1]])
            }
            else
            {
                levelSelect('complete',(event.target as MVCLevelController));
            }*/
        }
    }
    private function level_feilHandler(event:Event):void
    {
        if (animate)
        {
            levelfeild = new LevelFeild();
            levelfeild.addEventListener(Myevent.MAIN_MENU, levelfeild_main_menuHandler,false, 0,true);
            levelfeild.addEventListener(Myevent.RESTART,restartHandler,false, 0,true);
            level.gameStart=false;
            addChild(levelfeild);
            addEventLevel(false);
        }
    }
    private function levelSelect(type : String,causedobject : DisplayObject) : void
    {
        if (animate)
        {
            selectLevel= new LevelSelect(arrayLocation[0],location[arrayLocation[0]],type);
            selectLevel.addEventListener(Event.COMPLETE, selectLevel_completeHandler);
            selectLevel.addEventListener(Myevent.RESTART,restartHandler);
            selectLevel.addEventListener(Myevent.MAIN_MENU,main_menuHandler);
            selectLevel.addEventListener(Myevent.NEXT, nextHandler);
            transition(causedobject,selectLevel);
        }
    }

    private function selectLevel_completeHandler(event:Event):void
    {
        if (animate)
        {
            addChild((event.target as LevelSelect));
            currentLevel = (event.target as LevelSelect).selected;


            level = new MVCLevelController(arrayLocation[0]+'/'+location[arrayLocation[0]][currentLevel]);
            addEventLevel(true);
            selectLevel.addEventListener(Event.COMPLETE, selectLevel_completeHandler);
            selectLevel.addEventListener(Myevent.RESTART,restartHandler);
            selectLevel.addEventListener(Myevent.MAIN_MENU,main_menuHandler);
            selectLevel.addEventListener(Myevent.NEXT, nextHandler);
            transition((event.target as LevelSelect),level);
        }
    }
    private function restartHandler(event:Event):void
    {
        if (animate)
        {
            levelfeild.removeEventListener(Myevent.MAIN_MENU, levelfeild_main_menuHandler);
            levelfeild.removeEventListener(Myevent.RESTART,restartHandler);
            levelfeild.destroy();
            if (levelfeild!=null)
                removeChild(levelfeild);
            levelfeild= null;
            restart_level(level);
        }
    }

    private function main_menuHandler(event:Event):void
    {
        if (animate)
        {
        /*    menu = new MVCMenuController();
            transition((event.target as DisplayObject),menu);*/
            levelSelect('start',(event.target as DisplayObject));
        }
    }

    private function location_completeHandler(event:Event):void
    {
        TextFormats.init_Formats();
        if (animate)
        {
            menu = new  MVCMenuController();
            location = (event.target as LoadLocation).getDictLocation();
            arrayLocation = (event.target as LoadLocation).getArrayLocation();
            level = new MVCLevelController(arrayLocation[0]+'/'+location[arrayLocation[0]][currentLevel]);
            addEventLevel(true);
            addChild(level);

            /*  addChild(menu);
              addEventMenu(true);*/
            /*         var cheto : Stats = new Stats();
             addChild(cheto);*/
        }
    }

    private function restart_level(object : DisplayObject) : void
    {
        if (animate)
        {
            hoverFon.graphics.beginFill(0x000000,1);
            hoverFon.graphics.drawRect(0,0,800,600);
            hoverFon.alpha=0;
            addChild(hoverFon);
            typeAnimate=0;

            animate=false;
            level.destroy();
            removeChild(level);
            addEventLevel(false);
            level=null;
            addEventListener(Event.ENTER_FRAME, enterFrameHandler_pause);


        }
    }

    private function nextHandler(event:Event):void
    {
        if (animate)
        {
            currentLevel++;
            level = new MVCLevelController(arrayLocation[0]+'/'+location[arrayLocation[0]][currentLevel]);
            transition((event.target as DisplayObject),level);
            addEventLevel(true);
        }
    }

    private function level_pauseHandler(event:Event):void
    {
        if (animate)
        {
            pause  = new PauseView(_width,_height,'complete');
            addChild(pause);
            pause.addEventListener(Myevent.MAIN_MENU,main_menuHandler_pause);
            pause.addEventListener(Myevent.RESTART,restartHandler_pause);
            pause.addEventListener(Myevent.CONTINUE, pause_continueHandler);
            pause.addEventListener(Myevent.MICROOFF, pause_MICROOFFHandler);
            pause.addEventListener(Myevent.MICROON, pause_MICROOFNHandler);
            pause.addEventListener(Myevent.SOUND_ON, pause_sound_onHandler);
            pause.addEventListener(Myevent.SOUND_OF, pause_sound_ofHandler);
            pause.addEventListener(Myevent.REVIEW, pause_reviewHandler);
            pause.addEventListener(Myevent.MICROPHONE_CALIBRATE, pause_microphone_calibrateHandler);
        }
    }

    private function pause_continueHandler(event:Event):void
    {
        if (animate)
        {
            removeChild(event.target as PauseView);
            (event.target as DisplayObject).removeEventListener(Myevent.MAIN_MENU,main_menuHandler_pause);
            (event.target as DisplayObject).removeEventListener(Myevent.RESTART,restartHandler_pause);
            (event.target as DisplayObject).removeEventListener(Myevent.CONTINUE, pause_continueHandler);
            level.pauseDeaactivate();
        }
    }
    private function  transition(firstObject : DisplayObject,secondObject : DisplayObject) : void
    {
        animate=false;
        transitionFirstObject=firstObject;
        transitionDisplayobjec = secondObject;
        transitionDisplayobjec.alpha = 0;
        addChild(transitionDisplayobjec);
        if (firstObject is MVCMenuController)
            addEventMenu(false);
        hoverFon.graphics.beginFill(0x000000,1);
        hoverFon.graphics.drawRect(0,0,800,600);
        hoverFon.alpha=0;
        addChild(hoverFon);
        typeAnimate=0;
   /*     TweenPlugin.activate([ColorTransformPlugin, TintPlugin]);
        timeline.append(new TweenLite(hoverFon,1,{colorTransform:{tint:0x000000, tintAmount:1}}))
        timer.addEventListener(TimerEvent.TIMER, firstPoint);
        timer.start()*/

        addEventListener(Event.ENTER_FRAME, enterFrameHandler);
        addEventListener(Myevent.TRANSITION_COMPLETE, transition_completeHandler);
    }
/*    private function firstPoint(e:TimerEvent) : void {
        timeline.append(new TweenLite(hoverFon,1,{colorTransform:{tint:0x000000, tintAmount:0}}))
        timer.removeEventListener(TimerEvent.TIMER, firstPoint);
        timer.addEventListener(TimerEvent.TIMER, secondPoint);
        timer.start()
    }
    private function secondPoint(e:TimerEvent) : void {
        removeChild(hoverFon);
        timer.removeEventListener(TimerEvent.TIMER, secondPoint);
//        dispatchEvent(new Event(Myevent.TRANSITION_COMPLETE));

    }*/
    private function enterFrameHandler(event:Event):void
    {
        animate=false;
        if (typeAnimate==0)
        {
         hoverFon.alpha+=0.05
            if (hoverFon.alpha>1)
            {
                typeAnimate =1
                dispatchEvent(new Event(Myevent.TRANSITION_COMPLETE));
            }
        }
        if (typeAnimate==1)
        {
            hoverFon.alpha-=0.05
            if (hoverFon.alpha<0)
            {
                animate=true;
                typeAnimate =2;
                this.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
                removeChild(hoverFon);
            }

        }
    }
    private function enterFrameHandler_pause(event:Event):void
    {
        if (typeAnimate==0)
        {
            hoverFon.alpha+=0.05
            if (hoverFon.alpha>1)
            {
                typeAnimate =1
                level  = new MVCLevelController(arrayLocation[0]+'/'+location[arrayLocation[0]][currentLevel]);
                addEventLevel(true);
                addChild(level);
            }
        }
        if (typeAnimate==1)
        {
            hoverFon.alpha-=0.05
            if (hoverFon.alpha<0)
            {
                animate=true;
                typeAnimate =2;
                this.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
                removeChild(hoverFon);
            }

        }
    }

    private function transition_completeHandler(event:Event):void
    {
        (transitionFirstObject as Destroyer).destroy();
        removeChild(transitionFirstObject);
        if (transitionDisplayobjec is MVCMenuController)
        {
            addEventMenu(true);
        }
        transitionFirstObject = null;
        transitionDisplayobjec.alpha=1;
    }
    private function main_menuHandler_pause(event:Event):void
    {
        if (animate)
        {
            (event.target as DisplayObject).removeEventListener(Myevent.MAIN_MENU,main_menuHandler_pause);
            (event.target as DisplayObject).removeEventListener(Myevent.RESTART,restartHandler_pause);
            (event.target as DisplayObject).removeEventListener(Myevent.CONTINUE, pause_continueHandler);
            (event.target as Destroyer).destroy();
            removeChild((event.target as DisplayObject));
         /*   menu = new MVCMenuController();
            transition(level,menu);*/
            levelSelect('start',level);
        }
    }

    private function restartHandler_pause(event:Event):void
    {
        if (animate)
        {

            pause.removeEventListener(Myevent.MAIN_MENU,main_menuHandler_pause);
            pause.removeEventListener(Myevent.RESTART,restartHandler_pause);
            pause.removeEventListener(Myevent.CONTINUE, pause_continueHandler);
            pause.destroy();
            if (pause!=null)
            removeChild(pause);
            pause= null;
            restart_level(level);
        }
    }

    private function menu_SettingHandler(event:Event):void
    {
        if (animate)
        {
            settings  = new SettingView();
            settings.addEventListener(Myevent.MAIN_MENU,main_menuHandler);
            transition((event.target as MVCMenuController),settings);
        }
    }

    private function menu_HelpHandler(event:Event):void
    {
        if (animate)
        {
            help = new HelpView();
            help.addEventListener(Myevent.MAIN_MENU,main_menuHandler);
            transition((event.target as MVCMenuController),help);
        }
    }
    private function addEventMenu(type : Boolean) : void
    {

        if (type)
        {
            menu.addEventListener(Event.COMPLETE, menu_completeHandler);
            menu.addEventListener(Myevent.SETTING,menu_SettingHandler);
            menu.addEventListener(Myevent.HELP, menu_HelpHandler);
            menu.addEventListener(Myevent.RETING, menu_RetingHandler);
        }
        else
        {
            menu.removeEventListener(Event.COMPLETE, menu_completeHandler);
            menu.removeEventListener(Myevent.SETTING,menu_SettingHandler);
            menu.removeEventListener(Myevent.HELP, menu_HelpHandler);
            menu.removeEventListener(Myevent.RETING, menu_RetingHandler);
        }
    }
    private function addEventLevel(type : Boolean) : void
    {
        if (type)
        {
            level.addEventListener(Event.COMPLETE, level_completeHandler);
            level.addEventListener(Myevent.FEILD, level_feilHandler);
            level.addEventListener(Myevent.PAUSE, level_pauseHandler);
            stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
            stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
        }
        else
        {
            level.removeEventListener(Event.COMPLETE, level_completeHandler);
            level.removeEventListener(Myevent.FEILD, level_feilHandler);
            level.removeEventListener(Myevent.PAUSE, level_pauseHandler);
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
            stage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
        }
    }

    private function levelfeild_main_menuHandler(event:Event):void
    {
        levelfeild =null;
        level.destroy();
        removeChild(level);
        level=null;
        main_menuHandler(event);
    }

    private function menu_RetingHandler(event:Event):void {
        if (animate)
        {
            liderboarView = new LiderbordView();
            liderboarView.addEventListener(Myevent.MAIN_MENU,main_menuHandler);
            transition((menu),liderboarView);
        }

    }

    private function keyDownHandler(event:KeyboardEvent):void {
        level.keyDownHandler(event)
    }

    private function keyUpHandler(event:KeyboardEvent):void {
        level.keyUpHandler(event);
    }

    private function onSoundLoaded(event:Event):void {
    }

    private function addedToStageHandler(event:Event):void {
        stage.addEventListener(KeyboardEvent.KEY_DOWN, stage11_keyDownHandler);
        ModalContainer.initTextView();
        Vk.init(stage);
        Vk.prava();
    }

    private function stage11_keyDownHandler(event:KeyboardEvent):void {
              if (event.charCode==192)
              {
                ModalContainer.messegeView.y = 500;
              }
    }

    private function pause_MICROOFFHandler(event:Event):void {
      level._view_microphoneHandler();
    }

    private function pause_MICROOFNHandler(event:Event):void {
        level._view_microphoneHandler();
    }

    private function pause_sound_onHandler(event:Event):void {

    }

    private function pause_sound_ofHandler(event:Event):void {

    }

    private function pause_reviewHandler(event:Event):void {
          level.clickHandler_rewiew();
    }

    private function pause_microphone_calibrateHandler(event:Event):void {
       level.clickHandler();
    }

    private function levelComplete_main_menuHandler(event:Event):void {
        levelComplete =null;
        level.destroy();
        removeChild(level);
        level=null;
        main_menuHandler(event);
    }

    private function levelComplete_nextHandler(event:Event):void {
        if (animate)
        {
            currentLevel++;
            levelComplete.removeEventListener(Myevent.MAIN_MENU, levelComplete_main_menuHandler);
            levelComplete.removeEventListener(Myevent.RESTART,levelComplete_nextHandler);
            levelComplete.destroy();
            if (levelComplete!=null)
                removeChild(levelComplete);
            levelComplete= null;
            restart_level(level);
        }
    }
}
}