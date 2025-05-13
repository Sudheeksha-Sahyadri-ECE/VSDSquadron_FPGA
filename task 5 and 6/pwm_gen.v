module pwm_gen(
    input clk,                  // System clock
    input [7:0] angle,          // Servo angle (0-180)
    output reg pwm_out          // PWM signal to drive servo
);

    reg [15:0] counter = 0;     // PWM counter
    localparam MAX_COUNT = 20000;  // 20 ms period for 50 Hz PWM
    localparam PULSE_WIDTH = 1000; // Start pulse width (1 ms for 0 degrees)

    always @(posedge clk) begin
        counter <= counter + 1;
        if (counter >= MAX_COUNT)
            counter <= 0;
    end

    always @(posedge clk) begin
        if (counter < (PULSE_WIDTH + (angle * 10)))  // map 0-180 to 1-2ms
            pwm_out <= 1;
        else
            pwm_out <= 0;
    end
endmodule
