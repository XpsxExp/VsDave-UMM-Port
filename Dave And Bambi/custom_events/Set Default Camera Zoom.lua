function onEvent(name, value1, value2)
   if name == 'Set Default Camera Zoom' then
      local type = value2;
	  if value2 == '' then type = 'set' end
      if type == 'set' then
         setProperty('defaultCamZoom', tonumber(value1));
	  elseif type == 'add' then
	     setProperty('defaultCamZoom', getProperty('defaultCamZoom') + tonumber(value1));
	  elseif type == 'subtract' then
	     setProperty('defaultCamZoom', getProperty('defaultCamZoom') - tonumber(value1))
	  end
   end
end