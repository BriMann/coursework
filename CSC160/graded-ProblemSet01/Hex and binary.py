Hex_string = input(""""Please type the hexedecimal bit string (Please don't use a 0x prefix):""")
Hex_dictionary = {"0":"0000" ,"1":"0001" ,"2":"0010" ,"3":"0011" ,"4":"0100" ,"5":"0101" ,"6":"0110" ,"7":"0111" ,"8":"1000" ,"9":"1001" ,"a":"1010" ,"b":"1011" ,"c":"1100" ,"d":"1101" ,"e":"1110" ,"f":"1111"}
Binary_value = ""

for bits in Hex_string:
    if bits in Hex_dictionary.keys():
        Binary_value = Binary_value + Hex_dictionary[bits] + " "
    
print("You entered: " + Hex_string + "\n" +
      "The binary equivalent is: " + Binary_value + "\n" +
      "Thanks for playing! Bye.")