/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 14.03.13
 * Time: 11:45
 * To change this template use File | Settings | File Templates.
 */
package GameComponets.loaders {
import flash.display.Bitmap;
import flash.display.Sprite;

public class PreloaderRef {
    public static var preloader : Sprite = new Sprite();
    public static var preloaderProgres : Bitmap = new Asset.PreloaderProgres();
    public function PreloaderRef() {
    }
    public static function init() :  void {
        var btm:Bitmap = new Asset.PreloaderFon();
        preloader.addChild(btm);
        preloaderProgres.x=10;
        preloaderProgres.y=preloader.height/2-preloaderProgres.height/2;
        preloaderProgres.width=0;
        preloader.addChild(preloaderProgres)
        preloader.x=255;
        preloader.y=450;
    }
    public static function setValue(value : Number) : void {
        preloaderProgres.width=value*2.7;
    }
}
}
