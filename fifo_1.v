module fifo_1# (
parameter memory_width = 8,
parameter memory_depth =8
)( 

input  wire clk,
input  wire rst,
input  wire[memory_width-1:0] data_in,
input  wire enable_wrt,
input  wire enable_rd,
output reg [memory_width-1:0] data_out,

output full,
output empty
//output not_full,
//output not_empty
 
    );
    wire out_wrt,out_rd,out_rst;
    reg wrt=0,rd=0,en_wrt=0,en_rd=0,rt=0,rt_f=0;
    
debouncer s2 (.clk(clk),.din(enable_wrt),.dfinal(out_wrt));
debouncer s3 (.clk(clk),.din(enable_rd),.dfinal(out_rd));
debouncer s4 (.clk(clk),.din(rst),.dfinal(out_rst));

reg [memory_width-1:0] memory [memory_depth-1:0];
reg [$clog2(memory_depth)-1:0] write_cnt=0;
reg [$clog2(memory_depth)-1:0] read_cnt=0;

reg [$clog2(memory_depth+1)-1:0] element_count = 0;

assign empty = (element_count == 0);
assign full =  (element_count == memory_depth);
//assign not_empty = ~empty;
//assign not_full = ~full;


always@ (posedge clk) begin

        wrt<= out_wrt;
    if(out_wrt==1 && wrt== 0)		  
        en_wrt<=!en_wrt;  
        if(out_wrt==0 && wrt== 1)		  
        en_wrt<=!en_wrt;  

end  
      
always@ (posedge clk) begin   
        
        rd<= out_rd;
    if(out_rd==1 && rd== 0)		  
    en_rd<=!en_rd;  
      if(out_rd==0 && rd== 1)		  
    en_rd<=!en_rd;  
end
     
always@ (posedge clk) begin   
        
        rt<= out_rst;
    if(out_rst==1 && rt== 0)		  
    rt_f<=!rt_f;  
      if(out_rst==0 && rt== 1)		  
        rt_f<=!rt_f;  
end

always @(negedge clk or negedge rst) begin
    if(~rst)begin
        write_cnt <= 0;
        read_cnt <= 0;
        element_count <= 0;
        data_out <= 0;
    end
    else begin
   
        if (en_wrt & ~full)begin
            memory[write_cnt] <= data_in;
            element_count <= element_count + 1;
            
            if (write_cnt == memory_depth-1)begin
            write_cnt <= 0;
            end
            else begin
             write_cnt <= write_cnt + 1;
            end
        end
        
         else if (en_rd & ~empty) begin 
            data_out <= memory[read_cnt];
            element_count <= element_count - 1;
            
            if(read_cnt == memory_depth-1)begin
             read_cnt <= 0;
            end
            else begin
            read_cnt <= read_cnt + 1;
            end
        end
   end
end
endmodule
