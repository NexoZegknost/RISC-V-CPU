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


module PC_tb(
    );
    reg clk, rst, inc_pc, ld_pc;
    reg [4:0] pc_in;
    wire [4:0] pc_out;
    Program_Counter uut (.clk(clk), .rst(rst), .inc_pc(inc_pc), .ld_pc(ld_pc), .pc_in(pc_in), .pc_out(pc_out));
    always #5 clk = ~clk;
    initial begin
    clk =0 ; rst = 1; inc_pc = 0; ld_pc = 0; pc_in =5'b00000;
    $monitor("time=%0t rst=%b inc_pc=%b ld_pc=%b pc_out=%b", 
          $time, rst, inc_pc, ld_pc, pc_out);
    #10
    rst =0;
    inc_pc = 1;
    #50
    inc_pc = 0;
    ld_pc =1;
    pc_in = 5'b01001;
    $display ("time=%0t rst=%b inc_pc=%b ld_pc=%b pc_in=%b pc_out=%b", $time, rst, inc_pc, ld_pc, pc_in, pc_out);
   #10
   ld_pc = 0;
   $finish;
    end
endmodule
