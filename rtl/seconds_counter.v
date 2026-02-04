module seconds_counter (
    input  wire clk,
    input  wire rst_n,
    input  wire enable,
    output reg  [5:0] seconds,
    output wire tick
);

    assign tick = (enable && seconds == 6'd59);

    always @(posedge clk or negedge rst_n) 
    begin
        if (!rst_n)
            seconds <= 6'b0;
        else if (enable) begin
            if (seconds == 6'd59)
                seconds <= 6'b0;
            else
                seconds <= seconds + 6'b000001;
        end
    end

endmodule
