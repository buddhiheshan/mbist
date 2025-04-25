module sram(
    input logic [5:0] ramaddr,
    input logic [7:0] ramin,
    input logic rwbar, clk, cs,
    output logic [7:0] ramout
);

logic [7:0] ram[0:63];

logic [5:0] addr_reg;

always_comb begin
    if (cs && rwbar) ramout = ram[addr_reg];
    else ramout = 8'b0;
end

always_ff @( posedge clk ) begin
    if (cs) begin
        if (!rwbar) ram[ramaddr] <= ramin;
        addr_reg <= ramaddr;
    end
end
    
endmodule