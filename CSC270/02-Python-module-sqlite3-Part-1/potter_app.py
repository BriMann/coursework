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

def main():
    options = ['Add person', 'Remove person', 'Add parent-child relationship', 'Quit']
    
    while True:
        for i, option in enumerate(options):
            print(i, option)
        choice = int(input('What would you like to do? '))
        if choice == len(options) - 1:
            break
        elif choice == 0:
            user_add_person()
        elif choice == 1:
            user_remove_person()
        elif choice == 2:
            user_add_relationship()
        else:
            print('--------------------')
            print(f'Sorry, I cannot perform option {choice}...yet.')
            print('--------------------')
            
    print('---------------------')
    print('Goodbye!')
    print('---------------------')
            
main()