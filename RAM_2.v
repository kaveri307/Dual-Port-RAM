module RAM_2(clk,chip_s1,w_en1,w_en2,o_en1,o_en2,r_en1,r_en2,data_out1,data_out2,data_in1,data_in2,address1,address2);
input clk,chip_s1,w_en1,w_en2,o_en1,o_en2,r_en1,r_en2;
input [4:0]address1;
input [4:0]address2;
input [7:0] data_in1;
input [7:0] data_in2;
output [7:0] data_out1;
output [7:0] data_out2;
reg [7:0] memory1[31:0];

reg [7:0] temp_data1;
reg [7:0] temp_data2;


always@(posedge clk)
begin
if(chip_s1 & w_en1 & !r_en1) 
  memory1[address1]<=data_in1;
end


always@(posedge clk)
begin
if(chip_s1& r_en1& !w_en1)
  temp_data1<=memory1[address1];

end

always@(posedge clk)
begin
if(chip_s1 & w_en2 & !r_en2) 
  memory1[address2]<=data_in2;
end

always@(posedge clk)
begin
if(chip_s1& r_en2 &!w_en2)
  temp_data2<=memory1[address2];

end


assign data_out1=chip_s1& o_en1 &r_en1 ? temp_data1: 1;
assign data_out2=chip_s1& o_en2 &r_en2 ? temp_data2: 1;

endmodule
