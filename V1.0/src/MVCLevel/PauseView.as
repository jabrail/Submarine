/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 14.12.12
 * Time: 14:52
 * To change this template use File | Settings | File Templates.
 */
package MVCLevel {
import GameComponets.loaders.Asset;

import Othe.Myevent;

import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.greensock.easing.Back;
import com.greensock.easing.Bounce;
import com.greensock.easing.Quart;

import flash.display.Bitmap;
import flash.display.Shape;
import flash.display.Sprite;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;

import implementation.Destroyer;

public class PauseView extends Sprite implements  Destroyer{
    private var _width : Number = 0;
    private var _height : Number = 0;
    private var array_def_point : Array = new Array();
    private var array_custom_point : Array = new Array();
    private var array_button : Array = new Array();
    private var timeLine_0 : TimelineLite = new TimelineLite();
    private var timeLine_1 : TimelineLite = new TimelineLite();
    private var timeLine_2 : TimelineLite = new TimelineLite();
    private var timeLine_3 : TimelineLite = new TimelineLite();
    private var timeLine_4 : TimelineLite = new TimelineLite();
    private var timeLine_5 : TimelineLite = new TimelineLite();
    private var timeLine_6 : TimelineLite = new TimelineLite();
    private var timeLine_7 : TimelineLite = new TimelineLite();
    private var timeLine_8 : TimelineLite = new TimelineLite();
    private var timeLine_9 : TimelineLite = new TimelineLite();
    private var fon_sprite : Sprite = new Sprite();
    public var fon : Bitmap;
    private var timer : Timer = new Timer(400);
    public function PauseView(_width: Number,_height : Number,type : String) {
        this._width = _width;
        this._height = _height;

       fon  = new Asset.Background_pause();
        fon_sprite.addChild(fon);
        fon_sprite.y=-800;
        timeLine_6.append(new TweenLite(fon_sprite,0.4,{x:0,y:0,ease:Back.easeIn}))

        addChild(fon_sprite);
        if (type=='complete_next')
        {
           /* var next_s :Sprite= new Sprite();
            var restart_s :Sprite= new Sprite();
            var main_menu_s :Sprite= new Sprite();
            var main_menu : Bitmap = new Asset.Main_menu;
            main_menu_s.addChild(main_menu);
            main_menu_s.x = 10;
            main_menu_s.y = 450;
            var restart : Bitmap = new Asset.Restert;
            restart_s.x =main_menu_s.x+ main_menu_s.width+30;
            restart_s.y = 450;
            restart_s.addChild(restart);
            var next : Bitmap = new Asset.Next;
            next_s.x = restart_s.x+restart_s.width+30;
            next_s.y = 450;
             addChild(main_menu_s);
            addChild(restart_s);
            addChild(next_s);
             next_s.addChild(next);
            var continue_button : Bitmap = new Asset.Continue;
            var continue_sprite : Sprite = new Sprite();
            continue_sprite.addChild(continue_button);
            continue_sprite.x = next_s.x+next_s.width+30;
            continue_sprite.y = 450;
            addChild(continue_sprite);

            continue_sprite.addEventListener(MouseEvent.MOUSE_UP, continue_sprite_mouseUpHandler)
            main_menu_s.addEventListener(MouseEvent.MOUSE_UP, main_menu_clickHandler);
            next_s.addEventListener(MouseEvent.MOUSE_UP, next_mouseUpHandler);
            restart_s.addEventListener(MouseEvent.MOUSE_UP, restart_mouseUpHandler);*/
        }
        else if (type=='complete')
        {
            var main_menu_Button : Sprite =  createButton(Asset.Main_menu);
            main_menu_Button.x = -0;
            main_menu_Button.y = 150;
            fon_sprite.addChild(main_menu_Button);
            array_custom_point['main_menu_Button'] = new Point(0,150);
            array_def_point['main_menu_Button'] = new Point(-160,150);
            array_button['main_menu_Button'] = main_menu_Button;

            var mic_calibrate : Sprite =  createButton(Asset.CalibrateButton);
            mic_calibrate.x = 640;
            mic_calibrate.y = 150;
            fon_sprite.addChild(mic_calibrate);
            array_custom_point['mic_calibrate'] = new Point(640,150);
            array_def_point['mic_calibrate'] = new Point(800,150);
            array_button['mic_calibrate'] = mic_calibrate;


            var sound_of : Sprite =  createButton(Asset.Audio_of);
            sound_of.x = 640;
            sound_of.y = 300;
            fon_sprite.addChild(sound_of);
            array_custom_point['sound_of'] = new Point(640,300);
            array_def_point['sound_of'] = new Point(800,300);
            array_button['sound_of'] = sound_of;
            var sound_on : Sprite =  createButton(Asset.Audio_on);
            sound_on.x = 640;
            sound_on.y = 300;
            fon_sprite.addChild(sound_on);
            array_custom_point['sound_on'] = new Point(640,300);
            array_def_point['sound_on'] = new Point(800,300);
            array_button['sound_on'] = sound_on;

            var mic_of : Sprite =  createButton(Asset.Keyboard);
            mic_of.x = 640;
            mic_of.y = 450;
            fon_sprite.addChild(mic_of);
            array_custom_point['mic_of'] = new Point(640,450);
            array_def_point['mic_of'] = new Point(800,450);
            array_button['mic_of'] = mic_of;
            var mic_on : Sprite =  createButton(Asset.Microphone);
            mic_on.x = 640;
            mic_on.y = 450;
            fon_sprite.addChild(mic_on);
            array_custom_point['mic_on'] = new Point(640,450);
            array_def_point['mic_on'] = new Point(800,450);
            array_button['mic_on'] = mic_on;

            var restart_button : Sprite =  createButton(Asset.Restert);
            restart_button.x = -0
            restart_button.y =  300;
            fon_sprite.addChild(restart_button);
            array_custom_point['restart_button'] = new Point(0,300);
            array_def_point['restart_button'] = new Point(-160,300);
            array_button['restart_button'] = restart_button;

            var review_button : Sprite =  createButton(Asset.ReviewButton);
            review_button.x = -0
            review_button.y =  450;
            fon_sprite.addChild(review_button);
            array_custom_point['review_button'] = new Point(0,450);
            array_def_point['review_button'] = new Point(-160,450);
            array_button['review_button'] = review_button;

            var continue_button : Sprite =  createButton(Asset.Continue);
            continue_button.x = 400-continue_button.width/2;
//            continue_button.y = 0-continue_button.height;
            fon_sprite.addChild(continue_button);
            array_custom_point['continue_button'] = new Point(400-continue_button.width/2,0);
            array_def_point['continue_button'] = new Point(400-continue_button.width/2,0-continue_button.height);
            array_button['continue_button'] = continue_button;

            continue_button.addEventListener(MouseEvent.MOUSE_UP, continue_sprite_mouseUpHandler)
            main_menu_Button.addEventListener(MouseEvent.MOUSE_UP, main_menu_clickHandler);
            restart_button.addEventListener(MouseEvent.MOUSE_UP, restart_mouseUpHandler);
            mic_calibrate.addEventListener(MouseEvent.MOUSE_UP, mic_calibrate_mouseUpHandler);
            sound_of.addEventListener(MouseEvent.MOUSE_UP, sound_of_mouseUpHandler);
            sound_on.addEventListener(MouseEvent.MOUSE_UP, sound_on_mouseUpHandler);
            mic_of.addEventListener(MouseEvent.MOUSE_UP, mic_of_mouseUpHandler);
            mic_on.addEventListener(MouseEvent.MOUSE_UP, mic_on_mouseUpHandler);
            review_button.addEventListener(MouseEvent.MOUSE_UP, review_button_mouseUpHandler);

/*            setPosition_custom(main_menu_Button,'main_menu_Button',timeLine_0);
            setPosition_custom(mic_calibrate,'mic_calibrate',timeLine_1);
            setPosition_custom(sound_of,'sound_of',timeLine_2);
            setPosition_custom(sound_on,'sound_on',timeLine_3);
            setPosition_custom(mic_of,'mic_of',timeLine_4);
            setPosition_custom(mic_on,'mic_on',timeLine_5);
            setPosition_custom(restart_button,'restart_button',timeLine_7);
            setPosition_custom(review_button,'review_button',timeLine_8);
            setPosition_custom(continue_button,'continue_button',timeLine_9);*/

        }




    }

    private function setPosition_def(sprite : Sprite,str : String,tm:TimelineLite) : void  {
        tm.append(new TweenLite(sprite,0.4,{x: array_def_point[str].x,y: array_def_point[str].y,ease:Back.easeIn}));
    }
    private function setPosition_custom(sprite : Sprite,str : String,tm:TimelineLite) : void  {
        tm.append(new TweenLite(sprite,0.4,{x: array_custom_point[str].x,y: array_custom_point[str].y,ease:Back.easeIn}));

                   }
    private function createButton(bg : Class) : Sprite {
        var button : Bitmap = new bg();
        var sprite : Sprite = new Sprite();
        sprite.addChild(button);
        return sprite;
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

    private function continue_sprite_mouseUpHandler(event:MouseEvent):void
    {
      /*  setPosition_def(array_button['main_menu_Button'],'main_menu_Button',timeLine_0);
        setPosition_def(array_button['mic_calibrate'],'mic_calibrate',timeLine_1);
        setPosition_def(array_button['sound_of'],'sound_of',timeLine_2);
        setPosition_def(array_button['sound_on'],'sound_on',timeLine_3);
        setPosition_def(array_button['mic_of'],'mic_of',timeLine_4);
        setPosition_def(array_button['mic_on'],'mic_on',timeLine_5);
        setPosition_def(array_button['restart_button'],'restart_button',timeLine_7);
        setPosition_def(array_button['review_button'],'review_button',timeLine_8);
        setPosition_def(array_button['continue_button'],'continue_button',timeLine_9);*/
        timeLine_6.append(new TweenLite(fon_sprite,0.4,{x:0,y:-800,ease:Back.easeIn}));

        timer.addEventListener(TimerEvent.TIMER, timer_timerHandler);
        timer.start();
    }
    public function destroy() : void
    {

    }

    private function timer_timerHandler(event:TimerEvent):void {
        timer.removeEventListener(TimerEvent.TIMER, timer_timerHandler);

        dispatchEvent(new Event(Myevent.CONTINUE));

    }

    private function mic_calibrate_mouseUpHandler(event:MouseEvent):void {
        dispatchEvent(new Event(Myevent.MICROPHONE_CALIBRATE));
    }

    private function sound_of_mouseUpHandler(event:MouseEvent):void {
        setPosition_custom(array_button['sound_on'],'sound_on',timeLine_4);
        setPosition_def(array_button['sound_of'],'sound_of',timeLine_4);
        dispatchEvent(new Event(Myevent.SOUND_OF));
    }

    private function sound_on_mouseUpHandler(event:MouseEvent):void {
        setPosition_custom(array_button['sound_of'],'sound_of',timeLine_4);
        setPosition_def(array_button['sound_on'],'sound_on',timeLine_4);
        dispatchEvent(new Event(Myevent.SOUND_ON));
    }

    private function mic_of_mouseUpHandler(event:MouseEvent):void {
        setPosition_custom(array_button['mic_on'],'mic_on',timeLine_4);
        setPosition_def(array_button['mic_of'],'mic_of',timeLine_4);

        dispatchEvent(new Event(Myevent.MICROOFF));
    }

    private function mic_on_mouseUpHandler(event:MouseEvent):void {
        setPosition_custom(array_button['mic_of'],'mic_of',timeLine_4);
        setPosition_def(array_button['mic_on'],'mic_on',timeLine_4);
        dispatchEvent(new Event(Myevent.MICROON));
    }

    private function review_button_mouseUpHandler(event:MouseEvent):void {
        dispatchEvent(new Event(Myevent.REVIEW));
    }
}
}
