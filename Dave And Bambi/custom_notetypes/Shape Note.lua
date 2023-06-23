function onCreatePost()
   addHaxeLibrary('Std');
   for i = 0, getProperty('unspawnNotes.length') - 1 do
      if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Shape Note' then
	     setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_assets_Shape');
		 setPropertyFromGroup('unspawnNotes', i, 'blockHit', true); 
		 setPropertyFromGroup('unspawnNotes', i, 'offsetX', 19); 
	  end
   end
end

function onUpdatePost()
   if keyboardPressed('SPACE') then
      if not leftSide then
         for i = 0, getProperty('notes.length') - 1 do 
	        if getPropertyFromGroup('notes', i, 'mustPress') and not getPropertyFromGroup('notes', i, 'isSustainNote') then 
		       if getPropertyFromGroup('notes', i, 'noteType') == '' then
		          setPropertyFromGroup('notes', i, 'alpha', 0.5); 
			      setPropertyFromGroup('notes', i, 'blockHit', true); 
			   elseif getPropertyFromGroup('notes', i, 'noteType') == 'Shape Note' then
		          setPropertyFromGroup('notes', i, 'alpha', 1); 
			      setPropertyFromGroup('notes', i, 'blockHit', false); 
			   end
	        end 
	     end
	  else
         for i = 0, getProperty('notes.length') - 1 do 
	        if not getPropertyFromGroup('notes', i, 'mustPress') and not getPropertyFromGroup('notes', i, 'isSustainNote') then 
		       if getPropertyFromGroup('notes', i, 'noteType') == '' then
		          setPropertyFromGroup('notes', i, 'alpha', 0.5); 
			      setPropertyFromGroup('notes', i, 'blockHit', true); 
			   elseif getPropertyFromGroup('notes', i, 'noteType') == 'Shape Note' then
		          setPropertyFromGroup('notes', i, 'alpha', 1); 
			      setPropertyFromGroup('notes', i, 'blockHit', false); 
			   end
	        end 
	     end
	  end
	  
	  -- for i = 0, getProperty('unspawnNotes.length') - 1 do 
	     -- if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then 
		    -- if getPropertyFromGroup('unspawnNotes', i, 'texture') == '' then
		       -- setPropertyFromGroup('unspawnNotes', i, 'alpha', 0.5); 
			   -- setPropertyFromGroup('unspawnNotes', i, 'blockHit', false); 
			-- elseif getPropertyFromGroup('unspawnNotes', i, 'texture') == 'NOTE_assets_Shape' then
		       -- setPropertyFromGroup('unspawnNotes', i, 'alpha', 1); 
			   -- setPropertyFromGroup('unspawnNotes', i, 'blockHit', true); 
			-- end
	     -- end 
	  -- end
   else
      if not leftSide then
         for i = 0, getProperty('notes.length') - 1 do 
	        if getPropertyFromGroup('notes', i, 'mustPress') and not getPropertyFromGroup('notes', i, 'isSustainNote') then 
		       if getPropertyFromGroup('notes', i, 'noteType') == '' then
		          setPropertyFromGroup('notes', i, 'alpha', 1); 
			      setPropertyFromGroup('notes', i, 'blockHit', false); 
			   elseif getPropertyFromGroup('notes', i, 'noteType') == 'Shape Note' then
	    	      setPropertyFromGroup('notes', i, 'alpha', 0.5); 
			      setPropertyFromGroup('notes', i, 'blockHit', true); 
			   end
	        end 
		 end
	  else
	     for i = 0, getProperty('notes.length') - 1 do
	        if not getPropertyFromGroup('notes', i, 'mustPress') and not getPropertyFromGroup('notes', i, 'isSustainNote') then 
		       if getPropertyFromGroup('notes', i, 'noteType') == '' then
		          setPropertyFromGroup('notes', i, 'alpha', 1); 
			      setPropertyFromGroup('notes', i, 'blockHit', false); 
			   elseif getPropertyFromGroup('notes', i, 'noteType') == 'Shape Note' then
	    	      setPropertyFromGroup('notes', i, 'alpha', 0.5); 
			      setPropertyFromGroup('notes', i, 'blockHit', true); 
			   end
	        end 
	     end
	  end
	  
	  -- for i = 0, getProperty('unspawnNotes.length') - 1 do 
	     -- if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then 
		    -- if getPropertyFromGroup('unspawnNotes', i, 'texture') == '' then
		       -- setPropertyFromGroup('unspawnNotes', i, 'alpha', 1); 
			   -- setPropertyFromGroup('unspawnNotes', i, 'blockHit', true); 
			-- elseif getPropertyFromGroup('unspawnNotes', i, 'texture') == 'NOTE_assets_Shape' then
		       -- setPropertyFromGroup('unspawnNotes', i, 'alpha', 0.5); 
			   -- setPropertyFromGroup('unspawnNotes', i, 'blockHit', false); 
			-- end
	     -- end 
	  -- end
   end
end