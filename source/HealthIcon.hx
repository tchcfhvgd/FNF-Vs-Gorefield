package;

import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.utils.Assets as OpenFlAssets;

using StringTools;

class HealthIcon extends FlxSprite
{
	public var sprTracker:FlxSprite;
	private var isOldIcon:Bool = false;
	private var isPlayer:Bool = false;
	private var char:String = '';

	public var offsetX = 0;
	public var offsetY = 0;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		isOldIcon = (char == 'bf-old');
		this.isPlayer = isPlayer;
		changeIcon(char);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}

	public function swapOldIcon() {
		if(isOldIcon = !isOldIcon) changeIcon('bf-old');
		else changeIcon('bf');
	}

	private var iconOffsets:Array<Float> = [0, 0];
	public function changeIcon(char:String) {
		if(this.char != char) {
			offsetX = 0;
			offsetY = 0;
			switch (char) {
				case 'garfield':
					var file:FlxAtlasFrames = Paths.getSparrowAtlas('icons/garfield');
					frames = file;
					
					animation.addByPrefix('default', 'Icon Garfield', 24, true);
					animation.addByPrefix('losing', 'Garfield 2 Icon', 24, true);
					antialiasing = ClientPrefs.globalAntialiasing;
					iconOffsets[0] = (width - 135) / 2;
					iconOffsets[1] = (width - 115) / 2;
					updateHitbox();
				case 'gorefield-phase-2':
					var file:FlxAtlasFrames = Paths.getSparrowAtlas('icons/gorefield');
					frames = file;
					
					animation.addByPrefix('default', 'GOREFIELD P2 Icon', 24, true);
					animation.addByPrefix('losing', 'ICON GOREFIELD P2 2', 24, true);
					antialiasing = ClientPrefs.globalAntialiasing;
					iconOffsets[0] = (width - 135) / 2;
					iconOffsets[1] = (width - 115) / 2;
					updateHitbox();
				case 'gorefield-phase-3':
					var file:FlxAtlasFrames = Paths.getSparrowAtlas('icons/gorefield-phase-3');
					frames = file;
					
					animation.addByPrefix('default', 'GOREFIELD WB ICON', 24, true);
					animation.addByPrefix('losing', 'ICON GOREFIELD WB 2', 24, true);
					antialiasing = ClientPrefs.globalAntialiasing;
					iconOffsets[0] = (width - 135) / 2;
					iconOffsets[1] = (width - 115) / 2;
					updateHitbox();
				case 'bf-art':
					var file:FlxAtlasFrames = Paths.getSparrowAtlas('icons/bf-art');
					frames = file;
					
					animation.addByPrefix('default', 'BF ICON', 24, true, isPlayer);
					animation.addByPrefix('losing', 'ICON BF 2', 24, true, isPlayer);
					antialiasing = ClientPrefs.globalAntialiasing;
					iconOffsets[0] = (width - 150) / 2;
					iconOffsets[1] = (width - 160) / 2;
					updateHitbox();
				case 'bf-final':
					var file:FlxAtlasFrames = Paths.getSparrowAtlas('icons/bf-final');
					frames = file;
					
					animation.addByPrefix('default', 'BF WB ICON', 24, true, isPlayer);
					animation.addByPrefix('losing', 'ICON BF WB 2', 24, true, isPlayer);
					antialiasing = ClientPrefs.globalAntialiasing;
					iconOffsets[0] = (width - 150) / 2;
					iconOffsets[1] = (width - 160) / 2;
					updateHitbox();
				default:
					var name:String = 'icons/' + char;
					if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-' + char; //Older versions of psych engine's support
					if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-face'; //Prevents crash from missing icon
					var file:Dynamic = Paths.image(name);
	
					loadGraphic(file); //Load stupidly first for getting the file size
					loadGraphic(file, true, Math.floor(width / 2), Math.floor(height)); //Then load it fr
					iconOffsets[0] = (width - 150) / 2;
					iconOffsets[1] = (width - 150) / 2;
					updateHitbox();
	
					animation.add(char, [0, 1], 0, false, isPlayer);
					animation.play(char);
					this.char = char;
	
					antialiasing = ClientPrefs.globalAntialiasing;
					if(char.endsWith('-pixel')) {
						antialiasing = false;
					}
				}
				animation.play('default');
		}
	}

	override function updateHitbox()
	{
		super.updateHitbox();
		offset.x = iconOffsets[0];
		offset.y = iconOffsets[1];
	}

	public function getCharacter():String {
		return char;
	}
}
