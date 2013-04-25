/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 31.01.13
 * Time: 17:08
 * To change this template use File | Settings | File Templates.
 */
package GameComponets.loaders {
import MVCLevel.LayerCreate;

import flash.display.Sprite;

import flash.events.Event;
import flash.utils.Dictionary;

import nape.phys.Body;

public class CacheController extends Sprite{
    private  var cache : Cache;
    public function CacheController() {
          cache  = new Cache();
        addChild(cache);
        cache.addEventListener(Event.COMPLETE, cache_completeHandler);
    }
    public  function getDictionary() : Dictionary {
         return cache.dictionaryObj;
    }
    public  function loadLevel(levelName : String) : void {
         cache.init(levelName);
    }
    private function cache_completeHandler(event:Event):void {
       trace('complete');
       dispatchEvent(new Event(Event.COMPLETE));
    }
    public function getLength() : Number {
        return cache._length;
    }
    public function getSpeed() : Number {
        return cache._speed;
    }
    public function getEnemyNum() : Number {
        return cache._enemyNum  ;
    }
    public function destroy() : void {
         cache.destroy();
    }
}
}
