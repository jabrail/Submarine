/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 25.01.13
 * Time: 23:17
 * To change this template use File | Settings | File Templates.
 */
package GameComponets.loaders {
import GameComponets.loaders.MySound;

import MVCLevel.BitmapDataIso;
import MVCLevel.IsoBody;
import MVCLevel.LayerCreate;
import MVCLevel.LoaderImg;

import Othe.Elements;

import flash.display.Bitmap;

import flash.display.BitmapData;
import flash.display.Loader;

import flash.display.LoaderInfo;
import flash.display.MovieClip;

import flash.display.Sprite;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.media.Sound;

import flash.net.SharedObject;
import flash.utils.ByteArray;
import flash.utils.Dictionary;
import flash.utils.Dictionary;

import nape.callbacks.CbType;

import nape.dynamics.InteractionFilter;

import nape.phys.Body;
import nape.phys.Material;

public class Cache extends Sprite{

    private  var mainDictionary : Dictionary = new Dictionary();
    public  var dictionaryObj : Dictionary = new Dictionary();
    private var sharedObject : SharedObject;
    private var levelName : String;
    private var allImgLoader : LoaderImg;
    private var keysArray : Array = new Array();
    private var completeIndex : int = 0;
    private var sostButton : int = 0;
    private var currentcompleteIndex : int = 0;
    private var complete : Boolean = false;
    private var button_complete : Sprite = new Sprite();
    private var create_Cache : Boolean = false;
    public var _length : Number = 0;
    public var _speed : Number = 0;
    public var _enemyNum : Number = 0;
    [Embed(source="/images/preloaders/preloader_250x250.swf", mimeType="application/octet-stream")]
    public var  preloader_data : Class;
    public static var mcPreloader: MovieClip;
    public var loader:Loader = new Loader();
    public function Cache() {
        sharedObject = SharedObject.getLocal('sub_maps10345');
    }
    public function init(levelName : String='Location_1/level_4') : void
    {
        currentcompleteIndex = 0;
        completeIndex =0;
        this.levelName = levelName;
        if (sharedObject.data.allLoad)
        {
            if (sharedObject.data.allLoad[levelName]!=null)
            {
                var btm : Bitmap = new Asset.Help();
                addChild(btm);
                loader.loadBytes( new preloader_data() as ByteArray );
                loader.contentLoaderInfo.addEventListener(Event.INIT, onSwfLoaded);
                create_Cache = true;
                countObject();
                create_components();
            }
            else
            {
                create_Cache =false;
                allImgLoader  = new LoaderImg(levelName);
                allImgLoader.addEventListener(Event.COMPLETE, allImgLoader_completeHandler);
                addChild(allImgLoader);
            }
        }
        else
        {
            create_Cache=false;
            allImgLoader  = new LoaderImg(levelName);
            sharedObject.data.allLoad =new Dictionary();
            allImgLoader.addEventListener(Event.COMPLETE, allImgLoader_completeHandler);
            addChild(allImgLoader);
        }



    }

    private function allImgLoader_completeHandler(event:Event):void {
        sharedObject.data.allLoad[levelName] = allImgLoader.allLoad;
        sharedObject.flush();
        mainDictionary=sharedObject.data.allLoad[levelName];
        countObject();
        create_components();
    }
    private function create_components() :void {
        mater = new Material(0,0,0,1);
        interactFilter = new InteractionFilter(0x000000001, 0x000000001);
        createBody(Elements.ship,mater,interactFilter,1);
        createImg(Elements.plase31,0,2);
        createImg(Elements.plase3,0,2);
        createImg(Elements.plase32,0,2);
        createImg(Elements.plase2,0,2);
        var mater : Material = new Material(0,0,0,1000000);
        interactFilter = null;
        var interactFilter : InteractionFilter = new InteractionFilter(0x000000011, 0x000000001)
        createBody(Elements.plase1,mater, interactFilter,0,2);
        createBody(Elements.plase11,mater, interactFilter,0,2);
        createBody(Elements.plase12,mater, interactFilter,0,2);
        interactFilter=null;
        interactFilter = new InteractionFilter(0x000000001, 0x000000001);
        mater  = new Material(0,0.1,2,0.01);
        createBody(Elements.coins,mater,interactFilter,1,30);
        createBody(Elements.bonus,mater,interactFilter,0,1);
        interactFilter =null;
        interactFilter = new InteractionFilter(0x000000001, 0x000000010);
        createBody(Elements.enemy,mater,interactFilter,0);
        //     createSound(Elements.soundMain);
        mater = new Material(0,0,0,1);
        interactFilter = new InteractionFilter(0x000000011, 0x000000001);
        createBody(Elements.ship,mater,interactFilter,1);
        _length = mainDictionary[Elements.length];
        _speed = mainDictionary[Elements.speed];
        _enemyNum = mainDictionary[Elements.enemyNum];
        complete=true;
        mater = null;
        interactFilter = null;
    }
    /*    public static function getImage(dir : String) : LayerCreate {

     }
     public static function getBody(dir : String) : Body {

     }*/
    private function createImg(dir : String, type : int,colobject : int=1) : void
    {
        keysArray.push(dir);
        completeIndex+= colobject*mainDictionary[dir].length;
        for (var j : int = 0;j<colobject;j++)
            for  (var i :int =0; i<mainDictionary[dir].length;i++)
            {
                var loader : MyByteLoder = new MyByteLoder();
                loader.dir = dir;
                loader.type = type;
                loader.loadBytes(mainDictionary[dir][i]);
                loader.contentLoaderInfo.addEventListener(Event.INIT, initHandler);
            }
    }
    private function createBody(dir : String,mater : Material,interactionFilter : InteractionFilter,type : int,colobject : int=1) : void
    {
        keysArray.push(dir);
        completeIndex+= colobject*mainDictionary[dir].length;
        for (var j : int = 0;j<colobject;j++)
            for  (var i :int =0; i<mainDictionary[dir].length;i++)
            {
                var loader : MyByteLoder = new MyByteLoder();
                loader.dir = dir;
                loader.mater = mater;
                loader.type = type;
                loader.interactionFilter = interactionFilter;
                loader.loadBytes(mainDictionary[dir][i]);
                loader.contentLoaderInfo.addEventListener(Event.INIT, initHandlerBody);


            }
    }
    private function createSound(dir : String) : void
    {
        keysArray.push(dir);
        completeIndex+= mainDictionary[dir].length;
        var sound : MySound = new MySound();
        sound.dir = dir;
        sound.loadCompressedDataFromByteArray((mainDictionary[dir][0] as ByteArray),(mainDictionary[dir][0] as ByteArray).length/2/4);
        if (dictionaryObj[dir]==null)
        {
            dictionaryObj[dir] = new Array();
        }
        dictionaryObj[dir].push(sound);
        sound.play();
        currentcompleteIndex++;
        if (currentcompleteIndex==completeIndex)
        {
            if (create_Cache)
            {
                var btm : Bitmap = new Asset.PlayGame();
                btm.alpha=0;
                button_complete.addChild(btm);
                button_complete.x=660;
                button_complete.y=460;
                button_complete.addEventListener(MouseEvent.CLICK, sprite_clickHandler);
                addEventListener(Event.ENTER_FRAME, enterFrameHandler);
                addChild(button_complete);
            }
            else
            {
                dispatchEvent(new Event(Event.COMPLETE));
            }
        }
        //    sound = null;
    }

    private function initHandler(event:Event):void {
        var dir : String = ((event.target as LoaderInfo).loader as MyByteLoder).dir ;
        var type : int = ((event.target as LoaderInfo).loader as MyByteLoder).type ;
        var layer: LayerCreate = new LayerCreate((event.target as LoaderInfo),type);
        if (dictionaryObj[dir]==null)
        {
            dictionaryObj[dir] = new Array();
        }
        dictionaryObj[dir].push(layer);
        layer=null;
        currentcompleteIndex++;
        if (currentcompleteIndex==completeIndex)
        {
            if (create_Cache)
            {
                var btm : Bitmap = new Asset.PlayGame();
                btm.alpha=0;
                button_complete.addChild(btm);
                button_complete.x=660;
                button_complete.y=460;
                button_complete.addEventListener(MouseEvent.CLICK, sprite_clickHandler);
                addEventListener(Event.ENTER_FRAME, enterFrameHandler);
                addChild(button_complete);
            }
            else
            {
                dispatchEvent(new Event(Event.COMPLETE));
            }
        }
        (event.target as LoaderInfo).loader.contentLoaderInfo.addEventListener(Event.INIT, initHandler);

    }


    private function initHandlerBody(event:Event):void {

        var dir : String  =  ((event.target as LoaderInfo).loader as MyByteLoder).dir;
        var type : int = ((event.target as LoaderInfo).loader as MyByteLoder).type ;
        var layer: LayerCreate = new LayerCreate((event.target as LoaderInfo),type);
        layer.visible=false;
        var currentBody : Body;
        var cogIso:BitmapDataIso = new BitmapDataIso(layer.image.bitmapData, 0x80);
        var cogBody:Body = IsoBody.run(cogIso, cogIso.bounds,null,2,1.5,((event.target as LoaderInfo).loader as MyByteLoder).interactionFilter);
        currentBody = cogBody.copy();
        currentBody.setShapeMaterials(((event.target as LoaderInfo).loader as MyByteLoder).mater);
        currentBody.userData.graphic =  layer
        currentBody.allowRotation = false;
        currentBody.space=null;
        if (dictionaryObj[dir]==null)
        {
            dictionaryObj[dir] = new Array();
        }
        dictionaryObj[dir].push(currentBody);
        currentBody = null;
        cogIso = null;
        cogBody = null;
        layer = null;
        currentcompleteIndex++;
        if (currentcompleteIndex==completeIndex)
        {
            if (create_Cache)
            {
                var btm : Bitmap = new Asset.PlayGame();
                btm.alpha=0;
                button_complete.addChild(btm);
                button_complete.x=660;
                button_complete.y=460;
                button_complete.addEventListener(MouseEvent.CLICK, sprite_clickHandler);
                addEventListener(Event.ENTER_FRAME, enterFrameHandler);
                addChild(button_complete);
            }
            else
            {
               dispatchEvent(new Event(Event.COMPLETE));
            }
        }

        (event.target as LoaderInfo).loader.contentLoaderInfo.addEventListener(Event.INIT, initHandlerBody);

    }
    private function completeLoad(): void {

    }


    private function countObject() : void {
        //  completeIndex=0;
        /*        mainDictionary[Elements.plase31]  = new Array();
         mainDictionary[Elements.plase32] = new Array();
         mainDictionary[Elements.plase3] = new Array();
         mainDictionary[Elements.plase2] = new Array();
         mainDictionary[Elements.plase1] = new Array();
         mainDictionary[Elements.plase11] = new Array();
         mainDictionary[Elements.plase12] = new Array();
         mainDictionary[Elements.coins] = new Array();
         mainDictionary[Elements.bonus] = new Array();
         mainDictionary[Elements.enemy] = new Array();
         mainDictionary[Elements.ship] = new Array();*/
        mainDictionary = new Dictionary();
        dictionaryObj = new Dictionary();
        mainDictionary[Elements.plase31]  =  sharedObject.data.allLoad[levelName][Elements.plase31];
        mainDictionary[Elements.plase32] = sharedObject.data.allLoad[levelName][Elements.plase32];
        mainDictionary[Elements.plase3] = sharedObject.data.allLoad[levelName][Elements.plase3];
        mainDictionary[Elements.plase2] = sharedObject.data.allLoad[levelName][Elements.plase2];
        mainDictionary[Elements.plase1] = sharedObject.data.allLoad[levelName][Elements.plase1];
        mainDictionary[Elements.plase11] = sharedObject.data.allLoad[levelName][Elements.plase11];
        mainDictionary[Elements.plase12] = sharedObject.data.allLoad[levelName][Elements.plase12];
        mainDictionary[Elements.coins] = sharedObject.data.allLoad[levelName][Elements.coins];
        mainDictionary[Elements.bonus] = sharedObject.data.allLoad[levelName][Elements.bonus];
        mainDictionary[Elements.enemy] = sharedObject.data.allLoad[levelName][Elements.enemy];
        mainDictionary[Elements.ship] = sharedObject.data.allLoad[levelName][Elements.ship];
        mainDictionary[Elements.speed] = sharedObject.data.allLoad[levelName][Elements.speed];
        mainDictionary[Elements.length] = sharedObject.data.allLoad[levelName][Elements.length];
        mainDictionary[Elements.enemyNum] = sharedObject.data.allLoad[levelName][Elements.enemyNum];

    }
    public function destroy() : void {
        dictionaryObj = null;
        mainDictionary=null;
    }


    private function sound_completeHandler(event:Event):void {

    }

    private function enterFrameHandler(event:Event):void {
        if (sostButton==0)
        {
            (button_complete.getChildAt(0) as Bitmap).alpha+=0.05;
        }
        else
        {
            (button_complete.getChildAt(0) as Bitmap).alpha-=0.05;
        }
        if (  (button_complete.getChildAt(0) as Bitmap).alpha>1)
            sostButton=1;
        if (  (button_complete.getChildAt(0) as Bitmap).alpha<0)
            sostButton=0;
    }

    private function sprite_clickHandler(event:MouseEvent):void {
        dispatchEvent(new Event(Event.COMPLETE));
    }
    private function onSwfLoaded(e:Event):void
    {
        mcPreloader = loader.content as MovieClip;
        mcPreloader.x=0-(mcPreloader.width/2+140);
        mcPreloader.y=0-(mcPreloader.height/2+40);
        addChild(mcPreloader);
        mcPreloader.gotoAndStop(100);
    }
}
}
