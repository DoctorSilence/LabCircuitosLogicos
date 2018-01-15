view wave 
wave clipboard store
wave create -driver freeze -pattern repeater -initialvalue U -period 50ps -sequence { 0 1  } -repeat forever -starttime 0ps -endtime 1000ps sim:/altera/A 
wave create -driver freeze -pattern repeater -initialvalue U -period 100ps -sequence { 0 1  } -repeat forever -starttime 0ps -endtime 1000ps sim:/altera/B 
wave create -driver freeze -pattern repeater -initialvalue U -period 200ps -sequence { 0 1  } -repeat forever -starttime 0ps -endtime 1000ps sim:/altera/C 
wave create -driver freeze -pattern repeater -initialvalue U -period 400ps -sequence { 0 1  } -repeat forever -starttime 0ps -endtime 1000ps sim:/altera/D 
WaveCollapseAll -1
wave clipboard restore
