local stageTags = {'flatgrass', 'hills', 'farmHouse', 'grassLand', 'cornFence', 'cornFence2', 'cornBag', 'sign'};
local nightColor = '0xFF878787';
local sunsetColor = '0xFFFF8FB2';
local WHITE = '0xFFFFFFFF';
local twnTime = 0;

function onCreatePost()
   luaDebugMode = true;
   local theTimeTheTweenTakesToGetToTheInputtedValue = sectionStartTime(25);
   twnTime = theTimeTheTweenTakesToGetToTheInputtedValue / 1000;
   for i = 1, #stageTags do
	  runHaxeCode([[
		FlxTween.color(game.getLuaObject(']] .. stageTags[i] .. [['), ]] .. theTimeTheTweenTakesToGetToTheInputtedValue / 1000 .. [[, ]] .. getColorFromHex(WHITE) .. [[, ]] .. getColorFromHex(sunsetColor) .. [[).then(FlxTween.color(game.getLuaObject(']] .. stageTags[i] .. [['), ]] .. theTimeTheTweenTakesToGetToTheInputtedValue / 1000 .. [[, ]] .. getColorFromHex(sunsetColor) .. [[, ]] .. getColorFromHex(nightColor) .. [[));
      ]])
   end
   doTweenAlpha('bgfarmfade', 'bg', 0, twnTime);
   doTweenAlpha('sunsetBGfarmfade', 'sunsetBG', 1, twnTime);
   doTweenAlpha('nightBGfarmfade', 'nightBG', 0, twnTime);
   
   runHaxeCode([[
     FlxTween.color(game.dad, ]] .. theTimeTheTweenTakesToGetToTheInputtedValue / 1000 .. [[, ]] .. getColorFromHex(WHITE) .. [[, ]] .. getColorFromHex(sunsetColor) .. [[).then(FlxTween.color(game.dad, ]] .. theTimeTheTweenTakesToGetToTheInputtedValue / 1000 .. [[, ]] .. getColorFromHex(sunsetColor) .. [[, ]] .. getColorFromHex(nightColor) .. [[));
	 FlxTween.color(game.gf, ]] .. theTimeTheTweenTakesToGetToTheInputtedValue / 1000 .. [[, ]] .. getColorFromHex(WHITE) .. [[, ]] .. getColorFromHex(sunsetColor) .. [[).then(FlxTween.color(game.gf, ]] .. theTimeTheTweenTakesToGetToTheInputtedValue / 1000 .. [[, ]] .. getColorFromHex(sunsetColor) .. [[, ]] .. getColorFromHex(nightColor) .. [[));
	 FlxTween.color(game.boyfriend, ]] .. theTimeTheTweenTakesToGetToTheInputtedValue / 1000 .. [[, ]] .. getColorFromHex(WHITE) .. [[, ]] .. getColorFromHex(sunsetColor) .. [[).then(FlxTween.color(game.boyfriend, ]] .. theTimeTheTweenTakesToGetToTheInputtedValue / 1000 .. [[, ]] .. getColorFromHex(sunsetColor) .. [[, ]] .. getColorFromHex(nightColor) .. [[));
   ]])
end

function sectionStartTime(section)
   local theBpm = bpm;
   local thePosition = 0;
   
   for i = 0, section do
      thePosition = thePosition + 4 * (1000 * 60 / theBpm);
   end
   return thePosition;
end

function onTweenCompleted(tag)
   if stringEndsWith(tag, 'farmfade') then
      if tag == 'sunsetBGfarmfade' then
         doTweenAlpha(tag .. 'then', 'sunsetBG', 0, twnTime);
      elseif tag == 'nightBGfarmfade' then
	     doTweenAlpha(tag .. 'then', 'nightBG', 1, twnTime);
	  end
   end
end