vsim -gui work.processor
add wave -position insertpoint sim:/processor/*

# load Reg File incremental
mem load -skip 0 -filltype inc -filldata 1 -fillradix hexadecimal /processor/decodeObj/u1/array_reg
mem load -skip 0 -filltype value -filldata 0 -fillradix binary /processor/fetchObj/instMem/RAM

#NOP
# mem load -filltype value -filldata 1101000001010011 -fillradix binary /processor/fetchObj/instMem/RAM(1)

#mov
#mem load -filltype value -filldata 0010101001010011 -fillradix binary /processor/fetchObj/instMem/RAM(1)


mem load -filltype value -filldata 0001101100101110 -fillradix binary /processor/fetchObj/instMem/RAM(1)
mem load -filltype value -filldata 0010001001010011 -fillradix binary /processor/fetchObj/instMem/RAM(4)
mem load -filltype value -filldata 0010001001010011 -fillradix binary /processor/fetchObj/instMem/RAM(5)

# clock with 100ps period
force -freeze sim:/processor/clk 0 0, 1 {50 ps} -r 100
