/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 31.01.13
 * Time: 0:08
 * To change this template use File | Settings | File Templates.
 */
package GameComponets.loaders {
import flash.display.Loader;

import nape.dynamics.InteractionFilter;

import nape.phys.Material;

public class MyByteLoder extends Loader{
    public var  dir : String;
    public var mater : Material;
    public var interactionFilter : InteractionFilter;
    public var  type : int=0;
    public function MyByteLoder() {
    }
}
}
