/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 16.03.13
 * Time: 14:40
 * To change this template use File | Settings | File Templates.
 */
package GameComponets.loaders {
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

public class TextFormats {
    public static var textFormat_1 : TextFormat = new TextFormat();
    public static var textFormat_2 : TextFormat = new TextFormat();
    public static var textFormat_3 : TextFormat = new TextFormat();
    public static var textFormat_4 : TextFormat = new TextFormat();
    public function TextFormats() {
    }
    public static function init_Formats()  : void  {
        textFormat_2.size = 50;
        textFormat_2.color = 0xFFFFFF;
        textFormat_3.size = 40;
        textFormat_3.color = 0xFFFFFF;
        textFormat_3.align = TextFormatAlign.CENTER;
        textFormat_1.size = 15;
        textFormat_1.color = 0xFFFFFF;
        textFormat_1.align = TextFormatAlign.CENTER;
        textFormat_4.size = 25;
        textFormat_4.color = 0xFFFFFF;
        textFormat_4.align = TextFormatAlign.CENTER;

//        textFormat_1.align = TextFormatAlign.CENTER;
    }
}
}
