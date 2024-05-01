
def Bin_to_hex(x):
    Binary_dictionary={"0000":"0", "0001":"1",               "0010":"2","0011":"3","0100":"4","0101":"5","0110":"6", "0111":"7", "1000":"8","1001":"9","1010":"A", "1011":"B", "1100":"C","1101":"D", "1110":"E", "1111":"F"}
    Hex_value = ""
    for i in range(0, len(x), 4):
        if x[i:i+4] in Binary_dictionary.keys():
            Hex_value = Hex_value + Binary_dictionary[x[i:i+4]]
    output = ("You entered:" + x + "\n"+
              "Hex equivalent:" + Hex_value)
    return output

def main():
    
    Again = "y"
    while Again == "y":
        Binary_string = input("Please type the binary bit string:")
        print(Bin_to_hex(Binary_string))
        Again = input("Do you want to go again?(y/n):")
    print("Goodbye")
main()
