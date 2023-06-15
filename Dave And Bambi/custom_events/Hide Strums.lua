local indexPlayer = {[0] = 4, [1] = 5, [2] = 6, [3] = 7};

function onEvent(name, value1)
   if name == 'Hide Strums' then
      if value1 == 'true' then
	     for i = 0, 3 do
		    if not leftSide then
			   noteTweenAlpha('strm' .. i, i, 0, 1);
			end
			noteTweenAlpha('strm' .. indexPlayer[i], indexPlayer[i], 0, 1);
		 end
	  elseif value1 == 'false' then
	     for i = 0, 3 do
			noteTweenAlpha('strm' .. i, i, 1, 1);
			noteTweenAlpha('strm' .. indexPlayer[i], indexPlayer[i], 1, 1);
		 end
	  end
   end
end