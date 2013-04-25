/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 10.12.12
 * Time: 18:02
 * To change this template use File | Settings | File Templates.
 */
package Menu {
import GameComponets.loaders.Asset;
import GameComponets.loaders.ModalContainer;
import GameComponets.loaders.PreloaderRef;
import GameComponets.loaders.SoundManager;
import GameComponets.loaders.Vk;

import Othe.Myevent;

import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.greensock.easing.Elastic;
import com.greensock.plugins.BlurFilterPlugin;
import com.greensock.plugins.TweenPlugin;

import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import implementation.Destroyer;

public class CompleteGameView extends Sprite implements Destroyer{

    private var timeLinePlay : TimelineLite = new TimelineLite();
    private var timeLineStop : TimelineLite = new TimelineLite();
    private var timeLinePost : TimelineLite = new TimelineLite();
    private var PlayPressed : Boolean = true;
    private var StopPressed : Boolean = true;
    private var PostPressed : Boolean = true;
    private var stopCont : Sprite = new Sprite();
    private var playcont : Sprite = new Sprite();
    private var soundCompleteEncode : Boolean =false;
    var postCont : Sprite = new Sprite();



    public function CompleteGameView()
    {
        if (ModalContainer.micSost)
        {
        ModalContainer.eventDispatcher.addEventListener(Myevent.SOUND_COMPLETE_ENCODE, SOUND_COMPLETE_ENCODeHandler);
        }
        else
        {
            ModalContainer.rootConteiner.removeChild(PreloaderRef.preloader);
        }
            TweenPlugin.activate([BlurFilterPlugin]);
        var blackFon : Shape = new Shape();
        blackFon.graphics.beginFill(0x000000,0.5);
        blackFon.graphics.drawRect(0,0,800,600);
        addChild(blackFon);

        var bitmap = new Asset.LevelCompleteView();
        addChild(bitmap);
        bitmap.x=400-bitmap.width/2;
        bitmap.y=300-bitmap.height/2;
        var menucont : Sprite = new Sprite();
        var menu : Bitmap = new Asset.Main_menu_G_O();
        menu.y = 450;
        menucont.addChild(menu);
        addChild(menucont);
        menucont.addEventListener(MouseEvent.MOUSE_DOWN, menu_clickHandler);
        bitmap = null;
        menucont = null;
        menu = null;

        var restartcont : Sprite = new Sprite();
        var restart : Bitmap = new Asset.Next();
        restart.x =800-restart.width;
        restart.y = 450;
        restartcont.addChild(restart);
        addChild(restartcont);
        restartcont.addEventListener(MouseEvent.MOUSE_DOWN, restart_clickHandler);
        restartcont =null;
        restart = null;

    }

    private function menu_clickHandler(event:MouseEvent):void
    {
        this.dispatchEvent(new Event(Myevent.MAIN_MENU));
        (event.target as DisplayObject).removeEventListener(MouseEvent.MOUSE_DOWN, menu_clickHandler);

    }

    private function restart_clickHandler(event:MouseEvent):void
    {
        if (Vk.flashVars['viewer_id']!=155685417)
        {
           if (ModalContainer.levelName=='Location_1/level_6_6_2')
            {
                SharedTracker.tracker.trackEvent("/play_again","/play_again");
                this.dispatchEvent(new Event(Myevent.MAIN_MENU));

            }
           else
           {
               this.dispatchEvent(new Event(Myevent.NEXT));
           }

        }
        else
        {
        if (ModalContainer.levelName=='Location_1/level_6_6_2')
        {
            this.dispatchEvent(new Event(Myevent.MAIN_MENU));
        }
        else
        {
            this.dispatchEvent(new Event(Myevent.NEXT));
        }
        }

        (event.target as DisplayObject).removeEventListener(MouseEvent.MOUSE_DOWN, restart_clickHandler);
    }
    public function destroy() : void
    {
        for (var i : int =0;i<this.numChildren;i++)
        {
            this.removeChildAt(i);
        }
    }


    private function playcont_mouseDownHandler(event:MouseEvent):void {

        if (PlayPressed)
        {
            SoundManager.play_Player_Sound();
            /*   timeLineStop.append(new TweenLite(event.target,0.2,{x:event.target.x+(event.target.width/100*5),y:event.target.y+(event.target.height/100*5),scaleX:0.9,scaleY:0.9}));
             timeLineStop.append(new TweenLite(stopCont,0.2,{x:400,y:350,scaleX:1,scaleY:1,ease:Elastic.easeOut}));
             */  PlayPressed =false;
            StopPressed=true;
            playcont.visible =false;
            stopCont.visible = true;
            SoundManager.sound_player_chanel.addEventListener(Event.SOUND_COMPLETE, completeHandler);
        }

    }

    private function stopCont_mouseDownHandler(event:MouseEvent):void {
        if (StopPressed)
        {
            SoundManager.stop_Player_Sound();
            /*            timeLineStop.append(new TweenLite(event.target,0.2,{x:event.target.x+(event.target.width/100*5),y:event.target.y+(event.target.height/100*5),scaleX:0.9,scaleY:0.9}));
             timeLineStop.append(new TweenLite(playcont,0.2,{x:300,y:350,scaleX:1,scaleY:1}));*/
            playcont.visible =true;
            stopCont.visible = false;
            PlayPressed =true;
            StopPressed=false;
        }
    }

    private function postCont_mouseDownHandler(event:MouseEvent):void {
        if (PostPressed)
        {
            /*          timeLineStop.append(new TweenLite(event.target,0.2,{x:event.target.x+(event.target.width/100*5),y:event.target.y+(event.target.height/100*5),scaleX:0.9,scaleY:0.9}));
             */          PostPressed=false;
            Vk.clickHandler();

        }
        else
        {
            timeLineStop.append(new TweenLite(event.target,0.2,{x:200,y:430,scaleX:1,scaleY:1}));
            PostPressed=true;
        }
        event.target.removeEventListener(MouseEvent.MOUSE_DOWN, postCont_mouseDownHandler);

    }

    private function completeHandler(event:Event):void {
        /*  timeLineStop.append(new TweenLite(playcont,0.2,{x:300,y:350,scaleX:1,scaleY:1}));
         */

        playcont.visible =true;
        stopCont.visible = false;
        PlayPressed =true;
        StopPressed=false;
    }

    private function SOUND_COMPLETE_ENCODeHandler(event:Event):void {
        var play : Bitmap = new Asset.Play_sound();
        playcont.x =150;
        playcont.y = 350;
        playcont.addChild(play);
        addChild(playcont);


        var stop : Bitmap = new Asset.Stop_sound();
        stopCont.x =150;
        stopCont.y = 350;
        stopCont.addChild(stop);
        stopCont.visible = false;
        addChild(stopCont);


        var post : Bitmap = new Asset.Share();
        postCont.x =250;
        postCont.y = 350;
        postCont.addChild(post);
        addChild(postCont);

        SoundManager.createSound(ModalContainer.soundArray);
        stopCont.addEventListener(MouseEvent.MOUSE_DOWN, stopCont_mouseDownHandler);
        postCont.addEventListener(MouseEvent.MOUSE_DOWN, postCont_mouseDownHandler);
        playcont.addEventListener(MouseEvent.MOUSE_DOWN, playcont_mouseDownHandler);

        ModalContainer.rootConteiner.removeChild(PreloaderRef.preloader);

    }
}
}

