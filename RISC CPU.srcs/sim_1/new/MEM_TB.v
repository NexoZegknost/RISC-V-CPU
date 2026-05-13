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


`timescale 1ns / 1ps

module tb_memory();
    // Khai báo các tín hiệu
    reg clk;
    reg rd, wr;
    reg [4:0] addr; // 5-bit địa chỉ cho 32 ô nhớ
    reg [31:0] data_in;
    wire [31:0] data_out;
    
    // Tín hiệu inout xử lý cổng hai chiều
    wire [31:0] data_bus;
    
    // Logic cho cổng bidirectional
    // Khi ghi (wr=1): đẩy data_in ra bus. Khi đọc: để bus ở trạng thái trở kháng cao (Z)
    assign data_bus = (wr && !rd) ? data_in : 32'bz;
    assign data_out = data_bus;

    // Khởi tạo module Memory
    Memory DUT (
        .clk(clk),
        .rd(rd),
        .wr(wr),
        .addr(addr),
        .data(data_bus)
    );

    // Tạo xung clock
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // Khởi tạo các giá trị ban đầu
        rd = 0; wr = 0; addr = 0; data_in = 0;
        
        // 1. Reset hệ thống (nếu module memory có rst)
        #10;
        
        // 2. Kiểm tra ghi dữ liệu (Write)
        // Ghi giá trị 32'hABCD1234 vào địa chỉ 5'h05
        addr = 5'h05;
        data_in = 32'hABCD1234;
        wr = 1; rd = 0;
        #10;
        wr = 0; // Kết thúc ghi
        
        // 3. Kiểm tra đọc dữ liệu (Read)
        // Đọc từ địa chỉ 5'h05, mong đợi nhận được 32'hABCD1234
        #10;
        addr = 5'h05;
        rd = 1; wr = 0;
        #10;
        rd = 0;

        // 4. Kiểm tra nạp file memory.list (nếu có)
        // $readmemh("memory.list", uut.ram);
        
        #50;
        $stop;
    end
endmodule