//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2026 00:12:23
// Design Name: 
// Module Name: Controller
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


module Controller(
    input rst, clk, zero,
    input [2:0] opcode,
    output reg sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr, data_e
    );
    
    reg [2:0] state;
    
    parameter INST_ADDR  = 3'b000,
              INST_FETCH = 3'b001,
              INST_LOAD  = 3'b010,
              IDLE       = 3'b011,
              OP_ADDR    = 3'b100, 
              OP_FETCH   = 3'b101,
              ALU_OP     = 3'b110,
              STORE      = 3'b111;
    
    always @(posedge clk) begin
        if (rst) state <= INST_ADDR;
        else state <= state + 1'b1;
    end
    
    always @(*) begin
        assign {sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr, data_e} = 9'b00000000;

        case (state)
            INST_ADDR: sel = 1;
            INST_FETCH: begin
                sel = 1;
                rd = 1;
            end
            INST_LOAD: begin
                sel = 1;
                rd = 1;
                ld_ir = 1;
            end
            IDLE: begin
                sel = 1;
                rd = 1;
                ld_ir = 1;
            end
            OP_ADDR: begin
                sel = 0;
                halt = (opcode == 3'b000);
            end
            OP_FETCH: begin
                sel = 0;
                if (opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b100 || opcode == 3'b101)
                    rd = 1;
            end
            ALU_OP: begin
                sel = 0;
                if (opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b100 || opcode == 3'b101)
                    rd = 1;
                inc_pc = (opcode == 3'b001 && zero);
                ld_pc = (opcode == 3'b111);
            end
            STORE: begin
                sel = 0;
                if (opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b100 || opcode == 3'b101) begin
                    rd = 1;
                    ld_ac = 1;
                end
                if (opcode == 3'b110) begin
                    wr = 1;
                    data_e = 1;
                end
                if (opcode == 3'b111) ld_pc = 1;
            end
        endcase
    end
    
endmodule
