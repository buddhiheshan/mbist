module comparator (
    input logic [7:0] data_t, ramout,
    output logic gt, eq, lt
);

assign gt = data_t > ramout;
assign eq = data_t === ramout;
assign lt = data_t < ramout;
    
endmodule