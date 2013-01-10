/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 06.12.12
 * Time: 16:17
 * To change this template use File | Settings | File Templates.
 */
package MVCLevel {
import flash.display.Sprite;

public class DinamicLayer extends Sprite {
    private var speed : int = 0;
    public function DinamicLayer() {

    }

    public function update() : void
    {
        this.x+=speed;
    }
}
}
