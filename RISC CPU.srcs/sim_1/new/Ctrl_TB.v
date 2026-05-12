`timescale 1ns / 1ps

module tb_controller();
    reg clk, rst, zero;
    reg [2:0] opcode;
    wire sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr, data_e;

    Controller dut (clk, rst, zero, opcode, sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr, data_e);

    initial begin
        clk = 0; rst = 1; zero = 0; opcode = 3'b010; // Giả lập lệnh ADD
        #20 rst = 0;
        // Quan sát các tín hiệu thay đổi qua 8 chu kỳ (160ns)
        #160 opcode = 3'b111; // Chuyển sang lệnh JMP
        #160 $finish;
    end
    always #10 clk = ~clk;
endmodule