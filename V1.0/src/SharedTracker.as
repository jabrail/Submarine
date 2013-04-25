/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 11.03.13
 * Time: 16:35
 * To change this template use File | Settings | File Templates.
 */
package {

import com.google.analytics.AnalyticsTracker;
import com.google.analytics.GATracker;

import flash.display.DisplayObject;

public class SharedTracker {
    public static var tracker:AnalyticsTracker;
    public function SharedTracker() {
    }
    public static function init(parent:DisplayObject):void {
        tracker = new GATracker(parent, "UA-39187766-1", "AS3", true );
        tracker.debug.active = false;
    }
}
}
