module bist #(
    parameter SIZE = 6,
    parameter LENGTH = 8
) (
    input logic start, rst, clk, csin, rwbarin, opr,
    input logic [SIZE-1:0] address, 
    input logic [LENGTH-1:0] datain,
    output logic [LENGTH-1:0] dataout,
    output logic fail
);

logic cout, NbarT, ld, cs_out, rwbar_out, eq;
logic [LENGTH-1:0] ramin_out;
logic [SIZE-1:0] ramaddr_out;
logic [7:0] data_t;
logic [9:0] q;

controller controller(.start(start), .rst(rst), .clk(clk), .cout(cout), .NbarT(NbarT), .ld(ld));
counter #(.LENGTH(10)) counter(.d_in(0), .clk(clk), .ld(ld), .u_d(1'b1), .cen(1'b1), .q(q), .cout(cout));
decoder decoder(.q(q[9:7]), .data_t(data_t));
comparator comparator(.data_t(data_t), .ramout(dataout), .gt(), .eq(eq), .lt());

multiplexer #(.WIDTH(SIZE)) mux_a(.normal_in(address), .bist_in(q[5:0]), .NbarT(NbarT), .out(ramaddr_out));
multiplexer #(.WIDTH(LENGTH)) mux_d(.normal_in(datain), .bist_in(data_t), .NbarT(NbarT), .out(ramin_out));
multiplexer #(.WIDTH(1)) mux_rwbar(.normal_in(rwbarin), .bist_in(q[6]), .NbarT(NbarT), .out(rwbar_out));
multiplexer #(.WIDTH(1)) mux_cs(.normal_in(csin), .bist_in(1'b1), .NbarT(NbarT), .out(cs_out));

sram memory(.ramaddr(ramaddr_out), .ramin(ramin_out), .rwbar(rwbar_out), .clk(clk), .cs(cs_out), .ramout(dataout));

assign fail = NbarT && rwbar_out && ~eq && opr;

endmodule