`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2026 02:26:01 PM
// Design Name: 
// Module Name: tb_seatbelt_alarm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_seatbelt_alarm;
    reg clk;
    reg reset;
    reg ignition;
    reg driver_unbuckled;
    reg passenger_present;
    reg passenger_unbuckled;
    reg door_open;
    
    wire warning_led;
    wire buzzer_alarm;
    wire [6:0] seg;
    wire [3:0] an;

    // Instantiate the design
    seatbelt_alarm uut (
        .clk(clk),
        .reset(reset),
        .ignition(ignition),
        .driver_unbuckled(driver_unbuckled),
        .passenger_present(passenger_present),
        .passenger_unbuckled(passenger_unbuckled),
        .door_open(door_open),
        .warning_led(warning_led),
        .buzzer_alarm(buzzer_alarm),
        .seg(seg),
        .an(an)
    );

    // Generate 100 MHz Clock (10ns period)
    always #5 clk = ~clk;

    initial begin
        // Initialize all inputs
        clk = 0; reset = 1;
        ignition = 0; driver_unbuckled = 0;
        passenger_present = 0; passenger_unbuckled = 0;
        door_open = 0;
        #20 reset = 0;

        // Case 1: Ignition ON, Driver & Passenger safe -> All Alerts OFF
        ignition = 1; driver_unbuckled = 0; passenger_present = 1; passenger_unbuckled = 0;
        #50;

        // Case 2: Passenger unbuckles while seat is occupied -> Immediate Warning LED
        passenger_unbuckled = 1;
        #100;

        // Case 3: Passenger leaves seat (unoccupied) -> Alert clears even if belt is unbuckled
        passenger_present = 0;
        #50;

        // Case 4: Door opens while ignition is ON -> Alert triggers
        door_open = 1;
        #50;

        $finish;
    end
endmodule