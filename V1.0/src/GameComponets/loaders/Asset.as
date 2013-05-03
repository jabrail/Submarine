/**
 * Created with IntelliJ IDEA.
 * User: Джабраил
 * Date: 13.12.12
 * Time: 16:47
 * To change this template use File | Settings | File Templates.
 */
package GameComponets.loaders {
import com.google.analytics.AnalyticsTracker;
import com.google.analytics.GATracker;

import flash.display.Sprite;

public class Asset {
    [Embed(source="../../images/shark.png")]
    public static const  Gameover : Class;
    [Embed(source="../../images/button/restart.png")]
    public static const Restert : Class;
    [Embed(source="../../images/button/restart_gameover.png")]
    public static const Restert_G_O : Class;
    [Embed(source="../../images/button/menu.png")]
    public static const Main_menu : Class;
    [Embed(source="../../images/button/level.png")]
    public static const Main_menu_G_O : Class;
    [Embed(source="../../images/button/next.png")]
    public static const Next : Class;
    [Embed(source="../../images/button/pause.png")]
    public static const Pause : Class;
    [Embed(source="../../images/button/share.png")]
    public static const Share : Class;
    [Embed(source="../../images/button/skip.png")]
    public static const Skip : Class;
    [Embed(source="../../images/button/continue.png")]
    public static const Continue : Class;
    [Embed(source="../../images/ПУЗЫРЬ.png")]
    public static const Bubble : Class;


    [Embed(source="../../images/button/fon_level.png")]
    public static const  Background_pause : Class;
    [Embed(source="../../images/button/microphone.png")]
    public static const  Microphone : Class;
    [Embed(source="../../images/button/sound_of.png")]
    public static const  Audio_of : Class;
    [Embed(source="../../images/button/sound_on.png")]
    public static const  Audio_on : Class;
    [Embed(source="../../images/button/keyboard.png")]
    public static const  Keyboard : Class;
    [Embed(source="../../images/menu/fon.png")]
    public static const  BackgroundMenu : Class;
    [Embed(source="../../images/help/help.png")]
    public static const  Help : Class;
    [Embed(source="../../images/help/play.png")]
    public static const PlayGame : Class;
    [Embed(source="../../images/game components/map.png")]
    public static const Map : Class;
    [Embed(source="../../images/game components/cursor.PNG")]
    public static const  Cursor : Class;

    [Embed(source="../../images/game components/sub_new.png")]
    public static const  Sub : Class;

    [Embed(source="../../images/button/mask.png")]
    public static const  Mask : Class;

    [Embed(source="../../images/button/MicCalibrate.png")]
    public static const  CalibrateButton : Class;
    [Embed(source="../../images/button/playagain.png")]
    public static const  PlayAgainButton : Class;
    [Embed(source="../../images/button/otzuv.png")]
    public static const  ReviewButton : Class;

    [Embed(source="/images/menu/Sub_menu.png")]
    public static const  background_menu : Class;
    [Embed(source="/images/menu/play.png")]
    public static const menu_play : Class;

    [Embed(source="/images/LevelSelect/fon_level.png")]
    public static const LevelSelect : Class;


    [Embed(source="/images/button/play_sound.png")]
    public static const Play_sound : Class;
    [Embed(source="/images/button/stop.png")]
    public static const Stop_sound : Class;
    [Embed(source="/images/complete/level com.png")]
    public static const LevelCompleteView : Class;
    [Embed(source="/images/preloaders/preload.PNG")]
    public static const PreloaderFon : Class;

    [Embed(source="/images/preloaders/load.PNG")]
    public static const PreloaderProgres : Class;

    [Embed(source="/images/ship/Sub_vint.swf" ,mimeType="application/octet-stream")]
    public static const Vint : Class;


    public function Asset() {
    }
}
}
