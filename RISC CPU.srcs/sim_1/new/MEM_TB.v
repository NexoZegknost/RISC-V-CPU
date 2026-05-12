`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.05.2026 23:05:12
// Design Name: 
// Module Name: MEM_TB
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


module tb_memory();
    reg clk, wr, rd;
    reg [4:0] addr;
    wire [31:0] data;
    reg [31:0] data_reg;

    assign data = (wr) ? data_reg : 32'bz; // Logic điều khiển bus hai chiều

    Memory dut (clk, wr, rd, addr, data);

    initial begin
        clk = 0; wr = 0; rd = 0; addr = 5'h0; data_reg = 32'h0;
        
        // Ghi dữ liệu vào địa chỉ 0x05
        #20 addr = 5'h05; data_reg = 32'hABCDE123; wr = 1;
        #20 wr = 0;
        
        // Đọc dữ liệu từ địa chỉ 0x05
        #20 rd = 1;
        #20 rd = 0;
        $finish;
    end
    always #10 clk = ~clk;
endmodule