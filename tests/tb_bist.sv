module tb_bist ();
    `define SIZE 6
    `define LENGTH 8

    logic start, rst, clk, csin, rwbarin, opr;
    logic [`SIZE-1:0] address;
    logic [`LENGTH-1:0] datain;
    logic [`LENGTH-1:0] dataout;
    logic fail;

    bist #(.SIZE(`SIZE), .LENGTH(`LENGTH)) bist (.*);

    always #5 clk = ~clk;

    task check_output(logic expected_fail, logic [`LENGTH-1:0] expected_dataout);
        if (fail !== expected_fail || dataout !== expected_dataout) begin
            $display("FAIL\tTime=%0t\t Expected: fail=%b dataout=%b | Got: fail=%b dataout=%b", $time, expected_fail, expected_dataout, fail, dataout);
        end
        else begin
            $display("PASS\tTime=%0t\t Expected: fail=%b dataout=%b | Got: fail=%b dataout=%b", $time, expected_fail, expected_dataout, fail, dataout);
        end
    endtask

    initial begin
        clk = 0;
        rst = 1;
        start = 0;
        opr = 1;

        
        rwbarin = 0;
        csin = 0;
        address = 0;
        datain = 10;

        @(posedge clk) check_output(0, 0);

        #1;
        rst = 0;
        rwbarin = 0;
        csin = 1;
        check_output(0, 0);

        @(posedge clk) check_output(0, 0);

        #1;
        rwbarin = 1;

        #1;
        check_output(0, 10);

        #1;
        start = 1;
        @(posedge clk);

        #1;
        check_output(0, 0);

        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        #1;
        rst = 1;
        @(posedge clk);

        #1;
        rwbarin = 1;
        #1;
        check_output(0, 8'b10101010);




        // #6;
        // rwbarin = 1;

        // #1;
        // check_output(0, 10);



        #50;
        $finish;
    end

endmodule