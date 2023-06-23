local objectTag = 'bfwhite'
local offsetTool = true;
local addValue = 1;

if offsetTool then
   function onUpdate()
      if getPropertyFromClass('flixel.FlxG', 'keys.pressed.G') then
         setProperty(objectTag .. '.x', getProperty(objectTag .. '.x') - addValue);
      elseif getPropertyFromClass('flixel.FlxG', 'keys.pressed.H') then
         setProperty(objectTag .. '.y', getProperty(objectTag .. '.y') + addValue);
      elseif getPropertyFromClass('flixel.FlxG', 'keys.pressed.Y') then
         setProperty(objectTag .. '.y', getProperty(objectTag .. '.y') - addValue);
      elseif getPropertyFromClass('flixel.FlxG', 'keys.pressed.J') then
         setProperty(objectTag .. '.x', getProperty(objectTag .. '.x') + addValue);
      end
   
      if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ONE') then
         objectTag = 'dad';
      elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.TWO') then
         objectTag = 'gf';
      elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.THREE') then
         objectTag = 'boyfriend';
      end
   
      if keyJustPressed('space') then
	     debugPrint(objectTag .. ' X: ' .. getProperty(objectTag .. '.x'), ' ' .. objectTag .. ' Y: ' .. getProperty(objectTag .. '.y'))
		 setProperty(objectTag .. '.visible', not getProperty(objectTag .. '.visible'));
	  end
   end
end

function setXYPosition(tag, x, y)
   setProperty(tag .. '.x', x);
   
   setProperty(tag .. '.y', y);
end