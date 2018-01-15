transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/local/ITAM/mmontesv/Examen/practicaExamen.vhd}
vcom -93 -work work {/home/local/ITAM/mmontesv/Examen/M.vhd}
vcom -93 -work work {/home/local/ITAM/mmontesv/Examen/G.vhd}
vcom -93 -work work {/home/local/ITAM/mmontesv/Examen/div_freq.vhdl}
vcom -93 -work work {/home/local/ITAM/mmontesv/Examen/mux_4_1.vhd}
vcom -93 -work work {/home/local/ITAM/mmontesv/Examen/cont2.vhd}
vcom -93 -work work {/home/local/ITAM/mmontesv/Examen/decoder_2_4.vhd}

