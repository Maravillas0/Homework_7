`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 14.09.2026 12:50:12
// Design Name:
// Module Name: expr_plain
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


module expr_plain (
    input  logic        clk   ,
    input  logic        rst   ,
    input  logic [ 3:0] a     ,
    input  logic [ 3:0] b     ,
    input  logic [ 3:0] c     ,
    input  logic [ 3:0] d     ,
    output logic [7:0] result_plain
);

    // ---- Stage 0: registered inputs (this is what fixes it) ----
    logic [3:0] a_reg, b_reg, c_reg, d_reg;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            a_reg <= 3'd0;
            b_reg <= 3'd0;
            c_reg <= 3'd0;
            d_reg <= 3'd0;
        end else begin
            a_reg <= a;
            b_reg <= b;
            c_reg <= c;
            d_reg <= d;
        end
    end
    always_ff @(posedge clk or posedge rst) begin
        if(rst)
            result_plain <= 8'b0;
        else
            result_plain = (a_reg * b_reg) + (c_reg * d_reg);
    end
endmodule
