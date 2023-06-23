local toY = 0;
local toX = 0;
local elapsedTime = 0;

function onCreatePost()
   addLuaScript('recursing');
end

function onUpdate(elapsed)
   if getProperty('dad.curCharacter') == 'recurser' then
      elapsedTime = elapsedTime + elapsed;
	  
      toY = 100 + -math.sin((elapsedTime) * 2) * 300;
	  toX = -400 - math.cos((elapsedTime)) * 200;
	  
	  setProperty('dad.x', getProperty('dad.x') + (toX - getProperty('dad.x')));
	  setProperty('dad.y', getProperty('dad.y') + (toY - getProperty('dad.y')));
   end
end