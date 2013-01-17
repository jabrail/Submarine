/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 01.10.12
 * Time: 14:55
 * To change this template use File | Settings | File Templates.
 */
package Menu
{
import MVCLevel.*;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.net.URLRequest;


public class LevelSelect  extends Sprite  implements Destroyer
{


	public var fonShape : Shape = new Shape()
	public var level1 : MVCLevelController;
    public var selected : int = 0;
    private var arrayLevel : Array = new Array();
    private var arrayLevel_title : Array = new Array();
    private var collevel : int = 5;
    private var index : int =0;


	public function LevelSelect(location : String,arraylevels : Array,type : String)
	{

        arrayLevel_title =arraylevels;
        for (var i : int =0; i<arraylevels.length;i++)
        {
            var thumbusLoader : Loader =new Loader();
            thumbusLoader.load(new URLRequest('http://runaway.afterwar.ru/submarine/games/locations/'+location+'/'+arraylevels[i]+'/thumbs.png'));
            thumbusLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);

        }

		this.addEventListener(MouseEvent.CLICK,eventHandler);

        if (type=='complete_next')
        {
            var next_s :Sprite= new Sprite();
            var restart_s :Sprite= new Sprite();
            var main_menu_s :Sprite= new Sprite();

            var main_menu : Bitmap = new Asset.Main_menu;
            main_menu_s.x = 10;
            main_menu_s.y = 450;
            main_menu_s.addChild(main_menu);
            var restart : Bitmap = new Asset.Restert;
            restart_s.x =main_menu_s.x+ main_menu_s.width+30;
            restart_s.y = 450;
            restart_s.addChild(restart);
            var next : Bitmap = new Asset.Next;
            next_s.x = restart_s.x+restart_s.width+30;
            next_s.y = 450;
            addChild(main_menu_s);
            addChild(restart_s);
            addChild(next_s);


            next_s.addChild(next);
            main_menu_s.addEventListener(MouseEvent.CLICK, main_menu_clickHandler);
            next_s.addEventListener(MouseEvent.CLICK, next_mouseUpHandler);
            restart_s.addEventListener(MouseEvent.CLICK, restart_mouseUpHandler);
        }
        else if (type == 'start')
        {
            var main_menu : Bitmap = new Asset.Main_menu;
            var main_menu_s : Sprite = new Sprite();
            main_menu_s.x = 10;
            main_menu_s.y = 450;
            addChild(main_menu_s);
            main_menu_s.addChild(main_menu);

            main_menu_s.addEventListener(MouseEvent.CLICK, main_menu_clickHandler);

        }
        else if (type=='complete')
        {
            var main_menu : Bitmap = new Asset.Main_menu;
            var main_menu_s : Sprite = new Sprite();
            main_menu_s.x = 10;
            main_menu_s.y = 450;

            addChild(main_menu_s);
            main_menu_s.addChild(main_menu);
            var restart : Bitmap = new Asset.Restert;
            var restart_s : Sprite = new Sprite();
            restart_s.x =main_menu.x+ main_menu.width+30;
            restart_s.y = 450;
            restart_s.addChild(restart);
            addChild(restart_s);
            main_menu_s.addEventListener(MouseEvent.CLICK, main_menu_clickHandler);
            restart_s.addEventListener(MouseEvent.CLICK, restart_mouseUpHandler);
        }
	}

	private function eventHandler(event:Event):void
	{

	}

	private function levelel_clickHandler(event:MouseEvent):void
	{
        selected = (event.target as Hover).number;
        dispatchEvent(new Event(Event.COMPLETE));
        (event.target as Hover).removeEventListener(Event.COMPLETE, levelel_clickHandler);


	}
    public function elementresaze(currentlevel : int,btm : Bitmap) : void
    {

    }
     private function reposition () : void
     {
         var j : int = 0;
         var k : int = 0;
         for (var i : int = 0; i<arrayLevel.length;i++)
         {
             if ((k * (arrayLevel[i] as LevelSelectElement).width+30*k)>700)
         {
             j++;
             k=0;
         }

             arrayLevel[i].x = k * arrayLevel[i].width+30*k;
             arrayLevel[i].y=j*arrayLevel[i].height+j*30+Math.random()*50;
              k++;
         }

     }

    private function completeHandler(event:Event):void
    {
        var bitmapdata : BitmapData;
        bitmapdata = new BitmapData(event.target.loader.content.width,event.target.loader.content.height,true,0x000000);
        bitmapdata.draw(event.target.loader.content);
        var bitmap : Bitmap = new Bitmap(bitmapdata);
        arrayLevel[index] = new LevelSelectElement(bitmap,index,arrayLevel_title[index]);
        addChild(arrayLevel[index]);
        (arrayLevel[index] as LevelSelectElement).addEventListener(MouseEvent.CLICK, levelel_clickHandler);
         index++;
        bitmapdata=null;
        bitmap=null;
        reposition();

    }

    private function main_menu_clickHandler(event:MouseEvent):void
    {
        dispatchEvent(new Event(Myevent.MAIN_MENU));
    }

    private function next_mouseUpHandler(event:MouseEvent):void
    {
        dispatchEvent(new Event(Myevent.NEXT));
    }

    private function restart_mouseUpHandler(event:MouseEvent):void
    {
        dispatchEvent(new Event(Myevent.RESTART));
    }
    public function destroy() : void
    {


        for (var i : int = 0; i<arrayLevel.length;i++)
        {
          (arrayLevel[i] as LevelSelectElement).destroy();

        }
        for (var i : int =0;i<this.numChildren;i++)
        {
            this.removeChildAt(i);
        }
    }
}
}
