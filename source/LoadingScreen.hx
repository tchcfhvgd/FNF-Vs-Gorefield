package;

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
import flixel.util.FlxTimer;

enum PreloadType {
    atlas;
    image;
}

class LoadingScreen extends MusicBeatState {

    public static var assetStack:Map<String, PreloadType> = [];
    
    var maxCount:Int;

    private var pizza:Character = null;

    
    private var playstateInfo:Map<String, Dynamic> = [
        "songLowerCase" => "",
        "diffuclty" => 0,
        "jsondata" /*aka songname-diff*/ => "",
        "songPlayList" => [],
        "isStoryMode" => false
    ];

    private var spriteInfo:Map<String, Array<Dynamic>> = [
        "curious-cat" => ["loadingbg1", "rightloadingimage1", [561.46,-42.08], "BF 1"],
        "metamorphosis" => ["loadingbg2", "GOREFIELD_CARGA", [600.46,-42.08], "GOREFIELD"],
        "hi-jon" => ["pantalla_azul_3", "JHON_CARGA", [770.46,40.08], "JHON CARGA"],
    ];

    private var finished:Bool = false;

    override public function create() {
        trace(playstateInfo["songLowerCase"]);

        super.create();

        FlxG.sound.music.stop();

        Paths.setCurrentLevel('shared');

        var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image(spriteInfo[playstateInfo["songLowerCase"]][0], "shared"));
        bg.screenCenter();
        bg.antialiasing = true;
        add(bg);

        var portrait:FlxSprite = new FlxSprite();
        portrait.frames = Paths.getSparrowAtlas(spriteInfo[playstateInfo["songLowerCase"]][1], "shared");
        portrait.animation.addByPrefix('idle', spriteInfo[playstateInfo["songLowerCase"]][3], 24, true);
        portrait.animation.play('idle');
        portrait.scale.set(0.68,0.68);
        portrait.updateHitbox();
        portrait.setPosition(spriteInfo[playstateInfo["songLowerCase"]][2][0], spriteInfo[playstateInfo["songLowerCase"]][2][1]);
        portrait.antialiasing = true;
        trace(portrait);
        add(portrait);

        pizza = new Character(0,0,"loading");
        pizza.playAnim('loading');
        pizza.x = 0 - (pizza.width/3.5);
        pizza.y = FlxG.height - (pizza.height + (pizza.height / 4));
        add(pizza);

        FlxG.camera.alpha = 0;

        maxCount = Lambda.count(assetStack);
        trace(maxCount);

        FlxG.mouse.visible = false;

        FlxG.sound.play(Paths.sound("loadingsound", "shared"));

        new FlxTimer().start(1.5, function(tmr:FlxTimer)
            {
                FlxTween.tween(FlxG.camera, {alpha: 1}, 0.5, {
                    onComplete: function(tween:FlxTween){
                        Thread.create(function(){
                            assetGenerate();
                        });
                    }
                });
            });
    }

    override public function new(songLowerCase:String, diffuclty:Int, jsondata:String, isStoryMode:Bool, ?songPlayList:Array<String> = null) {
        super();

        //passing info to finish function

        playstateInfo["songLowerCase"] = songLowerCase;

        playstateInfo["diffuclty"] = diffuclty;

        playstateInfo["jsondata"] = jsondata;

        playstateInfo["isStoryMode"] = isStoryMode;

        playstateInfo["songPlayList"] = songPlayList;

        assetStack = getAssets();
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ENTER && finished) {
            finish();
        }
    }

    function finish() {

        FlxTween.tween(FlxG.camera, {alpha: 0}, 0.5, {
            onComplete: function(tween:FlxTween){

                if (playstateInfo["isStoryMode"]) {
                    PlayState.storyPlaylist = playstateInfo["songPlayList"];
                    PlayState.isStoryMode = playstateInfo["isStoryMode"];
                    PlayState.campaignScore = 0;
                    PlayState.campaignMisses = 0; 
                } else {
                    PlayState.isStoryMode = false;
                }
               
                PlayState.SONG = Song.loadFromJson(StringTools.replace(playstateInfo["jsondata"], "-null", ""), playstateInfo["songLowerCase"]);

                PlayState.storyDifficulty = playstateInfo["diffuclty"];  
                
                MusicBeatState.switchState(new PlayState());
            }
        });
    }

    function getAssets() {
        return switch(playstateInfo["songLowercase"]) {
            default: 
                [
                    "stages/BG" => LoadingScreen.PreloadType.image,
                    "stages/balls_overlay" => LoadingScreen.PreloadType.image,
                    "stages/JON" => LoadingScreen.PreloadType.image,
                    "NOTE_assets" => LoadingScreen.PreloadType.image,
                    "noteSplashes" => LoadingScreen.PreloadType.image,
                    "ready" => LoadingScreen.PreloadType.image,
                    "go" => LoadingScreen.PreloadType.image,
                    "set" => LoadingScreen.PreloadType.image,
                    "shit" => LoadingScreen.PreloadType.image,
                    "bad" => LoadingScreen.PreloadType.image,
                    "good" => LoadingScreen.PreloadType.image,
                    "sick" => LoadingScreen.PreloadType.image,
                    "combo" => LoadingScreen.PreloadType.image,
                    "CATNOTE_assets" => LoadingScreen.PreloadType.image,
                    "CLAWNOTE_assets" => LoadingScreen.PreloadType.image,
                    "garfield" => LoadingScreen.PreloadType.atlas,
                    "bf-art" => LoadingScreen.PreloadType.atlas,
                ];
            case 'metamorphosis':
                [
                    "stages/BG" => LoadingScreen.PreloadType.image,
                    "stages/balls_overlay" => LoadingScreen.PreloadType.image,
                    "stages/JON" => LoadingScreen.PreloadType.image,
                    "NOTE_assets" => LoadingScreen.PreloadType.image,
                    "noteSplashes" => LoadingScreen.PreloadType.image,
                    "ready" => LoadingScreen.PreloadType.image,
                    "go" => LoadingScreen.PreloadType.image,
                    "set" => LoadingScreen.PreloadType.image,
                    "shit" => LoadingScreen.PreloadType.image,
                    "bad" => LoadingScreen.PreloadType.image,
                    "good" => LoadingScreen.PreloadType.image,
                    "sick" => LoadingScreen.PreloadType.image,
                    "combo" => LoadingScreen.PreloadType.image,
                    "CATNOTE_assets" => LoadingScreen.PreloadType.image,
                    "CLAWNOTE_assets" => LoadingScreen.PreloadType.image,
                    "gorefield-phase-2" => LoadingScreen.PreloadType.atlas,
                    "bf-art" => LoadingScreen.PreloadType.atlas,
                ];
            case 'hi-jon':
                [
                    "stages/BG" => LoadingScreen.PreloadType.image,
                    "stages/BG_2" => LoadingScreen.PreloadType.image,
                    "stages/balls_overlay" => LoadingScreen.PreloadType.image,
                    "stages/JON" => LoadingScreen.PreloadType.image,
                    "NOTE_assets" => LoadingScreen.PreloadType.image,
                    "noteSplashes" => LoadingScreen.PreloadType.image,
                    "ready" => LoadingScreen.PreloadType.image,
                    "go" => LoadingScreen.PreloadType.image,
                    "set" => LoadingScreen.PreloadType.image,
                    "shit" => LoadingScreen.PreloadType.image,
                    "bad" => LoadingScreen.PreloadType.image,
                    "good" => LoadingScreen.PreloadType.image,
                    "sick" => LoadingScreen.PreloadType.image,
                    "combo" => LoadingScreen.PreloadType.image,
                    "CATNOTE_assets" => LoadingScreen.PreloadType.image,
                    "CLAWNOTE_assets" => LoadingScreen.PreloadType.image,
                    "gorefield-phase-2" => LoadingScreen.PreloadType.atlas,
                    "bf-art" => LoadingScreen.PreloadType.atlas,
                    "gorefield-phase-3" => LoadingScreen.PreloadType.atlas,
                    "bf-final" => LoadingScreen.PreloadType.atlas,
                ];
        };
    }

    function assetGenerate() {

        var countUp:Int = 0;

        for (i in assetStack.keys()) {
            trace('calling asset $i');

            switch(assetStack[i]) {
                case PreloadType.image:
                    var loadedsprite:FlxSprite = new FlxSprite(FlxG.width / 2, FlxG.height / 2).loadGraphic(Paths.image(i, "shared"));
                    loadedsprite.visible = false;
                    add(loadedsprite);

                    Paths.returnGraphic(i);

                    trace('image loaded ${loadedsprite}');
                case PreloadType.atlas:
                    var preloadedCharacter:Character = new Character(FlxG.width / 2, FlxG.height / 2, i);
                    preloadedCharacter.visible = false;
                    add(preloadedCharacter);
                    trace('character loaded ${preloadedCharacter.frames}');
            }
        
            countUp++;
        }

        trace("finished loading");

        pizza.playAnim('enter');

        pizza.animation.finishCallback = function (name:String) {
            if (name == 'enter')
            {
                pizza.playAnim('enterloop');
                finished = true;
            }    
        }
    }
}