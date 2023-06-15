local floatyBoys = {'dave-angey', 'bambi-3d', 'expunged', 'bambi-unfair', 'exbungo', 'dave-festival-3d', 'dave-3d-recursed', 'bf-3d'};
local is3D = false;

function onCreatePost()
   if table.contains(floatyBoys, dadName) then
      is3D = true;
	  
	  for i = 0, getProperty('opponentStrums.length') - 1 do
	     setPropertyFromGroup('opponentStrums', i, 'texture', '3DNOTE_assets');
	  end
	  
	  for i = 0, getProperty('unspawnNotes.length') - 1 do
	     if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
		    setPropertyFromGroup('unspawnNotes', i, 'texture', '3DNOTE_assets');
		 end
	  end
   end
end

function onSpawnNote(noteIndex, noteData, noteType, isSustainNote)
   if is3D and getPropertyFromGroup('notes', noteIndex, 'mustPress') and getPropertyFromGroup('notes', i, 'texture') == '' and (getPropertyFromGroup('notes', noteIndex, 'strumTime') / 50) % 20 > 10 then
      setPropertyFromGroup('notes', noteIndex, 'texture', '3DNOTE_assets');
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