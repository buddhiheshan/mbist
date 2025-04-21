module multiplexer_tb ();
    int WIDTH = 10;
    logic [WIDTH-1:0] normal_in, bist_in, out
    logic NbarT,

    multiplexer #(.WIDTH(WIDTH)) dut(.normal_in(normal_in), .bist_in(bist_in), .out(out), .NbarT(NbarT));

    task automatic checkOutput(output, expected_output);
        if (output === expected_output) begin
            $display("PASS");
        end
        else begin
            $display("FAIL");
        end
    endtask //automatic

    initial begin
        normal_in = 0;
        bist_in = 0;
        NbarT = 0;

        checkOutput(output, normal_in);

        NbarT = 1;
        checkOutput(output, bist_in);



    end

endmodule