`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11.09.2026 09:19:58
// Design Name:
// Module Name: debounce
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


module debounce #(parameter integer COUNT_MAX = 200) (
    input  logic       clk        ,
    input              rst        ,
    input  logic [3:0] digit_in   ,
    output logic [3:0] digit_clean,
    output logic valid
);
    logic [17:0] counter;
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            counter     <= 0;
            digit_clean <= 4'd0;
        end
        else begin
            if (digit_in != digit_clean) begin
                if (counter < COUNT_MAX)
                    counter <= counter + 1;
                else begin
                    valid <= 1;
                    digit_clean <= digit_in;
                    counter     <= 0;
                end
            end
            else begin
                counter     <= 0;
                valid <= 0;
            end
        end
    end

endmodule