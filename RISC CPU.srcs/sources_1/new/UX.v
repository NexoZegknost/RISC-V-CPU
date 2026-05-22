module bin_to_7seg (
    input  wire [2:0] hex_digit,
    output reg  [6:0] seg         // Ngõ ra điều khiển 7 thanh {g, f, e, d, c, b, a}
);

    // Mạch logic tổ hợp giải mã cấu hình Anode chung (Active Low)
    always @(*) begin
        case (hex_digit)
            3'h0 : seg = 7'b100_0000; // Hiển thị số 0
            3'h1 : seg = 7'b111_1001; // Hiển thị số 1
            3'h2 : seg = 7'b010_0100; // Hiển thị số 2
            3'h3 : seg = 7'b011_0000; // Hiển thị số 3
            3'h4 : seg = 7'b001_1001; // Hiển thị số 4
            3'h5 : seg = 7'b001_0010; // Hiển thị số 5
            3'h6 : seg = 7'b000_0010; // Hiển thị số 6
            3'h7 : seg = 7'b111_1000; // Hiển thị số 7
            3'h8 : seg = 7'b000_0000; // Hiển thị số 8
            3'h9 : seg = 7'b001_0000; // Hiển thị số 9
            default: seg = 7'b111_1111; // Trường hợp lỗi: Tắt toàn bộ các đoạn LED
        endcase
    end

endmodule

