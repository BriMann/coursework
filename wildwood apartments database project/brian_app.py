import wildwood_sql as db
import datetime

def updateTenantInfo(ID):
    print("1. First Name")
    print("2. Last Name")
    print("3. Phone Number")
    option = int(input("Choose what you want to update: "))
    options = ['tenantFirstName', 'tenantLastName', 'tenantPhoneNumber']
    selected_option = options[option - 1]
    value = input("Type your new info: ")
    print(selected_option)
    print(value)
    db.updatePersonalTenantInfo(selected_option, value, ID)
    print(f"Your new {selected_option} is now {value}.")

def tenant_menu():
    response = False
    while (response == False):
        print("*** Sign in ***")
        firstName=input('First name: ').strip()
        lastName=input('Last name: ').strip()
        phone_number=input('phone_number: ').strip()
        tenant_ID = int(input('ID: '))
        tenant = db.getTenantInfo(phone_number, firstName, lastName)
        # change if condition
        if firstName in str(tenant) and lastName in str(tenant) and phone_number in str(tenant):
            print("** Welcome " + firstName + " " + lastName)
            print("My ID: " + str(tenant_ID))
            print("My Phone Number " + phone_number)
            response = True
        else:
            print("/invalid input. Try Again!")
    if response == True:
        menu = False
        while menu == False:
            print("----- Menu ----")
            print("1. Update info")
            print("2. current balance, pay rent/deposit")
            print("3. Report problems")
            print("4. Exit")
            key = int(input("What would you like to do?: "))
            if key == 1:
                updateTenantInfo(tenant_ID)
            elif key == 2:
                print("1. Make deposit.")
                print("2. Check finances.")
                print("3. Pay rent.")
                option = int(input("What would you like to do? : "))
                if option == 1:
                    today = datetime.date.today() # Gives me an error
                    payment_amount = int(input("Please insert your deposit: "))
                    db.makeDepositPayment(payment_amount, tenant_ID)
                    print(f'''You deposited ${payment_amount} on {today}''')
                elif option == 2:
                    print("Amount Paid: $"+str(db.getFinance(tenant_ID)[2]))
                    print("Deposit: $"+str(db.getFinance(tenant_ID)[3]))
                    print("Rent Amount: $"+str(db.getFinance(tenant_ID)[4]))
                    print("*Balance: $" + str(db.getFinance(tenant_ID)[4]-db.getFinance(tenant_ID)[2]))
                elif option == 3:
                    today = datetime.date.today() # Gives me an error
                    payment_amount = int(input("Please insert your rent payment: "))
                    lateExcept = db.getLateException(tenant_ID)[0]
                    dueDate = db.getDueDate(tenant_ID)[0]
                    leaseID = db.getLeaseID(tenant_ID)[0]
                    db.makeRentPayment(payment_amount, lateExcept, dueDate, leaseID)
                    print(f'''You payed ${payment_amount} on {today}''')
                elif option == 4:
                    print("Bye!")
                else:
                    print('--------------------')
                    print(f'Sorry, you cannot do that...yet.')
                    print('--------------------')
            elif key == 3:  #adding complaint
                description = str(input("Please describe the problem: "))
                problem_types = ["electrical", "plumbing", "appliances"]
                print("Please select the problem type")
                for i, option in enumerate(problem_types):
                    print(f"{i}- {option}")
                ptselection = int(input("Type number here: "))
                ptype = problem_types[ptselection - 1]
                apartKey = int(db.getTenantsApartmentKey(tenant_ID)[0])
                db.generateMaintenanceKey(apartKey) #this creates a maintenaceKey in the Maintenance table that will be used in the ProblemReport table
                maintKey = int(db.getTenantsMaintenanceKey(apartKey)[0])
                db.fileProblemReport(maintKey, description, ptype)
                print("Your complaint has been filed")
            elif key == 4:
                print("Bye!")
                menu = True
            else:
                print('--------------------')
                print(f'Sorry, you cannot do that...yet.')
                print('--------------------')

if __name__=="__main__":
    print("*** Sign in as ***")
    print("1- HQ staff")
    print("2- Complex Manager")
    print("3- Tenant")
    print("4- Exit")
    choice=int(input('Choose an option above: '))
    if choice==1:
        hq_sign_in()
    elif choice==2:
        signInManager()
    elif choice==3:
        tenant_menu()
    elif choice==4:
        print("Bye!")
    else:
        print(f'Invalid option!')