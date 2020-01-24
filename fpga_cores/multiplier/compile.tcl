# Step 1: Define the output directory area
set partNum xc7a100tcsg324-1
set outputDir ./build
set topName multiplier
file mkdir $outputDir
set arg_len [ llength $argv ]


# Step 2: Setup design sources and constraints
if {$arg_len == 0} {
    read_verilog [ glob ./src/*.sv ]
    read_xdc ./src/constraints.xdc
} elseif {$arg_len == 1} {
    read_xdc ./src/[lindex $argv 0]
} elseif {$arg_len == 2} {
    set lang [lindex $argv 1]
    set constr ./src/[lindex $argv 0]
    if {$lang == "vhdl"} {
        read_vhdl [ glob ./src/*.vhd ]
	read_xdc $constr
    } elseif {$lang == "verilog"} {
        read_verilog -sv [ glob ./src/*.sv ]
	read_xdc $constr
    } elseif {$lang == "both"} {
	read_verilog -sv [ glob ./src/*.sv ]
	read_vhdl [ glob ./src/*.vhd ]
	read_xdc $contr
    }

}

# Step 3: Run synthesis, write design checkpoint, report timing, and utilization estimates
synth_design -top $topName -part $partNum
write_checkpoint -force $outputDir/post_synth.dcp
report_timing_summary -file $outputDir/post_synth_timing_summary.rpt
report_utilization -file $outputDir/post_synth_util.rpt
# Run custom script to report critical timing paths
reportCriticalPaths $outputDir/post_synth_critpath_report.csv

# Step 4: Run logic optimization, placement and physical logic optimization, write design checkpoint, report utilization and timing estimates
opt_design
reportCriticalPaths $outputDir/post_opt_critpath_report.csv
place_design
report_clock_utilization -file $outputDir/clock_util.rpt
# Optionally run optimization if there are timing violations after the placement
if{[ get_property SLACK [ get_timing_paths -max_paths 1 -nworst 1 -setup ] ] < 0} {
    puts "Found setup timing violations => running physical optimization"
    phys_opt_design
}
write_checkpoint -force $outputDir/post_place.dcp
report_utilization -file $outputDir/post_place_util.rpt
report_timing_summary -file $outputDir/post_place_timing_summary.rpt

# Step 5: Run the router, write the post-route design checkpoint, report the routing status, report timing, power, and DRC, and finally save the Verilog netlist
route_design -directive Explore
write_checkpoint -force $outputDir/post_route.dcp
report_route_status -file $outputDir/post_route_status.rpt
report_timing_summary -file $outputDir/post_route_timing_summary.rpt
report_power -file $outputDir/post_route_power.rpt
report_drc -file $outputDir/post_imp_drc.rpt
write_verilog -sv -force $outputDir/cpu_impl_netlist.sv -mode timesim -sdf_anno true

# Step 6: Generate a bitstream
write_bitstream -force $outputDir/$topName.bit





