/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 17.01.13
 * Time: 11:30
 * To change this template use File | Settings | File Templates.
 */
package MVCLevel {
import GameComponets.loaders.Asset;

import flash.display.Bitmap;
import flash.display.Sprite;

import implementation.Destroyer;

public class MapStatus extends Sprite implements Destroyer{
    private var cursor : int = 0;
    private var len : int=0;
    private var  cursorBitmap : Bitmap;
    private var mapBitmap : Bitmap;
    public function MapStatus(len : int=100) {
        this.len=len;
        cursorBitmap=new Asset.Cursor;
        mapBitmap  = new Asset.Map;
        mapBitmap.width=200;
        addChild(mapBitmap);
        addChild(cursorBitmap);
        cursorBitmap.y =  mapBitmap.height+1;
        cursorBitmap.x = 0-cursorBitmap.width/2
        this.alpha=0.6;

    }
    public function destroy(): void {
        cursorBitmap=null;
        mapBitmap=null;
        for (var i:int = 0;i<this.numChildren;i++)
            removeChildAt(i);
    }
    public function update(current : int): void {
        mapBitmap.x=0-(current)/(len/mapBitmap.width);
    }
}
}
