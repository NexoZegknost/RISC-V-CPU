//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2026 08:32:12 PM
// Design Name: 
// Module Name: Instruction_Register
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

module Instruction_Register (
    input wire clk,
    input wire rst,             // Reset đồng bộ, tích cực mức cao
    input wire load,            // Tín hiệu cho phép nạp dữ liệu (tương ứng với ld_ir)
    input wire [31:0] data_in,  // Dữ liệu đầu vào 32-bit từ Memory
    output reg [31:0] data_out  // Dữ liệu đầu ra 32-bit (chứa opcode và toán hạng)
);

    // Mạch tuần tự hoạt động tại sườn lên của xung nhịp clk
    always @(posedge clk) begin
        if (rst) begin
            // Reset đồng bộ: đưa giá trị thanh ghi về 0 khi có rst = 1 tại sườn lên clk
            data_out <= 32'b0;
        end 
        else if (load) begin
            // Nạp dữ liệu: khi load = 1, cập nhật dữ liệu đầu vào ra đầu ra
            data_out <= data_in;
        end
        // Nếu rst = 0 và load = 0, thanh ghi tự động giữ nguyên giá trị (không cần viết thêm else)
    end

endmodule