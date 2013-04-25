/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 15.12.12
 * Time: 16:28
 * To change this template use File | Settings | File Templates.
 */
package MVCLevel {
import GameComponets.loaders.Asset;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.Event;

public class BubbleView extends Sprite{
    private var bubble : Bitmap;
    public var flag : int = 0;
    public function BubbleView() {
       bubble =  new Asset.Bubble;
       bubble.width = bubble.height = 7+(Math.random()*10);
        addChild(bubble);

    }

    public function update():void
    {
        if (flag == 0)
        {
        this.y-=6;
        if (this.y<0)
        {

            dispatchEvent(new Event(Event.COMPLETE));
            flag = 1;
        }

        }
    }

}
}
