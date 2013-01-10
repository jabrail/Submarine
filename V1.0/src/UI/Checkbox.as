/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 07.01.13
 * Time: 12:21
 * To change this template use File | Settings | File Templates.
 */
package UI {
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;

public class Checkbox extends Sprite{
    public var text : TextField = new TextField();
    private var box : Sprite = new Sprite();
    private var currentState : Boolean;
    private var hover : Sprite = new Sprite();
    private var _textColor : Number =0;
    public function Checkbox(text : String='Checkbox',textColor : Number=0x000000,current : Boolean = false) {
        currentState = current;
        _textColor=textColor;
        if (currentState)
        {
            box.graphics.beginFill(_textColor);
            box.graphics.drawRect(0,0,10,10);
        }
        else
        {
            box.graphics.lineStyle(1,_textColor);
            box.graphics.drawRect(0,0,10,10);
        }

        box.x = 0;
        box.y = 5;
        this.text.text=text;
        this.text.x = box.width+5;
        this.text.y = 0;
        this.text.width=300;
        this.text.height=20;
        this.text.textColor=_textColor;

        hover.graphics.beginFill(_textColor,0.01);
        hover.graphics.drawRect(0,0,this.text.width+box.width,this.text.height);
        hover.x = this.box.x;
        hover.y = this.text.y;

        addChild(box);
        addChild(this.text);
        addChild(hover);
        hover.addEventListener(MouseEvent.CLICK, clickHandler);
    }

    private function clickHandler(event:MouseEvent):void
    {
        if (currentState)
        {
            currentState = false;
            box.graphics.lineStyle(1,_textColor);
            box.graphics.drawRect(0,0,10,10);

        }
        else
        {
            currentState = true
            box.graphics.beginFill(0xFFFFFF);
            box.graphics.drawRect(0,0,10,10);

        }

    }
    public function getValue() : Boolean {
        return currentState;
    }
}
}
