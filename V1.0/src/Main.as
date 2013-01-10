package
{

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.AccelerometerEvent;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.events.ProgressEvent;
import flash.events.SampleDataEvent;
import flash.geom.Point;
import flash.media.Microphone;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;
import flash.sensors.Accelerometer;
import flash.text.TextField;
import flash.ui.Keyboard;
import flash.utils.Timer;



[SWF(width="800", height="600",frameRate="60")]
[Frame(factoryClass="Preloader")]

public class Main extends Sprite
{
    private var navigationController : NavigationController = new NavigationController();

    public function Main()
    {
       addChild(navigationController);

    }

}
}