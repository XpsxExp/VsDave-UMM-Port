function onCreate()
   makeLuaSprite('darken');
   makeGraphic('darken', screenWidth * 2, screenHeight * 2, '000000');
   screenCenter('darken');
   addLuaSprite('darken',true);
   setProperty('darken.alpha', 0);
end

function onEvent(name, value1, value2)
   if name == 'Darken Screen' then
      cancelTween('darkenAlpha');
	  doTweenAlpha('darkenAlpha', 'darken', tonumber(value1), tonumber(value2));
   end
end