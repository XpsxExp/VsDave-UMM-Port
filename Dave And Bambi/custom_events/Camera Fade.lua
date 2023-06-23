function onCreate()
   luaDebugMode = true;
end

function onEvent(name, value1, value2)
   if name == 'Camera Fade' then
      addHaxeLibrary('FlxG', 'flixel');
      local args = stringSplit(value2, ',');
	  local toBool = {['true'] = true, ['false'] = false};
      runHaxeCode([[
	    FlxG.camera.fade(]] .. getColorFromHex(args[1]) .. [[, ]] .. tonumber(args[2]) .. [[, ]] .. tostring(toBool[args[3]]) .. [[);
	  ]])
   end
end