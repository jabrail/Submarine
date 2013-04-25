/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 01.10.12
 * Time: 14:55
 * To change this template use File | Settings | File Templates.
 */
package Menu
{
import GameComponets.loaders.Asset;
import GameComponets.loaders.ModalContainer;
import GameComponets.loaders.UrlSettings;
import GameComponets.loaders.Vk;

import MVCLevel.*;

import Othe.Myevent;

import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.greensock.easing.Elastic;
import com.greensock.plugins.ScrollRectPlugin;
import com.greensock.plugins.TweenPlugin;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.net.URLRequest;
import flash.utils.Timer;

import implementation.Destroyer;


public class LevelSelect  extends Sprite  implements Destroyer
{


	public var fonShape : Shape = new Shape()
	public var level1 : MVCLevelController;
    public var selected : int = 0;
    private var arrayLevel : Array = new Array();
    private var arrayLevel_title : Array = new Array();
    private var collevel : int = 5;
    private var index : int =0;
    private var timer : Timer = new Timer(1000);
    private var timeLine : TimelineLite = new TimelineLite();
    private var currentIndex : int =0;
    private var location : String;


	public function LevelSelect(location : String,arraylevels : Array,type : String)
	{
        this.location = location;
        TweenPlugin.activate([ScrollRectPlugin]);
        addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        arrayLevel_title =arraylevels;
        var background : Bitmap = new Asset.LevelSelect();
        addChild(background);

        loadThumbus();

		this.addEventListener(MouseEvent.CLICK,eventHandler);

        if (type=='complete_next')
        {
            var next_s :Sprite= new Sprite();
            var restart_s :Sprite= new Sprite();
            var main_menu_s :Sprite= new Sprite();

         /*   var main_menu : Bitmap = new Asset.Main_menu;
            main_menu_s.x = 10;
            main_menu_s.y = 450;
            main_menu_s.addChild(main_menu);*/
            var restart : Bitmap = new Asset.Restert;
            restart_s.x =10;
            restart_s.y = 450;
            restart_s.addChild(restart);
            var next : Bitmap = new Asset.Next;
            next_s.x = restart_s.x+restart_s.width+30;
            next_s.y = 450;
            addChild(main_menu_s);
            addChild(restart_s);
            addChild(next_s);


            next_s.addChild(next);
/*
            main_menu_s.addEventListener(MouseEvent.CLICK, main_menu_clickHandler);
*/
            next_s.addEventListener(MouseEvent.CLICK, next_mouseUpHandler);
            restart_s.addEventListener(MouseEvent.CLICK, restart_mouseUpHandler);
        }
        else if (type == 'start')
        {
     /*       var main_menu : Bitmap = new Asset.Main_menu;
            var main_menu_s : Sprite = new Sprite();
            main_menu_s.x = 10;
            main_menu_s.y = 450;
            addChild(main_menu_s);
            main_menu_s.addChild(main_menu);

            main_menu_s.addEventListener(MouseEvent.CLICK, main_menu_clickHandler);*/

        }
        else if (type=='complete')
        {
   /*         var main_menu : Bitmap = new Asset.Main_menu;
            var main_menu_s : Sprite = new Sprite();
            main_menu_s.x = 10;
            main_menu_s.y = 450;

            addChild(main_menu_s);
            main_menu_s.addChild(main_menu);*/
            var restart : Bitmap = new Asset.Restert;
            var restart_s : Sprite = new Sprite();
            restart_s.x =10;
            restart_s.y = 450;
            restart_s.addChild(restart);
            addChild(restart_s);
            restart_s.addEventListener(MouseEvent.CLICK, restart_mouseUpHandler);
        }
	}
    private function loadThumbus() : void  {

            var thumbusLoader : LoaderThumbus =new LoaderThumbus();
            thumbusLoader.load(new URLRequest(UrlSettings.mainUrl+'/submarine/games/locations/'+location+'/'+arrayLevel_title[currentIndex]+'/thumbs.png'));
            thumbusLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);

    }
	private function eventHandler(event:Event):void
	{

	}

	private function levelel_clickHandler(event:MouseEvent):void
	{
        selected = (event.target as Hover).number;
        if (Vk.flashVars['viewer_id']!=155685417)
        {
            SharedTracker.tracker.trackEvent("/Click",'/Load_level',selected.toString());
        }

        timeLine.append(new TweenLite( arrayLevel[(event.target as Hover).number],1,{scaleX : 1.2,scaleY : 1.2, x : arrayLevel[(event.target as Hover).number].x-(arrayLevel[(event.target as Hover).number].width/100*10),y: arrayLevel[(event.target as Hover).number].y-(arrayLevel[(event.target as Hover).number].height/100*10), ease:Elastic.easeInOut}));

        timer.addEventListener(TimerEvent.TIMER, timer_timerHandler);
        timer.start();
        (event.target as Hover).removeEventListener(Event.COMPLETE, levelel_clickHandler);


	}
    public function elementresaze(currentlevel : int,btm : Bitmap) : void
    {

    }
     private function reposition () : void
     {
         var j : int = 0;
         var k : int = 0;
         for (var i : int = 0; i<arrayLevel.length;i++)
         {
             if ((k * (arrayLevel[i] as LevelSelectElement).width+80*k)>600)
         {
             j++;
             k=0;
         }

             arrayLevel[i].x = (k * arrayLevel[i].width)+80*k+40;
             arrayLevel[i].y=j*arrayLevel[i].height+j*80+40;
              k++;
         }

     }

    private function completeHandler(event:Event):void
    {
        var bitmapdata : BitmapData;
        bitmapdata = new BitmapData(event.target.loader.content.width,event.target.loader.content.height,true,0x000000);
        bitmapdata.draw(event.target.loader.content);
        var bitmap : Bitmap = new Bitmap(bitmapdata);
        arrayLevel[currentIndex] = new LevelSelectElement(bitmap,currentIndex,arrayLevel_title[currentIndex]);
        addChild(arrayLevel[currentIndex]);
        (arrayLevel[currentIndex] as LevelSelectElement).addEventListener(MouseEvent.CLICK, levelel_clickHandler);
        currentIndex++;
        index++;
        bitmapdata=null;
        bitmap=null;
        if (currentIndex==arrayLevel_title.length)
        {
            reposition();
        }
        else
        {
            loadThumbus();
        }

    }

    private function main_menu_clickHandler(event:MouseEvent):void
    {
        dispatchEvent(new Event(Myevent.MAIN_MENU));
    }

    private function next_mouseUpHandler(event:MouseEvent):void
    {
        dispatchEvent(new Event(Myevent.NEXT));
    }

    private function restart_mouseUpHandler(event:MouseEvent):void
    {
        dispatchEvent(new Event(Myevent.RESTART));
    }
    public function destroy() : void
    {


        for (var i : int = 0; i<arrayLevel.length;i++)
        {
          (arrayLevel[i] as LevelSelectElement).destroy();

        }
        for (var i : int =0;i<this.numChildren;i++)
        {
            this.removeChildAt(i);
        }
    }

    private function addedToStageHandler(event:Event):void {
//        ModalContainer.messegeView.y = 450;
        ModalContainer.textField.text = 'Для прохождение уровня необходимо не давать кораблю столкнуться с противниками и удариться об скалы издавая звуки.      Что бы убрать окно нажмите на него';
    }

    private function timer_timerHandler(event:TimerEvent):void {
        timer.removeEventListener(TimerEvent.TIMER, timer_timerHandler);
        dispatchEvent(new Event(Event.COMPLETE));

    }
}
}
