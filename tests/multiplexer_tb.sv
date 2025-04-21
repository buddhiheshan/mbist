module multiplexer_tb ();

    `define WIDTH 10

    logic [`WIDTH-1:0] normal_in, bist_in, out;
    logic NbarT;

    multiplexer #(.WIDTH(`WIDTH)) dut(.normal_in(normal_in), .bist_in(bist_in), .out(out), .NbarT(NbarT));

    task check_output(logic [`WIDTH-1:0] expected_output);
        if (out === expected_output) begin
            $display("PASS\tTime=%0t\t Expected: out=%b | Got: out=%b", $time, expected_output, out);
        end
        else begin
            $display("FAIL\tTime=%0t\t Expected: out=%b | Got: out=%b", $time, expected_output, out);
        end
    endtask

    initial begin
        void'(std::randomize(normal_in));
        void'(std::randomize(bist_in));

        repeat (10) begin
            void'(std::randomize(NbarT));

            if (NbarT)
                #1 check_output(bist_in);
            else
                #1 check_output(normal_in);
            #1;
        end
        $finish;

    end

endmodule