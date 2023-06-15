local crazyZooming = false;

function onEvent(name, value1)
   if name == 'Crazy Zooming' then
      if getPropertyFromClass('ClientPrefs', 'camZooms') then
         setPropertyFromClass('ClientPrefs', 'camZooms', false);
	     crazyZooming = true;
      elseif not getPropertyFromClass('ClientPrefs', 'camZooms') then
         setPropertyFromClass('ClientPrefs', 'camZooms', true);
	     crazyZooming = false;
      end
   end
end

function onBeatHit()
   if crazyZooming then
      setProperty('camGame.zoom', getProperty('camGame.zoom') + 0.015);
	  setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.03);
   end
end