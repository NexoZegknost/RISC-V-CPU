`timescale 1ns / 1ps

module tb_Controller();
    reg clk, rst, zero;
    reg [2:0] opcode;
    wire sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr, data_e;

    Controller DUT (clk, rst, zero, opcode, sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr, data_e);
    
    initial begin
        // Bước 1: Khởi tạo và Reset hệ thống
        rst = 1; opcode = 3'b000; zero = 0;
        #15 rst = 0; // Kết thúc reset đồng bộ

        // Bước 2: Kiểm tra lệnh LDA (Load Accumulator - Opcode 101)
        opcode = 3'b101;
        #80; // Chờ chạy qua 8 trạng thái của FSM [cite: 28]

        // Bước 3: Kiểm tra lệnh ADD (Opcode 010)
        opcode = 3'b010;
        #80;

        // Bước 4: Kiểm tra lệnh SKZ (Skip if Zero - Opcode 001) với zero = 1
        opcode = 3'b001; zero = 1;
        #80;

        // Bước 5: Kiểm tra lệnh JMP (Jump - Opcode 111)
        opcode = 3'b111;
        #80;

        // Bước 6: Kiểm tra lệnh HLT (Halt - Opcode 000)
        opcode = 3'b000;
        #80;

    end
    
    initial begin
        #2000;
        $finish;
    end
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
endmodule