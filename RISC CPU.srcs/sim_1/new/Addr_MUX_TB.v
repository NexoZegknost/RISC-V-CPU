`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2026 08:49:48 PM
// Design Name: 
// Module Name: Addr_Mux_tb
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


module Addr_Mux_tb(
    );
    reg [4:0] pc;
    reg [4:0] ir;
    reg sel;
    wire [4:0] out;
    Address_Mux #(.WIDTH(5)) uut (.pc_addr(pc), .ir_addr(ir), .sel(sel), .addr_out(out));
    initial begin
    $monitor ("ir_addr = %b pc_addr = %b sel = %b addr_out = %b", ir, pc, sel, out);
    pc = 5'b01010; sel=1; ir = 5'b00001;
    #10
    pc = 5'b01010; sel=0; ir = 5'b00001;
    #10
    $finish;
    end
endmodule
