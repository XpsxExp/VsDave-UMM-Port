function onCreate()
   setProperty('camZooming', false);
   setProperty('camGame.zoom', 1.3);
   setProperty('defaultCamZoom', 1.3);
end

function opponentNoteHit()
   if not mustHitSection then
      setProperty('defaultCamZoom', 1.3);
      cancelTween('zoomOut');
      doTweenZoom('zoomIn', 'camGame', 1.3, (stepCrochet * 4 / 1000), 'sineInOut');
   end
end

function goodNoteHit()
   if mustHitSection then
      setProperty('defaultCamZoom', 1);
      cancelTween('zoomIn');
      doTweenZoom('zoomOut', 'camGame', 1, (stepCrochet * 4 / 1000), 'sineInOut');
   end
end

function onTweenCompleted(tag)
   if tag == 'zoomIn' or tag == 'zoomOut' then
      setProperty('defaultCamZoom', getProperty('camGame.zoom'));
   end
end