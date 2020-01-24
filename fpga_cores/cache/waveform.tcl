add_wave -into  [add_wave_group Cache_TB] [append Cache_TB "/*"]
add_wave -into  [add_wave_group Cache] [append Cache "/Cache_TB/cache/*"]
add_wave -into  [add_wave_group LRU] [append LRU "/Cache_TB/cache/\genblk1.g_lru[0].lru /*"]
save_wave_config ./wave_config.wcfg
exit
