`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2026 02:25:33 PM
// Design Name: 
// Module Name: seatbelt_alarm
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


module seatbelt_alarm (
    input wire clk,                  // 100 MHz FPGA Clock
    input wire reset,                // Center Push Button (Reset)
    input wire ignition,             // Switch 0: Engine ON (1) / OFF (0)
    input wire driver_unbuckled,     // Switch 1: Driver Belt Unbuckled (1)
    input wire passenger_present,    // Switch 2: Passenger Seat Occupied (1)
    input wire passenger_unbuckled,  // Switch 3: Passenger Belt Unbuckled (1)
    input wire door_open,            // Switch 4: Door Ajar (1)
    output reg warning_led,          // LED 0: Turns ON immediately when unsafe
    output reg buzzer_alarm,         // LED 1 / Buzzer: Turns ON after 5-sec grace period
    output reg [6:0] seg,            // 7-Segment Display (Active Low: CA-CG)
    output reg [3:0] an              // 7-Segment Anode (Active Low)
);

    // 1. Combinational Logic: Check all vehicle safety sensors
    wire driver_unsafe    = ignition & driver_unbuckled;
    wire passenger_unsafe = ignition & passenger_present & passenger_unbuckled;
    wire door_unsafe      = ignition & door_open;
    
    wire any_unsafe = driver_unsafe | passenger_unsafe | door_unsafe;

    // 2. Sequential Logic: 5-Second Grace Period Timer (at 100 MHz = 500,000,000 cycles)
    reg [28:0] grace_counter;
    reg [24:0] blink_counter;
    localparam GRACE_LIMIT = 29'd500_000_000; 

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            grace_counter <= 29'd0;
            blink_counter <= 25'd0;
            warning_led   <= 1'b0;
            buzzer_alarm  <= 1'b0;
        end else if (!any_unsafe) begin
            // Everything is safe -> Reset timer and turn off all alerts
            grace_counter <= 29'd0;
            blink_counter <= 25'd0;
            warning_led   <= 1'b0;
            buzzer_alarm  <= 1'b0;
        end else begin
            // Unsafe condition detected -> Turn on dashboard warning light immediately
            warning_led <= 1'b1;
            blink_counter <= blink_counter + 1'b1;
            
            if (grace_counter < GRACE_LIMIT) begin
                grace_counter <= grace_counter + 1'b1;
                buzzer_alarm  <= 1'b0; // Wait during grace period
            end else begin
                // Grace period expired -> Pulse the buzzer alarm (~2 Hz)
                buzzer_alarm  <= grace_counter[24]; 
            end
        end
    end

    // 3. 7-Segment Display Driver (Shows '1' for Alert, '0' for Safe on rightmost digit)
    always @(*) begin
        an = 4'b1110; // Enable only the rightmost 7-segment digit
        if (any_unsafe)
            seg = 7'b1111001; // Displays "1" (Alert)
        else
            seg = 7'b1000000; // Displays "0" (Safe)
    end

endmodule
