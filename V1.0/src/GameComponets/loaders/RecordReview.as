/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 25.03.13
 * Time: 15:43
 * To change this template use File | Settings | File Templates.
 */
package GameComponets.loaders {
import Othe.Myevent;

import flash.display.Sprite;
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.ProgressEvent;
import flash.events.SampleDataEvent;

import flash.media.Microphone;
import flash.utils.ByteArray;

import fr.kikko.lab.ShineMP3Encoder;

import org.bytearray.micrecorder.MicRecorder;
import org.bytearray.micrecorder.encoder.WaveEncoder;
import org.bytearray.micrecorder.events.RecordingEvent;

public class RecordReview extends Sprite{
    private  var mic :Microphone;
    private  var recorder : MicRecorder;
    private  var _mp3_encoder: ShineMP3EncoderClone;
    public var outarray : ByteArray;

    public function RecordReview(mic : Microphone) {
     this.mic = mic;
    }
    public function init() : void {
        mic.addEventListener(SampleDataEvent.SAMPLE_DATA, onMicActivity);
        var volume : Number = 0.8;
        var wavEncoder : WaveEncoder = new WaveEncoder(volume);
        recorder  = new MicRecorder(wavEncoder,mic);
        recorder.addEventListener(RecordingEvent.RECORDING, onRecording);
        recorder.addEventListener(Event.COMPLETE, onRecordComplete);
        recorder.record();
    }


    private function onMicActivity(event:SampleDataEvent):void {
        recorder.onSampleData(event);

    }
    private function onRecordComplete(event:Event):void {

        var  sound_arr : ByteArray = recorder.output;
        ModalContainer.preloaderInit();
        PreloaderRef.init();
        ModalContainer.rootConteiner.addChild(PreloaderRef.preloader);
        sound_arr.position =0;
        try {
             _mp3_encoder  = new ShineMP3EncoderClone(sound_arr);
            _mp3_encoder.addEventListener(Event.COMPLETE, onMP3EncoderComplete, false, 0, true);
            _mp3_encoder.addEventListener(ProgressEvent.PROGRESS, onMP3EncoderProcess, false, 0, true);
            _mp3_encoder.addEventListener(ErrorEvent.ERROR, mp3_encoder_errorHandler);
            _mp3_encoder.start();
        } catch (e:Error) {
            ModalContainer.textField.text = "Вы ошибаетесь, мой друг! " + e.message;
        }
    }
    function onMP3EncoderComplete (e:Event):void
    {
        ModalContainer.rootConteiner.removeChild(PreloaderRef.preloader);
        outarray = _mp3_encoder.mp3Data;
        dispatchEvent(new Event(Event.COMPLETE));

    }


    private function onRecording(event:RecordingEvent):void {

    }
    function onMP3EncoderProcess (e:ProgressEvent):void
    {
        trace("Encoding to mp3 ... " + Math.ceil(e.bytesLoaded * 100 / e.bytesTotal) + "%");
        PreloaderRef.setValue(Math.ceil(e.bytesLoaded * 100 / e.bytesTotal));
    }
    private function mp3_encoder_errorHandler(event:ErrorEvent):void {
        ModalContainer.textField.text = "Вы ошибаетесь, мой друг! " + event.errorID;
    }
    public function stopRecord() : void {
        recorder.stop();
        mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, onMicActivity);

    }
}
}
