function onEvent(name, value1, value2)
   if name == 'Camera Flash' then
	  local color = value1; local duration = value2;
	  if value1 == '' then color = 'FFFFFF'; end if value2 == '' then duration = 1; end
      cameraFlash('camGame', color, duration, true);
   end
end