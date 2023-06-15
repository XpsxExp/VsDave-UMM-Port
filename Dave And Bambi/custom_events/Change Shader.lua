local shaderInitialized = false;

function onCreate()
   makeLuaSprite('shaderHolder');
end

function onEvent(name, value1, value2)
   if name == 'Change Shader' then
      if value1 == 'null' then
		 addHaxeLibrary('ShaderFilter', 'openfl.filters');
		 runHaxeCode([[
		   game.]] .. value2 .. [[.setFilters(null);
		 ]])
	  else
	     shaderInitialized = true;
		 initLuaShader(value1);
	     setSpriteShader('shaderHolder', value1);
		 
		 addHaxeLibrary('ShaderFilter', 'openfl.filters');
		 runHaxeCode([[
		   game.]] .. value2 .. [[.setFilters([new ShaderFilter(game.getLuaObject('shaderHolder').shader)]);
		 ]])
	  end
   end
end

function onUpdate()
   if shaderInitialized then
      setShaderFloat('shaderHolder', 'iTime', os.clock());
   end
end