module controller_tb();

    import controller_fsm_pkg::*;
    
    logic start, rst, clk, cout, NbarT, ld;

    controller dut(.*);

    task check_output(state_t expected_state, logic expected_ld, expected_NbarT);
        if (dut.state !== expected_state || ld !== expected_ld || NbarT !== expected_NbarT) begin
            $display("FAIL\tTime=%0t\t Expected: State:%s ld=%b NbarT=%b | Got: State:%s ld=%b NbarT=%b", $time, expected_state.name(), expected_ld, expected_NbarT, dut.state.name(), ld, NbarT);
        end
        else begin
            $display("PASS\tTime=%0t\t Expected: State:%s ld=%b NbarT=%b | Got: State:%s ld=%b NbarT=%b", $time, expected_state.name(), expected_ld, expected_NbarT, dut.state.name(), ld, NbarT);
        end
    endtask

    always #5 clk = ~clk;

    initial begin
        clk = 0;

        start = 0;
        rst = 0;
        cout = 0;

        #1 rst = 1;
        #5 check_output(RESET, 1'b1, 1'b0);
        #1 rst = 0;

        cout = 1;
        #9 check_output(RESET, 1'b1, 1'b0);
        #1 cout = 0;

        start = 1;
        #9 check_output(TEST, 1'b0, 1'b1);
        #1 start = 0;

        start = 1;
        #9 check_output(TEST, 1'b0, 1'b1);
        #1 start = 0;

        cout = 1;
        #9 check_output(RESET, 1'b1, 1'b0);
        #1 cout = 0;

        start = 1;
        #9 check_output(TEST, 1'b0, 1'b1);
        #1 start = 0;

        #1 rst = 1;
        check_output(TEST, 1'b0, 1'b1);
        #9 check_output(RESET, 1'b1, 1'b0);
        #1 rst = 0;
        #10;
        $finish;
    end
    
endmodule