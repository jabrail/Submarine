/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 08.12.12
 * Time: 16:56
 * To change this template use File | Settings | File Templates.
 */
package Menu {
import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;

public class LevelComplete extends Sprite{
    public function LevelComplete() {
        var nextlevel : Sprite= new Sprite();
        var menu : Sprite = new Sprite();
        var nextLevelText : TextField = new TextField();
        var menuText : TextField = new TextField();
        nextLevelText.text="Next";
        menuText.text="Menu.MVCMenuController";
        nextlevel.addChild(nextLevelText);
        menu.addChild(menuText);
        nextlevel.x=200;
        addChild(nextlevel);
        addChild(menu);
    //    nextlevel.addEventListener(Event)

    }
}
}
