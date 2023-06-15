local floatyBoys = {'dave-angey', 'bambi-3d', 'expunged', 'bambi-unfair', 'exbungo', 'dave-festival-3d', 'dave-3d-recursed', 'bf-3d'};
local canFloat = true;
local elapsedTime = 0;

function onUpdate(elapsed)
   elapsedTime = elapsedTime + elapsed;
   if table.contains(floatyBoys, dadName) and canFloat then
      setProperty('dad.y', getProperty('dad.y') + (math.sin(elapsedTime) * 0.2));
   elseif table.contains(floatyBoys, gfName) and canFloat then
      setProperty('gf.y', getProperty('gf.y') + (math.sin(elapsedTime) * 0.2));
   elseif table.contains(floatyBoys, boyfriendName) and canFloat then
      setProperty('boyfriend.y', getProperty('boyfriend.y') + (math.sin(elapsedTime) * 0.2));
   end
end

function table.contains(table, element)
   for _, value in pairs(table) do
	  if value == element then
		 return true
	  end
   end
   return false
end

function stopFloating()
   canFloat = false;
end