`timescale 1ns / 1ps

module tb_Controller();
    reg clk, rst, zero;
    reg [2:0] opcode;
    wire sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr, data_e;

    Controller DUT (clk, rst, zero, opcode, sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr, data_e);
    
    initial $monitor("reset = %b, zero = %b, sel = %, rd = %b, ld_ir = %b", rst, zero, sel, rd, ld_ir);
    
    initial begin
        clk = 0; rst = 1; zero = 0; opcode = 3'b010; // Giả lập lệnh ADD
        #50 rst = 0;
        // Quan sát các tín hiệu thay đổi qua 8 chu kỳ (160ns)
        #160 opcode = 3'b111; // Chuyển sang lệnh JMP
        #160 $finish;
    end
    always #10 clk = ~clk;
endmodule