/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 12.03.13
 * Time: 11:15
 * To change this template use File | Settings | File Templates.
 */
package GameComponets.loaders {
import GameComponets.loaders.ModalContainer;
import GameComponets.loaders.ModalContainer;

import Othe.MultipartURLLoader;

import flash.display.Bitmap;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.MouseEvent;
import flash.events.SecurityErrorEvent;
import flash.events.StatusEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLRequestHeader;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;
import flash.text.TextField;
import flash.utils.ByteArray;

import vk.APIConnection;
import vk.api.serialization.json.JSONDecoder;
import vk.events.CustomEvent;

public class Vk extends  Sprite{
    public static var flashVars: Object;
    public static var apiConnection: APIConnection;
    public static var urlStrin : String;
    public static var mp3File : ByteArray;
    public static var tf : TextField;
    public static var jsonString : String;
    public static var audioid : Array = new Array();
    public static var arrayParametrs : Array = new Array();
    public function Vk() {
    }

    public static function init(stage: DisplayObject):void {

        flashVars = stage.loaderInfo.parameters as Object;

        /*          // -- Your code for local testing:
         flashVars['api_id'] = 3484689;
         flashVars['viewer_id'] = 79588723;
         flashVars['sid'] = "3020c6cf1de1db74061016fb418b9024e2cf06bac0ceb61753c4278d96e8ea75cd875bd3fbb4fc27e6db9";
         flashVars['secret'] = "6796d42836";
         */
        apiConnection  = new APIConnection(flashVars);
        tf = new TextField();
        trace(flashVars);
        for (var prop in flashVars){
            trace("flashVar["+prop+"]= "+flashVars[prop]);
            trace(flashVars['id_val']);
        }
        if (Vk.flashVars['viewer_id']!=155685417)
        {
        SharedTracker.init(stage)
        SharedTracker.tracker.trackEvent("/Start","/Start");
        }


    }
    private static function vkapiComplete(e:Object): void {

        SharedView.init();
        SharedView.buttonShare.addEventListener(MouseEvent.CLICK, clickHandler);
        SharedView.buttonSkip.addEventListener(MouseEvent.CLICK, clickHandlerSkip);
        urlStrin = e["upload_url"];
//        tf.text =e.upload_url;

    }

    private static function vkapiFail(e:Object): void {
        Vk.tf.text = 'error';
        ModalContainer.textField.text= 'fail_audio';
    }
    public static function prava() : void {
//       apiConnection.callMethod('showSettingsBox',4096, vkapiCompleteSettings, vkapiFail);

    }
    public static function addSound(): void {
        apiConnection.api('audio.getUploadServer',null,vkapiComplete, vkapiFail);
 //       apiConnection.api('audio.getUploadServer',{messeges : 'ghfgh'},function() {}, vkapiFail)
    }

    private static function xmlImagesLoader_completeHandler(event:Event):void {


        jsonString = (event.target as MultipartURLLoader).loader.data;
        trace(jsonRead('"audio"',jsonString));
        trace(jsonRead('"server"',jsonString));
        trace(jsonRead('"hash"',jsonString));
        var js : Object =  GameComponets.loaders.JSON.decode((event.target as MultipartURLLoader).loader.data);
        arrayParametrs['audio']= js["audio"];
        arrayParametrs['server']= js["server"];
        arrayParametrs['hash']= js["hash"];

//        flashVar[user_id]
        apiConnection.api('users.get',{uids : flashVars.viewer_id},vkapiCompleteGetUser, vkapiFailGetUser);
    }

    private static function xmlImagesLoader_ioErrorHandler(event:Event):void {

    }

    private static function xmlImagesLoader_securityErrorHandler(event:Event):void {

    }
    private static function vkapiCompleteSave(e:Object): void {
        ModalContainer.textField.text='audio.save';
        trace("audio"+e.aid+"_3489280");
        audioid['attachments'] = "http://jabrail.myjino.ru?id="+e.owner_id+",audio"+e.owner_id+"_"+e.aid+',';
        audioid['owner_id'] = e.owner_id;
        var fotoid : String = "photo"+e.owner_id+"_298878399"
//        var fotoid : String = "photo79588723_298878399,http://vk.com/app3502155"
        var messeges : String;
        var randomString : int = Math.random()*4;
        switch (randomString)
        {
            case  0 :
                messeges = 'В детстве мне вкалывали транквилизаторы, чтобы я не кричал.';
                break;
            case  1 :
                messeges = 'Зачем молчать, когда можно кричать.';
                break;
            case  2 :
                messeges = 'Я набрал 100500 очков в игре Voice Submarine';
                break;
            case  3 :
                messeges = 'Покричал на расслабоне';
                break;
            case  4 :
                messeges = 'У меня крик тарзана';
                break;
        }
        apiConnection.api('wall.post',{owner_id : audioid['owner_id'],attachments : audioid['attachments']+fotoid, message : messeges+' http://vk.com/app3502155'}, wallPostComplete, vkapiFail)
        //     apiConnection.api('audio.add',{oid : e.owner_id ,aid : e.aid}, wallPostComplete, vkapiFail);


        var reviewLoader : URLLoader  = new URLLoader();
        var request : URLRequest = new URLRequest(UrlSettings.reviewUrl);
        request.method = URLRequestMethod.POST;
        var variables : URLVariables = new URLVariables();
        variables.message = 'Сделал пост';
        variables.uid = Vk.getUid();
        request.data = variables;
        reviewLoader.load(request);
        reviewLoader.addEventListener(Event.COMPLETE, reviewLoader_completeHandler);
        reviewLoader.addEventListener(IOErrorEvent.IO_ERROR, reviewLoader_ioErrorHandler);
        reviewLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, reviewLoader_securityErrorHandler);

    }
    private static function vkapiFail1(e:Object): void {
        trace()
    }
    private static function jsonRead(s : String, str : String): String {
        var i : int = str .search(s);
        i+= s.length+2;
        var retStr : String = '';
        var seach : Boolean = false;
        while (seach!=true) {
            if (str.charAt(i)!='"') {
                if (str.charAt(i)!=',')
                {
                    retStr+=str.charAt(i);
                    i++;
                }
                else
                {
                    i++;
                }
            }
            else
                seach = true;
        }


        return retStr;
    }

    public static function clickHandler():void {
//        ModalContainer.removePlayAgain();
//        SharedView.view.removeEventListener(MouseEvent.CLICK, clickHandler);
        if (Vk.flashVars['viewer_id']!=155685417)
        {
            SharedTracker.tracker.trackEvent("/Post","/Post");
        }
//        ModalContainer.rootConteiner.removeChild(SharedView.view);
//        ModalContainer.rootConteiner.removeChild(ModalContainer.preloader);

        var mll : MultipartURLLoader = new MultipartURLLoader();
        mll.addEventListener(Event.COMPLETE,xmlImagesLoader_completeHandler);
        mll.addFile(Vk.mp3File,"audio.mp3","file","audio/mp3");

        mll.load(urlStrin);


        /*        var xmlImagesLoader : URLLoader = new URLLoader();
         var request : URLRequest = new URLRequest(urlStrin + "&?random=" + ''+ Math.random()*35247235);
         //        var header:URLRequestHeader = new URLRequestHeader("pragma", "no-cache");
         //        request.requestHeaders.push(header);
         request.method = URLRequestMethod.POST;
         var variables : URLVariables = new URLVariables("time="+Number(new Date().getTime()));
         variables.file = mp3File;
         request.data = variables;
         request.contentType = 'multipart/form-data';

         xmlImagesLoader.load(request);
         xmlImagesLoader.addEventListener(Event.COMPLETE,xmlImagesLoader_completeHandler);
         xmlImagesLoader.addEventListener(IOErrorEvent.IO_ERROR, xmlImagesLoader_ioErrorHandler);
         xmlImagesLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, xmlImagesLoader_securityErrorHandler);*/
    }
    private static function wallPostComplete(e : Object) : void {

    }

    private static function vkapiCompleteSettings(e : Object) : void {

    }


    private static function clickHandlerSkip(event:MouseEvent):void {
        ModalContainer.removePlayAgain();
        sendMessage('dfgdfhd');
        if (Vk.flashVars['viewer_id']!=155685417)
        {
            SharedTracker.tracker.trackEvent("/Not_Post","/Not_Post");
        }
        SharedView.view.removeEventListener(MouseEvent.CLICK, clickHandler);
    }
    private static function sendMessage(text : String) : void {
        apiConnection.api('messages.send',{uid : '79588723', message : 'fgdfgdfh'},sendComplate,sendFail)
    }
    private static function sendComplate(e : Object) : void {

    }
    private static function sendFail(e : Object) : void {

    }
    private static function vkapiCompleteGetUser(e : Object) : void {

//        var js : Object =  GameComponets.loaders.JSON.decode(e.data);

//        var artist : String = js["first_name"]+' '+ js["last_name"];
        var artist : String = e[0]['first_name']+' '+ e[0]['last_name'];

        ModalContainer.textField.text= artist;
        apiConnection.api('audio.save',{server:arrayParametrs['server'], audio:arrayParametrs['audio'], hash:arrayParametrs['hash'],artist : 'I',title : 'Submarine'},vkapiCompleteSave, vkapiFail);
    }
    private static function vkapiFailGetUser(e : Object) : void {
       ModalContainer.textField.text= 'fail_audio';
    }


    public static function getUid() : String {
        return flashVars['viewer_id'];
    }
    private static function reviewLoader_completeHandler(event:Event):void {
    }

    private static function reviewLoader_ioErrorHandler(event:IOErrorEvent):void {
    }

    private static function reviewLoader_securityErrorHandler(event:SecurityErrorEvent):void {

    }
}

}