package MVCLevel
{


import GameComponets.loaders.Asset;
import GameComponets.loaders.CacheController;
import GameComponets.loaders.ImgBodyCache;
import GameComponets.loaders.SoundManager;
import GameComponets.loaders.TextFormats;

import Othe.Button;
import Othe.Elements;

import Othe.Myevent;

import flash.Boot;
import flash.display.Bitmap;

import flash.display.DisplayObject;
import flash.display.Loader;
import flash.display.MovieClip;

import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

import flash.net.SharedObject;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.utils.ByteArray;

import implementation.Destroyer;

import nape.callbacks.CbEvent;

import nape.callbacks.CbType;

import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionListener;
import nape.callbacks.InteractionType;

import nape.dynamics.InteractionFilter;
import nape.geom.Vec2;


import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.phys.Material;
import nape.shape.Circle;
import nape.shape.Polygon;

import nape.space.Space;
import nape.util.Debug;
import nape.util.ShapeDebug;

import silin.bitmap.ExplosionBitmap;


public class MVCLevelView extends Sprite  implements Destroyer
{
    private var layer_enemy : DinamicLayer = new DinamicLayer();
    private var layer_enemy_Array_Body : Array = new Array();
    private var layer_stone : DinamicLayer = new DinamicLayer();
    private var layer_stone_Array_Body : Array = new Array();
    private var layer_bonus : DinamicLayer = new DinamicLayer();
    private var layer_bonus_Array_Body : Array = new Array();
    private var array_hit_bonus : Array = new Array();
    private var layer_remote : DinamicLayer = new DinamicLayer();
    private var layer_plant : DinamicLayer = new DinamicLayer();
    private var layer_ship : DinamicLayer = new DinamicLayer();
    private var layer_buble : DinamicLayer = new DinamicLayer();
    private var layer_coins : DinamicLayer = new DinamicLayer();
    private var layer_explant : DinamicLayer = new DinamicLayer();
    private var layer_coin_Array_Body : Array = new Array();
    private var up : int=0;
    private var valueUp : Number = 0;
    private var life : Number=100;
    private var lifeBlock : Shape = new Shape();
    private var micBlock : Shape = new Shape();
    private var coins_numchildren : Array = new Array();
    private var textPoint : TextField = new TextField();
    private var buble: BubbleView;
    private var space:Space = new Space(new Vec2(0, 100));
    private var body : Body;
    private var body_coin : Body;
    private var shiptype : CbType = new CbType();
    private var otherObject : CbType = new CbType();
    private var bonusObject : CbType = new CbType();
    private var enemyCbType : CbType = new CbType();
    private var bonuscbType : CbType = new CbType();
    private var liderbordName : Sprite = new  Sprite;
    private var liderbordInput : TextField = new TextField();
    private var arrayHitEnemy : Array = new Array();
    private var sharedobj :  SharedObject;
    private var point : int = 0;
    private var movie : MovieClip   = new MovieClip();
    private var loadVint : Loader;
    private var pauseViewStatus : Boolean = false;
    private var bonusMagnitstaus : Boolean = false;
    public var mapLength : Number=0;
    private var mapStatus: MapStatus;
    private var pauseButtonView : LevelButtonView = new LevelButtonView();
    private var exposition : ExplosionBitmap = new ExplosionBitmap(600,600);
    private var coinsStartposition : Point = new Point(1000,300);
    private var cache : ImgBodyCache;
    private var bodytempore : Body;
    public var soundManager : SoundManager;


    public var debug:Debug = new ShapeDebug(800, 600, 0xFFFFFF);
    public var speed : Number = 0;
    public var speed_stone : Number = 0;


    public function MVCLevelView(cache : ImgBodyCache)
    {
        new Boot();

        this.cache = cache
        soundManager = new SoundManager();

        this.visible = false;


        textPoint.defaultTextFormat = TextFormats.textFormat_4;
        sharedobj = SharedObject.getLocal('submarine');
        /*	var background : Bitmap  = new Asset.background;
         addChild(background);
         */	addChild(layer_remote);
        addChild(layer_plant);
        addChild(layer_buble);
        addChild(layer_stone);
        addChild(layer_coins);
        addChild(layer_enemy);
        addChild(layer_bonus);
        addChild(layer_ship);
        addChild(layer_explant);
        addDetectedBur();
        var button : Button = new Button('Сохранить');
        button.x = 290 - button.width;
        button.y = 40;
        button.height=20;
        button.addEventListener(Event.COMPLETE, button_completeHandler,false,0,true)
        liderbordName.addChild(button);
    }

    public function update(point : int) : void
    {
        if (pauseViewStatus)
        {
            for (var i:int =0; i <layer_coins.numChildren;i++)
            {
                ((layer_coins.getChildAt(i) as Sprite).getChildAt(0) as MovieClip).play();
            }
        }
        space.step(1 / 30.0);
//		debug.clear();
//	    debug.draw(space);
        textPoint.text='Очки '+point;
        this.point=point;

        sleep_shape();

        layer_plant.x-=speed_stone-3;
        layer_remote.x-=speed_stone-6;
        layer_buble.x-=speed_stone;
        if (vis_validate(layer_plant,Elements.plase2))
        {
            dispatchEvent(new Event(Myevent.ADDPlANT));
        }
        if (vis_validate(layer_remote,Elements.plase3))
        {
            dispatchEvent(new Event(Myevent.ADDREMOTE))
        }

        for (var i : int = 0; i<layer_buble.numChildren; i++)
        {
            (layer_buble.getChildAt(i) as BubbleView).update();
        }
        _graphicUpdate(body);


        if (up!=0)
        {
         //   body.velocity.set(new Vec2(0,-valueUp));
            body.applyImpulse(new Vec2(0,-valueUp));
            movie.play();

        }
        else
        {
            movie.stop();
//            body.velocity.set(new Vec2(0,150));

        }
        if (body.position.x<100)
        {
//            body.applyImpulse(new Vec2(1000,0),new Vec2(body.bounds.width/2,body.bounds.height/2));
            speed_stone=6;
            if (body.position.x<0)
                life=-1;
        }
        else
        {
            speed_stone = speed;
        }
        if ((layer_stone_Array_Body[layer_stone_Array_Body.length-1] as Body).space!=null)
        {
            //    addChild(liderbordName);
            //    dispatchEvent(new Event(Myevent.LIDERBOARD));
        }
        if (life<0)
        {
            dispatchEvent(new Event(Myevent.FEILD));
            for (var i:int =0; i <layer_coins.numChildren;i++)
            {
                ((layer_coins.getChildAt(i) as Sprite).getChildAt(0) as MovieClip).stop();
            }
        }
        if (life<40)
        {   lifeBlock.graphics.clear();
            lifeBlock.graphics.beginFill(0xff0000,0.6);
            lifeBlock.graphics.drawRoundRect(0,0,life*2,5,5);
            lifeBlock.graphics.endFill();
        }
        else
        {
            lifeBlock.graphics.clear();
            lifeBlock.graphics.beginFill(0x00ff00,0.6);
            lifeBlock.graphics.drawRoundRect(0,0,life*2,5,5);
            lifeBlock.graphics.endFill();
        }

        lifeBlock.width=life*2;

        var random : int = Math.random()*3;
        if (random==2)
        {
            buble = new BubbleView();
            buble.y=600;
            buble.x =Math.abs(layer_buble.x)+Math.random()*800+300;
            layer_buble.addChild(buble);
            buble.addEventListener(Event.COMPLETE, layer_buble_completeHandler,false,0,true);
            buble=null;
        }

        bonusMagnitstaus=0;
        if (bonusMagnitstaus)
        {
            coinAnimates(1);
        }
        else
        {
            coinAnimates(0);
        }
        this.visible = true;

        mapStatus.update(Math.abs(0-layer_plant.x));
        if (layer_plant.x<0-mapLength)
        {
            dispatchEvent(new Event(Event.COMPLETE));
        }
    }

    public function addEnemy(bodyObject : Body) : void
    {
        if (bodyObject!=null)
        {
            var _x : Number = 1000;
            var _y : Number = Math.random()*300 +100;;
            bodyObject.position.setxy(_x, _y);
            bodyObject.userData.graphic.visible = false;
            bodyObject.space = null;
            bodyObject.userData.graphic.x=0-bodyObject.userData.graphic.width/2;
            bodyObject.userData.graphic.y=0-bodyObject.userData.graphic.height/2;
            layer_enemy.addChild(bodyObject.userData.graphic);
            bodyObject.cbTypes.add(enemyCbType);
            if (Math.random()>0.5)
            {
                bodyObject.angularVel = Math.random();
            }
            else{
                bodyObject.angularVel = 0-Math.random();
            }
//		bodyObject.allowRotation = false;
            layer_enemy_Array_Body.push(bodyObject);
        }
    }
    public function AddPlant(displobj : DisplayObject) : void
    {

        if (layer_plant.numChildren==0)
        {
            var _x : Number = 0;
            var _y : Number = 600-displobj.height;
        }
        else
        {
            var _x : Number = layer_plant.getChildAt(layer_plant.numChildren-1).width+layer_plant.getChildAt(layer_plant.numChildren-1).x
            var _y : Number = 600-displobj.height;
        }
        displobj.x = _x;
        displobj.y = _y;
        layer_plant.addChild(displobj);
        displobj.visible = true;
        var sum : Number =0;
        for (var i : int = 0; i< layer_plant.numChildren;i++)
        {
            sum+=layer_plant.getChildAt(i).width;
        }
        if (sum<1000+layer_plant.getChildAt(i-1).width)
        {
            dispatchEvent(new Event(Myevent.ADDPlANT));
        }
        sum = null;
    }
    public function addRemote(displobj : DisplayObject) : void
    {
        if (layer_remote.numChildren==0)
        {
            var _x : Number = 0;
            var _y : Number = 600-displobj.height;
        }
        else
        {
            var _x : Number = layer_remote.getChildAt(layer_remote.numChildren-1).width+layer_remote.getChildAt(layer_remote.numChildren-1).x
            var _y : Number = 600-displobj.height;
        }
        layer_remote.addChild(displobj);
        displobj.x = _x;
        displobj.y = _y;
        displobj.visible= true;
    }
    public function addStone(bodyObject : Body) : void
    {
        if (layer_stone_Array_Body.length==0)
        {
            var _x : Number = 0;
            var _y : Number = 600-bodyObject.userData.graphic.height;
        }
        else
        {
            var _x : Number = (layer_stone_Array_Body[layer_stone_Array_Body.length-1]as Body).userData.graphic.width+(layer_stone_Array_Body[layer_stone_Array_Body.length-1]as Body).position.x+0.2;
            var _y : Number = 600-bodyObject.userData.graphic.height;
        }
        bodyObject.position.setxy(_x, _y);
        bodyObject.space =null;
        bodyObject.userData.graphic.visible =false;
        layer_stone.addChild(bodyObject.userData.graphic);
        bodyObject.cbTypes.add(otherObject);
        bodyObject.allowRotation = false;
        layer_stone_Array_Body.push(bodyObject);
        trace('addStone    =  ',layer_stone_Array_Body.length)
    }

    public function addBonus(bodyObject : Body) : void
    {
        if (bodyObject!=null)
        {
            var _x : Number = 10000+Math.random()*4000;
            var _y : Number = Math.random()*150+150;;
            bodyObject.position.setxy(_x, _y);
            layer_bonus.addChild(bodyObject.userData.graphic);
            bodyObject.cbTypes.add(bonuscbType);
            bodyObject.allowRotation = false;
            bodyObject.space=space;
            layer_bonus_Array_Body.push(bodyObject);
        }
    }

    public function addCoins(bodyObject : Body) : void
    {
        bodyObject.position.x = coinsStartposition.x+10+bodyObject.bounds.width;
        bodyObject.position.y = coinsStartposition.y + (Math.random()*30-Math.random()*15);
        coinsStartposition.x = bodyObject.position.x;
        coinsStartposition.y = bodyObject.position.y;
        bodyObject.space = space; // Добавим тело в мир
        layer_coin_Array_Body.push(bodyObject);
        layer_coins.addChild(bodyObject.userData.graphic);
//        (bodyObject.userData.graphic as MovieClip).play();
        bodyObject.cbTypes.add(bonusObject);
    }
    public function addShip(bodyObject : Body) : void
    {
        speed_stone=speed;
        bodyObject.position.setxy(100, 300);
        bodyObject.space = space;
        bodyObject.userData.graphic.visible = true;
        bodyObject.cbTypes.add(shiptype);
        layer_ship.addChild(bodyObject.userData.graphic);
        bodyObject.allowRotation = false;
        body = bodyObject;
        body.mass =10;
        addButton();
        addGrounds();
        mapStatus=new MapStatus(mapLength);
        mapStatus.x = 400;
        mapStatus.y = 30;
        addChild(mapStatus);
    }
    public function shipUp(value : Number) :void
    {
        up = 1;
        trace(value);
        micBlock.graphics.clear();
        micBlock.graphics.beginFill(0x00ff00,0.6);
        micBlock.graphics.drawRoundRect(0,0,5,value,5);
        this.valueUp = value;
    }
    public function shipDown(value : Number) :void
    {
        micBlock.graphics.clear();
        micBlock.graphics.beginFill(0x00ff00,0.6);
        micBlock.graphics.drawRoundRect(0,0,5,value,5);
        up = 0;
    }

    private function pause_sparite_mouseUpHandler(event:MouseEvent):void
    {
        for (var i:int =0; i <layer_coins.numChildren;i++)
        {
            ((layer_coins.getChildAt(i) as Sprite).getChildAt(0) as MovieClip).stop();
        }
        pauseViewStatus = true;
        dispatchEvent(new Event(Myevent.PAUSE));
    }

    private function layer_buble_completeHandler(event:Event):void
    {
        layer_buble.removeChild((event.target as Sprite));
    }

    public function microphone_s_mouseUpHandler():void
    {
    }

    private function vis_validate(object : DinamicLayer,dir : String) : Boolean
    {
        var bool : Boolean=false;
        for (var i : int = 0; i<object.numChildren;i++)
        {
            if (((object.getChildAt(i).x)-Math.abs(object.x))<(0-object.getChildAt(i).width))
            {
                var layer : LayerCreate = (object.getChildAt(i) as LayerCreate);
                object.removeChild(layer);
                cache.setLayer(dir, layer);
                layer= null;
                bool = true;
            }
            else if (((object.getChildAt(i).x)-Math.abs(object.x))>1000)
            {
                object.getChildAt(i).visible=false;
            }
            else
            {
                object.getChildAt(i).visible=true;
            }
        }

        return bool;

    }
    public function destroy(): void
    {
        remove(layer_buble,3);
        layer_buble = null;
        remove(layer_coins,1);
        layer_coins = null;
        remove(layer_enemy,0);
        layer_enemy = null;
        remove(layer_plant,4,Elements.plase2);
        layer_plant = null;
        remove(layer_remote,4,Elements.plase3);
        layer_remote =null;
        remove(layer_stone,0);
        layer_stone = null;
        remove(layer_ship,0);
        cache.setBody(Elements.ship,body);
        body=null;
        layer_ship = null;
        destroyBody(layer_coin_Array_Body,Elements.coins);
        destroyBody(layer_enemy_Array_Body,Elements.enemy);
        destroyBody(layer_stone_Array_Body,Elements.plase1);
        remove(this,0);
        cache = null;


    }
    private function destroyBody(array : Array,dir : String) : void
    {
        for (var i : int =0;i<array.length;i++)
        {
            if (array[i]!=null)
            {
                bodytempore =  (array[i] as Body)
                array.splice(i,1);
                cache.setBody(dir, bodytempore);
                bodytempore   = null;
            }
        }
    }
    private function remove(object : Sprite,type:int,dir : String = 'null') : void
    {
        for (var i : int =0;i<object.numChildren;i++)
        {
            if (type==3)
            {
                (object.getChildAt(i) as BubbleView).flag=1;
                object.getChildAt(i).removeEventListener(Event.COMPLETE,layer_buble_completeHandler);

            }
            if (type == 4)
            {
                cache.setLayer(dir, (object.getChildAt(i) as LayerCreate))
            }
            object.removeChildAt(i);
        }
    }
    private function _graphicUpdate(b:Body):void
    {
        if (b)
        {
            var graphic:DisplayObject = b.userData.graphic;
            graphic.x = b.position.x;
            graphic.y = b.position.y;
            graphic.rotation = (b.rotation * 180/Math.PI) % 360;
        }
    }
    private function sleep_shape(): void
    {
        if (validateBody(layer_enemy_Array_Body,speed,-(speed*35),Elements.enemy))
        {
            dispatchEvent(new Event(Myevent.ADDENEMY));
        }
        if (validateBody(layer_bonus_Array_Body,(speed_stone-4),-(speed_stone*30),Elements.bonus))
        {
            dispatchEvent(new Event(Myevent.ADDBONUS));
        }
        var col : int=0;
        var __width : Number=0;
        if (validateBody(layer_stone_Array_Body,speed_stone,-(speed_stone*30),Elements.plase1))
        {
            dispatchEvent(new Event(Myevent.ADDSTONE));
        }
        for (var i : int = 0;i<layer_stone_Array_Body.length-1;i++)
        {
            (layer_stone_Array_Body[i+1] as Body).position.x=(layer_stone_Array_Body[i] as Body).position.x+(layer_stone_Array_Body[i] as Body).bounds.width;
        }
        if (validateBody(layer_coin_Array_Body,(speed_stone-4),-(speed_stone*30),Elements.coins))
        {

        }
    }
    public function addCollisionListener(cb:InteractionCallback):void
    {
        life-=5;
//        soundManager.play_hit()
    }
    private function addCollisionListenerEnemy(cb:InteractionCallback) : void
    {
        //    soundManager.play_hit()
        cb.int2.castBody.space = null;
        life-=20;
//		exposition.addExplosion(cb.int2.castBody.bounds.x, cb.int2.castBody.bounds.y )
        cache.setBody(Elements.enemy,cb.int2.castBody);
        layer_enemy_Array_Body.splice(layer_enemy_Array_Body.indexOf(cb.int2.castBody),1);
        layer_enemy.removeChild(cb.int2.castBody.userData.graphic);
        dispatchEvent(new Event(Myevent.ADDENEMY));

    }
    private function addCollisionListenerEnemyForStone(cb:InteractionCallback) : void
    {

        /*    cb.int1.castBody.space = null;
         cache.setBody(Elements.enemy,cb.int1.castBody);
         layer_enemy_Array_Body.splice(layer_enemy_Array_Body.indexOf(cb.int1.castBody),1);
         layer_enemy.removeChild(cb.int1.castBody.userData.graphic);
         dispatchEvent(new Event(Myevent.ADDENEMY));*/
//		exposition.addExplosion(cb.int1.castBody.bounds.x,cb.int1.castBody.bounds.y);
    }
    private function addCollisionListenerCoinsForStone(cb:InteractionCallback) : void
    {
        cb.int1.castBody.space = null;
        cb.int1.castBody.userData.graphic.alpha = 0.1;
        coins_numchildren.push(cb.int1);
    }
    private function addCollisionListenerCoinsForBonus(cb:InteractionCallback) : void
    {
//        soundManager.play_bonus();
        cb.int2.castBody.space=null;
        cb.int2.castBody.userData.graphic.visible = false;
        layer_bonus.removeChild(cb.int2.castBody.userData.graphic),
                layer_bonus_Array_Body.splice(layer_bonus_Array_Body.indexOf(cb.int2.castBody),1);
        cache.setBody(Elements.bonus,cb.int2.castBody);
        life+=20;
        if (life>100) life=100;
        dispatchEvent(new Event(Myevent.ADDBONUS));

    }
    private function addCollisionListenerBonus(cb:InteractionCallback) : void
    {

        //   soundManager.play_coin();
        cb.int2.castBody.space = null;
        coins_numchildren.push(cb.int2);
        layer_coin_Array_Body.splice(layer_coin_Array_Body.indexOf(cb.int2.castBody),1);
        dispatchEvent( new Event(Myevent.COINS));
    }

    private function button_completeHandler(event:Event):void {

        sharedobj.data.liderBord=(new Array(liderbordInput.text,point));
        dispatchEvent(new Event(Event.COMPLETE));
    }

    private function onSwfLoaded_loadVint(event:Event):void {

        movie = loadVint.content as MovieClip;
        movie.stop();
        movie.x= -33;
        movie.y=24;
        body.userData.graphic.addChild(movie);
    }
    private function addButton() : void {

        pauseButtonView.addEventListener(Myevent.PAUSELEVELVIEW, pause_sparite_mouseUpHandler);
        pauseButtonView.addEventListener(Myevent.MICROOFF, microphone_s_mouseUpHandler,false,0,true);
        addChild(pauseButtonView);
    }
    private function addGrounds() : void {

        var ground:Body = new Body(BodyType.STATIC); // Земля
        ground.shapes.add(new Polygon(Polygon.rect(0, 602, 2000, 100), Material.ice()));
        ground.space = space;
        var ground_buttom:Body = new Body(BodyType.STATIC); // Земля
        ground_buttom.shapes.add(new Polygon(Polygon.rect(0, -10, 2000, 12), Material.ice()));
        var mater11 : Material = new Material(0,0.1,2,1);
        ground_buttom.setShapeMaterials(mater11);
        ground_buttom.space = space;

        var right_barier:Body = new Body(BodyType.STATIC); // Земля
        right_barier.shapes.add(new Polygon(Polygon.rect(0, 300, 310, 600), Material.ice(),new InteractionFilter(0x000000011, 0x000000001)));
        var mater11 : Material = new Material(0,0.1,2,1);
        right_barier.setShapeMaterials(mater11);
        right_barier.space = space;


        addChild(debug.display);
        body.setShapeFilters(new InteractionFilter(0x000000011, 0x000000001));

        var beginCollideListener:InteractionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, shiptype, otherObject, addCollisionListener);
        var beginCollideListenerBonus:InteractionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, shiptype, bonusObject, addCollisionListenerBonus);
        var beginCollideListenerEnemy:InteractionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, shiptype, enemyCbType, addCollisionListenerEnemy);
        var beginCollideListenerEnemyForStone:InteractionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, enemyCbType, otherObject, addCollisionListenerEnemyForStone);
        var beginCollideListenerCoinsForStone:InteractionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, bonusObject, otherObject, addCollisionListenerCoinsForStone);
        var beginCollideListenerCoinsForBonus:InteractionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, shiptype, bonuscbType, addCollisionListenerCoinsForBonus);
        space.listeners.add(beginCollideListener);
        space.listeners.add(beginCollideListenerBonus);
        space.listeners.add(beginCollideListenerEnemy);
        space.listeners.add(beginCollideListenerEnemyForStone);
        space.listeners.add(beginCollideListenerCoinsForStone);
        space.listeners.add(beginCollideListenerCoinsForBonus);
        layer_explant.addChild(exposition);
    }
    private function bonusMagnit(): void
    {
        bonusMagnitstaus = true;
    }
    private function coinAnimates(type : int) : void
    {
        if (type == 0)
        {
            for (var i : int = 0; i<coins_numchildren.length;i++)
            {
                (coins_numchildren[i] as Body).position.y-=15;
//				(coins_numchildren[i] as Body).position.x+=5;
                (coins_numchildren[i] as Body).space=null;

                (coins_numchildren[i] as Body).userData.graphic.alpha-=0.1;
                if ((coins_numchildren[i] as Body).userData.graphic.alpha<0)
                {
                    (coins_numchildren[i] as Body).userData.graphic.visible = false;
                    (coins_numchildren[i] as Body).userData.graphic.alpha =1;
                    (coins_numchildren[i] as Body).space=null;
                    var bodytempore  : Body = (coins_numchildren[i] as Body);
                    coins_numchildren.splice(i, 1);
                    cache.setBody(Elements.coins,bodytempore);
                    bodytempore = null;

                }
            }
        }
        else  if (type==1)
        {

            for (var i : int = 0; i<layer_coin_Array_Body.length;i++)
            {
                if ((layer_coin_Array_Body[i] as Body).position.x<600)
                {
//					(layer_coin_Array_Body[i] as Body).position.x=(layer_coin_Array_Body[i] as Body).position.x-((layer_coin_Array_Body[i] as Body).position.x-(body.position.x + body.bounds.width))/10;
//					(layer_coin_Array_Body[i] as Body).position.y=(layer_coin_Array_Body[i] as Body).position.y-((layer_coin_Array_Body[i] as Body).position.y-(body.position.y+body.bounds.height/2))/10;
                    (layer_coin_Array_Body[i] as Body).position.y-=10;
                    (layer_coin_Array_Body[i] as Body).space=null;
                    (layer_coin_Array_Body[i] as Body).userData.graphic.alpha-=0.06;
                    if ((layer_coin_Array_Body[i] as Body).userData.graphic.alpha<0)
                    {
                        (layer_coin_Array_Body[i] as Body).userData.graphic.visible = false;
                        (layer_coin_Array_Body[i] as Body).space=null;
                        (layer_coin_Array_Body[i] as Body).userData.graphic.alpha =1;
                        cache.setBody(Elements.coins,(layer_coin_Array_Body[i] as Body));
                        layer_coin_Array_Body.splice(i, 1);
                        dispatchEvent( new Event(Myevent.COINS));
                    }
                }
            }

        }
        if (layer_coin_Array_Body.length==0)
        {
//			coinsStartposition.x += Math.random()*100 + 100;
            coinsStartposition.y = Math.random()*300+100;
            dispatchEvent(new Event(Myevent.ADDCOIN))

        }
    }
    private function validateBody(array : Array,_speed1 : Number,_speed2: Number,dir : String): Boolean
    {
        var bool : Boolean = false;
        for (var i : int = 0;i<array.length;i++)
        {
            _graphicUpdate((array[i] as Body));

            if ((array[i] as Body).position.x<(0-(array[i] as Body).bounds.width)-(array[i] as Body).bounds.width)
            {
                (array[i] as Body).userData.graphic.visible = false;
                (array[i] as Body).space = null;
                bodytempore = (array[i] as Body);
                array.splice(i,1);
                cache.setBody(dir, bodytempore);
                trace('body','  =  ',dir);
                bodytempore = null;
                bool = true;
            }
            else if ((array[i] as Body).position.x>1000)
            {
                (array[i] as Body).space = null;
                (array[i] as Body).position.x-=_speed1;
                (array[i] as Body).userData.graphic.visible = false;
            }
            else
            {
                (array[i] as Body).space=space;
                (array[i] as Body).userData.graphic.visible = true;
                (array[i] as Body).velocity.set(new Vec2(_speed2,0));
            }
        }
        return bool;
    }
    private function addDetectedBur():void {
        textPoint.text = 'Очки 0';
        textPoint
        textPoint.x = 690-textPoint.width;
        addChild(textPoint);
        lifeBlock.graphics.beginFill(0x00ff00,0.6);
        lifeBlock.graphics.drawRoundRect(0,0,230,5,5);
        addChild(lifeBlock);
        lifeBlock.x=30;
        lifeBlock.y=30;
        micBlock.graphics.beginFill(0x00ff00,0.6);
        micBlock.graphics.drawRoundRect(0,0,5,2,5);
        addChild(micBlock);
        micBlock.x=30;
        micBlock.y=570;
        micBlock.rotationZ=180;
        liderbordName.graphics.beginFill(0xFF9922);
        liderbordName.graphics.drawRoundRect(0,0,300,80,10);
        liderbordInput.type = TextFieldType.INPUT;
        liderbordInput.border=true;
        liderbordInput.width=280;
        liderbordInput.height=30;
        liderbordInput.x = 10;
        liderbordInput.y = 5;
        liderbordName.addChild(liderbordInput);
        liderbordName.x = 800/2 - liderbordName.width/2;
        liderbordName.y = 600/2-liderbordName.height/2;
    }
    public function reviewReposition() : void {
        pauseButtonView.reviewReposition();
    }
}
}