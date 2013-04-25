/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 18.03.13
 * Time: 14:57
 * To change this template use File | Settings | File Templates.
 */
package GameComponets.loaders {
import GameComponets.loaders.ModalContainer;

import flash.display.Bitmap;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.SampleDataEvent;
import flash.events.TimerEvent;
import flash.media.Microphone;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.utils.Timer;

public class MicroCalibrate extends Sprite {
    private var mainWindow : Sprite = new Sprite();
    private var textField : TextField = new TextField();
    private var mic : Microphone;
    private static var timer : Timer = new Timer(50);
    private var seconds : int = 0;
    private var color : Number = 0x000000;
    public  var gain : int =0;
    private var value : int = 10;
    private var sub : Bitmap;
    public function MicroCalibrate() {
        mainWindow.graphics.beginFill(0xFF0000,0.9);
        mainWindow.graphics.drawRoundRect(0,0,600,400,5,5);
        mainWindow.x = 100;
        mainWindow.y = 100;
        addChild(mainWindow);
        var lineTop : Sprite = new Sprite();
        var lineBottom : Sprite = new Sprite();
        lineTop.graphics.beginFill(0x000000,0.9);
        lineBottom.graphics.beginFill(0x000000,0.9);
        lineTop.graphics.drawRect(0,0,600,1);
        lineBottom.graphics.drawRect(0,0,600,1);
        lineBottom.y=100;
        lineTop.y =300;
        mainWindow.addChild(lineBottom);
        mainWindow.addChild(lineTop);
        textField.defaultTextFormat = TextFormats.textFormat_1;
        textField.width =600;
        textField.text = 'Настройте микрофон';
        textField.x = 20;
        textField.y = 30;
        mainWindow.addChild(textField);
        sub = new Asset.Sub();
        sub.x = 300-sub.width/2;
        sub.y = 200-sub.height/2;
        mainWindow.addChild(sub);

    }
    public function  init(mic : Microphone) : void {
        mainWindow.graphics.clear();
        mainWindow.graphics.beginFill(0xFF0000,0.9);
        mainWindow.graphics.drawRoundRect(0,0,600,400,5,5);
        this.mic = mic;
        this.mic.addEventListener(SampleDataEvent.SAMPLE_DATA, onMicActivity);
        timer.start();
        timer.addEventListener(TimerEvent.TIMER, timer_timerHandler);
        gain = 100;
        seconds=0;
        value = 15;
        alpha=1;
        color = 0xFF0000;

    }

    private function onMicActivity(event:SampleDataEvent):void {

        if ((mic.activityLevel>20)) {
            mic.gain-=value;
            value--;
        }
        else
        if ((mic.activityLevel>2)||(mic.activityLevel<10)) {
            mic.gain+=value;
            value--;
        }
        if (value<1) value=1;
        gain = mic.gain;
        sub.y = 100+ mic.activityLevel;
    }

    private function timer_timerHandler(event:TimerEvent):void {
        seconds++;
        color-=0x020000;
        color+=0x000200;
        mainWindow.graphics.clear();
        mainWindow.graphics.beginFill(color,0.9);
        mainWindow.graphics.drawRoundRect(0,0,600,400,5,5);

        if (seconds>100)
        {
            alpha-=0.05;
            if (alpha<0)
            {
                timer.removeEventListener(TimerEvent.TIMER, timer_timerHandler);
                this.mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, onMicActivity);
                dispatchEvent(new Event(Event.COMPLETE));
            }
        }
    }
}
}
