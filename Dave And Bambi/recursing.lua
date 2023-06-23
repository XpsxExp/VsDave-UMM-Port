local isRecursed = false;
local preRecursedHealth = 0;
local letterMissCount = 0;
local timeLeft = 0;
local timeGiven = 0;
local notesLeft = 0;
local notesCount = 0;
local camAngle = 0;
local angleMult = 1;
local recursedXs = {};
local initializedShader = false;
local rotateCamToRight = true;
local shaderObjects = {'fakeP1', 'boyfriend'};
local recursedUI = {};
local originalBF = '';

function onCreate()
   addHaxeLibrary('FlxStringUtil', 'flixel.util');
   precacheImage('characters/recursed/Recursed_BF');
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
   if isRecursed and not isSustainNote then
      notesCount = notesCount + 1;
	  setTextString('notesLeftTxt', notesCount .. '/' .. notesLeft);
	  
	  if notesCount >= notesLeft then
	     removeRecursed();
	  end
   end
end

function noteMiss(id, noteData, noteType, isSustainNote)
   if not isRecursed and noteType == 'Letter Note' then
      letterMissCount = letterMissCount + 1;
	  makeLuaSprite('recursedX' .. letterMissCount, 'recursed/recursedX');
	  setProperty('recursedX' .. letterMissCount .. '.x', (getGraphicMidpointX('boyfriend')) + getRandomFloat(-getProperty('recursedX' .. letterMissCount .. '.width'), getProperty('recursedX' .. letterMissCount .. '.width')));
      setProperty('recursedX' .. letterMissCount .. '.y', (getGraphicMidpointY('boyfriend')) + getRandomFloat(-getProperty('recursedX' .. letterMissCount .. '.height'), getProperty('recursedX' .. letterMissCount .. '.height')) / 2);
	  
	  setProperty('recursedX' .. letterMissCount .. '.angle', getRandomFloat(0, 180));
	  
	  addLuaSprite('recursedX' .. letterMissCount, true);
	  table.insert(recursedXs, 'recursedX' .. letterMissCount);
	  
	  cameraShake('camGame', 0.012 * letterMissCount, 0.5, true);
	  if (letterMissCount > getRandomInt(2, 5)) then
	     turnRecursed();
	  end
   elseif isRecursed then
      cameraShake('camGame', 0.02, 0.5, true);
	  timeLeft = timeLeft - 5;
   end
end

function turnRecursed()
   isRecursed = true;
   preRecursedHealth = getHealth();
   letterMissCount = 0;
   
   for i = 1, #recursedXs do
      removeLuaSprite(recursedXs[i], true);
   end
   cameraFlash('camGame', 1, 'FFFFFF', true);
   
   if getProperty('boyfriend.curCharacter') == 'bf' then
      originalBF = getProperty('boyfriend.curCharacter');
      triggerEvent('Change Character', 'bf', getProperty('boyfriend.curCharacter') .. '-recursed');
   else
      if not initializedShader then
	     initializedShader = true;
		 initLuaShader('desaturation');
	  end
	  for i = 1, #shaderObjects do
	     setSpriteShader(shaderObjects[i], 'desaturation');
	  end
   end
   addRecursedUI();
end

function addRecursedUI()
   timeGiven = math.floor(getRandomFloat(25, 35));
   timeLeft = timeGiven;
   notesLeft = getRandomInt(65, 100);
   notesCount = 0;
   
   local yOffset = getProperty('healthBar.y') - 50;
   
   makeLuaText('notesLeftTxt', notesCount .. '/' .. notesLeft, 0, (screenWidth / 2) - 200, yOffset);
   setTextAlignment('notesLeftTxt', 'center');
   setProperty('notesLeftTxt.borderSize', 2.5);
   setTextFont('notesLeftTxt', 'vcr.ttf');
   setTextSize('notesLeftTxt', 30);
   addLuaText('notesLeftTxt');
   table.insert(recursedUI, 'notesLeftTxt');
   
   makeLuaSprite('noteIcon', 'recursed/noteIcon', getProperty('notesLeftTxt.x') + getProperty('notesLeftTxt.width') + 10, getProperty('notesLeftTxt.y') - 15);
   setGraphicSize('noteIcon', math.floor(getProperty('noteIcon.width') * 0.4), 0);
   setObjectCamera('noteIcon', 'camHUD');
   addLuaSprite('noteIcon');
   table.insert(recursedUI, 'noteIcon');
   
   makeLuaText('timeLeftTxt', getFormattedTime(timeLeft), 0, (screenWidth / 2) + 100, yOffset);
   setTextAlignment('timeLeftTxt', 'center');
   setProperty('timeLeftTxt.borderSize', 2.5);
   setTextFont('timeLeftTxt', 'vcr.ttf');
   setTextSize('timeLeftTxt', 30);
   addLuaText('timeLeftTxt');
   table.insert(recursedUI, 'timeLeftTxt');
   
   makeLuaSprite('timerIcon', 'recursed/timerIcon', getProperty('timeLeftTxt.x') + getProperty('timeLeftTxt.width') + 20, getProperty('timeLeftTxt.y') - 7);
   setGraphicSize('timerIcon', math.floor(getProperty('timerIcon.width') * 0.4), 0);
   setObjectCamera('timerIcon', 'camHUD');
   addLuaSprite('timerIcon');
   table.insert(recursedUI, 'timerIcon');
   
   for i = 1, #recursedUI do
      setObjectOrder(recursedUI[i], getObjectOrder('fakeP2') + 1);
   end
   --Im not sure if not cleaning the tables is going to be an issue but who cares. It doesn't fucking work anyways.
end

function removeRecursed()
   cameraFlash('camGame', 1, 'FFFFFF', true);
   setProperty('camGame.angle', 0);
   setProperty('camHUD.angle', 0);
   
   isRecursed = false;
   for i = 1, #recursedUI do
      if not stringEndsWith(recursedUI[i], 'Txt') then
         removeLuaSprite(recursedUI[i]);
      else
	     removeLuaText(recursedUI[i]);
	  end
   end
   
   removeSpriteShader('boyfriend');
   triggerEvent('Change Character', 'bf', originalBF);
   setHealth(preRecursedHealth);
end

function onUpdate(elapsed)
   if isRecursed and initializedShader then
	  for i = 1, #shaderObjects do
	     setShaderFloat(shaderObjects[i], 'iTime', os.clock());
	  end
   end
   
   if isRecursed then
      timeLeft = timeLeft - elapsed;
	  
	  if luaTextExists('timeLeftTxt') then
	     setTextString('timeLeftTxt', getFormattedTime(math.floor(timeLeft)));
	  end
	  
	  camAngle = camAngle + elapsed * 5 * angleMult;
	  setProperty('camGame.angle', camAngle);
	  setProperty('camHUD.angle', camAngle);
	  
	  if camAngle > 8 then
	     angleMult = -1;
	  elseif camAngle < -8 then
	     angleMult = 1;
	  end
	  
	  setHealth(math.lerp(0, 2, timeLeft / timeGiven));
   end
end

function getFormattedTime(secondsTotal)
   return runHaxeCode([[ FlxStringUtil.formatTime(]] .. secondsTotal .. [[, false); ]])
end

function math.lerp(a, b, ratio)
   return a + ratio * (b - a);
end