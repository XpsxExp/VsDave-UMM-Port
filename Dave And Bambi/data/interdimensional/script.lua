local crowdPeople = {};
local stageObjects = {'bg', 'bambic', 'tristanc', 'flatGrass', 'farmHouse', 'hills', 'corn', 'cornGlow', 'backGrass', 'crowd', 'frontGrass', 'stageGlow'};
local theOtherOnes = {'bg3D', 'ball', 'bimpe', 'maldo', 'memes kids', 'muko', 'ruby man', 'tristan', 'bambi'};

function onCreatePost()
   local mainSongChars = {
      ['shredder'] = {{'dave', 'idle', 0.8, 175, 100}, {'tristan', 'bop', 0.4, 800, 325}};
	  ['greetings'] = {{'dave', 'idle', 0.8, 175, 100}, {'bambi', 'bambi idle', 0.9, 700, 350}};
	  ['interdimensional'] = {{'bambi', 'bambi idle', 0.9, 400, 350}, {'tristan', 'bop', 0.4, 800, 325}};
   }

   makeBackgroundSprite('bg', 'backgrounds/shared/sky_festival', -600, -230, 0.6, 0.6);
   
   makeBackgroundSprite('flatGrass', 'backgrounds/festival/gm_flatgrass', 800, -100, 0.7, 0.7);
   
   makeBackgroundSprite('farmHouse', 'backgrounds/festival/farmHouse', 800, -150, 0.7, 0.7);
   
   makeBackgroundSprite('hills', 'backgrounds/festival/hills', -1000, -100, 0.7, 0.7);
   
   makeBackgroundSprite('corn', 'backgrounds/festival/corn', -1000, 120, 0.85, 0.85, true)
   addAnimationByPrefix('corn', 'idle', 'idle', 5, true);
   
   makeBackgroundSprite('cornGlow', 'backgrounds/festival/cornGlow', -1000, 120, 0.85, 0.85, true);
   addAnimationByPrefix('cornGlow', 'idle', 'idle', 5, true);
   setBlendMode('cornGlow', 'ADD');
   
   makeBackgroundSprite('backGrass', 'backgrounds/festival/backGrass', -1000, 475, 0.85, 0.85);
   
   makeBackgroundSprite('crowd', 'backgrounds/festival/crowd', -500, -150, 0.85, 0.85, true);
   addAnimationByPrefix('crowd', 'idle', 'crowdDance', 24, true);
   table.insert(crowdPeople, 'crowd');
   
   for i = 1, #mainSongChars[string.lower(songName)] do
      local curTable = mainSongChars[string.lower(songName)][i];
      makeBackgroundSprite(curTable[1] .. 'c', 'backgrounds/festival/mainCrowd/' .. curTable[1], curTable[4], curTable[5], 0.85, 0.85, true);
	  addAnimationByPrefix(curTable[1] .. 'c', 'idle', curTable[2], 24, false);
	  setGraphicSize(curTable[1] .. 'c', getProperty(curTable[1] .. 'c' .. '.width') * curTable[3]);
	  setProperty(curTable[1] .. 'c' .. '.alpha', 0);
	  table.insert(crowdPeople, curTable[1] .. 'c');
   end
   
   makeBackgroundSprite('frontGrass', 'backgrounds/festival/frontGrass', -1300, 600, 1, 1);
   
   makeBackgroundSprite('stageGlow', 'backgrounds/festival/generalGlow', -450, 300, 0, 0, true);
   addAnimationByPrefix('stageGlow', 'idle', 'idle', 5, true);
   setBlendMode('stageGlow', 'ADD');
   
   for i = 1, #stageObjects do
      setProperty(stageObjects[i] .. '.alpha', 0);
   end
end

function onCountdownTick()
   for i = 1, #crowdPeople do
      playAnim(crowdPeople[i], 'idle', true);
   end
end

function onBeatHit()
   if curBeat % 2 == 0 then
      for i = 1, #crowdPeople do
	     playAnim(crowdPeople[i], 'idle', true);
	  end
   end
end

function makeBackgroundSprite(tag, path, x, y, xScroll, yScroll, animated)
   if animated ~= nil and animated then
      makeAnimatedLuaSprite(tag, path, x, y);
   else
      makeLuaSprite(tag, path, x, y);
   end
   setScrollFactor(tag, xScroll, yScroll);
   addLuaSprite(tag);
end

function onEvent(name)
   if name == 'Interdimensional End' then
      callScript('floatyBoys', 'stopFloating');
      for i = 1, #theOtherOnes do
	     doTweenAlpha(theOtherOnes[i] .. 'Alpha', theOtherOnes[i], 0, 1);
	  end
      
      for i = 1, #stageObjects do
	     doTweenAlpha(stageObjects[i] .. 'Alpha', stageObjects[i], 1, 1);
	  end
	  
	  setProperty('defaultCamZoom', 0.7);
	  cameraFlash('camGame', 'FFFFFF', 0.25);
	  
	  runHaxeCode([[ FlxTween.linearMotion(game.dad, game.dad.x, game.dad.y, ]] .. getProperty('DAD_X') .. [[, ]] .. getProperty('DAD_Y') .. [[, 0.6, true); ]])
	  
	  setProperty('boyfriend.skipDance', true); setProperty('gf.skipDance', true);
	  local chars = {'boyfriend', 'gf'};
	  for i = 1, #chars do
	     if animationExists(chars[i], 'hey') then
		    playAnim(chars[i], 'hey', true);
		 elseif animationExists(chars[i], 'cheer') then
		    playAnim(chars[i], 'cheer', true);
		 end
	  end
   end
end

function animationExists(char, anim)
   return runHaxeCode([[
     game.]] .. char .. [[.animOffsets.exists(']] .. anim .. [[');
   ]])
end