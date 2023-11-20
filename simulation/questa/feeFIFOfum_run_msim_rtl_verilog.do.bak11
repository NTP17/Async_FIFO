transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/ngtph/OneDrive/university\ courses/Logic\ Synthesis\ (EE4449_TT01)/Labs/DONE/Lab3/MiNE {C:/Users/ngtph/OneDrive/university courses/Logic Synthesis (EE4449_TT01)/Labs/DONE/Lab3/MiNE/fFFf.v}
vlog -vlog01compat -work work +incdir+C:/Users/ngtph/OneDrive/university\ courses/Logic\ Synthesis\ (EE4449_TT01)/Labs/DONE/Lab3/MiNE {C:/Users/ngtph/OneDrive/university courses/Logic Synthesis (EE4449_TT01)/Labs/DONE/Lab3/MiNE/dual_RAM.v}
vlog -sv -work work +incdir+C:/Users/ngtph/OneDrive/university\ courses/Logic\ Synthesis\ (EE4449_TT01)/Labs/DONE/Lab3/MiNE {C:/Users/ngtph/OneDrive/university courses/Logic Synthesis (EE4449_TT01)/Labs/DONE/Lab3/MiNE/controller.sv}

vlog -sv -work work +incdir+C:/Users/ngtph/OneDrive/university\ courses/Logic\ Synthesis\ (EE4449_TT01)/Labs/DONE/Lab3/MiNE {C:/Users/ngtph/OneDrive/university courses/Logic Synthesis (EE4449_TT01)/Labs/DONE/Lab3/MiNE/testFIFObench.sv}
vlog -vlog01compat -work work +incdir+C:/Users/ngtph/OneDrive/university\ courses/Logic\ Synthesis\ (EE4449_TT01)/Labs/DONE/Lab3/MiNE {C:/Users/ngtph/OneDrive/university courses/Logic Synthesis (EE4449_TT01)/Labs/DONE/Lab3/MiNE/altera_mf.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  testFIFObench

add wave *
view structure
view signals
run -all
