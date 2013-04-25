/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 17.12.12
 * Time: 14:44
 * To change this template use File | Settings | File Templates.
 */
package Othe {
import GameComponets.loaders.Asset;

import flash.display.Bitmap;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Vector3D;
import flash.text.TextField;

import flashx.textLayout.conversion.PlainTextExporter;

public class Button extends Sprite{
    private var background : Shape;
    private var par : int = 0;
    private var deg : Number=-30;
    private var value : String = new String();
    private var animate : Boolean = false;
    private var mouseout : Boolean = false;
    public function Button(value : String) {


        this.value =value;
        var bg_play : Bitmap = new Asset.menu_play();
        addChild(bg_play);
        var hover : Sprite = new Sprite();
        hover.graphics.beginFill(0x000000,0.01);
        hover.graphics.drawRoundRect(0,0,bg_play.width,bg_play.height,5,5);
        addChild(hover);
            //       hover.addEventListener(MouseEvent.MOUSE_MOVE,mouseMoveHandler);
            //       hover.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
            hover.addEventListener(MouseEvent.CLICK, hover_mouseUpHandler)
            rotationZ=0;
//        this.transform.matrix3D.appendRotation(-30,new Vector3D(0,1,0), new Vector3D(0,0,0));



        this.graphics.beginFill(0x000000);
        this.graphics.lineStyle(1,0x000000);

    }



    private function mouseMoveHandler(event:MouseEvent):void
    {
        if (!animate)
        {
            animate=true;
            addEventListener(Event.ENTER_FRAME, enterFrame_Handler);

        }
    }

    private function mouseOutHandler(event:MouseEvent):void
    {

        if (!animate)
        {
            animate=true;
            addEventListener(Event.ENTER_FRAME, enterFrameHandler);

        }
        else
        {
            mouseout = true;
        }
    }

    private function enterFrame_Handler(event:Event):void
    {
        if (animate)
        {
            if (deg<0)
            {
                this.transform.matrix3D.appendRotation(10,new Vector3D(0,1,0), new Vector3D(0,0,0));
                deg+=10;

            }
            else
            {
                animate=false;
                removeEventListener(Event.ENTER_FRAME,enterFrame_Handler);
                if (mouseout)
                {
                    animate=true;
                    addEventListener(Event.ENTER_FRAME, enterFrameHandler);
                }
            }
        }
    }

    private function enterFrameHandler(event:Event):void
    {

        if (animate)
        {
            if (deg>-30)
            {
                this.transform.matrix3D.appendRotation(-10,new Vector3D(0,1,0), new Vector3D(0,0,0));
                deg-=10;

            }
            else
            {
                animate=false;
                mouseout = false;
                removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
            }
        }
    }
    public function getValue() : String { return value;  }

    private function hover_mouseUpHandler(event:MouseEvent):void
    {
        dispatchEvent(new Event(Event.COMPLETE));
    }
}
}
