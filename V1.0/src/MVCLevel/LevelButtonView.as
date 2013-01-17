/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 17.01.13
 * Time: 12:55
 * To change this template use File | Settings | File Templates.
 */
package MVCLevel {
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class LevelButtonView extends Sprite implements Destroyer{
    private var microphone_s : Sprite = new Sprite();
    private var microphon_sum : int = 0;
    private var event_S : String;
    public function LevelButtonView() {

        var pause_button : Bitmap = new Asset.Pause;
        var pause_sparite : Sprite = new Sprite()
        pause_sparite.addChild(pause_button);
        addChild(pause_sparite);
        pause_sparite.x= 800-pause_sparite.width-30;
        pause_sparite.addEventListener(MouseEvent.CLICK, pause_sparite_mouseUpHandler);

        var microphone : Bitmap = new Asset.Microphone;
        microphone_s.addChild(microphone);
        microphone.width=70;
        microphone.height=70;
        addChild(microphone_s);
        microphone.x =0-microphone.width/2;
        microphone.y = 0-microphone.height/2;
        microphone_s.x= 800-microphone_s.width/2-30;
        microphone_s.y= pause_sparite.height+30+microphone.height/2;
        microphone_s.addEventListener(MouseEvent.CLICK, microphone_s_mouseUpHandler);
    }
    public function destroy() : void {

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

}
}
