//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2026 08:40:12 PM
// Design Name: 
// Module Name: Address_Mux
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


module Address_Mux # (parameter WIDTH = 32)(
input [WIDTH-1:0] pc_addr,
input [WIDTH-1:0] ir_addr,
input sel,
output [WIDTH-1:0] addr_out
    );
 assign addr_out = (sel == 1)? pc_addr : ir_addr;
endmodule
