module control_fsm (
    input  wire clk,
    input  wire rst_n,
    input  wire start,
    input  wire stop,
    input  wire reset,
    output reg  count_enable,
    output reg [1:0] status
);

    localparam 2'b00    = 2'b00;//IDLE
    localparam 2'b01 = 2'b01;//RUNNING
    localparam 2'b10  = 2'b10;//PAUSED

    reg [1:0] state, next_state;//stores next state

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= 2'b00;
        else
            state <= next_state;
    end

    //Determining next state
    always @(*) begin
        next_state = state;
        case (state)
            2'b00:    if (start) next_state = 2'b01;
            2'b01: if (stop)  next_state = 2'b10;
            2'b10:  if (start) next_state = 2'b01;

            default: begin
            next_state = 2'b00;
            end
        endcase
        if (reset)
            next_state = 2'b00;
    end

    
    always @(*) begin
        status = state;
        count_enable = (state == 2'b01);
    end

endmodule
