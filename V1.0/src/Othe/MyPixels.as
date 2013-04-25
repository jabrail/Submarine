/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 07.12.12
 * Time: 22:34
 * To change this template use File | Settings | File Templates.
 */
package Othe {
import flash.display.Shape;
import flash.display.Sprite;

public class MyPixels extends Sprite{
    private var pix : Shape = new Shape();
    public function MyPixels() {
       pix.graphics.beginFill(0xFFFFFF);
        pix.graphics.drawRect(0,0,1,1);
        addChild(pix);

    }
}
}
