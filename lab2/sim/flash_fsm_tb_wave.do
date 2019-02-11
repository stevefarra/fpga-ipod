onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /flash_fsm_tb/sim_clk
add wave -noupdate /flash_fsm_tb/dut/state
add wave -noupdate -radix decimal /flash_fsm_tb/sim_addr
add wave -noupdate /flash_fsm_tb/sim_rst
add wave -noupdate /flash_fsm_tb/sim_start
add wave -noupdate /flash_fsm_tb/sim_readdatavalid
add wave -noupdate /flash_fsm_tb/sim_gen_addr
add wave -noupdate /flash_fsm_tb/sim_read
add wave -noupdate /flash_fsm_tb/sim_data_en
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 178
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 16
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {226 ps}
