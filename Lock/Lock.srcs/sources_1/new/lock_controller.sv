`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 09.09.2026 10:12:10
// Design Name:
// Module Name: lock_controller
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

import lock_pkg::*;


module lock_controller (
    input        clk         , //— тактовий сигнал
    input        rst         , //— асинхронний reset, активний високим рівнем
    input  [3:0] digit_in    , 
    output       unlocked_led  //— вихід, 1 = розблоковано
);


// Код — три цифри, оберіть довільні значення самі (наприклад, 5, 3, 7 — за зразком, як зручно).

    localparam [3:0] CODE0 = 4'd5;
    localparam [3:0] CODE1 = 4'd3;
    localparam [3:0] CODE2 = 4'd7;

// ЧОТИРИ стани: LOCKED, WAIT_D2, WAIT_D3, UNLOCKED.

    state_t state, next_state;

    logic [3:0] digit_clean;
    logic valid;
    debounce debounce (
        .clk        (clk        ),
        .rst        (rst),
        .valid      (valid),
        .digit_in   (digit_in   ),
        .digit_clean(digit_clean)
    );




    always_ff @(posedge clk or posedge rst) begin
        if(rst) state <= LOCKED;
        else begin if (valid) begin
            state <= next_state;
        end 
    end
end
/*
    Переходи:   LOCKED -> WAIT_D2 (якщо digit_in == 1-ша цифра коду),
    WAIT_D2 -> WAIT_D3 (якщо digit_in == 2-га цифра),
    WAIT_D3 -> UNLOCKED (якщо digit_in == 3-тя цифра).
    З БУДЬ- ЯКОГО стану — неправильна цифра повертає в LOCKED.
    У стані UNLOCKED лишається в UNLOCKED (не скидається саме по собі).
    unlocked_led = 1 ТІЛЬКИ в стані UNLOCKED, інакше 0.
    */

    always_comb begin

        next_state = state;

        case (state)

            LOCKED :
                if (digit_clean == CODE0)
                    next_state = WAIT_D2;
                else
                    next_state = LOCKED;
            WAIT_D2 :
                if (digit_clean == CODE1)
                    next_state = WAIT_D3;
                else
                    next_state = LOCKED;
            WAIT_D3 :
                if (digit_clean == CODE2)
                    next_state = UNLOCKED;
                else
                    next_state = LOCKED;
            UNLOCKED :
                next_state = UNLOCKED;

            default : next_state = LOCKED;
        endcase

    end

    assign unlocked_led = (state == UNLOCKED);

endmodule
