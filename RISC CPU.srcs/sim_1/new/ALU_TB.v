`timescale 1ns / 1ps

module tb_ALU();
    reg [31:0] inA, inB;
    reg [2:0] opcode;
    wire [31:0] alu_out;
    wire is_zero;

    ALU DUT (inA, inB, opcode, alu_out, is_zero);
    
    initial $monitor("OpCode = %b, inA = %d, inB = %d, isZero = %b, output = %d", opcode, inA, inB, is_zero, alu_out);
    
    initial begin
        // Kiểm tra phép cộng (ADD - 010)
        inA = 32'd10; inB = 32'd20; opcode = 3'b010; #10;
        
        // Kiểm tra cờ Zero (SKZ - 001)
        inA = 32'd0; opcode = 3'b001; #10;
        
        // Kiểm tra phép AND (011)
        inA = 32'hFFFF0000; inB = 32'h0000FFFF; opcode = 3'b011; #10;
    end
    
    initial begin
        #100;
        $finish;
    end
    
endmodule