module fifo_tek_tb();

 reg clk=0,rst=0;
 reg   [7:0]x;
 reg   enable_wrt;
 reg   enable_rd;
 wire  [7:0]out;

fifo_tek dut (.data_in(x), .data_out(out),.clk(clk),.enable_wrt(enable_wrt),.rst(rst),. enable_rd(enable_rd));


always begin
clk=~clk;
#5;
end

initial begin
rst=0;
#20;
rst=1;
#20;
rst=0;
#20;
rst=1;


enable_wrt=1;
#10;
enable_wrt=0;
#10;
x=8'b1000;
#10;
enable_wrt=1;
#10;
enable_wrt=0;
#10;

x=8'b1001;
#10;
enable_wrt=1;
#10;
enable_wrt=0;
#10;
x=8'b1010;
#10;
x=8'b1100;
#10;
enable_wrt=1;
#10;
enable_wrt=0;
#10;
x=8'b1000;
#10;
enable_wrt=1;
#10;
enable_wrt=0;
#10;
x=8'b1001;
#10;
x=8'b1010;
#10;
enable_wrt=1;
#10;
enable_wrt=0;
#10;
x=8'b1100;
#10;
enable_wrt=1;
#10;
enable_wrt=0;
#10;


enable_rd=1;
#10;
enable_rd=0;
#10;
enable_rd=1;
#10;
enable_rd=0;
#10;
enable_rd=1;
#10;
enable_rd=0;
#10;
enable_rd=1;
#10;
enable_rd=0;
#10;
enable_rd=1;
#10;
enable_rd=0;
#10;
enable_rd=1;
#10;
enable_rd=0;
#10;
enable_rd=1;
#10;
enable_rd=0;
#10;
enable_rd=1;
#10;
enable_rd=0;
#10;


end




endmodule
