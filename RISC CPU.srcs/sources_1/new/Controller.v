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


module Controller (
    input clk, rst, zero,
    input [2:0] opcode,
    output reg sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr, data_e
);

    // Định nghĩa các trạng thái (FSM States)
    parameter INST_ADDR  = 3'b000, // 0
              INST_FETCH = 3'b001, // 1
              INST_LOAD  = 3'b010, // 2
              IDLE       = 3'b011, // 3
              OP_ADDR    = 3'b100, // 4
              OP_FETCH   = 3'b101, // 5
              ALU_OP     = 3'b110, // 6
              STORE      = 3'b111; // 7

    reg [2:0] state;

    // Chuyển đổi trạng thái tuần tự
    always @(posedge clk) begin
        if (rst)
            state <= INST_ADDR;
        else
            state <= state + 1'b1; // Chạy liên tục qua 8 trạng thái
    end

    // Logic điều khiển đầu ra dựa trên trạng thái và opcode
    always @(*) begin
        // Thiết lập giá trị mặc định cho các đầu ra
        {sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr, data_e} = 9'b00000000;

        case (state)
            INST_ADDR: sel = 1; // Chọn địa chỉ từ PC [cite: 113]
            
            INST_FETCH: begin
                sel = 1;
                rd = 1;         // Đọc lệnh từ bộ nhớ [cite: 113]
            end

            INST_LOAD: begin
                sel = 1;
                rd = 1;
                ld_ir = 1;      // Nạp lệnh vào Instruction Register [cite: 113]
            end

            IDLE: begin
                sel = 1;
                rd = 1;
                ld_ir = 1;
            end

            OP_ADDR: begin
                sel = 0;        // Chọn địa chỉ toán hạng từ IR [cite: 113]
                halt = (opcode == 3'b000); // Lệnh HLT [cite: 113]
                inc_pc = 1;
            end

            OP_FETCH: begin
                sel = 0;
                // rd = 1 nếu là các lệnh tính toán hoặc load [cite: 113]
                if (opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b100 || opcode == 3'b101)
                    rd = 1;
            end

            ALU_OP: begin
                sel = 0;
                if (opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b100 || opcode == 3'b101)
                    rd = 1;
                inc_pc = (opcode == 3'b001 && zero); // Lệnh SKZ: nếu zero=1 thì bỏ qua lệnh kế [cite: 113]
                ld_pc = (opcode == 3'b111);          // Lệnh JMP [cite: 113]
                data_e = (opcode == 3'b110);         // Lenh STO
            end

            STORE: begin
                sel = 0;
                if (opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b100 || opcode == 3'b101) begin
                    rd = 1;
                    ld_ac = 1;  // Lưu kết quả vào Accumulator [cite: 113]
                end
                if (opcode == 3'b110) begin // Lệnh STO
                    wr = 1;     // Ghi vào bộ nhớ [cite: 113]
                    data_e = 1; // Cho phép dữ liệu từ AC ra bus [cite: 113]
                end
                ld_pc = (opcode == 3'b111); // Tiếp tục JMP
            end
        endcase
    end
endmodule
