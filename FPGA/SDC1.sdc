#Constraining PLL Base Clocks Manually
create_clock -period 20.000 -waveform {0.000 10.000} -name Ex_Clock [get_ports {SysClk}]

#The Timing Analyzer determines the correct settings based on the IP Catalog instantiation of the PLL.
derive_pll_clocks -create_base_clocks
derive_clock_uncertainty

create_clock -period 3.125 -waveform {0.78125 2.34375} -name DCO_CLK [get_ports {DCO}]

create_clock -period 1.5625 -name CLK_VIR -waveform {0 0.78125}

set_input_delay -clock CLK_VIR \
-max 0.5 \
[get_ports {FCO}]

set_input_delay -clock CLK_VIR \
-min 0.03 \
[get_ports {FCO}]

set_input_delay -clock CLK_VIR \
-max 0.5 \
[get_ports {Data_B_L}]

set_input_delay -clock CLK_VIR \
-min 0.03 \
[get_ports {Data_B_L}]


set_input_delay -clock CLK_VIR \
-max 0.5 \
[get_ports {Data_B_H}]

set_input_delay -clock CLK_VIR \
-min 0.03 \
[get_ports {Data_B_H}]



