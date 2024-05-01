name = input("Enter your name:")
place = input("Enter your favorite place:")
classs = input("Enter your current class:")
hobby = input("Enter your personal hobby:")
thingymabob = input("Enter your favorite thingymabob:")
listything = [name, place, classs, hobby, thingymabob]
newlisty = []

reference = 'abcdefghijklmnopqrstuvwxyz'

def cipher(thingy):
    ciphtxt = ""
    for i in range(len(thingy)):
        char = thingy[i]
        if char in reference:
            index = reference.index(thingy[i])
            ref = reference[(index+3)%26]
            ciphtxt += ref
    return ciphtxt

for things in listything:
    new = cipher(things)
    newlisty.append(new)
    
print(newlisty)



