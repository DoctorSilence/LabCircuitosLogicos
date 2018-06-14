view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue U -period 100ps -dutycycle 50 -starttime 0ps -endtime 5000ps sim:/practica2/clock 
wave create -driver freeze -pattern constant -value 0001 -range 0 3 -starttime 0ps -endtime 5000ps sim:/practica2/dip_0 
WaveExpandAll -1
wave create -driver freeze -pattern constant -value 0100 -range 0 3 -starttime 0ps -endtime 5000ps sim:/practica2/dip_1 
wave create -driver freeze -pattern constant -value UU1U -range 0 3 -starttime 0ps -endtime 5000ps sim:/practica2/dip_1 
wave create -driver freeze -pattern constant -value 0010 -range 0 3 -starttime 0ps -endtime 5000ps sim:/practica2/dip_1 
WaveExpandAll -1
wave create -driver freeze -pattern constant -value 0100 -range 0 3 -starttime 0ps -endtime 5000ps sim:/practica2/dip_2 
WaveExpandAll -1
wave create -driver freeze -pattern constant -value 1000 -range 0 3 -starttime 0ps -endtime 5000ps sim:/practica2/dip_3 
WaveExpandAll -1
WaveCollapseAll -1
wave clipboard restore
