function onCreate()
   luaDebugMode = true;
   addHaxeLibrary('FlxTypeText', 'flixel.addons.text');
   addHaxeLibrary('FlxText', 'flixel.text');
   addHaxeLibrary('FlxTextBorderStyle','flixel.text');
   addHaxeLibrary('FlxTextAlign','flixel.text');
   addHaxeLibrary('FlxAxes', 'flixel.util');
   addHaxeLibrary('Type');
end

function createSubtitle(text, typeSpeed, showTime, size)
   runHaxeCode([[
     var OUTLINE = Type.getEnum(game.scoreTxt.borderStyle).OUTLINE;
     var aSubtitle = new FlxTypeText(]] .. 0 .. [[, ]] .. (screenHeight / 2) - 200 .. [[, ]] .. screenWidth .. [[, "]] .. text .. [[", ]] .. size .. [[);
	 aSubtitle.sounds = null;
	 aSubtitle.setFormat(Paths.font('vcr.ttf'), ]] .. size .. [[, ]] .. getColorFromHex('FFFFFF') .. [[, null, OUTLINE, ]] .. getColorFromHex('000000') .. [[);
	 aSubtitle.alignment = game.scoreTxt.alignment; //lol, lmao even.
	 aSubtitle.antialiasing = true;
	 aSubtitle.borderSize = 2;
	 aSubtitle.start(]] .. typeSpeed .. [[, false, false, [], function() {
	    new FlxTimer().start(]] .. showTime .. [[, function(timer:FlxTimer) {
		   FlxTween.tween(aSubtitle, {alpha: 0}, 0.5, {onComplete: function (tween:FlxTween) {
		      aSubtitle.destroy();
		   }});
		});
	 });
	 aSubtitle.cameras = [game.camHUD];
	 game.add(aSubtitle);
   ]])
end

function onEvent(name, value1, value2)
   if name == 'Create Subtitle' then
      local eventstr = value2;
	  local args = stringSplit(eventstr, ',');
	  createSubtitle(value1, args[1], args[2], args[3]);
   end
end

function onSubtitleCompleted()
   debugPrint('ASFOAFIASOFIASFI');
end