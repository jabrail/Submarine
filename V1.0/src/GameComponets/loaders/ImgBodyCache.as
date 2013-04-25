/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 02.02.13
 * Time: 16:37
 * To change this template use File | Settings | File Templates.
 */
package GameComponets.loaders {
import MVCLevel.LayerCreate;

import flash.media.Sound;

import flash.utils.Dictionary;

import nape.phys.Body;

public class ImgBodyCache {
    private var dictionary : Dictionary;
    private var layer : LayerCreate;
    public function ImgBodyCache(dictionary : Dictionary) {
        this.dictionary =dictionary;
    }
    public function getLayer(dir: String) : LayerCreate {
        if (dictionary[dir].length!=0)
        {
            var i : int = Math.random()*dictionary[dir].length-1;
            layer = dictionary[dir][i];
            (dictionary[dir] as Array).splice(i, 1);
            return  layer;

        }
        else
        {
            return null;
        }
    }
    public function getBody(dir : String) : Body {
        if (dictionary[dir].length>0)
        {
            var i : int = Math.random()*dictionary[dir].length-1;
            var body : Body = dictionary[dir][i];
            (dictionary[dir] as Array).splice(i, 1);
            return body;

        }
        else
        {
            return null;
        }
    }
    public function getSound(dir : String) : Sound {
        if (dictionary[dir].length>0)
        {
            var i : int = Math.random()*dictionary[dir].length-1;
            var sound : Sound = dictionary[dir][i];
            (dictionary[dir] as Array).splice(i, 1);
            return sound;

        }
        else
        {
            return null;
        }
    }
    public function setBody(dir : String,body : Body) : void {
        (dictionary[dir] as Array).push(body);
    }
    public function setLayer(dir : String,layer : LayerCreate) : void {
        (dictionary[dir] as Array).push(layer);
        trace('set layer')
    }
    public function destroy() : void {
        dictionary = null;

    }

}
}
