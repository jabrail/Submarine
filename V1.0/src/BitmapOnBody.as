/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 23.12.12
 * Time: 15:26
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;

import nape.geom.Vec2;
import nape.phys.Body;

import nape.phys.Body;
import nape.phys.BodyType;
import nape.phys.Material;
import nape.shape.Circle;

public class BitmapOnBody extends Sprite{
    public var  body : Body;
    public var first_circle : Body
    public var second_circle : Body;
    private var  displayobj : DisplayObject;
    public function BitmapOnBody(displayobj : DisplayObject) {
        this.displayobj = displayobj;
        this.x=displayobj.x;
        this.y=displayobj.y;
        this.displayobj.x =0 - displayobj.width/2;
        this.displayobj.y =0 - displayobj.height/2;
        addChild(this.displayobj);
    }
    public function update() : void
    {
        this.x = body.position.x;
        this.y= body.position.y;
    }
}
}
