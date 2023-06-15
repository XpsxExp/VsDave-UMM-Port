-- Script made by XpsxExp.

-- Dad variables.
local dadCamX = 0;
local dadCamY = 0;
local dadCamPos = {};
local dadCamOffset = {};
local dadCurAnim = '';
-- Gf variables.
local gfCamX = 0;
local gfCamY = 0;
local gfCamPos = {};
local gfCamOffset = {};
local gfCurAnim = '';
-- Bf variables.
local bfCamX = 0;
local bfCamY = 0;
local bfCamPos = {};
local bfCamOffset = {};
local bfCurAnim = '';
-- Other
local canFollow = true;
local moveValue = 20;
local cameraDebug = false;

function onCreatePost()
   -- If you wan't to get these values for other stuff.
   setPropertyFromClass('flixel.FlxG', 'save.data.dadCamX', dadCamX);
   setPropertyFromClass('flixel.FlxG', 'save.data.dadCamY', dadCamY);
   
   setPropertyFromClass('flixel.FlxG', 'save.data.gfCamX', gfCamX);
   setPropertyFromClass('flixel.FlxG', 'save.data.gfCamY', gfCamY);
   
   setPropertyFromClass('flixel.FlxG', 'save.data.bfCamX', bfCamX);
   setPropertyFromClass('flixel.FlxG', 'save.data.bfCamY', bfCamY);
end

function noteMissPress(direction)
   if mustHitSection and canFollow then
      triggerEvent('Camera Follow Pos', bfCamX, bfCamY);
   end
end

function noteMiss(id, direction, noteType, isSustainNote)
   if mustHitSection and canFollow then
      triggerEvent('Camera Follow Pos', bfCamX, bfCamY);
   end
end

function onUpdate()
   -- Debug stuff.
   if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.T') and not canFollow then
      canFollow = true;
	  debugPrint('Camera is now following');
   elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.T') and canFollow then
      canFollow = false;
	  triggerEvent('Camera Follow Pos', nil, nil);
	  debugPrint('Camera is now not following');
   end
   
   if getPropertyFromClass('flixel.FlxG', 'keys.pressed.O') then
      moveValue = moveValue - 1;
   elseif getPropertyFromClass('flixel.FlxG', 'keys.pressed.P') then
      moveValue = moveValue + 1;
   end
   
   -- Dad stuff.
   dadCamOffset = getProperty('opponentCameraOffset');
   dadCamPos = getProperty('dad.cameraPosition')
   
   if getProperty('dad.curCharacter') == 'senpai' and songName == 'Broken-Heart-Corrosion' then --all the other scripts break the fucking camera im too tired to even bother anymore
      dadCamX = 372;
      dadCamY = 422;
   else
      dadCamX = getMidpointX('dad') + 150 + dadCamPos[1] + dadCamOffset[1];
      dadCamY = getMidpointY('dad') - 100 + dadCamPos[2] + dadCamOffset[2];
   end
   -- GF stuff.
   gfCamOffset = getProperty('girlfriendCameraOffset');
   gfCamPos = getProperty('gf.cameraPosition');
   
   gfCamX = getMidpointX('gf') + gfCamPos[1] + gfCamOffset[1];
   gfCamY = getMidpointY('gf') + gfCamPos[2] + gfCamOffset[2];
   -- BF stuff.
   bfCamOffset = getProperty('boyfriendCameraOffset');
   bfCamPos = getProperty('boyfriend.cameraPosition');
   
   bfCamX = getMidpointX('boyfriend') - 100 - bfCamPos[1] + bfCamOffset[1];
   bfCamY = getMidpointY('boyfriend') - 100 + bfCamPos[2] + bfCamOffset[2];

   -- Camera code.
   dadCurAnim = getProperty('dad.animation.curAnim.name');
   gfCurAnim = getProperty('gf.animation.curAnim.name');
   bfCurAnim = getProperty('boyfriend.animation.curAnim.name');
   
   if not mustHitSection and not gfSection and canFollow then
      if dadCurAnim == 'idle' or dadCurAnim == 'idle-loop' or dadCurAnim == 'danceLeft' or dadCurAnim == 'danceRight' then
         triggerEvent('Camera Follow Pos', dadCamX, dadCamY);
      elseif dadCurAnim == 'singLEFT' or dadCurAnim == 'singLEFT-loop' or dadCurAnim == 'singLEFT-alt' then
         triggerEvent('Camera Follow Pos', dadCamX - moveValue, dadCamY);
      elseif dadCurAnim == 'singDOWN' or dadCurAnim == 'singDOWN-loop' or dadCurAnim == 'singDOWN-alt' then
         triggerEvent('Camera Follow Pos', dadCamX, dadCamY + moveValue);
      elseif dadCurAnim == 'singUP' or dadCurAnim == 'singUP-loop' or dadCurAnim == 'singUP-alt' then
         triggerEvent('Camera Follow Pos', dadCamX, dadCamY - moveValue);
      elseif dadCurAnim == 'singRIGHT' or dadCurAnim == 'singRIGHT-loop' or dadCurAnim == 'singRIGHT-alt' then
         triggerEvent('Camera Follow Pos', dadCamX + moveValue, dadCamY);
	  else
         triggerEvent('Camera Follow Pos', dadCamX, dadCamY);	  
      end
   end
   
   if gfSection and canFollow then
      if gfCurAnim == 'idle' or gfCurAnim == 'idle-loop' or gfCurAnim == 'danceLeft' or gfCurAnim == 'danceRight' then
         triggerEvent('Camera Follow Pos', gfCamX, gfCamY);
      elseif gfCurAnim == 'singLEFT' or gfCurAnim == 'singLEFT-loop' or gfCurAnim == 'singLEFT-alt' then
         triggerEvent('Camera Follow Pos', gfCamX - moveValue, gfCamY);
      elseif gfCurAnim == 'singDOWN' or gfCurAnim == 'singDOWN-loop' or gfCurAnim == 'singDOWN-alt' then
         triggerEvent('Camera Follow Pos', gfCamX, gfCamY + moveValue);
      elseif gfCurAnim == 'singUP' or gfCurAnim == 'singUP-loop' or gfCurAnim == 'singUP-alt' then
         triggerEvent('Camera Follow Pos', gfCamX, gfCamY - moveValue);
      elseif gfCurAnim == 'singRIGHT' or gfCurAnim == 'singRIGHT-loop' or gfCurAnim == 'singRIGHT-alt' then
         triggerEvent('Camera Follow Pos', gfCamX + moveValue, gfCamY);
      else
	     triggerEvent('Camera Follow Pos', gfCamX, gfCamY);
      end
   end
   
   if mustHitSection and not gfSection and canFollow then
      if bfCurAnim == 'idle' or bfCurAnim == 'idle-loop' or bfCurAnim == 'danceLeft' or bfCurAnim == 'danceRight' then
	     triggerEvent('Camera Follow Pos', bfCamX, bfCamY);
	  elseif bfCurAnim == 'singLEFT' or bfCurAnim == 'singLEFT-loop' or bfCurAnim == 'singLEFT-alt' then
	     triggerEvent('Camera Follow Pos', bfCamX - moveValue, bfCamY);	  
	  elseif bfCurAnim == 'singDOWN' or bfCurAnim == 'singDOWN-loop' or bfCurAnim == 'singDOWN-alt' then
	     triggerEvent('Camera Follow Pos', bfCamX, bfCamY + moveValue);
	  elseif bfCurAnim == 'singUP' or bfCurAnim == 'singUP-loop' or bfCurAnim == 'singUP-alt' then
	     triggerEvent('Camera Follow Pos', bfCamX, bfCamY - moveValue);
	  elseif bfCurAnim == 'singRIGHT' or bfCurAnim == 'singRIGHT-loop' or bfCurAnim == 'singRIGHT-alt' then
	     triggerEvent('Camera Follow Pos', bfCamX + moveValue, bfCamY);
	  else
	     triggerEvent('Camera Follow Pos', bfCamX, bfCamY);
	  end
   end
end

function onEvent(name, value1)
   local boolConvert = {['true'] = true, ['false'] = false};
   if name == 'Turn Off Cam Follow' then
      canFollow = boolConvert[value1];
   end
end