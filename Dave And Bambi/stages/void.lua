local shaderName = 'pulseEffect';
local shakeCam = false;
local bgNamesArray = {
   ['polygonized'] = 'red-void',
   ['cheating'] = 'green-void',
   ['unfairness'] = 'glitchy-void'
}
local bgName = '';

function onCreatePost()
   luaDebugMode = true;
   bgName = bgNamesArray[string.lower(songName)];
   makeBackgroundSprite('bg3D', nil, -600, -200, 1, 1);
   
   initLuaShader('glitchEffect');
   setSpriteShader('bg3D', 'glitchEffect');
   setShaderFloat('bg3D', 'uWaveAmplitude', 0.1); setShaderFloat('bg3D', 'uFrequency', 5); setShaderFloat('bg3D', 'uSpeed', 2); setShaderBool('bg3D', 'uEnabled', true);
   
   if string.lower(songName) == 'polygonized' then
      initLuaShader('pulseEffect');
      makeLuaSprite('shaderHolder');
	  setSpriteShader('shaderHolder', 'pulseEffect');
	  setShaderFloat('shaderHolder', 'uampmul', 0); setShaderFloat('shaderHolder', 'uWaveAmplitude', 0.5); setShaderFloat('shaderHolder', 'uSpeed', 1); setShaderFloat('shaderHolder', 'uFrequency', 1); 
	  addHaxeLibrary('ShaderFilter', 'openfl.filters');
      runHaxeCode([[
        game.camGame.setFilters([new ShaderFilter(game.getLuaObject('shaderHolder').shader)]);
      ]])
   end
   
   if bgName == 'red-void' then
      setProperty('defaultCamZoom', 0.8);
	  loadGraphic('bg3D', 'backgrounds/void/redsky');
   elseif bgName == 'green-void' then
      loadGraphic('bg3D', 'backgrounds/void/cheater');
	  setProperty('bg3D.x', -700); setProperty('bg3D.y', -350);
	  setGraphicSize('bg3D', math.floor(getProperty('bg3D.width') * 2), 0, false);
   elseif bgName == 'glitchy-void' then
      loadGraphic('bg3D', 'backgrounds/void/scarybg');
	  setProperty('bg3D.x', 0); setProperty('bg3D.y', 200);
	  setGraphicSize('bg3D', math.floor(getProperty('bg3D.width') * 3), 0, false);
   end
end

function onUpdate(elapsed)
   setShaderFloat('bg3D', 'uTime', os.clock());
   if shakeCam then cameraShake('camGame', 0.010 + elapsed, 0.010 + elapsed); setShaderFloat('shaderHolder', 'uampmul', 1); else setShaderFloat('shaderHolder', 'uampmul', getShaderFloat('shaderHolder', 'uampmul') - (elapsed / 2)); end 
   if string.lower(songName) == 'polygonized' then
      setShaderFloat('shaderHolder', 'uTime', os.clock());
   end
end

function onEvent(name)
   if name == 'Polygonized Thing' then
      shakeCam = not shakeCam;
   end
end

function makeBackgroundSprite(tag, path, x, y, xScroll, yScroll)
   makeLuaSprite(tag, path, x, y);
   setScrollFactor(tag, xScroll, yScroll);
   addLuaSprite(tag);
end