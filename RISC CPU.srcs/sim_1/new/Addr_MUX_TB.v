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


module tb_Addr_Mux;
    
    parameter WIDTH = 5;
    
    reg [WIDTH-1:0] pc;
    reg [WIDTH-1:0] ir;
    reg sel;
    wire [WIDTH-1:0] out;
    
    Address_Mux #(.WIDTH(WIDTH)) DUT (.pc_addr(pc), .ir_addr(ir), .sel(sel), .addr_out(out));
    
    initial $monitor ("ir_addr = %b pc_addr = %b sel = %b addr_out = %b", ir, pc, sel, out);
    
    initial begin
        pc = 5'b01010; sel=1; ir = 5'b00001;
        #10
        pc = 5'b01010; sel=0; ir = 5'b00001;
        #10
        sel = 1;
        #20;
        $finish;
    end
    
endmodule
