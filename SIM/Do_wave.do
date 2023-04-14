onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/rst
add wave -noupdate /tb/clk
add wave -noupdate -radix decimal /tb/upperBound
add wave -noupdate -radix decimal /tb/countOut
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 41
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {4341095 ps}
bookmark add wave bookmark4 {{0 ps} {1 ns}} 0
