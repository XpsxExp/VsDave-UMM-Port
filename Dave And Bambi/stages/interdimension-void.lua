local bgCharSpeed = 300;
local posOffset = 800;
local floatingChars = {};
local nimbiSprites = {'nimbiLand', 'nimbiSign'};
local elapsedTime = 0;

function onCreatePost()
   makeBackgroundSprite('bg3D', 'backgrounds/void/interdimensions/interdimensionVoid', -700, -350, 1, 1);
   setGraphicSize('bg3D', math.floor(getProperty('bg3D.width') * 1.75), 0, false);

   initLuaShader('glitchEffect'); setSpriteShader('bg3D', 'glitchEffect'); setShaderFloat('bg3D', 'uWaveAmplitude', 0.1); setShaderFloat('bg3D', 'uFrequency', 5); setShaderFloat('bg3D', 'uSpeed', 2); setShaderBool('bg3D', 'uEnabled', true);
   
   --Floating characters code.
   local direction = {'left', 'right'};
   floatingChars = {
      --What do you do when you can't make classes? Tables!
      --Tag, Direction, Random speed, Angle change amount, Left position check, Right position check, Direction mult.
      {'ball', direction[getRandomInt(1, 2)], getRandomFloat(1, 5), getRandomFloat(100, 200), 0, 0, 1},
	  {'bimpe', direction[getRandomInt(1, 2)], getRandomFloat(1, 5), getRandomFloat(100, 200), 0, 0, 1},
	  {'maldo', direction[getRandomInt(1, 2)], getRandomFloat(1, 5), getRandomFloat(100, 200), 0, 0, 1},
	  {'memes kids', direction[getRandomInt(1, 2)], getRandomFloat(1, 5), getRandomFloat(100, 200), 0, 0, 1},
	  {'muko', direction[getRandomInt(1, 2)], getRandomFloat(1, 5), getRandomFloat(100, 200), 0, 0},
	  {'ruby man', direction[getRandomInt(1, 2)], getRandomFloat(1, 5), getRandomFloat(100, 200), 0, 0, 1},
	  {'tristan', direction[getRandomInt(1, 2)], getRandomFloat(1, 5), getRandomFloat(100, 200), 0, 0, 1},
	  {'bambi', direction[getRandomInt(1, 2)], getRandomFloat(1, 5), getRandomFloat(100, 200), 0, 0, 1}
   };
  
   for i = 1, #floatingChars do
      makeLuaSprite(floatingChars[i][1], 'backgrounds/festival/scaredCrowd/' .. floatingChars[i][1]);
	  addLuaSprite(floatingChars[i][1]);
	  
	  floatingChars[i][5] = (-getProperty(floatingChars[i][1] .. '.width') * (1 / getProperty('defaultCamZoom'))) - posOffset;
	  floatingChars[i][6] = (screenWidth * (1 / getProperty('defaultCamZoom'))) + getProperty(floatingChars[i][1] .. '.width') + posOffset;
	  
	  if floatingChars[i][2] == 'left' then
	     setProperty(floatingChars[i][1] .. '.x', floatingChars[i][6]);
	  elseif floatingChars[i][2] == 'right' then
	     setProperty(floatingChars[i][1] .. '.x', floatingChars[i][5]);
	  end
	  screenCenter(floatingChars[i][1], 'y');
   end
end

function onUpdate(elapsed)
   setShaderFloat('bg3D', 'uTime', os.clock());
   elapsedTime = elapsedTime + elapsed;
   
   --Floating characters code.
   --I hope this works first try.
   for i = 1, #floatingChars do
      if floatingChars[i][2] == 'left' then
	     floatingChars[i][7] = -1;
	  elseif floatingChars[i][2] == 'right' then
	     floatingChars[i][7] = 1;
	  end
	  
	  setProperty(floatingChars[i][1] .. '.x', getProperty(floatingChars[i][1] .. '.x') + bgCharSpeed * elapsed * floatingChars[i][7] * floatingChars[i][3]);
	  setProperty(floatingChars[i][1] .. '.y', getProperty(floatingChars[i][1] .. '.y') + (math.sin(elapsedTime) * 5));
	  
	  setProperty(floatingChars[i][1] .. '.angle', getProperty(floatingChars[i][1] .. '.angle') + floatingChars[i][4] * elapsed);
	  
	  if floatingChars[i][2] == 'left' then
	     if getProperty(floatingChars[i][1] .. '.x') < floatingChars[i][5] then
		    floatingChars[i][2] = 'right';
			floatingChars[i][4] = getRandomFloat(100, 200);
			setProperty(floatingChars[i][1] .. '.y', (screenHeight / 2) - screenHeight / 2);
		 end
	  elseif floatingChars[i][2] == 'right' then
	     if getProperty(floatingChars[i][1] .. '.x') > floatingChars[i][6] then
		    floatingChars[i][2] = 'left';
			floatingChars[i][4] = getRandomFloat(100, 200);
			setProperty(floatingChars[i][1] .. '.y', (screenHeight / 2) - screenHeight / 2);
		 end
	  end
   end
end

function onEvent(name, value1)
   if name == 'Change Interdimensional Background' then
      for i = 1, #nimbiSprites do
	     if luaSpriteExists(nimbiSprites[i]) then
		    removeLuaSprite(nimbiSprites[i], true);
		 end
	  end
	  
      local bgFunctions = {
	     ['interdimension-void'] = function()
	        loadGraphic('bg3D', 'backgrounds/void/interdimensions/interdimensionVoid');
		    setProperty('bg3D.x', -700); setProperty('bg3D.y', -350);
		    setGraphicSize('bg3D', math.floor(getProperty('bg3D.width') * 1.75), 0, false);
	     end,
		 ['spike-void'] = function()
	        loadGraphic('bg3D', 'backgrounds/void/interdimensions/spike');
		    setProperty('bg3D.x', -200); setProperty('bg3D.y', 0);
		    setGraphicSize('bg3D', math.floor(getProperty('bg3D.width') * 3), 0, false);
		 end,
		 ['darkspace'] = function()
	        loadGraphic('bg3D', 'backgrounds/void/interdimensions/darkSpace');
		    setProperty('bg3D.x', -200); setProperty('bg3D.y', 0);
		    setGraphicSize('bg3D', math.floor(getProperty('bg3D.width') * 2.75), 0, false);
		 end,
		 ['hexagon-void'] = function()
	        loadGraphic('bg3D', 'backgrounds/void/interdimensions/hexagon');
		    setProperty('bg3D.x', -200); setProperty('bg3D.y', 0);
		    setGraphicSize('bg3D', math.floor(getProperty('bg3D.width') * 3), 0, false);
		 end,
		 ['nimbi-void'] = function()
	        loadGraphic('bg3D', 'backgrounds/void/interdimensions/nimbi/nimbiVoid');
		    setProperty('bg3D.x', -200); setProperty('bg3D.y', 0);
		    setGraphicSize('bg3D', math.floor(getProperty('bg3D.width') * 2.75), 0, false);
			
			makeBackgroundSprite('nimbiLand', 'backgrounds/void/interdimensions/nimbi/nimbi_land', 200, 100, 1, 1);
			setGraphicSize('nimbiLand', math.floor(getProperty('nimbiLand.width') * 1.5), 0, false);
			setObjectOrder('nimbiLand', getObjectOrder('bg3D') + 1);
			
			makeBackgroundSprite('nimbiSign', 'backgrounds/void/interdimensions/nimbi/sign', 800, -73, 1, 1);
			setGraphicSize('nimbiSign', math.floor(getProperty('nimbiSign.width') * 0.2), 0, false);
			setObjectOrder('nimbiSign', getObjectOrder('nimbiLand') + 1);
		 end
	  };
	  bgFunctions[string.lower(value1)]();
   end
end

function makeBackgroundSprite(tag, path, x, y, xScroll, yScroll)
   makeLuaSprite(tag, path, x, y);
   setScrollFactor(tag, xScroll, yScroll);
   addLuaSprite(tag);
end