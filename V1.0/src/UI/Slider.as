/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 07.01.13
 * Time: 12:42
 * To change this template use File | Settings | File Templates.
 */
package UI {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

public class Slider extends Sprite {

    private var _widthSlider : Number = 0;
    private var track : Sprite = new Sprite();
    private var box : Sprite = new Sprite();
    private var mouseDown : Boolean = false;
    private var posClick : Number = 0;
    private var hover : Sprite = new Sprite();
    private var customPos : Number = 0;
    private var _textColor : Number = 0;
    public function Slider(widthSlider : Number =100,position : Number =50, textColor: Number = 0x000000) {
        _textColor =textColor;
        _widthSlider = widthSlider;
        customPos = position;
        this.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler)
        draw();

    }

 protected function draw() : void
 {
     track.graphics.beginFill(_textColor);
     track.graphics.drawRoundRect(0,0,_widthSlider,2,1);
     track.y = 10;

     box.graphics.beginFill(_textColor);
     box.graphics.drawRect(0,0,6,12);
     box.y=5;
     box.x = customPos;

     hover.graphics.beginFill(0xFFFFFF,0.01);
     hover.graphics.drawRect(0,0,track.width,12);
     hover.y = box.y;
     hover.x = track.x;

     addChild(track);
     addChild(hover);
     addChild(box);
     addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler)

 }
    private function box_mouseDownHandler(event:MouseEvent):void
    {
        mouseDown = true;
        posClick = event.stageX;
        stage.addEventListener(MouseEvent.MOUSE_MOVE, box_mouseMoveHandler)

    }

    private function box_mouseUpHandler(event:MouseEvent):void
    {
        mouseDown =false;
        stage.removeEventListener(MouseEvent.MOUSE_MOVE, box_mouseMoveHandler);
    }

    private function box_mouseMoveHandler(event:MouseEvent):void
    {

        if (event.stageX>(track.width+this.localToGlobal(new Point(track.x, track.y)).x))
        {
            box.x = track.x+track.width;
        }
        else if (event.stageX<this.localToGlobal(new Point(track.x, track.y)).x)
        {
            box.x = track.x;
        }
        else
        {
            box.x=event.stageX-this.localToGlobal(new Point(track.x, track.y)).x;
        }
    }
    public function getValue(): Number
    {
        return box.x-track.x;
    }

    private function addedToStageHandler(event:Event):void {
        box.addEventListener(MouseEvent.MOUSE_DOWN, box_mouseDownHandler);
        stage.addEventListener(MouseEvent.MOUSE_UP, box_mouseUpHandler);
    }

    private function removedFromStageHandler(event:Event):void {
      box.removeEventListener(MouseEvent.MOUSE_DOWN, box_mouseDownHandler);
        stage.removeEventListener(MouseEvent.MOUSE_UP, box_mouseUpHandler);
    }
}
}
