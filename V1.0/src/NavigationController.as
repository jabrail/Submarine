/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 10.12.12
 * Time: 14:41
 * To change this template use File | Settings | File Templates.
 */
package {
import MVCLevel.LevelFeild;
import MVCLevel.LevelFeild;
import MVCLevel.LevelFeild;
import MVCLevel.LevelSelect;
import MVCLevel.MVCLevelController;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.utils.Dictionary;

public class NavigationController extends Sprite{
    public var menu : MVCMenuController;

    public var roundObject  : Shape = new Shape();
    public var bitmap : Bitmap;
    public var bitmapdata : BitmapData;
    public var currentLevel : int = 0;
    private var level : MVCLevelController;
    private var levelScreen : Bitmap;
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
    private var selectLevel:LevelSelect;
    private var liderboarView : LiderbordView;


    public function NavigationController()  {
        var location_f : LoadLocation = new LoadLocation();
        location_f.addEventListener(Event.COMPLETE, location_completeHandler)

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
            level.gameStart=false;
     addEventLevel(false);

            if (location[arrayLocation[0]][currentLevel+1]!=null)
            {
                levelSelect('complete_next',(event.target as MVCLevelController));
                trace(location[arrayLocation[currentLevel+1]])
            }
            else
            {
                levelSelect('complete',(event.target as MVCLevelController));
            }
        }
    }
    private function level_feilHandler(event:Event):void
    {
        if (animate)

        {
            levelfeild = new LevelFeild();
            levelfeild.addEventListener(Myevent.MAIN_MENU, levelfeild_main_menuHandler);
            levelfeild.addEventListener(Myevent.RESTART,restartHandler_pause);
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
            addChild(level);
            selectLevel.addEventListener(Event.COMPLETE, selectLevel_completeHandler);
            selectLevel.addEventListener(Myevent.RESTART,restartHandler);
            selectLevel.addEventListener(Myevent.MAIN_MENU,main_menuHandler);
            selectLevel.addEventListener(Myevent.NEXT, nextHandler);
            this.removeChild((event.target as LevelSelect));

        }
    }
    private function restartHandler(event:Event):void
    {
        if (animate)

        {
            restart_level(event.target as DisplayObject);
        }
    }



    private function main_menuHandler(event:Event):void
    {
        if (animate)

        {
            menu = new MVCMenuController();
            transition((event.target as DisplayObject),menu);

        }
    }




    private function location_completeHandler(event:Event):void
    {
        if (animate)

        {
            menu = new  MVCMenuController();
            location = (event.target as LoadLocation).getDictLocation();
            arrayLocation = (event.target as LoadLocation).getArrayLocation();
            addChild(menu);
            addEventMenu(true);
   /*         var cheto : Stats = new Stats();
             addChild(cheto);*/

        }

    }
    private function restart_level(object : DisplayObject) : void
    {
        if (animate)
        {
            level = new MVCLevelController(arrayLocation[0]+'/'+location[arrayLocation[0]][currentLevel]);
            addEventLevel(true);
            transition(object,level);
        }
    }

    private function nextHandler(event:Event):void
    {
        if (animate)
        {
            currentLevel++;
            level = new MVCLevelController(arrayLocation[0]+'/'+location[arrayLocation[0]][currentLevel]);
            transition((event.target as DisplayObject),level);
       addEventLevel(true)

        }
    }

    private function level_pauseHandler(event:Event):void
    {
        if (animate)

        {
            level.gameStart =false;
            var pause : PauseView = new PauseView(_width,_height,'complete');
            addChild(pause);
            pause.addEventListener(Myevent.MAIN_MENU,main_menuHandler_pause);
            pause.addEventListener(Myevent.RESTART,restartHandler_pause);
            pause.addEventListener(Myevent.CONTINUE, pause_continueHandler);
            pause = null;
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
            level.gameStart = true;
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
        addEventListener(Event.ENTER_FRAME, enterFrameHandler);
        addEventListener(Myevent.TRANSITION_COMPLETE, transition_completeHandler);

    }

    private function enterFrameHandler(event:Event):void
    {
        animate=false;
    //    transitionFirstObject.y+=20;
        transitionFirstObject.alpha-=0.033;
    //    transitionDisplayobjec.y+=20;
        transitionDisplayobjec.alpha+=0.033;
        if (transitionDisplayobjec.alpha>1)
        {
            dispatchEvent(new Event(Myevent.TRANSITION_COMPLETE));
        }
    }

    private function transition_completeHandler(event:Event):void
    {
        this.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
        (transitionFirstObject as Destroyer).destroy();
        removeChild(transitionFirstObject);
        if (transitionDisplayobjec is MVCMenuController)
        {
            addEventMenu(true);
        }
        transitionFirstObject = null;
        animate=true;
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
            menu = new MVCMenuController();
            transition(level,menu);
        }
    }

    private function restartHandler_pause(event:Event):void
    {
        if (animate)
        {
            (event.target as Destroyer).destroy();
            removeChild((event.target as DisplayObject));
            (event.target as DisplayObject).removeEventListener(Myevent.MAIN_MENU,main_menuHandler_pause);
            (event.target as DisplayObject).removeEventListener(Myevent.RESTART,restartHandler_pause);
            (event.target as DisplayObject).removeEventListener(Myevent.CONTINUE, pause_continueHandler);
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
        }
        else
        {
            level.removeEventListener(Event.COMPLETE, level_completeHandler);
            level.removeEventListener(Myevent.FEILD, level_feilHandler);
            level.removeEventListener(Myevent.PAUSE, level_pauseHandler);
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
}
}