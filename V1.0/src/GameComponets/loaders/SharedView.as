/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 13.03.13
 * Time: 14:15
 * To change this template use File | Settings | File Templates.
 */
package GameComponets.loaders {
import flash.display.Bitmap;
import flash.display.Shape;
import flash.display.Sprite;
import flash.text.TextField;

public class SharedView  {
    public static var buttonShare : Sprite = new Sprite();
    public static var view : Sprite = new Sprite();
    public static var buttonSkip : Sprite = new Sprite();

    public function SharedView() {

    }
    public static function init() : void {

        var bitmap : Bitmap = new  Asset.Share();
        buttonShare.addChild(bitmap);
        view.addChild(buttonShare);
        var bitmap : Bitmap = new  Asset.Skip();
        buttonSkip.y = buttonShare.height + buttonShare.y;
        buttonSkip.addChild(bitmap);
        view.addChild(buttonSkip);
    }

}
}
