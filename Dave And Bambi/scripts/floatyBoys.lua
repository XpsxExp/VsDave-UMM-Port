local floatyBoys = {'dave-angey', 'dave-angey-festival', 'bambi-3d', 'expunged', 'bambi-unfair', 'exbungo', 'dave-festival-3d', 'dave-3d-recursed', 'bf-3d'};
local theCurrentFloatyBoys = {};
local canFloat = false;
local elapsedTime = 0;

function onCreatePost()
   if table.contains(floatyBoys, getProperty('dad.curCharacter')) then
      table.insert(theCurrentFloatyBoys, 'dad');
	  canFloat = true;
   elseif table.contains(floatyBoys, getProperty('gf.curCharacter')) then
      table.insert(theCurrentFloatyBoys, 'gf');
	  canFloat = true;
   elseif table.contains(floatyBoys, getProperty('boyfriend.curCharacter')) then
      table.insert(theCurrentFloatyBoys, 'boyfriend');
	  canFloat = true;
   end
end

function onUpdate(elapsed)
   if canFloat then
      elapsedTime = elapsedTime + elapsed;
      for i = 1, #theCurrentFloatyBoys do
	     setProperty(theCurrentFloatyBoys[i] .. '.y', getProperty(theCurrentFloatyBoys[i] .. '.y') + (math.sin(elapsedTime) * 0.2));
	  end
   end
end

function onEvent(name)
   if name == 'Change Character' then
      if table.contains(floatyBoys, getProperty('dad.curCharacter')) then
         table.insert(theCurrentFloatyBoys, 'dad');
	     canFloat = true;
      elseif table.contains(floatyBoys, getProperty('gf.curCharacter')) then
         table.insert(theCurrentFloatyBoys, 'gf');
	     canFloat = true;
      elseif table.contains(floatyBoys, getProperty('boyfriend.curCharacter')) then
         table.insert(theCurrentFloatyBoys, 'boyfriend');
	     canFloat = true;
	  else
	     canFloat = false;
      end
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