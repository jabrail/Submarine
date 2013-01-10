package MVCLevel
{

import Box2D.Collision.b2DynamicTreeNode;

import MVCLevel.LayerCreate;

import MVCLevel.LayerCreate;

import flash.Boot;

import flash.display.Bitmap;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;

import flash.display.DisplayObject;
import flash.display.MovieClip;

import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.Event;
import flash.events.EventPhase;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.filters.DisplacementMapFilter;
import flash.geom.Point;
import flash.net.SharedObject;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.utils.Timer;

import nape.callbacks.CbEvent;

import nape.callbacks.CbType;
import nape.callbacks.CbTypeIterator;
import nape.callbacks.CbTypeList;
import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionListener;
import nape.callbacks.InteractionType;

import nape.constraint.PivotJoint;
import nape.dynamics.InteractionFilter;
import nape.geom.AABB;
import nape.geom.GeomPolyList;
import nape.geom.MarchingSquares;
import nape.geom.Vec2;

import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.phys.Material;
import nape.phys.Material;
import nape.shape.Circle;
import nape.shape.Polygon;

import nape.space.Space;
import nape.util.Debug;
import nape.util.ShapeDebug;
import nape.geom.IsoFunction

import org.osmf.events.TimeEvent;

import zpp_nape.callbacks.ZPP_CbType;
import zpp_nape.util.ZPP_CbTypeList;

public class MVCLevelView extends Sprite  implements Destroyer
{
    [Embed(source="../images/Stone/почва.png")]
    private var StoneBg : Class;

    private var layer_enemy : DinamicLayer = new DinamicLayer();
    private var layer_enemy_Array_Body : Array = new Array();
    private var layer_stone : DinamicLayer = new DinamicLayer();
    private var layer_stone_Array_Body : Array = new Array();
    private var layer_remote : DinamicLayer = new DinamicLayer();
    private var layer_plant : DinamicLayer = new DinamicLayer();
    private var layer_ship : DinamicLayer = new DinamicLayer();
    private var layer_buble : DinamicLayer = new DinamicLayer();
    private var layer_coins : DinamicLayer = new DinamicLayer();
    private var layer_coin_Array_Body : Array = new Array();
    private var up : int=0;
    private var valueUp : Number = 0;
    private var microphone_s : Sprite = new Sprite();
    private var microphone_animate : Boolean = false;
    private var microphon_sum : int = 0;
    private var life : Number=100;
    private var lifeBlock : Shape = new Shape();
    private var micBlock : Shape = new Shape();
    private var coins_numchildren : Array = new Array();
    private var textPoint : TextField = new TextField();
    private var buble: BubbleView;
    private var space:Space = new Space(new Vec2(0, 100));
    private var body : Body;
    private var body_coin : Body;
    private var shiptype : CbType = new CbType;
    private var otherObject : CbType = new CbType;
    private var bonusObject : CbType = new CbType;
    private var enemyCbType : CbType = new CbType();
    private var liderbordName : Sprite = new  Sprite;
    private var liderbordInput : TextField = new TextField();
    private var arrayHitEnemy : Array = new Array();
    private var sharedobj :  SharedObject;
    private var point : int = 0;

    public var debug:Debug = new ShapeDebug(800, 600, 0xFFFFFF);
    public var speed : Number = 0;


    public function MVCLevelView()
    {
        new Boot();

        this.visible = false;

       sharedobj = SharedObject.getLocal('submarine');
        var background : Bitmap  = new Asset.background;
        addChild(background);
        addChild(layer_remote);
        var pause : Bitmap = new StoneBg();
        pause.y = 600-pause.height;
        pause.width=800;
        addChild(pause);
        addChild(layer_plant);
        addChild(layer_buble);
        addChild(layer_stone);
        addChild(layer_coins);
        addChild(layer_enemy);
        addChild(layer_ship);


        textPoint.text = 'Очки 0';
        textPoint
        textPoint.x = 700-textPoint.width;
        addChild(textPoint);
        // добавление блока жизней и блока уровня громкости
        lifeBlock.graphics.beginFill(0x00ff00,0.6);
        lifeBlock.graphics.drawRoundRect(0,0,230,5,5);
        addChild(lifeBlock);
        lifeBlock.x=30;
        lifeBlock.y=30;
        micBlock.graphics.beginFill(0x00ff00,0.6);
        micBlock.graphics.drawRoundRect(0,0,5,200,5);
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
        var button : Button = new Button('Сохранить');
        button.x = 290 - button.width;
        button.y = 40;
        button.height=20;
        button.addEventListener(Event.COMPLETE, button_completeHandler)
        liderbordName.addChild(button);




    }

    public function update(point : int) : void
    {
        space.step(1 / 30.0);
        debug.clear();
        //    debug.draw(space);
        textPoint.text='Очки '+point;
        this.point=point;
        if (microphone_animate)
        {
            microphone_s.rotationZ+=10;
            microphon_sum++;
            if ((microphon_sum)==18)
            {
                microphon_sum=0;
                microphone_animate=false;
            }
        }

        sleep_shape();

        layer_plant.x-=10;
        layer_remote.x-=8;
        layer_buble.x-=10;
        vis_validate(layer_enemy,1);
        vis_validate(layer_coins,1);
        vis_validate(layer_plant,1);
        vis_validate(layer_remote,2);
        vis_validate(layer_stone,1);


        for (var i : int = 0; i<layer_buble.numChildren; i++)
        {
            (layer_buble.getChildAt(i) as BubbleView).update();
        }





        _graphicUpdate(body);
        body.position.x = 200;
        if (up!=0)
        {
            body.applyImpulse(new Vec2(0,-50));
        }
        if (life<0)
            dispatchEvent(new Event(Myevent.FEILD));


        if (layer_stone.x<(0-layer_stone.width+800))
        {
            addChild(liderbordName);
            dispatchEvent(new Event(Event.COMPLETE))
           // dispatchEvent(new Event(Myevent.LIDERBOARD))

        }

        if (life<40)
        {   lifeBlock.graphics.clear();
            lifeBlock.graphics.beginFill(0xff0000,0.6);
            lifeBlock.graphics.drawRoundRect(0,0,life*2,5,5);
            lifeBlock.graphics.endFill();
        }

        lifeBlock.width=life*2;


        var random : int = Math.random()*15;
        if (random==7)
        {
            buble = new BubbleView();
            buble.y=600;
            buble.x =Math.abs(layer_buble.x)+Math.random()*800;
            layer_buble.addChild(buble);
            buble.addEventListener(Event.COMPLETE, layer_buble_completeHandler);
            buble=null;
        }
        for (var i : int = 0; i<coins_numchildren.length;i++)
        {
            (coins_numchildren[i] as Body).position.y-=5;
            (coins_numchildren[i] as Body).position.x+=5;
            (coins_numchildren[i] as Body).space=null;

            (coins_numchildren[i] as Body).userData.graphic.alpha-=0.1;
            if ((coins_numchildren[i] as Body).userData.graphic.alpha<0)
            {
                (coins_numchildren[i] as Body).userData.graphic.visible = false;
                (coins_numchildren[i] as Body).space=null;
            }

        }
        this.visible = true;
    }


    public function addEnemy(displobj : DisplayObject) : void
    {
        var _x : Number= displobj.x;
        var _y : Number = displobj.y;
        var mater : Material = new Material(0,1,2,0.1)
        var body_enemy : Body;
        var cogIso:BitmapDataIso = new BitmapDataIso((displobj as LayerCreate).image.bitmapData, 0x80);
        var cogBody:Body = IsoBody.run(cogIso, cogIso.bounds);
        var objIso:DisplayObjectIso = new DisplayObjectIso(displobj);
        layer_enemy.addChild(objIso.displayObject);
        var objBody:Body = IsoBody.run(objIso, objIso.bounds);
        layer_enemy.removeChild(objIso.displayObject);

        body_enemy = cogBody.copy();
        body_enemy.position.setxy(_x, _y);
        body_enemy.setShapeMaterials(mater);
        body_enemy.userData.graphic = (displobj as LayerCreate).image;
        layer_enemy.addChild(body_enemy.userData.graphic);
        layer_enemy_Array_Body.push(body_enemy);
        body_enemy.cbTypes.add(enemyCbType);
        body_enemy.allowRotation = false;
        body_enemy = null;
        cogIso = null;
        cogBody = null;
        objIso = null;

    }
    public function AddPlant(displobj : DisplayObject) : void
    {
        layer_plant.addChild(displobj);
    }
    public function addRemote(displobj : DisplayObject) : void
    {
        layer_remote.addChild(displobj);
    }
    public function addStone(displobj : DisplayObject) : void
    {
        var mater : Material = new Material(0,0,0,1000000)
        var _x : Number= displobj.x;
        var _y : Number = displobj.y;
        var body_stone : Body;
        var cogIso:BitmapDataIso = new BitmapDataIso((displobj as LayerCreate).image.bitmapData, 0x80);
        var cogBody:Body = IsoBody.run(cogIso, cogIso.bounds);
        var objIso:DisplayObjectIso = new DisplayObjectIso(displobj);
        layer_stone.addChild(objIso.displayObject);
        var objBody:Body = IsoBody.run(objIso, objIso.bounds);
        layer_stone.removeChild(objIso.displayObject);
        layer_stone.addChild(displobj);
        body_stone = cogBody.copy();
        body_stone.position.setxy(_x, _y);
        body_stone.setShapeMaterials(mater);
        body_stone.userData.graphic = displobj;
        layer_stone_Array_Body.push(body_stone);
        body_stone.cbTypes.add(otherObject);
        body_stone.allowRotation = false;
        body_stone = null;
        cogIso = null;
        cogBody = null;
        objIso = null;
    }
    public function addCoins(displobj : DisplayObject) : void
    {
        var mater : Material = new Material(0,0.1,2,0.01);
        body_coin = new Body(BodyType.DYNAMIC, new Vec2(displobj.x, displobj.y)); // Новое тело
        body_coin.shapes.add(new Circle(32, new Vec2(0, 0), mater, new InteractionFilter(0x000000001, 0x000000010))); // Добавим фигуру
        body_coin.align(); // Нужно совместить центр фигуры и ее центр масс, иначе будут глюки
        displobj.x = 0-displobj.width/2;
        displobj.y = 0-displobj.height/2;
        var conteiner : Sprite = new Sprite();
        conteiner.addChild(displobj);
        body_coin.userData.graphic=conteiner;
        conteiner = null;
        body_coin.space = space; // Добавим тело в мир
        layer_coin_Array_Body.push(body_coin);
        layer_coins.addChild(body_coin.userData.graphic);
        body_coin.cbTypes.add(bonusObject);
        body_coin = null;

    }
    public function addShip(displobj : DisplayObject) : void
    {

        var mater : Material = new Material(0,0,0,1);
        var cogIso:BitmapDataIso = new BitmapDataIso((displobj as LayerCreate).image.bitmapData, 0x80);
        var cogBody:Body = IsoBody.run(cogIso, cogIso.bounds);
        var objIso:DisplayObjectIso = new DisplayObjectIso(displobj);
        layer_ship.addChild(objIso.displayObject);
        var objBody:Body = IsoBody.run(objIso, objIso.bounds);
        layer_ship.removeChild(objIso.displayObject);
        body = cogBody.copy();
        body.position.setxy(400, 300);
        body.space = space;
        body.setShapeMaterials(mater);
        body.cbTypes.add(shiptype);
        var content : Sprite = new Sprite();
        var movie : MovieClip = new Asset.Vint;
        movie.x= (displobj as LayerCreate).image.x-movie.width/5-2;
        movie.y=24;
        content.addChild(movie);
        content.addChild((displobj as LayerCreate).image);
        body.userData.graphic = content;
        layer_ship.addChild(body.userData.graphic);
        body.allowRotation = false;

        var pause_button : Bitmap = new Asset.Pause;
        var pause_sparite : Sprite = new Sprite()
        pause_sparite.addChild(pause_button);
        addChild(pause_sparite);
        pause_sparite.x= 800-pause_sparite.width-30;
        pause_sparite.addEventListener(MouseEvent.MOUSE_UP, pause_sparite_mouseUpHandler);

        var microphone : Bitmap = new Asset.Microphone;
        microphone_s.addChild(microphone);
        microphone.width=70;
        microphone.height=70;
        addChild(microphone_s);
        microphone.x =0-microphone.width/2;
        microphone.y = 0-microphone.height/2;
        microphone_s.x= 800-microphone_s.width/2-30;
        microphone_s.y= pause_sparite.height+30+microphone.height/2;
        microphone_s.addEventListener(MouseEvent.MOUSE_UP, microphone_s_mouseUpHandler);

        var ground:Body = new Body(BodyType.STATIC); // Земля
        ground.shapes.add(new Polygon(Polygon.rect(0, 600, 1000, 100), Material.ice()));
        ground.space = space;
        var ground_buttom:Body = new Body(BodyType.STATIC); // Земля
        ground_buttom.shapes.add(new Polygon(Polygon.rect(0, 0, 800, 2), Material.ice()));
        var mater11 : Material = new Material(0,0.1,2,1);
        ground_buttom.setShapeMaterials(mater11);
        ground_buttom.space = space;



        var ground_left:Body = new Body(BodyType.STATIC); // Земля
        ground_left.shapes.add(new Polygon(Polygon.rect(0, 0, 1, 600), Material.ice(), new InteractionFilter(0x000000001, 0x000000010)));
        ground_left.space = space;
        addChild(debug.display);
        body.setShapeFilters(new InteractionFilter(0x000000011, 0x000000001));

        var beginCollideListener:InteractionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, shiptype, otherObject, addCollisionListener);
        var beginCollideListenerBonus:InteractionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, shiptype, bonusObject, addCollisionListenerBonus);
        var beginCollideListenerEnemy:InteractionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, shiptype, enemyCbType, addCollisionListenerEnemy);
        space.listeners.add(beginCollideListener);
        space.listeners.add(beginCollideListenerBonus);
        space.listeners.add(beginCollideListenerEnemy);


    }
    public function shipUp(value : Number) :void
    {

        if (value<6)
        {
            up = 0;
            valueUp=3;

        }
        else
        {
            valueUp=value-6;
            up = 1;

        }
    }

    private function pause_sparite_mouseUpHandler(event:MouseEvent):void
    {
        dispatchEvent(new Event(Myevent.PAUSE));
    }

    private function layer_buble_completeHandler(event:Event):void
    {
        (event.target as Sprite).removeEventListener(Event.COMPLETE,layer_buble_completeHandler);
        layer_buble.removeChild((event.target as Sprite));


    }

    private function microphone_s_mouseUpHandler(event:MouseEvent):void
    {
        microphone_animate = true;
        dispatchEvent(new Event(Myevent.MICROPHONE_EVENT))
    }

    private function CoinsHandler(event:Event):void
    {
        dispatchEvent(new Event(Myevent.COINS));
        (event.target as DisplayObject).removeEventListener(Myevent.COINS,CoinsHandler);
    }
    private function vis_validate(object : DinamicLayer, type: int) : void
    {
        for (var i : int = 0; i<object.numChildren;i++)
        {
            if (type==1)
            {
                if (((object.getChildAt(i).x)-Math.abs(object.x))<-200)
                {
                    object.removeChildAt(i)
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
            else
            {
                if (((object.getChildAt(i).x)-Math.abs(object.x))<-800)
                {
                    object.removeChildAt(i);
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
        }
    }
    public function destroy(): void
    {

        remove(layer_buble,3);
        layer_buble = null;
        remove(layer_coins,1);
        layer_coins = null;
        remove(layer_enemy,0);
        layer_enemy = null;
        remove(layer_plant,0);
        layer_plant = null;
        remove(layer_remote,0);
        layer_remote =null;
        remove(layer_stone,0);
        layer_stone = null;
        remove(layer_ship,0);
        layer_ship = null;
        remove(this,0);
        body.userData.graphic=null;
        destroyBody(layer_coin_Array_Body);
        destroyBody(layer_enemy_Array_Body);
        destroyBody(layer_stone_Array_Body);


    }
    private function destroyBody(array : Array) : void
    {
        for (var i : int =0;i<array.length;i++)
        {
            if (layer_coin_Array_Body[i]!=null)
            {
                (layer_coin_Array_Body[i] as Body).userData.graphic = null;
                layer_coin_Array_Body[i] = null;
            }
        }
    }
    private function remove(object : Sprite,type:int) : void
    {
        for (var i : int =0;i<object.numChildren;i++)
        {
            if (type==1)
                object.getChildAt(i).removeEventListener(Myevent.COINS,CoinsHandler);
            if (type==3)
            {
                (object.getChildAt(i) as BubbleView).flag=1;
                object.getChildAt(i).removeEventListener(Event.COMPLETE,layer_buble_completeHandler);

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
        for (var i : int = 0;i<layer_enemy_Array_Body.length;i++)
        {
            (layer_enemy_Array_Body[i] as Body).velocity.set(new Vec2(-500,0));
            _graphicUpdate((layer_enemy_Array_Body[i] as Body));
            if ((layer_enemy_Array_Body[i] as Body).position.x<-200)
            {
                (layer_enemy_Array_Body[i] as Body).space = null;
                (layer_enemy_Array_Body[i] as Body).userData.graphic.visible = false;
            }
            else if ((layer_enemy_Array_Body[i] as Body).position.x>800)
            {
                (layer_enemy_Array_Body[i] as Body).space = null;
                (layer_enemy_Array_Body[i] as Body).position.x-=15;
                (layer_enemy_Array_Body[i] as Body).userData.graphic.visible = false;
            }
            else
            {
                (layer_enemy_Array_Body[i] as Body).space=space;
                (layer_enemy_Array_Body[i] as Body).userData.graphic.visible = true;
            }

        }
        for (var i : int = 0;i<layer_stone_Array_Body.length;i++)
        {
            _graphicUpdate((layer_stone_Array_Body[i] as Body));

            if ((layer_stone_Array_Body[i] as Body).position.x<-200)
            {
                (layer_stone_Array_Body[i] as Body).userData.graphic.visible = false;
                (layer_stone_Array_Body[i] as Body).space = null;

            }
            else if ((layer_stone_Array_Body[i] as Body).position.x>800)
            {
                (layer_stone_Array_Body[i] as Body).space = null;
                (layer_stone_Array_Body[i] as Body).position.x-=10;
                (layer_stone_Array_Body[i] as Body).userData.graphic.visible = false;
            }
            else
            {

                (layer_stone_Array_Body[i] as Body).space=space;
                (layer_stone_Array_Body[i] as Body).userData.graphic.visible = true;
                (layer_stone_Array_Body[i] as Body).velocity.set(new Vec2(-300,0));
                _graphicUpdate((layer_stone_Array_Body[i] as Body));
            }

        }


        for (var i : int = 0;i<layer_coin_Array_Body.length;i++)
        {
            _graphicUpdate((layer_coin_Array_Body[i] as Body));

            if ((layer_coin_Array_Body[i] as Body).position.x<-200)
            {
                (layer_coin_Array_Body[i] as Body).userData.graphic.visible = false;
                (layer_coin_Array_Body[i] as Body).space = null;

            }
            else if ((layer_coin_Array_Body[i] as Body).position.x>800)
            {
                (layer_coin_Array_Body[i] as Body).space = null;
                (layer_coin_Array_Body[i] as Body).position.x-=10;
                (layer_coin_Array_Body[i] as Body).userData.graphic.visible = false;
            }
            else
            {

                (layer_coin_Array_Body[i] as Body).space=space;
                (layer_coin_Array_Body[i] as Body).userData.graphic.visible = true;
                (layer_coin_Array_Body[i] as Body).velocity.set(new Vec2(-300,0));
                _graphicUpdate((layer_coin_Array_Body[i] as Body));
            }
        }
        for (i=0; i<arrayHitEnemy.length;i++)
        {
            (arrayHitEnemy[i] as Body).space=null;
            (arrayHitEnemy[i] as Body).position.x-=10;
        }


    }
    public function addCollisionListener(cb:InteractionCallback):void
    {
        life-=5;
    }
    private function addCollisionListenerEnemy(cb:InteractionCallback) : void
    {
        cb.int2.castBody.space = null;
        life-=5;
        arrayHitEnemy.push(cb.int2);
        var bang : MovieClip = new Asset.Bang;
        layer_enemy.removeChild(cb.int2.castBody.userData.graphic);
        cb.int2.castBody.userData.graphic = null;
        cb.int2.castBody.userData.graphic = bang;
        layer_enemy.addChild(cb.int2.castBody.userData.graphic);
        bang=null;

    }
    private function addCollisionListenerBonus(cb:InteractionCallback) : void
    {

        cb.int2.castBody.space = null;
        coins_numchildren.push(cb.int2);
        dispatchEvent( new Event(Myevent.COINS));
    }

    private function button_completeHandler(event:Event):void {

        sharedobj.data.liderBord.push(new Array(liderbordInput.text,point));
        dispatchEvent(new Event(Event.COMPLETE));

    }
}

}