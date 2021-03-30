/*Ayush Aryan
2018A8PS0041P*/

//Q1

module multi(input [7:0]A,B, output [15:0] out );

wire [15:0] s1 = {8'd0, A[3:0]*B[3:0]};
wire [15:0] s2 = {4'd0, A[3:0]*B[7:4], 4'd0};
wire [15:0] s3 = {4'd0, A[7:4]*B[3:0], 4'd0};
wire [15:0] s4 = { A[7:4]*B[7:4], 8'd0};

assign out= s1+s2+s3+s4;

endmodule

module test();

wire [15:0]out;
reg [7:0]A,B;

initial begin
    $dumpfile("mutli.vcd");
	$dumpvars;
end

multi t(A,B, out);

initial begin

        #2 A=8'd2;
           B=8'd4; 
        #6 A=8'd16;
           B=8'd10; 

        #2 $finish;
    end

    initial
		$monitor($time," A=%d B=%d Out=%d", A, B, out);
endmodule

