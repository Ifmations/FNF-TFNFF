import flixel.graphics.FlxGraphic;
import sys.thread.Thread;
import flixel.system.FlxAssets;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;

enum PreloadType {
    atlas;
    image;
}

class PreloadState extends FlxState {

    var globalRescale:Float = 2/3;
    var preloadStart:Bool = false;

    var loadText:FlxText;
    var assetStack:Map<String, PreloadType> = [
        'clod/LOD' => PreloadType.image, 
    ];
    var maxCount:Int;

    public static var preloadedAssets:Map<String, FlxGraphic>;
    var backgroundGroup:FlxTypedGroup<FlxSprite>;
    var bg:FlxSprite;

    public static var unlockedSongs:Array<Bool> = [false, false];

    override public function create() {
        super.create();

        FlxG.camera.alpha = 0;

        maxCount = Lambda.count(assetStack);
        trace(maxCount);
        // create funny assets
        backgroundGroup = new FlxTypedGroup<FlxSprite>();
        FlxG.mouse.visible = false;

        preloadedAssets = new Map<String, FlxGraphic>();

        bg = new FlxSprite();
		bg.loadGraphic(Paths.image('clod/LOD'));
        bg.setGraphicSize(Std.int(bg.width * globalRescale));
        bg.updateHitbox();
		backgroundGroup.add(bg);

        // save bullshit
        FlxG.save.bind('funkin', 'ninjamuffin99');
        if(FlxG.save.data != null) {
            if (FlxG.save.data.silverUnlock != null)
                unlockedSongs[0] = FlxG.save.data.silverUnlock;
            if (FlxG.save.data.missingnoUnlock != null)
                unlockedSongs[1] = FlxG.save.data.missingnoUnlock;
            if (FlxG.save.data.hasUnlockedFuck == null)
                FlxG.save.data.hasUnlockedFuck = false;
        }

        loadText = new FlxText(5, FlxG.height - (32 + 5), 0, 'Loading...', 32);
		loadText.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(loadText);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
    }

    var storedPercentage:Float = 0;

    function assetGenerate() {
        //
        var countUp:Int = 0;
        for (i in assetStack.keys()) {
            trace('calling asset $i');

            FlxGraphic.defaultPersist = true;
            switch(assetStack[i]) {
                case PreloadType.image:
                    var savedGraphic:FlxGraphic = FlxG.bitmap.add(Paths.image(i, 'shared'));
                    preloadedAssets.set(i, savedGraphic);
                    trace(savedGraphic + ', yeah its working');
                case PreloadType.atlas:
                    var preloadedCharacter:Character = new Character(FlxG.width / 2, FlxG.height / 2, i);
                    preloadedCharacter.visible = false;
                    add(preloadedCharacter);
                    trace('character loaded ${preloadedCharacter.frames}');
            }
            FlxGraphic.defaultPersist = false;
        
            countUp++;
            storedPercentage = countUp/maxCount;
            loadText.text = 'Loading... Progress at ${Math.floor(storedPercentage * 100)}%';
        }

        ///*
        FlxTween.tween(FlxG.camera, {alpha: 0}, 0.5, {
            onComplete: function(tween:FlxTween){
                FlxG.switchState(new TitleState());
            }
        });
        //*/

    }
}