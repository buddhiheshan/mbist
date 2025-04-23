module tb_comparator();
    logic [7:0] data_t, ramout;
    logic gt, eq, lt;

    comparator dut(.*);

    task check_output(logic expected_gt, expected_eq, expected_lt);
        if (gt !== expected_gt || eq !== expected_eq || lt !== expected_lt) begin
            $display("FAIL\tTime=%0t\t Expected: gt=%b eq=%b lt=%b | Got: gt=%b eq=%b lt=%b", $time, expected_gt, expected_eq, expected_lt, gt, eq, lt);
        end
        else begin
            $display("PASS\tTime=%0t\t Expected: gt=%b eq=%b lt=%b | Got: gt=%b eq=%b lt=%b", $time, expected_gt, expected_eq, expected_lt, gt, eq, lt);
        end
    endtask

    initial begin
    
        repeat (10) begin
            void'(std::randomize(data_t));
            ramout = data_t;

            #5 check_output(0,1,0);

            ramout = ramout + 1;
            #5 check_output(0,0,1);

            ramout = ramout - 1;
            #5 check_output(0,1,0);

            ramout = ramout - 1;
            #5 check_output(1,0,0);
        end
        #10;
        $finish;

    end
    
endmodule