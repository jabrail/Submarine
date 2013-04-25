/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 09.03.13
 * Time: 16:19
 * To change this template use File | Settings | File Templates.
 */
package GameComponets.loaders {
import flash.events.Event;
import flash.events.SampleDataEvent;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import flash.utils.ByteArray;

public class SoundManager {

    private var hit_sound : Sound;
    public var bonus_sound : Sound;
    private var coin_sound : Sound;
    private var hit_sound_channal : SoundChannel;
    private var bonus_sound_channal : SoundChannel;
    private var coin_sound_channal : SoundChannel;
    private var volumTransform : SoundTransform;
    public static var sound_player : Sound;
    public static var sound_player_volumeTransform : SoundTransform;
    public static var sound_player_chanel : SoundChannel;
    public static var sound_player_byteArray : ByteArray = new ByteArray();
    public function SoundManager() {


        volumTransform = new SoundTransform();
        volumTransform.volume = 0.8;


    }
    public static function createSound(bytearray :ByteArray): void
    {
        sound_player = new Sound();
        bytearray.position=0;
        sound_player_volumeTransform = new SoundTransform();
        sound_player_volumeTransform.volume = 1;
        sound_player_byteArray = bytearray;
 //       sound_player.addEventListener(SampleDataEvent.SAMPLE_DATA, playbackSampleHandler);
           sound_player.loadCompressedDataFromByteArray(bytearray,bytearray.length);

//            sound_player.loadCompressedDataFromByteArray(bytearray,bytearray.length);
    }
    public static function play_Player_Sound() : void
    {
        sound_player_byteArray.position=0;
        sound_player_chanel = sound_player.play();
        sound_player_chanel.soundTransform =   sound_player_volumeTransform;
    }
    private static function playbackSampleHandler(event : SampleDataEvent) : void
    {
        for (var i : int = 0;i < 8192 && sound_player_byteArray.bytesAvailable > 0;i++)
        {
            var sample : Number = sound_player_byteArray.readFloat();
            event.data.writeFloat(sample);
            event.data.writeFloat(sample);
        }
    }
    public static function stop_Player_Sound() : void
    {
        sound_player_chanel.stop();
        sound_player_chanel = null;
    }
    public function play_bonus() : void {
        bonus_sound_channal = bonus_sound.play();
        bonus_sound_channal.soundTransform = volumTransform;
    }
    public function play_hit() : void {
        hit_sound_channal = hit_sound.play();
        hit_sound_channal.soundTransform = volumTransform;

    }
    public function play_coin() : void {
        coin_sound_channal = coin_sound.play();
        coin_sound_channal.soundTransform = volumTransform;

    }


}
}
