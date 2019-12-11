onerror {resume}
quietly WaveActivateNextPane {} 0
log -r *
add wave -noupdate -group if_stage -group instr_cache /tb/cpu/if_stage/instr_cache/*
add wave -noupdate -group if_stage /tb/cpu/if_stage/*
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/*
add wave -noupdate -expand -group id_stage -group reg_file /tb/cpu/id_stage/reg_file/*
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/*
add wave -noupdate -group mem_stage /tb/cpu/mem_stage/*
add wave -noupdate -group cpu /tb/cpu/*
add wave -noupdate -group tb /tb/*
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {6485 ps}
