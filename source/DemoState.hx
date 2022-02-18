package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import openfl.Assets;

#if cpp
import sys.thread.Thread;
#end

using StringTools;

class DemoState extends MusicBeatState
{   

    
	var dropText:FlxText;
	var warningMusic:FlxSound;

    override  function create():Void
	{

        FlxG.sound.music.stop();
        warningMusic = new FlxSound().loadEmbedded(Paths.music("LunchboxScary", "week6"), true, true);
		warningMusic.volume = 0;
		warningMusic.play(false, FlxG.random.int(0, Std.int(warningMusic.length / 2)));
		
		FlxG.sound.list.add(warningMusic);

        var pic:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('loadthing'));
		pic.setGraphicSize(Std.int(pic.width * .9));
        pic.alpha = 0;
		add(pic);

        dropText = new FlxText(-150, 0, Std.int(FlxG.width * 1.2), "", 40);
		dropText.font = 'vcr';
		dropText.color = FlxColor.WHITE;
        dropText.alignment = FlxTextAlign.CENTER;
        dropText.alpha = 0;
		add(dropText);
        FlxTween.tween(pic, {alpha: 1}, 1.2, {ease: FlxEase.circOut});
        FlxTween.tween(dropText, {alpha: 1}, 1.2, {ease: FlxEase.circOut});
       
    }


    override function update(elapsed:Float)
	{
		if (warningMusic.volume < 0.3)
			warningMusic.volume += 0.01 * elapsed;
			
        dropText.text = "Warning!
this mod is a beta version and is a demo,
any bugs you might find, report to me.
ALSO THIS IS NOT FINAL!
(Press any key to continue)";
        dropText.visible = true;
        dropText.screenCenter();
         if (FlxG.keys.justPressed.ANY)
		{
            FlxG.sound.music.stop();
            FlxG.switchState(new MainMenuState());
		}
       
    }
}