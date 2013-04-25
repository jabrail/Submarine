/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 13.03.13
 * Time: 14:43
 * To change this template use File | Settings | File Templates.
 */
package GameComponets.loaders {
import GameComponets.loaders.ModalContainer;

import flash.display.Bitmap;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.utils.ByteArray;

public class ModalContainer {
    public static var rootConteiner : Sprite = new Sprite();
    public static var proelader : Sprite = new Sprite();
    public static var messegeView : Sprite = new Sprite();
    public static var textField : TextField = new TextField();
    public static var  startAnimate : Boolean = false;
    public static var levelName : String = '';
    public static var playAgainButton : Sprite = new Sprite();
    public static var reviewButton : Sprite = new Sprite();
    public static var containerForPlayAgain : Sprite = new Sprite();
    public static var micSost : Boolean = true;
    public static var soundArray : ByteArray;
    public static var eventDispatcher : EventDispatcher = new EventDispatcher();
    public function ModalContainer() {

    }
    public static function preloaderInit() : void {
//      var bitmap : Bitmap = new Asset.ModalFon();
       var shape : Shape = new Shape();
       shape.graphics.beginFill(0x000000,0.6);
        shape.graphics.drawRect(0,0,800,600);
//       preloader.addChild(shape);
    }
    public static  function  initTextView() : void  {
        messegeView.graphics.beginFill(0x000000,0.9);
        messegeView.graphics.drawRect(0,0,800,100);
        messegeView.y=600;
        textField.multiline = true;
        textField.mouseWheelEnabled = true;
        textField.wordWrap = true;
        textField.textColor = 0xFFFFFF;
        textField.width= 800;
        textField.height = 50;
        TextFormats.init_Formats();
        textField.defaultTextFormat = TextFormats.textFormat_1;
        messegeView.addChild(textField);
        rootConteiner.addChild(messegeView);
        messegeView.addEventListener(MouseEvent.CLICK, messegeView_clickHandler);

    }

    private static function messegeView_clickHandler(event:MouseEvent):void {
        ModalContainer.startAnimate = true;
        messegeView.addEventListener(Event.ENTER_FRAME, messegeView_enterFrameHandler);
    }

    private static function messegeView_enterFrameHandler(event:Event):void {

        if (startAnimate) {
            messegeView.y+=5
        }
        if (messegeView.y>600)
        {
            startAnimate = false;
            messegeView.removeEventListener(Event.ENTER_FRAME, messegeView_enterFrameHandler);

        }
    }
    public static function addPlayAgain() : void {
        if (ModalContainer.levelName=='Location_1/level_7')
        {
            var bitmap : Bitmap  = new Asset.PlayAgainButton();
             playAgainButton.addChild(bitmap);
            playAgainButton.x = 400-playAgainButton.width/2
            playAgainButton.y = 300-playAgainButton.height/2
            playAgainButton.addEventListener(MouseEvent.CLICK, playAgainButton_clickHandler);
            ModalContainer.containerForPlayAgain.addChild(playAgainButton);
        }
    }
    public static function removePlayAgain() : void {

        if (ModalContainer.levelName=='Location_1/level_7')
        {
            if (ModalContainer.containerForPlayAgain.getChildAt(0)!=null)
            ModalContainer.containerForPlayAgain.removeChild(playAgainButton);
        }

    }
    public static function reviewInit() : void {
        var bitmap : Bitmap = new Asset.ReviewButton();
        reviewButton.addChild(bitmap);
    }

    private static function playAgainButton_clickHandler(event:MouseEvent):void {
        if (Vk.flashVars['viewer_id']!=155685417)
        {
            SharedTracker.tracker.trackEvent('/Play_Again','/Play_Again');
        }
        removePlayAgain();
    }
}
}
