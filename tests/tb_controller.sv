module tb_controller();

    typedef enum logic { RESET, TEST } state_t;
    
    logic start, rst, clk, cout, NbarT, ld;

    controller dut(.*);

    task check_output(logic expected_ld, expected_NbarT);
        if (ld !== expected_ld || NbarT !== expected_NbarT) begin
            $display("FAIL\tTime=%0t\t Expected:  ld=%b NbarT=%b | Got:  ld=%b NbarT=%b", $time, expected_ld, expected_NbarT, ld, NbarT);
        end
        else begin
            $display("PASS\tTime=%0t\t Expected:  ld=%b NbarT=%b | Got:  ld=%b NbarT=%b", $time, expected_ld, expected_NbarT, ld, NbarT);
        end
    endtask

    always #5 clk = ~clk;

    initial begin
        clk = 0;

        start = 0;
        rst = 0;
        cout = 0;

        #1 rst = 1;
        #5 check_output(1'b1, 1'b0);
        #1 rst = 0;

        cout = 1;
        #9 check_output(1'b1, 1'b0);
        #1 cout = 0;

        start = 1;
        #9 check_output(1'b0, 1'b1);
        #1 start = 0;

        start = 1;
        #9 check_output(1'b0, 1'b1);
        #1 start = 0;

        cout = 1;
        #9 check_output(1'b1, 1'b0);
        #1 cout = 0;

        start = 1;
        #9 check_output(1'b0, 1'b1);
        #1 start = 0;

        #1 rst = 1;
        check_output(1'b0, 1'b1);
        #9 check_output(1'b1, 1'b0);
        #1 rst = 0;
        #10;
        $finish;
    end
    
endmodule