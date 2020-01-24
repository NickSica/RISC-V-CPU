xvlog.bat --sv LRU.sv Cache.sv Cache_TB.sv
xelab.bat --nolog --debug typical Cache_TB -s top_sim
xsim.bat --nolog top_sim -t waveform.tcl
xsim.bat --nolog --g --view ./waves/CPU_tb_behav.wcfg top_sim