module tb_decoder();
    logic [2:0] q;
    logic [7:0] data_t;

    decoder dut(.q(q), .data_t(data_t));

    task check_output();
        case (q)
            3'b000 : check_value(8'b10101010);
            3'b001 : check_value(8'b01010101);
            3'b010 : check_value(8'b11110000);
            3'b011 : check_value(8'b00001111);
            3'b100 : check_value(8'b00000000);
            3'b101 : check_value(8'b11111111);
            default: check_value(8'bxxxxxxxx);
        endcase
    endtask

    function check_value(logic [7:0] expected_output);
        if (data_t === expected_output) begin
            $display("PASS\tTime=%0t\t Expected: data_t=%b | Got: data_t=%b", $time, expected_output, data_t);
        end
        else begin
            $display("FAIL\tTime=%0t\t Expected: data_t=%b | Got: data_t=%b", $time, expected_output, data_t);
        end
    endfunction

    initial begin
        #1 check_output();

        #1 q = 0;
        repeat (8) begin
            #1 check_output();
            #1 q = q + 1;
        end
        $finish;

    end
endmodule