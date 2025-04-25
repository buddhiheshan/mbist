module tb_sram ();
    logic [5:0] ramaddr;
    logic [7:0] ramin, ramout;
    logic rwbar, clk, cs;

    logic [7:0] temp;

    sram dut(.*);

    always #5 clk = ~clk;

    task check_output(logic [7:0] expected_output);
        if (ramout !== expected_output) begin
            $display("FAIL\tTime=%0t\t Expected: ramout=%b | Got: ramout=%b", $time, expected_output, ramout);
        end
        else begin
            $display("PASS\tTime=%0t\t Expected: ramout=%b | Got: ramout=%b", $time, expected_output, ramout);
        end
    endtask

    initial begin
        clk = 0;
        
        repeat (2) begin
            rwbar = 0;
            cs = 0;

            void'(std::randomize(temp));
            ramin = temp;
            void'(std::randomize(ramaddr));

            #1 cs = 1;
            #6 rwbar = 1;
            #5 check_output(ramin);

            #1 cs = 0;
            #6 rwbar = 1;
            #5 check_output(0);

            #1 cs = 0;
            rwbar = 0;
            void'(std::randomize(ramin));
            #6 rwbar = 1;
            cs = 1;
            #5 check_output(temp);

            #5;
        end

        #10;
        $finish;
    end

endmodule