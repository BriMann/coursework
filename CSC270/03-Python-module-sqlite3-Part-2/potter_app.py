import potter_database as db


def user_add_person():
    print('---------Add a Person-----------')
    first = input("Enter the person's first name: ")
    last = input("Enter the person's last name: ")
    db.add_person(first, last)
    print(f'-----Person {first} {last} added!--------')
    
def user_remove_person():
    print('---------Remove a Person-----------')
    key = input("What is the person's key: ")
    db.remove_person(key)
    print(f'-----Person with key {key} removed!--------')
    
def user_add_relationship():
    print('---------Add Parent-Child Relationship-----------')
    parent_key = input("What is the parent's key: ")
    child_key = input("What is the child's key: ")
    db.add_parent_child(parent_key, child_key)
    print(f'-----Parent-Child Relationship Added!--------')
    
def show_parents():
    print('---------Show Parents-----------')
    user_person = input("Who would you like to show the parents of? Enter a name: ").strip()
    user_person = user_person.split()[0]
    persons = db.get_people(user_person)
    if len(persons) == 0:
        print(f"Could not find a {user_person}.")
        return
    elif len(persons) == 1:
        key = persons[0][0]
    else:
        for row in persons:
            print(row[0], row[1], row[2])
        key = int(input("Which person above did you mean? Enter a number: "))
    person = db.get_person(key)
    fullname = person[1] + " " + person[2]
    parents = db.get_parents(key)
    if len(parents) == 0:
        print('--------------------------------')
        print(f"Could not find any parents of {fullname}.")
    else:
        print(f"-------Parents of {fullname}---------")
        for parent in parents:
            print(parent[1], parent[2])
    print('--------------------------------')
            
def see_all_people():
    print('-----------All People-----------')
    people = db.get_all_people()
    for person in people:
        print(person[0], person[1], person[2])
    print('--------------------------------')
        

def main():
    options = ['Add person', 'Remove person', 'Add parent-child relationship', 'Show parents', 'See all people', 'Quit']
    
    while True:
        for i, option in enumerate(options):
            print(i, option)
        choice = int(input('What would you like to do? '))
        if choice == len(options) - 1: # The Quit option
            break
        elif choice == 0:
            user_add_person()
        elif choice == 1:
            user_remove_person()
        elif choice == 2:
            user_add_relationship()
        elif choice == 3:
            show_parents()
        elif choice == 4:
            see_all_people()
        else:
            print('--------------------')
            print(f'Sorry, I cannot perform option {choice}...yet.')
            print('--------------------')
            
    print('---------------------')
    print('Goodbye!')
    print('---------------------')
            
main()