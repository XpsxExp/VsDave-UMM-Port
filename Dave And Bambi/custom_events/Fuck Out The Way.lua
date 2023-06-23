local updatePosition = false;
local comeIn = '';
local flyOut = '';
local iconX = 0;
local iconY = 0;

function onCreate()
   luaDebugMode = true;
end

function onEvent(name, value1, value2)
   if name == 'Fuck Out The Way' and not getProperty('dad.Custom') then
      comeIn = stringSplit(value1, ',');
	  flyOut = value2;
	  
	  callScript('scripts/daveHUD', 'makeIcon', {'goingIn', -100, getProperty('fakeP2.y'), comeIn[1], false});
	  callScript('scripts/daveHUD', 'makeIcon', {'flingedIcon', getProperty('fakeP2.x'), getProperty('fakeP2.y'), flyOut, false});
	  setProperty('goingIn.animation.curAnim.curFrame', 0);
	  setProperty('flingedIcon.animation.curAnim.curFrame', 1);
	  
	  runHaxeCode([[
	    FlxTween.linearMotion(game.getLuaObject('goingIn'), -100, game.getLuaObject('goingIn').y, game.getLuaObject('fakeP2').x, game.getLuaObject('fakeP2').y, 0.3, true, {ease: FlxEase.expoInOut});
	  ]])
	  runTimer('flingIcon', 0.3);
   end
end

function onUpdate(elapsed)
   if updatePosition then
      iconX = iconX * 0.98;
	  iconY = iconY + elapsed * 6;
	  
	  if luaSpriteExists('flingedIcon') then
	     setProperty('flingedIcon.x', getProperty('flingedIcon.x') + iconX);
		 setProperty('flingedIcon.y', getProperty('flingedIcon.y') + iconY);
		 
		 if getProperty('flingedIcon.y') > 3000 then
		    updatePosition = false;
			removeLuaSprite('flingedIcon', true);
		 end
	  end
   end
end

function onTimerCompleted(tag)
   if tag == 'flingIcon' then
      updatePosition = true;
	  iconX = -5;
	  iconY = -5;
	  
	  triggerEvent('Change Character', 'dad', comeIn[2]);
	  removeLuaSprite('goingIn', true);
   end
end