module fulladder(
    input a, b,cin,
    output s, cout
    );
    assign s= a^b^cin;
    assign cout=(a & b) | cin & (a^b);
endmodule

module rippleadder (
    input [3:0]a , b,
    input cin,
    output [3:0]cout,
    output [3:0]s);
fulladder fa1(a[0],b[0],cin,s[0],cout[0]);
fulladder fa2(a[1],b[1],cout[0],s[1],cout[1]);
fulladder fa3(a[2],b[2],cout[1],s[2],cout[2]);
fulladder fa4(a[3],b[3],cout[2],s[3],cout[3]);
endmodule

module test_ra();
    reg [3:0]in1,in2;
    reg cin;
    wire [3:0]c,out;
    initial begin
		$dumpfile("ripple.vcd");
		$dumpvars;
	end


    rippleadder r(in1,in2,cin,c,out);
    initial begin

        #2 cin=1'b0;
           in1=4'b0000;
           in2=4'b1111;
        #6 cin=1'b0;
           in1=4'b1111;
           in2=4'b1111;

        #2 $finish;
    end

    initial
		$monitor($time," out=%b carry=%b",out, c[3]);
endmodule