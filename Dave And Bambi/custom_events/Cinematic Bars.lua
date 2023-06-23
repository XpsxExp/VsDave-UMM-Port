function onEvent(name, value1, value2)
   if name == 'Cinematic Bars' then
      local curDefaultZoom = getProperty('defaultCamZoom');
      makeLuaSprite('upBar'); makeGraphic('upBar', math.floor(screenWidth * ((1 / curDefaultZoom) * 2)), math.floor(screenHeight / 2), '000000'); setObjectCamera('upBar', 'camHUD'); screenCenter('upBar');
      makeLuaSprite('downBar'); makeGraphic('downBar', math.floor(screenWidth * ((1 / curDefaultZoom) * 2)), math.floor(screenHeight / 2), '000000'); setObjectCamera('downBar', 'camHUD'); screenCenter('downBar');
      setProperty('upBar.y', getProperty('upBar.y') - 2000); setProperty('downBar.y', getProperty('downBar.y') + 2000);
      addLuaSprite('upBar'); addLuaSprite('downBar');
   
      local displayTime = tonumber(value1);
	  local barCloseness = tonumber(value2);
	  
	  doTweenY('upBarMove', 'upBar', (screenHeight - getProperty('upBar.height')) / 2 - barCloseness, (crochet / 1000) / 2, 'expoInOut')
	  runTimer('upReturnTime', displayTime);
	  
	  doTweenY('downBarMove', 'downBar', (screenHeight - getProperty('downBar.height')) / 2 + barCloseness, (crochet / 1000) / 2, 'expoInOut')
	  runTimer('downReturnTime', displayTime);
   end
end

function onTimerCompleted(tag)
   if tag == 'upReturnTime' then
      doTweenY('upBarMoveDown', 'upBar', getProperty('upBar.y') - 2000, (crochet / 1000) / 2, 'expoIn');
   elseif tag == 'downReturnTime' then
      doTweenY('downBarMoveDown', 'downBar', getProperty('downBar.y') + 2000, (crochet / 1000) / 2, 'expoIn');
   end
end

function onTweenCompleted(tag)
   if tag == 'upBarMoveDown' or tag == 'downBarMoveDown' then
      removeLuaSprite(string.gsub(tag, 'MoveDown', ''), true);
   end
end