set name [current_scope]
set instance $name
append instance "/*"
add_wave_divider [current_scope]
set group [add_wave_group [current_scope]]
add_wave -into $group $instance
save_wave_config ./waves/tb.wcfg
exit
