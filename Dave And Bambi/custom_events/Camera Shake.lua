function onEvent(name, value1, value2)
   if name == 'Camera Shake' then
      local args = stringSplit(value2, ',');
      cameraShake(value1, tonumber(args[1]), tonumber(args[2]));
   end
end