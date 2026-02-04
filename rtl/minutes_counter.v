module minutes_counter (
    input  wire clk,
    input  wire rst_n,
    input  wire tick,
    output reg  [7:0] minutes
);

    always @(posedge clk or negedge rst_n) 
    begin
        if (!rst_n)
            minutes <= 8'b0;
        else if (tick) begin
            if (minutes == 8'd99)
                minutes <= 8'b0;
            else
                minutes <= minutes + 8'b00000001;
        end
    end

endmodule
