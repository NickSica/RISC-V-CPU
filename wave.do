onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group if_stage -group instr_cache /tb/cpu/if_stage/instr_cache/rst_i
add wave -noupdate -group if_stage -group instr_cache /tb/cpu/if_stage/instr_cache/wr_instr_en_i
add wave -noupdate -group if_stage -group instr_cache /tb/cpu/if_stage/instr_cache/wr_instr_i
add wave -noupdate -group if_stage -group instr_cache /tb/cpu/if_stage/instr_cache/addr_i
add wave -noupdate -group if_stage -group instr_cache /tb/cpu/if_stage/instr_cache/instr_o
add wave -noupdate -group if_stage -group instr_cache /tb/cpu/if_stage/instr_cache/r_addr_c
add wave -noupdate -group if_stage /tb/cpu/if_stage/clk_i
add wave -noupdate -group if_stage /tb/cpu/if_stage/rst_i
add wave -noupdate -group if_stage /tb/cpu/if_stage/pc_src_i
add wave -noupdate -group if_stage /tb/cpu/if_stage/pc_en_i
add wave -noupdate -group if_stage /tb/cpu/if_stage/if_en_i
add wave -noupdate -group if_stage /tb/cpu/if_stage/flush_i
add wave -noupdate -group if_stage /tb/cpu/if_stage/wr_instr_en_i
add wave -noupdate -group if_stage /tb/cpu/if_stage/branch_pc_i
add wave -noupdate -group if_stage /tb/cpu/if_stage/wr_instr_i
add wave -noupdate -group if_stage /tb/cpu/if_stage/pc_o
add wave -noupdate -group if_stage /tb/cpu/if_stage/instr_o
add wave -noupdate -group if_stage /tb/cpu/if_stage/instr_c
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/clk_i
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/rst_i
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/wr_reg_en_i
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/ex_rd_i
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/wb_rd_i
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/instr_i
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/rd_data_i
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/pc_i
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/ctrl_signals_o
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/pc_src_o
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/flush_o
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/pc_en_o
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/if_en_o
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/funct3_o
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/rs1_o
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/rs2_o
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/rd_o
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/funct7_o
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/imm_o
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/rs1_data_o
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/rs2_data_o
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/branch_pc_o
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/rd_data_r
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/pc_r
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/instr_r
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/ex_rd_r
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/wb_rd_r
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/rt_next
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/inhibit_ctrl
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/wr_reg_en_r
add wave -noupdate -expand -group id_stage /tb/cpu/id_stage/is_branch
add wave -noupdate -expand -group id_stage -expand -group reg_file /tb/cpu/id_stage/reg_file/clk_i
add wave -noupdate -expand -group id_stage -expand -group reg_file /tb/cpu/id_stage/reg_file/rst_i
add wave -noupdate -expand -group id_stage -expand -group reg_file /tb/cpu/id_stage/reg_file/wr_reg_en_i
add wave -noupdate -expand -group id_stage -expand -group reg_file /tb/cpu/id_stage/reg_file/rd_i
add wave -noupdate -expand -group id_stage -expand -group reg_file /tb/cpu/id_stage/reg_file/rs1_i
add wave -noupdate -expand -group id_stage -expand -group reg_file /tb/cpu/id_stage/reg_file/rs2_i
add wave -noupdate -expand -group id_stage -expand -group reg_file /tb/cpu/id_stage/reg_file/rd_data_i
add wave -noupdate -expand -group id_stage -expand -group reg_file /tb/cpu/id_stage/reg_file/rs1_data_o
add wave -noupdate -expand -group id_stage -expand -group reg_file /tb/cpu/id_stage/reg_file/rs2_data_o
add wave -noupdate -expand -group id_stage -expand -group reg_file -childformat {{{/tb/cpu/id_stage/reg_file/registers_r[9]} -radix decimal} {{/tb/cpu/id_stage/reg_file/registers_r[8]} -radix decimal} {{/tb/cpu/id_stage/reg_file/registers_r[2]} -radix decimal}} -subitemconfig {{/tb/cpu/id_stage/reg_file/registers_r[9]} {-radix decimal} {/tb/cpu/id_stage/reg_file/registers_r[8]} {-radix decimal} {/tb/cpu/id_stage/reg_file/registers_r[2]} {-radix decimal}} /tb/cpu/id_stage/reg_file/registers_r
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/clk_i
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/rst_i
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/mem_reg_write_i
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/wb_reg_write_i
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/alu_src_i
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/alu_op_i
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/funct3_i
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/rs1_i
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/rs2_i
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/rd_i
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/mem_rd_i
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/wb_rd_i
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/funct7_i
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/imm_i
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/ex_result_i
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/mem_result_i
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/rs1_data_i
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/rs2_data_i
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/rd_o
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/wr_ram_data_o
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/alu_result_o
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/rs1_data
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/rs2_data
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/ex_result_r
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/mem_result_r
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/rs1_data_r
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/rs2_data_r
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/imm_r
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/funct7_r
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/rs1_r
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/rs2_r
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/alu_ctrl_signal
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/funct3_r
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/fwd_rs1
add wave -noupdate -group ex_stage /tb/cpu/ex_stage/fwd_rs2
add wave -noupdate -expand -group mem_stage -expand -group cache /tb/cpu/mem_stage/cache/cache_type
add wave -noupdate -expand -group mem_stage -expand -group cache /tb/cpu/mem_stage/cache/cache_size
add wave -noupdate -expand -group mem_stage -expand -group cache /tb/cpu/mem_stage/cache/associativity
add wave -noupdate -expand -group mem_stage -expand -group cache /tb/cpu/mem_stage/cache/word_num
add wave -noupdate -expand -group mem_stage -expand -group cache /tb/cpu/mem_stage/cache/word_wid
add wave -noupdate -expand -group mem_stage -expand -group cache /tb/cpu/mem_stage/cache/IDX_WID
add wave -noupdate -expand -group mem_stage -expand -group cache /tb/cpu/mem_stage/cache/clk_i
add wave -noupdate -expand -group mem_stage -expand -group cache /tb/cpu/mem_stage/cache/wr_en_i
add wave -noupdate -expand -group mem_stage -expand -group cache /tb/cpu/mem_stage/cache/rd_en_i
add wave -noupdate -expand -group mem_stage -expand -group cache /tb/cpu/mem_stage/cache/rst_i
add wave -noupdate -expand -group mem_stage -expand -group cache /tb/cpu/mem_stage/cache/store_type_i
add wave -noupdate -expand -group mem_stage -expand -group cache /tb/cpu/mem_stage/cache/addr_i
add wave -noupdate -expand -group mem_stage -expand -group cache /tb/cpu/mem_stage/cache/data_i
add wave -noupdate -expand -group mem_stage -expand -group cache /tb/cpu/mem_stage/cache/data_o
add wave -noupdate -expand -group mem_stage -expand -group cache /tb/cpu/mem_stage/cache/ram
add wave -noupdate -expand -group mem_stage -expand -group cache /tb/cpu/mem_stage/cache/hit
add wave -noupdate -expand -group mem_stage -expand -group cache /tb/cpu/mem_stage/cache/hit_valid
add wave -noupdate -expand -group mem_stage -expand -group cache /tb/cpu/mem_stage/cache/hit_idx
add wave -noupdate -expand -group mem_stage -expand -group cache /tb/cpu/mem_stage/cache/inval_entry
add wave -noupdate -expand -group mem_stage -expand -group cache /tb/cpu/mem_stage/cache/inval_entry_idx
add wave -noupdate -expand -group mem_stage -expand -group cache /tb/cpu/mem_stage/cache/replace_idx
add wave -noupdate -expand -group mem_stage -expand -group cache /tb/cpu/mem_stage/cache/replace_valid
add wave -noupdate -expand -group mem_stage -expand -group cache /tb/cpu/mem_stage/cache/genblk1/tag_store
add wave -noupdate -expand -group mem_stage -expand -group cache /tb/cpu/mem_stage/cache/genblk1/data_store
add wave -noupdate -expand -group mem_stage /tb/cpu/mem_stage/mem_clk_i
add wave -noupdate -expand -group mem_stage /tb/cpu/mem_stage/clk_i
add wave -noupdate -expand -group mem_stage /tb/cpu/mem_stage/mem_wr_en_i
add wave -noupdate -expand -group mem_stage /tb/cpu/mem_stage/mem_rd_en_i
add wave -noupdate -expand -group mem_stage /tb/cpu/mem_stage/mem_to_reg_i
add wave -noupdate -expand -group mem_stage /tb/cpu/mem_stage/funct3_i
add wave -noupdate -expand -group mem_stage /tb/cpu/mem_stage/mem_addr_i
add wave -noupdate -expand -group mem_stage /tb/cpu/mem_stage/wr_data_i
add wave -noupdate -expand -group mem_stage /tb/cpu/mem_stage/alu_result_i
add wave -noupdate -expand -group mem_stage /tb/cpu/mem_stage/rd_data_o
add wave -noupdate -expand -group mem_stage -radix unsigned /tb/cpu/mem_stage/r_data
add wave -noupdate -expand -group mem_stage /tb/cpu/mem_stage/mem_addr_r
add wave -noupdate -expand -group mem_stage /tb/cpu/mem_stage/wr_data_r
add wave -noupdate -expand -group mem_stage /tb/cpu/mem_stage/alu_result_r
add wave -noupdate -expand -group mem_stage /tb/cpu/mem_stage/rst
add wave -noupdate -group cpu /tb/cpu/clk_i
add wave -noupdate -group cpu /tb/cpu/mem_clk_i
add wave -noupdate -group cpu /tb/cpu/rst_i
add wave -noupdate -group cpu /tb/cpu/wr_instr_en_i
add wave -noupdate -group cpu /tb/cpu/wr_instr_i
add wave -noupdate -group cpu /tb/cpu/out_o
add wave -noupdate -group cpu /tb/cpu/if_pc
add wave -noupdate -group cpu /tb/cpu/branch_pc
add wave -noupdate -group cpu /tb/cpu/if_instr
add wave -noupdate -group cpu /tb/cpu/if_flush
add wave -noupdate -group cpu /tb/cpu/if_pc_src
add wave -noupdate -group cpu /tb/cpu/if_en
add wave -noupdate -group cpu /tb/cpu/if_pc_en
add wave -noupdate -group cpu /tb/cpu/ctrl_signals
add wave -noupdate -group cpu /tb/cpu/id_rs1_data
add wave -noupdate -group cpu /tb/cpu/id_rs2_data
add wave -noupdate -group cpu /tb/cpu/id_imm
add wave -noupdate -group cpu /tb/cpu/id_funct7
add wave -noupdate -group cpu /tb/cpu/id_rs1
add wave -noupdate -group cpu /tb/cpu/id_rs2
add wave -noupdate -group cpu /tb/cpu/id_rd
add wave -noupdate -group cpu /tb/cpu/id_funct3
add wave -noupdate -group cpu /tb/cpu/ex_alu_result
add wave -noupdate -group cpu /tb/cpu/ex_wr_ram_data
add wave -noupdate -group cpu /tb/cpu/ex_rd_r
add wave -noupdate -group cpu /tb/cpu/ex_funct3_r
add wave -noupdate -group cpu /tb/cpu/ex_alu_op_r
add wave -noupdate -group cpu /tb/cpu/ex_reg_dst_r
add wave -noupdate -group cpu /tb/cpu/ex_reg_write_r
add wave -noupdate -group cpu /tb/cpu/ex_alu_src_r
add wave -noupdate -group cpu /tb/cpu/ex_mem_write_r
add wave -noupdate -group cpu /tb/cpu/ex_mem_read_r
add wave -noupdate -group cpu /tb/cpu/ex_mem_to_reg_r
add wave -noupdate -group cpu /tb/cpu/mem_rd_data
add wave -noupdate -group cpu /tb/cpu/mem_rd_r
add wave -noupdate -group cpu /tb/cpu/mem_funct3_r
add wave -noupdate -group cpu /tb/cpu/mem_reg_dst_r
add wave -noupdate -group cpu /tb/cpu/mem_reg_write_r
add wave -noupdate -group cpu /tb/cpu/mem_mem_write_r
add wave -noupdate -group cpu /tb/cpu/mem_mem_read_r
add wave -noupdate -group cpu /tb/cpu/mem_mem_to_reg_r
add wave -noupdate -group cpu /tb/cpu/wb_rd_data_r
add wave -noupdate -group cpu /tb/cpu/wb_rd_r
add wave -noupdate -group cpu /tb/cpu/wb_reg_write_r
add wave -noupdate -group cpu /tb/cpu/mem_mem_rd_r
add wave -noupdate -group tb /tb/wr_instr
add wave -noupdate -group tb /tb/ex_instr
add wave -noupdate -group tb /tb/mem_instr
add wave -noupdate -group tb /tb/wb_instr
add wave -noupdate -group tb /tb/wr_instr_en
add wave -noupdate -group tb /tb/mem_clk
add wave -noupdate -group tb /tb/clk
add wave -noupdate -group tb /tb/rst
add wave -noupdate -group tb /tb/counter
add wave -noupdate -group tb /tb/rs1
add wave -noupdate -group tb /tb/rs2
add wave -noupdate -group tb /tb/imm
add wave -noupdate -group tb /tb/result
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {48357 ps} 0}
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
WaveRestoreZoom {0 ps} {256200 ps}
