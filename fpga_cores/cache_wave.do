onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group TB /Cache_TB/en
add wave -noupdate -expand -group TB /Cache_TB/clk
add wave -noupdate -expand -group TB /Cache_TB/addr
add wave -noupdate -expand -group TB /Cache_TB/data
add wave -noupdate -expand -group cache /Cache_TB/cache/cache_type
add wave -noupdate -expand -group cache /Cache_TB/cache/cache_size
add wave -noupdate -expand -group cache /Cache_TB/cache/associativity
add wave -noupdate -expand -group cache /Cache_TB/cache/word_num
add wave -noupdate -expand -group cache /Cache_TB/cache/word_wid
add wave -noupdate -expand -group cache /Cache_TB/cache/IDX_WID
add wave -noupdate -expand -group cache /Cache_TB/cache/en_i
add wave -noupdate -expand -group cache /Cache_TB/cache/clk_i
add wave -noupdate -expand -group cache /Cache_TB/cache/addr_i
add wave -noupdate -expand -group cache /Cache_TB/cache/data_o
add wave -noupdate -expand -group cache /Cache_TB/cache/ram
add wave -noupdate -expand -group cache /Cache_TB/cache/hit
add wave -noupdate -expand -group cache /Cache_TB/cache/hit_valid
add wave -noupdate -expand -group cache /Cache_TB/cache/hit_idx
add wave -noupdate -expand -group cache /Cache_TB/cache/replace_idx
add wave -noupdate -expand -group cache /Cache_TB/cache/replace_valid
add wave -noupdate -expand -group cache /Cache_TB/cache/and_reduced_tag
add wave -noupdate -expand -group cache /Cache_TB/cache/genblk1/tag_store
add wave -noupdate -expand -group cache /Cache_TB/cache/genblk1/data_store
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {27325 ps} 0}
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
WaveRestoreZoom {0 ps} {31500 ps}
