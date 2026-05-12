`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2026 04:02:48 PM
// Design Name: 
// Module Name: PC_tb
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


module tb_PC;
    
    reg clk, rst, inc_pc, ld_pc;
    reg [4:0] pc_in;
    wire [4:0] pc_out;
    
    Program_Counter DUT (
        .clk(clk),
        .rst(rst),
        .inc_pc(inc_pc),
        .ld_pc(ld_pc),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );
    
    always #5 clk = ~clk;
    
    initial $monitor("time=%t rst=%b inc_pc=%b ld_pc=%b data_in=%d pc_out=%d", $time, rst, inc_pc, ld_pc, pc_in, pc_out);
    
    initial begin
        clk = 0; inc_pc = 0; ld_pc = 0;
        
        rst = 0;
        #30; // first 3 clock -> idle
        ld_pc = 1;
        pc_in = 5'h1A;
        #30; // hold load for 3 clocks
        rst = 1;
        #10; // reset in 1 clock
        rst = 0;
        ld_pc = 0;
        #20;
        ld_pc = 1;
        pc_in = 5'h0A;
        #10;
        ld_pc = 0;
        rst = 1;
        #10;
        rst = 0;
        inc_pc = 1;
        #50;
        rst = 1;
        #10;
        rst = 0;
        #30;
        ld_pc = 1;
        pc_in = 5'b01011;
        #30;
        pc_in = 5'b11100;
        #10;
        ld_pc = 0;
        #30;
        pc_in = 5'b1;
        ld_pc = 1;
        #2; // Glitch
        ld_pc = 0;
        #18;
        ld_pc = 1;
        pc_in = 5'b0;
        rst = 1;
        #10;
        rst = 0;
        #10;
        inc_pc = 0;
        
    end
    
    initial begin
        #2000;
        $finish;
    end
    
endmodule
