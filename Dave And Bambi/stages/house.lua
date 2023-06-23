local stageTags = {'stageHills', 'grassbg', 'gate', 'stageFront'};

local songStageVar = {
   ['house'] = 'house',
   ['insanity'] = 'house',
   ['supernovae'] = 'house',
   ['warmup'] = 'house',
   ['glitch'] = 'house-night',
   ['memory'] = 'house-night',
   ['bonus-song'] = 'house-night';
   ['secret'] = 'house-sunset'
};
local stageVariant = '';
--Asset vars.
local assetType = '';
local skyType = '';
function onCreatePost()
   luaDebugMode = true;
   stageVariant = songStageVar[string.lower(songName)];
   --Stage variant.
   if stageVariant == 'house' then
      skyType = 'sky';
   elseif stageVariant == 'house-night' then
      skyType = 'sky_night';
      assetType = 'night/';
   elseif stageVariant == 'house-sunset' then
      skyType = 'sky_sunset';
   end
   
   makeBackgroundSprite('bg', 'backgrounds/shared/' .. skyType, -600, -300, 0.6, 0.6);
   
   makeBackgroundSprite('stageHills', 'backgrounds/dave-house/' .. assetType .. 'hills', -834, -159, 0.7, 0.7);
   
   makeBackgroundSprite('grassbg', 'backgrounds/dave-house/' .. assetType .. 'grass bg', -1205, 580, 1, 1);
   
   makeBackgroundSprite('gate', 'backgrounds/dave-house/' .. assetType .. 'gate', -755, 250, 1, 1);
   
   makeBackgroundSprite('stageFront', 'backgrounds/dave-house/' .. assetType .. 'grass', -832, 505, 1, 1);
   
   for i = 1, #stageTags do
      setProperty(stageTags[i] .. '.color', getColorFromHex(getBackgroundColor(stageVariant)));
   end
   
   setProperty('dad.color', getColorFromHex(getBackgroundColor(stageVariant)));
   setProperty('gf.color', getColorFromHex(getBackgroundColor(stageVariant)));
   setProperty('boyfriend.color', getColorFromHex(getBackgroundColor(stageVariant)));
end

function makeBackgroundSprite(tag, path, x, y, xScroll, yScroll)
   makeLuaSprite(tag, path, x, y);
   setScrollFactor(tag, xScroll, yScroll);
   addLuaSprite(tag);
end

function setPosition(tag, x, y)
   runHaxeCode([[
     game.]] .. tag .. [[.setPosition(]] .. x .. [[, ]] .. y .. [[);
   ]]);
end

function getBackgroundColor(variant)
   local backgroundColors = {
      ['house-night'] = '0xFF878787';
      ['house-sunset'] = '0xFFFF8FB2';
	  ['house'] = '0xFFFFFFFF';
   }
   return backgroundColors[variant];
end