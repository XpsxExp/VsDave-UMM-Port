function onCreatePost()
   makeBackgroundSprite('bg3D', nil, -600, -200, 1, 1);
   
   initLuaShader('glitchEffect');
   setSpriteShader('bg3D', 'glitchEffect');
   setShaderFloat('bg3D', 'uWaveAmplitude', 0.1); setShaderFloat('bg3D', 'uFrequency', 5); setShaderFloat('bg3D', 'uSpeed', 2); setShaderBool('bg3D', 'uEnabled', true);
   
   loadGraphic('bg3D', 'backgrounds/void/redsky'); setProperty('bg3D.alpha', 0);
end

function onUpdate()
   setShaderFloat('bg3D', 'uTime', os.clock());
   setShaderFloat('bg3D', 'uAlpha', getProperty('bg3D.alpha'));
end

function makeBackgroundSprite(tag, path, x, y, xScroll, yScroll)
   makeLuaSprite(tag, path, x, y);
   setScrollFactor(tag, xScroll, yScroll);
   addLuaSprite(tag);
end