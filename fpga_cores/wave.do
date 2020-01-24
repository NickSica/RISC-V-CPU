onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group LRU /LRU_tb/lru/cache_type
add wave -noupdate -expand -group LRU /LRU_tb/lru/cache_size
add wave -noupdate -expand -group LRU /LRU_tb/lru/associativity
add wave -noupdate -expand -group LRU /LRU_tb/lru/word_wid
add wave -noupdate -expand -group LRU /LRU_tb/lru/clk_i
add wave -noupdate -expand -group LRU /LRU_tb/lru/hit_i
add wave -noupdate -expand -group LRU /LRU_tb/lru/valid_i
add wave -noupdate -expand -group LRU /LRU_tb/lru/idx_i
add wave -noupdate -expand -group LRU /LRU_tb/lru/valid_o
add wave -noupdate -expand -group LRU /LRU_tb/lru/idx_o
add wave -noupdate -expand -group LRU /LRU_tb/lru/lru_shift_registers
add wave -noupdate -expand -group LRU /LRU_tb/lru/reg_equals_idx
add wave -noupdate -expand -group LRU /LRU_tb/lru/shift_reg_en
add wave -noupdate -expand -group LRU_tb /LRU_tb/clk
add wave -noupdate -expand -group LRU_tb /LRU_tb/hit
add wave -noupdate -expand -group LRU_tb /LRU_tb/hit_valid
add wave -noupdate -expand -group LRU_tb /LRU_tb/replace_valid
add wave -noupdate -expand -group LRU_tb /LRU_tb/hit_idx
add wave -noupdate -expand -group LRU_tb /LRU_tb/replace_idx
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {553 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {0 ps} {10500 ps}
