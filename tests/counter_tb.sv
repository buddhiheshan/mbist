module tb_counter();
    `define LENGTH 10

    logic [`LENGTH-1:0] d_in, q;
    logic clk, ld, u_d, cen, cout;

    logic [`LENGTH-1:0] count;

    counter #(.LENGTH(`LENGTH)) dut(.*);

    task check_output(expected_cout);
        if (q !== count || cout !== expected_cout) begin
            $display("FAIL\tTime=%0t\t Expected: q:%b cout:%b | Got: q:%b cout:%b", $time, count, expected_cout, q, cout);
        end
        else begin
            $display("PASS\tTime=%0t\t Expected: q:%b cout:%b | Got: q:%b cout:%b", $time, count, expected_cout, q, cout);
        end
    endtask

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        ld = 0;
        d_in = 0;
        cen = 0;
        u_d = 0;

        #4;
        cen = 1;
        ld = 1;
        void'(std::randomize(count));
        d_in = count;
        
        #2 check_output(1'b0);
        cen = 0;

        void'(std::randomize(d_in));
        #10 check_output(1'b0);

        ld = 0;
        #10 check_output(1'b0);

        cen = 1;
        u_d = 1;
        count = count + 1;
        #10 check_output(1'b0);

        u_d = 0;
        count = count - 1;
        #10 check_output(1'b0);

        ld = 1;
        count = 0;
        d_in = count;
        #10 check_output(1'b0);

        u_d = 0;
        ld = 0;
        count = count - 1;
        #10 check_output(1'b1);

        u_d = 1;
        ld = 0;
        count = count + 1;
        #10 check_output(1'b1);

        count = count + 1;
        #10 check_output(1'b0);

        cen = 0;
        u_d = 1;
        #10 check_output(1'b0);

        u_d = 0;
        #10 check_output(1'b0);

        ld = 1;
        #10 check_output(1'b0);

        u_d = 0;
        ld = 0;
        #10 check_output(1'b0);

        u_d = 1;
        ld = 0;
        #10 check_output(1'b0);

        #10;
        $finish;

    end

endmodule