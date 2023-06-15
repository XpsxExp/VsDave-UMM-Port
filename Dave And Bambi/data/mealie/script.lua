function opponentNoteHit()
   if not leftSide or not Hosting or not onlinePlay then
      if curBeat >= 464 and curBeat <= 592 then
	     setProperty('health', getProperty('health') - (0.02 / 1.5));
	  end
   end
end