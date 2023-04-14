onerror {resume}
add list -width 9 /tb/rst
add list /tb/clk
add list /tb/upperBound
add list /tb/countOut
configure list -usestrobe 1
configure list -strobestart {0 ps} -strobeperiod {50 ns}
configure list -usesignaltrigger 0
configure list -delta all
configure list -signalnamewidth 0
configure list -datasetprefix 0
configure list -namelimit 5
