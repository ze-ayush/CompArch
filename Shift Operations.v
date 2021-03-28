module shift_rotate( 
    input [7:0]a, 
    input [2:0]op,
    output reg [7:0]y);

always @(*) begin
case (op)
    3'b001 : y= a<<1;
    3'b100 : y= a>>1; 
    3'b101 : y={a<<1|8'b0000_0001};
    3'b110 : y={8'b1000_0000|a>>1};
endcase
end
endmodule

module test();
reg [7:0]in;
reg [2:0]op;
wire  [7:0]out;

initial begin
		$dumpfile("rot.vcd");
		$dumpvars;
	end


    shift_rotate r(in,op,out);
    initial begin

        #2 in=8'b1001_1001;
            op=3'b001;
        #6 in=8'b1001_1001;
            op=3'b110;

        #2 $finish;
    end

    initial
		$monitor($time," out=%b in=%b",out, in);
endmodule

