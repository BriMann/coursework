Decimal_value = 0
Binary_value = ""

def binary_to_decimal(x):
    global Decimal_value
    loop_x = x[::-1]
    for i,bits in enumerate(loop_x):
        Decimal_value += int(bits)*(2**i)
    return Decimal_value

def decimal_to_binary(x):
    global Binary_value
    x_value = int(x)
    while x_value >= 1:
        Binary_value = str(x_value % 2) + Binary_value
        x_value = x_value//2
    return Binary_value

Again = "y"
while Again == "y":
    Conversion_type = int(input("Please select either 1)convert binary to decimal, 2)convert     decimal to binary, 3)quit :"))
    if Conversion_type == 1:
        Number_string = input("Please type the string you wish to convert:")
        print(binary_to_decimal(Number_string))
        Again = input("Do you want to go again?(y/n):")
    elif Conversion_type == 2:
        Number_string = input("Please type the string you wish to convert:")
        print(decimal_to_binary(Number_string))
        Again = input("Do you want to go again?(y/n):")
print("Goodbye")


