/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 25.03.13
 * Time: 17:27
 * To change this template use File | Settings | File Templates.
 */
package GameComponets.loaders {
import Othe.MultipartURLLoader;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.MouseEvent;
import flash.events.SecurityErrorEvent;
import flash.media.Microphone;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;
import flash.text.TextField;
import flash.text.TextFieldType;

public class ReviewWindow extends Sprite{
    private var started : Boolean = true;
    private var scales : Array = new Array();
    private var iteration_points :  Array = new Array();
    private var points : int = 0;
    private var iteration :  Number = 0;
    private var mainWindow : Sprite = new  Sprite();
    private  var voiceReviewButton : Sprite;
    private var textReviewButton : Sprite;
    private var textForVoice : TextField = new TextField();
    private var microphone : Microphone;
    private var record : RecordReview;
    private var completeButton : Sprite;
    private var messegesInput : TextField = new TextField();
    private var messegesInputButton : Sprite;
    public function ReviewWindow(mic : Microphone) {
        microphone = mic;
        mainWindow.graphics.beginFill(0x000000,0.8);
        mainWindow.graphics.drawRect(0,0,20,20);
        mainWindow.x = 390;
        mainWindow.y = 290;
        scales['width'] = 20;
        scales['height'] = 20;
        scales['x'] = 390;
        scales['y'] = 290;
        addChild(mainWindow);
        iteration_points[0] = 40;
        iteration_points[1] = 80;
        iteration_points[2] = 120;
        iteration_points[3] = 140;
     addEventListener(Event.ENTER_FRAME, enterFrameHandler);
    }

    private function enterFrameHandler(event:Event):void {
        if (points==0)
        {
            scales['width'] +=(740/iteration_points[0]);
            scales['height'] +=(540/iteration_points[0]);
            scales['x'] -=(740/iteration_points[0])/2;
            scales['y'] -=(540/iteration_points[0])/2;
            mainWindow.graphics.clear();
            mainWindow.graphics.beginFill(0x000000,0.8);
            mainWindow.graphics.drawRect(0,0,scales['width'],scales['height']);
            mainWindow.x = scales['x'];
            mainWindow.y = scales['y'];

        }

        if  (points==1) {
            scales['width'] -=(740/iteration_points[1]);
            scales['height'] -=(540/iteration_points[1]);
            scales['x'] +=(740/iteration_points[1])/2;
            scales['y'] +=(540/iteration_points[1])/2;
            mainWindow.graphics.clear();
            mainWindow.graphics.beginFill(0x000000,0.8);
            mainWindow.graphics.drawRect(0,0,scales['width'],scales['height']);
            mainWindow.x = scales['x'];
            mainWindow.y = scales['y'];

        }

        if  (points==2) {
            scales['width'] +=(740/iteration_points[2]);
            scales['height'] +=(540/iteration_points[2]);
            scales['x'] -=(740/iteration_points[2])/2;
            scales['y'] -=(540/iteration_points[2])/2;
            mainWindow.graphics.clear();
            mainWindow.graphics.beginFill(0x000000,0.8);
            mainWindow.graphics.drawRect(0,0,scales['width'],scales['height']);
            mainWindow.x = scales['x'];
            mainWindow.y = scales['y'];

        }


        iteration++;
        if (iteration>iteration_points[0])
        points++;
        if (iteration>iteration_points[1])
            points++;
        if (iteration>iteration_points[2])
        {
            points++;
            removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
            addButtons()

        }

    }

    private function addButtons() : void {


        textReviewButton  = buttonCreate('Написать отзыв');
        voiceReviewButton  = buttonCreate('Сказать  отзыв')
        voiceReviewButton.x = 400-150;
        voiceReviewButton.y = 300-40;
        textReviewButton.x = 400+10;
        textReviewButton.y = 300-40;
        addChild(textReviewButton);
        addChild(voiceReviewButton);
        textReviewButton.addEventListener(MouseEvent.CLICK, textReviewButton_clickHandler);
        voiceReviewButton.addEventListener(MouseEvent.CLICK, voiceReviewButton_clickHandler);
    }

    private function textReviewButton_clickHandler(event:MouseEvent):void {
       removeChild(textReviewButton);
       removeChild(voiceReviewButton);
       messegesInput.defaultTextFormat = TextFormats.textFormat_1;
        messegesInput.multiline = true;
        messegesInput.mouseWheelEnabled = true;
        messegesInput.wordWrap = true;
        messegesInput.type= TextFieldType.INPUT;
        messegesInput.border = true;
        messegesInput.borderColor = 0xFF0000;
        messegesInput.width=250;
        messegesInput.height=150;
        messegesInput.x = 800/2-messegesInput.width/2;
        messegesInput.y = 600/2-messegesInput.height/2;
        addChild(messegesInput);
        messegesInputButton = buttonCreate('Я закончил!');
        messegesInputButton.x = 800/2 - messegesInputButton.width/2;
        messegesInputButton.y = messegesInput.y+messegesInput.height+10;
        addChild(messegesInputButton);
        messegesInputButton.addEventListener(MouseEvent.CLICK, messegesInputButton_clickHandler);
    }

    private function voiceReviewButton_clickHandler(event:MouseEvent):void {
        removeChild(textReviewButton);
        removeChild(voiceReviewButton);
        textForVoice.defaultTextFormat = TextFormats.textFormat_1;
        textForVoice.text='Начинайте говорить!'
        textForVoice.width=200;
        textForVoice.x = 800/2-textForVoice.width/2;
        textForVoice.y = 600/2-textForVoice.height/2;
        addChild(textForVoice);
        completeButton = buttonCreate('Я закончил!');
        completeButton.x = 800/2 - completeButton.width/2;
        completeButton.y = textForVoice.y+textForVoice.height+10;
        addChild(completeButton);
        completeButton.addEventListener(MouseEvent.CLICK, completeButton_clickHandler);
        record = new RecordReview(microphone);
        record.init();
        record.addEventListener(Event.COMPLETE, record_completeHandler);

    }
    private function buttonCreate(text_button : String) : Sprite {
        var button_backround : Sprite = new Sprite();
        button_backround.graphics.beginFill(0xFF0000);
        button_backround.graphics.drawRect(0,0,140,60);

        var text : TextField = new TextField();
        text.defaultTextFormat = TextFormats.textFormat_1;
        text.text = text_button;
        text.height =  40;
        text.width=120;
        text.y = button_backround.height/2-text.height/2;
        text.x = button_backround.width/2-text.width/2;
        button_backround.addChild(text);
        var hover : Sprite = new Sprite();
        hover.graphics.beginFill(0xFF0000,0.01);
        hover.graphics.drawRect(0,0,140,60);
        button_backround.addChild(hover);
        return button_backround;
    }

    private function record_completeHandler(event:Event):void {
        sendData(true,record.outarray);
    }

    private function completeButton_clickHandler(event:MouseEvent):void {
        record.stopRecord();
    }

    private function messegesInputButton_clickHandler(event:MouseEvent):void {
                sendData(false, messegesInput.text);
    }
    private function sendData(type : Boolean,data : Object) : void {

        if (type)
        {
            var mll : MultipartURLLoader = new MultipartURLLoader();
            mll.addEventListener(Event.COMPLETE,reviewLoader_completeHandler);
            mll.addFile(record.outarray,"audio.mp3","file","audio/mp3");
            mll.addVariable('uid',Vk.getUid())

            mll.load(UrlSettings.reviewUrl);
        }
        else {
        var reviewLoader : URLLoader  = new URLLoader();
        var request : URLRequest = new URLRequest(UrlSettings.reviewUrl);
        request.method = URLRequestMethod.POST;
        var variables : URLVariables = new URLVariables();
        variables.message = data;
        variables.uid = Vk.getUid();
        request.data = variables;
        reviewLoader.load(request);
        reviewLoader.addEventListener(Event.COMPLETE, reviewLoader_completeHandler);
        reviewLoader.addEventListener(IOErrorEvent.IO_ERROR, reviewLoader_ioErrorHandler);
        reviewLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, reviewLoader_securityErrorHandler);
        }
    }

    private function reviewLoader_completeHandler(event:Event):void {
        dispatchEvent(new Event(Event.COMPLETE));
//        ModalContainer.textField.text = (event.target as MultipartURLLoader).loader.data;
    }

    private function reviewLoader_ioErrorHandler(event:IOErrorEvent):void {

           ModalContainer.textField.text = event.text;

    }

    private function reviewLoader_securityErrorHandler(event:SecurityErrorEvent):void {
        ModalContainer.textField.text =  event.text;

    }
}
}
