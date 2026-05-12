//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2026 10:37:54 PM
// Design Name: 
// Module Name: PC
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


module Program_Counter(
    input        clk,
    input        rst,
    input        inc_pc,
    input        ld_pc,
    input  [4:0] pc_in,
    output reg [4:0] pc_out
);
   always @(posedge clk) begin
       if (rst) begin
        pc_out <= 5'b00000;
       end
       else if (ld_pc) begin
        pc_out <= pc_in;
       end
       else if ( inc_pc )begin
       pc_out <= pc_out + 1;
       end
   end
endmodule
