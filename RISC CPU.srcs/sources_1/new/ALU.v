//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2026 00:01:41
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] inA, inB,
    input [2:0] opcode,
    output reg [31:0] out,
    output is_zero
    );
    
    assign is_zero = (inA == 32'b0) ? 0 : 1;
    
    always @(*) begin
        case (opcode)
            3'b000: assign out = inA; // HLT
            3'b001: assign out = inA; // SKZ
            3'b010: assign out = inA + inB; // ADD
            3'b011: assign out = inA & inB; // AND
            3'b100: assign out = inA ^ inB; // XOR
            3'b101: assign out = inB; // LDA
            3'b110: assign out = inA; // STO
            3'b111: assign out = inA; //JMP
            default: out = inA;
        endcase
    end
    
endmodule
