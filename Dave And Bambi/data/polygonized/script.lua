local stageTags = {'stageHills', 'grassbg', 'gate', 'stageFront'};
local characterTags = {'boyfriend', 'dad', 'gf'};
local stageVariant = 'house-night';

local assetType = 'night/';
local skyType = 'sky_night';
function onCreatePost()
   makeBackgroundSprite('bg', 'backgrounds/shared/' .. skyType, -600, -300, 0.6, 0.6);
   
   makeBackgroundSprite('stageHills', 'backgrounds/dave-house/' .. assetType .. 'hills', -834, -159, 0.7, 0.7);
   
   makeBackgroundSprite('grassbg', 'backgrounds/dave-house/' .. assetType .. 'grass bg', -1205, 580, 1, 1);
   
   makeBackgroundSprite('gate', 'backgrounds/dave-house/' .. assetType .. 'gate', -755, 250, 1, 1);
   
   makeBackgroundSprite('stageFront', 'backgrounds/dave-house/' .. assetType .. 'grass', -832, 505, 1, 1);
   
   for i = 1, #stageTags do
      setProperty(stageTags[i] .. '.alpha', 0);
	  setProperty(stageTags[i] .. '.color', getColorFromHex(getBackgroundColor(stageVariant)));
   end
   setProperty('bg.alpha', 0);
end

function onEvent(name)
   if name == 'Polygonized End' then
      setProperty('defaultCamZoom', 0.8);
	  playAnim('boyfriend', 'hey', true);
	  playAnim('gf', 'cheer', true);
	  setProperty('boyfriend.skipDance', true); setProperty('gf.skipDance', true);
	  callScript('floatyBoys', 'stopFloating');
	  setPosition('dad', 50, 110);
      setPosition('gf', 300, -60);
      setPosition('boyfriend', 843, 270);
	  cameraFlash('camGame', 'FFFFFF', 0.25);
	  
	  for i = 1, #characterTags do
	     doTweenColor('color' .. characterTags[i], characterTags[i], '0xFF878787', 0.6);
	  end
	  
	  doTweenAlpha('fbg', 'bg', 1, 1);
	  doTweenAlpha('shbg', 'stageHills', 1, 1);
	  doTweenAlpha('gbg', 'grassbg', 1, 1);
	  doTweenAlpha('gtbg', 'gate', 1, 1);
	  doTweenAlpha('sfbg', 'stageFront', 1, 1);
	  doTweenAlpha('f3dBG', 'bg3D', 0, 1);
	  
	  --MOVE MFFFF
	  runHaxeCode([[
        game.moveCameraSection();
      ]])
   end
end

function setPosition(tag, x, y)
   runHaxeCode([[
     game.]] .. tag .. [[.setPosition(]] .. x .. [[, ]] .. y .. [[);
   ]]);
end

function makeBackgroundSprite(tag, path, x, y, xScroll, yScroll)
   makeLuaSprite(tag, path, x, y);
   setScrollFactor(tag, xScroll, yScroll);
   addLuaSprite(tag);
end

function getBackgroundColor(variant)
   local backgroundColors = {
      ['house-night'] = '0xFF878787';
      ['house-sunset'] = '0xFFFF8FB2';
	  ['house'] = '0xFFFFFFFF';
   }
   return backgroundColors[variant];
end