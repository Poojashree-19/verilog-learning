module half_adder(input a,
                  input b,
                 output sum , 
                  output carry);
  assign sum=~ab|a~b;
  assign carry=a&b;
  
endmodule
