function onEvent(name, value1, value2)
   if name == 'Play Sound' then
      playSound(value1, tonumber(value2));
   end
end