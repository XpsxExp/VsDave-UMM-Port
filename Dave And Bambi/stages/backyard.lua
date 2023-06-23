local stageSprites = {'hills', 'grass', 'gates', 'bear', 'house', 'grill'};
local nightColor = '0xFF878787';
local sunsetColor = '0xFFFF8FB2';
local WHITE = '0xFFFFFFFF';

function onCreatePost()
   local theTimeTheTweenTakesToGetToTheInputtedValue = sectionStartTime(56);
   twnTime = theTimeTheTweenTakesToGetToTheInputtedValue / 1000;

   makeBackgroundSprite('bg', 'backgrounds/shared/sky_festival', -600, -400, 0.6, 0.6);
   
   if string.lower(songName) == 'rano' then
      makeBackgroundSprite('sunrise', 'backgrounds/shared/sky_sunrise', -600, -400, 0.6, 0.6);
	  setProperty('sunrise.alpha', 0);
	  
	  makeBackgroundSprite('sky', 'backgrounds/shared/sky', -600, -400, 0.6, 0.6);
	  setProperty('sky.alpha', 0);
   end
   
   makeBackgroundSprite('hills', 'backgrounds/backyard/hills', -1330, -432, 0.75, 0.75);
   
   makeBackgroundSprite('grass', 'backgrounds/backyard/supergrass', -800, 150, 1, 1);
   
   makeBackgroundSprite('gates', 'backgrounds/backyard/gates', 564, -33, 1, 1);
   
   makeBackgroundSprite('bear', 'backgrounds/backyard/bearDude', -1035, -710, 0.95, 0.95);
   
   makeBackgroundSprite('house', 'backgrounds/backyard/house', -1025, -323, 0.95, 0.95);
   
   makeBackgroundSprite('grill', 'backgrounds/backyard/grill', -489, 452, 0.95, 0.95);
   
   doTweenAlpha('skyFade', 'sky', 0, twnTime);
   doTweenAlpha('sunriseFade', 'sunrise', 1, twnTime);
   doTweenAlpha('festivalFade', 'bg', 0, twnTime);
   
   for i = 1, #stageSprites do
      setProperty(stageSprites[i] .. '.color', getColorFromHex(nightColor));
	  runHaxeCode([[
		FlxTween.color(game.getLuaObject(']] .. stageSprites[i] .. [['), ]] .. theTimeTheTweenTakesToGetToTheInputtedValue / 1000 .. [[, ]] .. getColorFromHex(nightColor) .. [[, ]] .. getColorFromHex(sunsetColor) .. [[).then(FlxTween.color(game.getLuaObject(']] .. stageSprites[i] .. [['), ]] .. theTimeTheTweenTakesToGetToTheInputtedValue / 1000 .. [[, ]] .. getColorFromHex(sunsetColor) .. [[, ]] .. getColorFromHex(WHITE) .. [[));
      ]])
   end
   
   setProperty('boyfriend.color', getColorFromHex(nightColor)); setProperty('gf.color', getColorFromHex(nightColor)); setProperty('dad.color', getColorFromHex(nightColor));
   runHaxeCode([[
     FlxTween.color(game.dad, ]] .. theTimeTheTweenTakesToGetToTheInputtedValue / 1000 .. [[, ]] .. getColorFromHex(nightColor) .. [[, ]] .. getColorFromHex(sunsetColor) .. [[).then(FlxTween.color(game.dad, ]] .. theTimeTheTweenTakesToGetToTheInputtedValue / 1000 .. [[, ]] .. getColorFromHex(sunsetColor) .. [[, ]] .. getColorFromHex(WHITE) .. [[));
	 FlxTween.color(game.gf, ]] .. theTimeTheTweenTakesToGetToTheInputtedValue / 1000 .. [[, ]] .. getColorFromHex(nightColor) .. [[, ]] .. getColorFromHex(sunsetColor) .. [[).then(FlxTween.color(game.gf, ]] .. theTimeTheTweenTakesToGetToTheInputtedValue / 1000 .. [[, ]] .. getColorFromHex(sunsetColor) .. [[, ]] .. getColorFromHex(WHITE) .. [[));
	 FlxTween.color(game.boyfriend, ]] .. theTimeTheTweenTakesToGetToTheInputtedValue / 1000 .. [[, ]] .. getColorFromHex(nightColor) .. [[, ]] .. getColorFromHex(sunsetColor) .. [[).then(FlxTween.color(game.boyfriend, ]] .. theTimeTheTweenTakesToGetToTheInputtedValue / 1000 .. [[, ]] .. getColorFromHex(sunsetColor) .. [[, ]] .. getColorFromHex(WHITE) .. [[));
   ]])
end

function makeBackgroundSprite(tag, path, x, y, xScroll, yScroll)
   makeLuaSprite(tag, path, x, y);
   setScrollFactor(tag, xScroll, yScroll);
   addLuaSprite(tag);
end

function onTweenCompleted(tag)
   if tag == 'sunriseFade' then
      doTweenAlpha('sunriseFade2', 'sunrise', 0, twnTime);
   elseif tag == 'skyFade' then
      doTweenAlpha('skyFade2', 'sky', 1, twnTime);
   end
end

function sectionStartTime(section)
   local theBpm = bpm;
   local thePosition = 0;
   
   for i = 0, section do
      thePosition = thePosition + 4 * (1000 * 60 / theBpm);
   end
   return thePosition;
end