local stageTags = {'flatgrass', 'hills', 'farmHouse', 'grassLand', 'cornFence', 'cornFence2', 'cornBag', 'sign'};
local songStageVar = {
   ['indignancy'] = 'farm-night',
   ['splitathon'] = 'farm-night',
   ['mealie'] = 'farm-night',
   ['blocked'] = 'farm',
   ['corn-theft'] = 'farm',
   ['maze'] = 'farm',  
};
local stageVariant = '';
--Asset vars.
local skyType = '';

function onCreatePost()
   stageVariant = songStageVar[string.lower(songName)];
   if stageVariant == 'farm-night' then
      skyType = 'sky_night';
   elseif stageVariant == 'farm-sunset' then
      skyType = 'sky_sunset';
   else
      skyType = 'sky';
   end
   
   makeBackgroundSprite('bg', 'backgrounds/shared/' .. skyType, -600, -200, 0.6, 0.6);
   
   if string.lower(songName) == 'maze' then
      makeBackgroundSprite('sunsetBG', 'backgrounds/shared/sky_sunset', -600, -200, 0.6, 0.6);
	  setProperty('sunsetBG.alpha', 0);
	  
	  makeBackgroundSprite('nightBG', 'backgrounds/shared/sky_night', -600, -200, 0.6, 0.6);
	  setProperty('nightBG.alpha', 0);
   end
   
   makeBackgroundSprite('flatgrass', 'backgrounds/farm/gm_flatgrass', 350, 75, 0.65, 0.65);
   
   makeBackgroundSprite('hills', 'backgrounds/farm/orangey hills', -173, 100, 0.65, 0.65);
   
   makeBackgroundSprite('farmHouse', 'backgrounds/farm/funfarmhouse', 100, 125, 0.7, 0.7);
   
   makeBackgroundSprite('grassLand', 'backgrounds/farm/grass lands', -600, 500, 1, 1);
   
   makeBackgroundSprite('cornFence', 'backgrounds/farm/cornFence', -400, 200, 1, 1);
   
   makeBackgroundSprite('cornFence2', 'backgrounds/farm/cornFence2', 1100, 200, 1, 1);
   
   if string.lower(songName) == 'splitathon' then
      makeBackgroundSprite('picnicTowel', 'backgrounds/farm/picnic_towel_thing', 1050, 650, 1, 1);
	  table.insert(stageTags, 'picnicTowel');
   end
   
   if getRandomInt(0, 1000) == 0 then
      makeBackgroundSprite('cornBag', 'backgrounds/farm/popeye', 1200, 550, 1, 1);
   else
      makeBackgroundSprite('cornBag', 'backgrounds/farm/cornbag', 1200, 550, 1, 1);
   end
   
   makeBackgroundSprite('sign', 'backgrounds/farm/sign', 0, 350, 1, 1);
   
   for i = 1, #stageTags do
      setProperty(stageTags[i] .. '.color', getColorFromHex(getBackgroundColor(stageVariant)));
   end
   
   setProperty('dad.color', getColorFromHex(getBackgroundColor(stageVariant)));
   setProperty('gf.color', getColorFromHex(getBackgroundColor(stageVariant)));
   setProperty('boyfriend.color', getColorFromHex(getBackgroundColor(stageVariant)));
   setProperty('dad.x', getProperty('dad.x') + 200);
   setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup') + 1);
end

function makeBackgroundSprite(tag, path, x, y, xScroll, yScroll)
   makeLuaSprite(tag, path, x, y);
   setScrollFactor(tag, xScroll, yScroll);
   addLuaSprite(tag);
end

function getBackgroundColor(variant)
   local backgroundColors = {
      ['farm-night'] = '0xFF878787';
      ['farm-sunset'] = '0xFFFF8FB2';
	  ['farm'] = '0xFFFFFFFF';
   }
   return backgroundColors[variant];
end

function onEvent(name)
   if name == 'Change Character' then
      setProperty('dad.x', getProperty('dad.x') + 200);
      setProperty('dad.color', getColorFromHex(getBackgroundColor(stageVariant)));
   end
end