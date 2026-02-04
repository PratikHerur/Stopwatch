module stopwatch_top (
    input  wire clk,
    input  wire rst_n,
    input  wire start,
    input  wire stop,
    input  wire reset,
    output wire [7:0] minutes,
    output wire [5:0] seconds,
    output wire [1:0] status
);

    wire count_enable;
    wire sec_tick;

    control_fsm u_fsm (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .stop(stop),
        .reset(reset),
        .count_enable(count_enable),
        .status(status)
    );

    seconds_counter u_sec (
        .clk(clk),
        .rst_n(rst_n),
        .enable(count_enable),
        .seconds(seconds),
        .tick(sec_tick)
    );

    minutes_counter u_min (
        .clk(clk),
        .rst_n(rst_n),
        .tick(sec_tick),
        .minutes(minutes)
    );

endmodule
