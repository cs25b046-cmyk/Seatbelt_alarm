## 100 MHz System Clock
set_property -dict {PACKAGE_PIN F14 IOSTANDARD LVCMOS33} [get_ports {clk}]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk}]

## Slide Switches (Inputs)
set_property -dict {PACKAGE_PIN V2 IOSTANDARD LVCMOS33} [get_ports {ignition}]            ;# SW0
set_property -dict {PACKAGE_PIN U2 IOSTANDARD LVCMOS33} [get_ports {driver_unbuckled}]    ;# SW1
set_property -dict {PACKAGE_PIN U1 IOSTANDARD LVCMOS33} [get_ports {passenger_present}]   ;# SW2
set_property -dict {PACKAGE_PIN T2 IOSTANDARD LVCMOS33} [get_ports {passenger_unbuckled}] ;# SW3
set_property -dict {PACKAGE_PIN T1 IOSTANDARD LVCMOS33} [get_ports {door_open}]           ;# SW4

## Push Button (Reset - BTN0)
set_property -dict {PACKAGE_PIN J2 IOSTANDARD LVCMOS33} [get_ports {reset}]               ;# BTN0

## Onboard LEDs (Outputs)
set_property -dict {PACKAGE_PIN G1 IOSTANDARD LVCMOS33} [get_ports {warning_led}]         ;# LD0
set_property -dict {PACKAGE_PIN G2 IOSTANDARD LVCMOS33} [get_ports {buzzer_alarm}]        ;# LD1

## 7-Segment Display (Digit 0 - Rightmost Bank)
set_property -dict {PACKAGE_PIN D5 IOSTANDARD LVCMOS33} [get_ports {an[0]}]             ;# D0_AN0
set_property -dict {PACKAGE_PIN C4 IOSTANDARD LVCMOS33} [get_ports {an[1]}]             ;# D0_AN1
set_property -dict {PACKAGE_PIN C7 IOSTANDARD LVCMOS33} [get_ports {an[2]}]             ;# D0_AN2
set_property -dict {PACKAGE_PIN A8 IOSTANDARD LVCMOS33} [get_ports {an[3]}]             ;# D0_AN3

set_property -dict {PACKAGE_PIN D7 IOSTANDARD LVCMOS33} [get_ports {seg[0]}]            ;# D0_CA
set_property -dict {PACKAGE_PIN C5 IOSTANDARD LVCMOS33} [get_ports {seg[1]}]            ;# D0_CB
set_property -dict {PACKAGE_PIN A5 IOSTANDARD LVCMOS33} [get_ports {seg[2]}]            ;# D0_CC
set_property -dict {PACKAGE_PIN B7 IOSTANDARD LVCMOS33} [get_ports {seg[3]}]            ;# D0_CD
set_property -dict {PACKAGE_PIN A7 IOSTANDARD LVCMOS33} [get_ports {seg[4]}]            ;# D0_CE
set_property -dict {PACKAGE_PIN D6 IOSTANDARD LVCMOS33} [get_ports {seg[5]}]            ;# D0_CF
set_property -dict {PACKAGE_PIN B5 IOSTANDARD LVCMOS33} [get_ports {seg[6]}]            ;# D0_CG