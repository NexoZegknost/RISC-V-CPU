//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2026 12:40:12 PM
// Design Name: 
// Module Name: Memory
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

module Memory (
    input wire clk,
    input wire rd,        
    input wire wr,         
    input wire [31:0] addr, 
    inout wire [31:0] data 
);

    reg [31:0] ram [0:31];
    
    reg [31:0] data_out;

    assign data = (rd && !wr) ? data_out : 32'bz;

    always @(posedge clk) begin
        
	if (wr && !rd) begin
            ram[addr[4:0]] <= data; 
        end

        else if (rd && !wr) begin
            data_out <= ram[addr[4:0]];
        end
    end

endmodule