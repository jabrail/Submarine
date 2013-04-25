/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 17.01.13
 * Time: 12:55
 * To change this template use File | Settings | File Templates.
 */
package MVCLevel {
import GameComponets.loaders.Asset;
import GameComponets.loaders.ModalContainer;

import Othe.Myevent;

import flash.display.Bitmap;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

import implementation.Destroyer;

import org.generalrelativity.animation.grape.Animation;

import org.generalrelativity.animation.grape.Grape;
import org.generalrelativity.animation.grape.path.LinearPath2D;
import org.generalrelativity.animation.grape.path.Path2D;
import org.generalrelativity.animation.grape.path.SpiralPath2D;


public class LevelButtonView extends Sprite implements Destroyer{
    private var microphone_s : Sprite = new Sprite();
    private var microphon_sum : int = 0;
    public static var CalibrateButton : Sprite = new Sprite();
    public var buttonPositionArray : Array = new Array();
    public var pause_sparite : Sprite;
    public static var shape : Shape = new Shape();
    private var animate : Animation;
    private var countSeconds : int=0;
    private var center : Point = new Point();



    private var event_S : String;
    public function LevelButtonView() {

        var pause_button : Bitmap = new Asset.Pause;
        pause_sparite  = new Sprite()
        pause_sparite.addChild(pause_button);
        addChild(pause_sparite);
        pause_sparite.x= 800-pause_sparite.width-30;
        pause_sparite.addEventListener(MouseEvent.CLICK, pause_sparite_mouseUpHandler);
        buttonPositionArray['pause_sparite'] = new Point(pause_sparite.x, pause_sparite.y);
        var microphone : Bitmap = new Asset.Microphone;
        microphone_s.addChild(microphone);
        microphone.width=70;
        microphone.height=70;
//        addChild(microphone_s);
        microphone.x =0-microphone.width/2;
        microphone.y = 0-microphone.height/2;
        microphone_s.x= 800-microphone_s.width/2-30;
        microphone_s.y= pause_sparite.height+30+microphone.height/2;
        microphone_s.addEventListener(MouseEvent.CLICK, microphone_s_mouseUpHandler);
        buttonPositionArray['microphone_s'] = new Point(microphone_s.x, microphone_s.y);
        var btm : Bitmap = new Asset.CalibrateButton;
        btm.scaleX=0.55
        btm.scaleY=0.55
        shape  = new Shape();
        shape.graphics.beginFill(0xFF0000,0.5);
        shape.graphics.drawCircle(0,0,40);
        btm.x =0-btm.width/2;
        btm.y = 0-btm.height/2;
        CalibrateButton.addChild(shape);
        CalibrateButton.addChild(btm)
//        addChild(CalibrateButton);
        CalibrateButton.x = microphone_s.x;
        CalibrateButton.y = microphone_s.y+40+CalibrateButton.height/2;
        buttonPositionArray['CalibrateButton'] = new Point(CalibrateButton.x, CalibrateButton.y);
        ModalContainer.reviewInit();
        ModalContainer.reviewButton.x = 800- ModalContainer.reviewButton.width;
        ModalContainer.reviewButton.y = 600 - ModalContainer.reviewButton.height;
//        addChild(ModalContainer.reviewButton);
        buttonPositionArray['reviewButton']= new Point(ModalContainer.reviewButton.x,ModalContainer.reviewButton.y);
    }
    public function destroy() : void {
        removeChild(ModalContainer.reviewButton);
    }

    private function pause_sparite_mouseUpHandler(e:Event):void {
        dispatchEvent(new MouseEvent(Myevent.PAUSELEVELVIEW));
    }

    private function microphone_s_mouseUpHandler(e:Event):void {
        dispatchEvent(new MouseEvent(Myevent.MICROOFF));
    }
    public function animateMicro() : void {
                   addEventListener(Event.ENTER_FRAME, enterFrameHandler)
}

    private function enterFrameHandler(event:Event):void {
            microphone_s.rotationZ+=10;
            microphon_sum++;
            if ((microphon_sum)==18)
            {
                microphon_sum=0;
                removeEventListener(Event.ENTER_FRAME,enterFrameHandler);

           }

    }
    public function reviewReposition() : void {
       addEventListener(Event.ENTER_FRAME, enterFrameHandlerReview);
    }


    private function enterFrameHandlerReview(event:Event):void {
        if (countSeconds<30)
        {
            center.x=ModalContainer.reviewButton.x =400-ModalContainer.reviewButton.width/2;
            center.y=ModalContainer.reviewButton.y =300-ModalContainer.reviewButton.height/2;
        }
        if (countSeconds>30)
        if (countSeconds<120)
        {
            ModalContainer.reviewButton.x += (buttonPositionArray['reviewButton'].x-center.x)/90;
            ModalContainer.reviewButton.y += (buttonPositionArray['reviewButton'].y-center.y)/90;
        }
        countSeconds++;
        if (countSeconds>120)
        {
            removeEventListener(Event.ENTER_FRAME, enterFrameHandlerReview);
            countSeconds=0;
        }


    }
}
}
