import wildwood_sql as db
import sqlite3
import jacinto_app as complexManager
import brian_app as tenants

#ADRIA
def hq_sign_in():
    print('***** HQ Sign In ******')
    while True:
        entry = [input('Enter Username: '), input('Enter Password: ')]
        userpass = [['adriabower', '123456789'], ['jacintoquimua','123456789'], ['brianmann','123456789'], ['imadahmetspahic','123456789']]
        #checking the login validity
        if entry in userpass:
            print(f'\n Welcome, {entry[0]}!')
            hq_menu()
            break
        else:
            print('Invalid Entry!')

def hq_menu():
    #display all complex options, picks a complex to view/update/change information about
    valid_response = False
    complexes = db.get_complexes()
    #if the insert is blank or choice=<show complexes>, it will show complexes and show the menu again
    while (valid_response == False):
        print('\n***********')
        complex = input('Enter Complex Key to show complex \nEnter <show complexes> to see all complexes \nor <exit> to exit)    ').strip()
        #exits menu
        if complex == 'exit':
            print('\nBye!')
            break
        #prints all complexes
        elif complex == 'show complexes':
            print ('\n-----Complexes-----')
            for building in complexes:
                print(f"Complex {building}")
        elif complex in str(complexes):
            valid_response = True
        else:
            #repeats menu
            print("\nInvalid response. ")


    #complex main menu options
    if valid_response == True:
        menu = False
        options_main = ['Complex Information', 'Manager Information', 'Tenant Information', 'Apartment Information', 'Maintenance Reports', 'Lease Information', 'Rent Information', 'Generate Quarterly Reports', 'Exit' ]
        while True:
            print(f"\n*** Complex {complex} Menu ***")
            for i, option in enumerate(options_main):
                print(f"{i}- {option}")
            choice = int(input('Choose an option above to access:  '))
            if choice == len(options_main) - 1: # The Quit option
                print('Bye!')
                break
            elif choice == 0:
                complex_information_sub_menu(complex)
            elif choice == 1:
                manager_information_sub_menu(complex)
            elif choice == 2:
                tenant_information_sub_menu(complex)
            elif choice == 3:
                apartment_information_sub_menu(complex)
            elif choice == 4:
                maintenance_reports_sub_menu(complex)
            elif choice == 5:
                lease_information_sub_menu(complex)
            elif choice == 6:
                rent_information_sub_menu(complex)
            elif choice == 7:
                quarterly_report_sub_menu(complex)
            else: print('Invalid option')

def complex_information_sub_menu(complex):
    ############  information menu options  ################
    options_list = ['Display Information', 'Add Information', 'Update Information', 'Delete Information', 'Main Menu']
    while True:
        print(f"\n*** Complex Information Menu ***")
        for i, option in enumerate(options_list):
            print(f"{i}- {option}")
        choice = int(input('Choose an option above to access:  '))
        if choice == len(options_list) - 1: # The Quit option
            break
        elif choice == 0:
            #display information
            complex_info = str(db.show_complex_info(complex)[0]).split(', ')
            complex_info.pop(2)
            sub_titles = ['Building ID','Tot. Apts.','Street','City','State','Zip Code','Country']
            print(f'******* Complex {complex} Information *********')
            #getting rid of extranneous symbols and printing information
            for i in range(len(complex_info)):
                if(complex_info[i][0] == "'"):
                    complex_info[i] = complex_info[i].replace("'", '')
                if('(' in complex_info[i]):
                    complex_info[i] = complex_info[i].replace("(", '')
                if(')' in complex_info[i]):
                    complex_info[i] = complex_info[i].replace(")", '')
                print(str(sub_titles[i]) + ':  ' + str(complex_info[i]))

        elif choice == 1:
            #add information
            print("****** New Complex info *******")
            buildingID = complex
            street = input('Address: ')
            city = input('City: ')
            state = input('State: ')
            zipCode = input('Zip Code: ')
            country = input('Country: ')
            totalApartments = input('Total Apartments: ')
            add_complex(street, city, state, zipCode, country, totalApartments)
            print("**** Complex Added ****")
        elif choice == 2:
            #update information
            print('Choose info to update: ')
            update_options = ['Street', 'City', 'State', 'Zip Code', 'Country', 'Total Apartments']
            corr_options = ['street', 'city', 'state', 'zipCode', 'country', 'totalApartments']
            for i, option in enumerate(update_options):
                print(f"{i}- {option}")
            choice_num = int(input('Choose an option above to access:  '))
            choice = update_options[choice_num]
            updated_thing = input(f'Enter New {choice}: ')
            update_complex(corr_options[choice_num], updated_thing , complex)
        elif choice == 3:
            if input(f"Are you sure you want to delete Complex {complex}? (y/n)  ") == 'y':
                if input(f"Are you really sure you want to delete Complex {complex}? (y/n)  ") == 'y':
                    delete_complex(complex)
            break
        else: print('Invalid option')

def manager_information_sub_menu(complex):
    ############  information menu options  ################
    options_list = ['Display Managers', 'Add New Manager', 'Update Manager Information', 'Delete Manager', 'Main Menu']
    while True:
        print(f"\n***** Manager Information Menu *****")
        for i, option in enumerate(options_list):
            print(f"{i}- {option}")
        choice = int(input('Choose an option above to access:  '))
        if choice == len(options_list) - 1: # The Quit option
            break
        elif choice == 0:
            #display information
            print(f"\n****** Manager(s) of Complex {complex} ******")
            manager_info = get_manager(complex)
            headers = ['First Name: ', 'Last Name: ', 'ID: ', 'Building #: ', 'Stipend: ']
            for i in range(len(manager_info)):
                for j in range(len(headers)):
                    print(headers[j], manager_info[i][j])
                print('******************')
        elif choice == 1:
            #adds a new manager
            print('****** Manager info *******')
            buildingID = complex
            managerFirstName = input('First Name: ')
            managerLastName = input('Last Name: ')
            stipend = input('Stipend: ')
            add_manager(buildingID, managerFirstName, managerLastName, stipend)
            print('****** Manager Added! ******')
        elif choice == 2:
            #update information
            manager_num = input('Enter Manager ID to change: ')
            update_options = ['First Name', 'Last Name', 'Stipend', 'Building ID']
            corr_options = ['managerFirstName', 'managerLastName', 'stipend', 'buildingID']
            for i, option in enumerate(update_options):
                print(f"{i}- {option}")
            choice_num = int(input('Choose an option above to access:  '))
            choice = update_options[choice_num]
            updated_thing = input(f'Enter New {choice}: ')
            update_manager(manager_num, corr_options[choice_num], updated_thing, complex)
        elif choice == 3:
            #deletes a manager after double confirmation
            print('***** Manager Deletion ******')
            delete_ID = input('Enter the ID of the manager you wish to delete: ')
            if input(f"Are you sure you want to delete Manager {delete_ID}? (y/n)  ") == 'y':
                if input(f"Are you really sure you want to delete Manager {delete_ID}? (y/n)  ") == 'y':
                        delete_manager(delete_ID)
                        print('Manager successfully deleted.')
            break
        else: print('Invalid option')

def tenant_information_sub_menu(someBuildingID):
    ############  information menu options  ################
    options_list = ['Display Tenants', 'Add Tenant', 'Update Tenant Information', 'Main Menu']
    while True:
        print(f"\n*** Tenant Information Menu ***")
        for i, option in enumerate(options_list):
            print(f"{i}- {option}")
        choice = int(input('Choose an option above to access:  '))
        if choice == len(options_list) - 1: # The Quit option
            break
        elif choice == 0:
            #display all tenants in a complex
            print(f"\n****** Tenants of Complex {complex} ******")
            tenants_info = get_tenants(someBuildingID)
            headers = ['Tenant ID #: ', 'First Name: ', 'Last Name:', 'Phone Number', 'Apartment #: ', 'Lease #: ']
            for i in range(len(tenants_info)):
                for j in range(len(headers)):
                    print(headers[j], tenants_info[i][j])
                print('***************************************')
        elif choice == 1:
            #add a tenant
            print("****** Tenant info *******")
            firstName=input('First name: ')
            lastName=input('Last name: ')
            phoneNumber=input('Phone number: ')
            print("*** Available apartments ***")
            print("ID- Size- Total Occupancy")
            #finds available apartments
            for i in range(0, len(complexManager.db.showAvailableApartments(someBuildingID))):
                print(complexManager.db.showAvailableApartments(someBuildingID)[i])
            apartmentID=int(input('* Choose an apartment ID above: '))
            leaseTime=int(input('* Lease: 6 or 12 months?: '))
            while leaseTime!=6 and leaseTime!=12:
                leaseTime=int(input('** Lease: 6 or 12 months?: '))
            print("* Payment *")
            deposit=1500.00
            rentAmount=900.00
            print("Deposit Amount($): "+str(deposit))
            print("Rent Amount($): "+str(rentAmount))
            print("Total($): "+str(deposit+rentAmount))
            pagamento=str(input('** Make payment? (y/n): '))
            #adds the tenant to the db
            if pagamento=='y':
                complexManager.db.addTenant(firstName, lastName, phoneNumber)
                complexManager.db.addLease(int(complexManager.db.getApartmentKey(someBuildingID, apartmentID)), leaseTime, deposit, rentAmount)
                complexManager.db.addRent(complexManager.db.getleaseNumberID(int(complexManager.db.getApartmentKey(someBuildingID, apartmentID))), rentAmount)
                complexManager.db.addTenantLease(int(complexManager.db.getTenantID(firstName, lastName, phoneNumber)), complexManager.db.getleaseNumberID(int(complexManager.db.getApartmentKey(someBuildingID, apartmentID))))
                print("****** Tenant Added! ******")
        elif choice == 2:
            #updates a tenant's info
            tenant_ID = input("Enter tenant ID: ")
            tenants.updateTenantInfo(tenant_ID)
        else: print('Invalid option')

def apartment_information_sub_menu(complex):
    ############  information menu options  ################
    options_list = ['Display Apartments', 'Add Apartment', 'Update Apartment Information', 'Main Menu']
    while True:
        print(f"\n*** Apartment Information Menu ***")
        for i, option in enumerate(options_list):
            print(f"{i}- {option}")
        choice = int(input('Choose an option above to access:  '))
        if choice == len(options_list) - 1: # The Quit option
            break
        elif choice == 0:
            #display information
            print(f"\n****** Apartments of Complex {complex} ******")
            apartments_info = get_apartments(complex)
            headers = ['Apartment #: ', 'Size: ', 'Total Occupancy: ', 'Building #: ']
            for i in range(len(apartments_info)):
                for j in range(len(headers)):
                    print(headers[j], apartments_info[i][j])
                print('***************************************')
        elif choice == 1:
            soemthing()
            #add information
        elif choice == 2:
            soemthing()
            #update information
        else: print('Invalid option')

def maintenance_reports_sub_menu(complex):
    ############  information menu options  ################
    options_list = ['Display Information', 'Add Information', 'Update Information', 'Main Menu']
    while True:
        print(f"\n*** Maintenence Reports Information Menu ***")
        for i, option in enumerate(options_list):
            print(f"{i}- {option}")
        choice = int(input('Choose an option above to access:  '))
        if choice == len(options_list) - 1: # The Quit option
            break
        elif choice == 0:
            #display information
            print(f"\n****** Maintenance Reports of Complex {complex} ******")
            maintenance_report_info = get_maintenance_reports(complex)
            headers = ['Apartment #: ', 'Problem Report Date: ', 'Resolution Date: ', 'Problem Type: ', 'Short Description: ',  'Resolution: ',  'Repair Company: ']
            for i in range(len(maintenance_report_info)):
                for j in range(len(headers)):
                    print(headers[j], maintenance_report_info[i][j])
                print('***************************************')
        elif choice == 1:
            soemthing()
            #add informations
        elif choice == 2:
            soemthing()
            #update information
        else: print('Invalid option')


def lease_information_sub_menu(complex):
    ############ information menu options  ################
    options_list = ['Display Information', 'Add Information', 'Update Information', 'Main Menu']
    while True:
        print(f"*** Lease Information Menu ***")
        for i, option in enumerate(options_list):
            print(f"{i}- {option}")
        choice = int(input('Choose an option above to access:  '))
        if choice == len(options_list) - 1: # The Quit option
            break
        elif choice == 0:
            #display information
            print(f"\n****** Lease Information of Complex {complex} ******")
            lease_info = get_leases(complex)
            headers = ['Lease # ID: ', 'Apartment #: ', 'Start Date: ', 'End Date: ', 'Rent Amount: ', 'Deposit: ', 'Tenant ID: ', 'First Name: ', 'Last Name: ']
            for i in range(len(lease_info)):
                for j in range(len(headers)):
                    print(headers[j], lease_info[i][j])
                print('***************************************')
        elif choice == 1:
            soemthing()
            #add informations
        elif choice == 2:
            soemthing()
            #update information
        else: print('Invalid option')


def rent_information_sub_menu(complex):
    ############ information menu options  ################
    options_list = ['Display Information', 'Add Information', 'Update Information', 'Main Menu']
    while True:
        print(f"*** Rent Information Menu ***")
        for i, option in enumerate(options_list):
            print(f"{i}- {option}")
        choice = int(input('Choose an option above to access:  '))
        if choice == len(options_list) - 1: # The Quit option
            break
        elif choice == 0:
            #display information
            print(f"\n****** Rent Information of Complex {complex} ******")
            rent_info = get_rents(complex)
            headers = ['Lease # ID: ', 'First Name: ', 'Last Name: ', 'Amount Paid: ', 'Payment Date: ', 'Late Exception: ', 'Due Date: ']
            for i in range(len(rent_info)):
                for j in range(len(headers)):
                    print(headers[j], rent_info[i][j])
                print('***************************************')
        elif choice == 1:
            soemthing()
            #add informations
        elif choice == 2:
            soemthing()
            #update information
        else: print('Invalid option')

def problem_reports_sub_menu(complex):
    ############ information menu options  ################
    options_list = ['Display Information', 'Add Information', 'Update Information', 'Main Menu']
    while True:
        print(f"*** Problem Reports Menu ***")
        for i, option in enumerate(options_list):
            print(f"{i}- {option}")
        choice = int(input('Choose an option above to access:  '))
        if choice == len(options_list) - 1: # The Quit option
            break
        elif choice == 0:
            #display information
            print(f"\n****** Problem Reports of Complex {complex} ******")
            rent_info = get_rents(complex)
            headers = ['Lease # ID: ', 'First Name: ', 'Last Name: ', 'Amount Paid: ', 'Payment Date: ', 'Late Exception: ', 'Due Date: ']
            for i in range(len(rent_info)):
                for j in range(len(headers)):
                    print(headers[j], rent_info[i][j])
                print('***************************************')
        elif choice == 1:
            soemthing()
            #add informations
        elif choice == 2:
            soemthing()
            #update information
        else: print('Invalid option')

def quarterly_report_sub_menu(someBuildingID):

    ############ information menu options  ################
    options_list = ['Display Information','Main Menu']
    while True:
        print(f"*** Quarterly Reports Menu ***")
        for i, option in enumerate(options_list):
            print(f"{i}- {option}")
        choice = int(input('Choose an option above to access:  '))
        if choice == len(options_list) - 1: # The Quit option
            break
        elif choice == 0:
            #generates quarterly report
            address = db.getComplexAddress(someBuildingID)
            year = db.getMonthandYear()[1]
            apartments = db.showAllApartments(someBuildingID)
            tenants = db.showAllTenants(someBuildingID)
            revenues = db.getRevenues(someBuildingID)
            expenses = db.getExpenses(someBuildingID)
            print("***** Quarterly Report *****")
            print("Building #" + str(someBuildingID))
            print("Address: " + str(address))
            month = int(db.getMonthandYear()[0])
            if month==12 or month==1 or month==2:
                print("Quarter: Winter")
            elif month==9 or month==10 or month==11:
                print("Quarter: Fall")
            elif month==6 or month==7 or month==8:
                print("Quarter: Summer")
            elif month==3 or month==4 or month==5:
                print("Quarter: Spring")

            print("Year: "+ year)
            print("Total apartments: "+str(len(apartments)))
            print("Currently occupied: "+ str(len(tenants)) + " ["+ str(100*len(tenants)/len(apartments)) +"%]")
            print("No. of changing tenants: 13"+str(tenants))

            totalRevenue=float(revenues[0][0])
            for i in range(1, len(revenues)):
                totalRevenue+=float(revenues[i][0])
            if len(expenses)>0:
                totalExpense=float(expenses[0][0])+float(expenses[0][1])
                for i in range(1, len(expenses)):
                    totalExpense+=float(expenses[i][0])+float(expenses[i][1])
            else: totalExpense=0

            print("*Total Revenue($): "+str(totalRevenue))
            print("*Total Expenses($): "+str(totalExpense))
            if totalRevenue-totalExpense>=0:
                print("**Net Profit($): "+str(totalRevenue-totalExpense))
            else: print("**Net Loss($): "+str(totalRevenue-totalExpense))
        else: print('Invalid option')

################################################ SQL ###########################################################
def get_rents(buildingID):
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute('''
            SELECT Rent.leaseNumberID, tenantFirstName, tenantLastName, amountPaid, paymentDate, lateException, dueDate FROM Rent
            LEFT JOIN Lease ON Lease.leaseNumberID = Rent.leaseNumberID
            LEFT JOIN TenantLease ON TenantLease.leaseNumberID = Lease.leaseNumberID
            LEFT JOIN Apartment ON Apartment.apartmentKey = Lease.apartmentKey
            LEFT JOIN Tenant ON TenantLease.tenantID = Tenant.tenantID
            WHERE BuildingID == ?;''', (buildingID))
    # Fetch some data
    data = cur.fetchall()
    #doing stuff
    # Closing down
    conn.commit()
    conn.close()
    # return what you fetched:
    return data

def get_leases(buildingID):
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute('''
            SELECT Lease.leaseNumberID, Apartment.apartmentID, startDate, endDate, rentAmount, deposit, TenantLease.tenantID, tenantFirstName, tenantLastName FROM Lease
            LEFT JOIN Apartment ON Apartment.apartmentKey = Lease.apartmentKey
            LEFT JOIN TenantLease ON TenantLease.leaseNumberID = Lease.leaseNumberID
            LEFT JOIN Tenant ON Tenant.tenantID = TenantLease.tenantID
            WHERE BuildingID == ?;''', (buildingID))
    # Fetch some data
    data = cur.fetchall()
    #doing stuff
    # Closing down
    conn.commit()
    conn.close()
    # return what you fetched:
    return data

def get_maintenance_reports(buildingID):
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute('''
            SELECT Maintenance.apartmentKey, ProblemReport.problemReportDate, Maintenance.resolutionDate, ProblemReport.problemType, ProblemReport.problemShortDescription, Maintenance.resolution,  Maintenance.repairCompany FROM Maintenance
            LEFT JOIN ProblemReport ON Maintenance.maintenanceKey = ProblemReport.maintenanceKey
            LEFT JOIN Apartment ON Apartment.apartmentKey = Maintenance.apartmentKey
            WHERE BuildingID == ?;''', (buildingID))
    # Fetch some data
    data = cur.fetchall()
    #doing stuff
    # Closing down
    conn.commit()
    conn.close()
    # return what you fetched:
    return data

def add_apartment(apartmentID, apartmentSize, totalOccupancy, buildingID):
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute('''
            INSERT INTO Apartmenr (apartmentID, apartmentSize, totalOccupancy, buildingID)
            VALUES (?, ?, ?, ?);''', (apartmentID, apartmentSize, totalOccupancy, buildingID))
    # Closing down
    conn.commit()
    conn.close()
def get_apartments(buildingID):
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute('''
            SELECT apartmentID, apartmentSize, totalOccupancy, buildingID FROM Apartment
            WHERE BuildingID == ?;''', (buildingID))
    # Fetch some data
    data = cur.fetchall()
    #doing stuff
    # Closing down
    conn.commit()
    conn.close()
    # return what you fetched:
    return data

def get_tenants(buildingID):
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute('''
            SELECT Tenant.tenantID, Tenant.tenantFirstName, Tenant.tenantLastName, Tenant.tenantPhoneNumber, Apartment.apartmentID, TenantLease.leaseNumberID FROM Tenant
            LEFT JOIN TenantLease ON Tenant.tenantID = TenantLease.tenantID
            LEFT JOIN Lease ON TenantLease.leaseNumberID = Lease.leaseNumberID
            LEFT JOIN Apartment ON Lease.apartmentKey = Apartment.apartmentKey
            WHERE buildingID == ?;''', (buildingID))
    # Fetch some data
    data = cur.fetchall()
    #doing stuff
    #data = data[0]
    # Closing down
    conn.commit()
    conn.close()
    # return what you fetched:
    return data


def delete_manager(managerID):
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute(f'''
            DELETE FROM Manager WHERE managerID = ? ;''', (managerID,))
    conn.commit()
    conn.close()
def update_manager(managerID, choice, updated_thing, buildingID ):
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute(f'''
            UPDATE Manager
            SET {choice} = ?
            WHERE managerID == ? AND buildingID == ?;''', (updated_thing, managerID, buildingID))
    
    # Closing down
    conn.commit()
    conn.close()
def add_manager(buildingID, managerFirstName, managerLastName, stipend):
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute('''
            INSERT INTO Manager (managerFirstName, managerLastName, buildingID, stipend)
            VALUES (?, ?, ?, ?);''', (managerFirstName, managerLastName, buildingID, stipend))
    # Closing down
    conn.commit()
    conn.close()
def get_manager(buildingID):
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute('''
            SELECT * FROM Manager
            WHERE BuildingID == ?;''', (buildingID))
    # Fetch some data
    data = cur.fetchall()
    #doing stuff
    #data = data[0]
    # Closing down
    conn.commit()
    conn.close()
    # return what you fetched:
    return data


def update_complex(choice, updated_thing, buildingID):
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    if choice == 'totalApartments':
        cur.execute('''
                UPDATE ComplexInformation
                SET totalApartments = ?
                WHERE buildingID = ?;''', (updated_thing, buildingID))
    else:
        cur.execute(f'''
               UPDATE ComplexAddress
               SET {choice} = ?
               WHERE buildingID = ?;''', (updated_thing, buildingID))
    # Fetch some data
    data = cur.fetchall()
    #doing stuff
    #data = data[0]
    # Closing down
    conn.commit()
    conn.close()
def delete_complex(buildingID):
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute('''
            DELETE FROM ComplexInformation WHERE buildingID = ? ;''', (buildingID,))
    cur.execute('''
            DELETE FROM ComplexAddress WHERE buildingID = ? ;''', (buildingID,))
    # Closing down
    conn.commit()
    conn.close()
def add_complex(Street, City, State, zipCode, Country, totalApartments):
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute('''
            INSERT INTO ComplexInformation (totalApartments)
            VALUES (?);''', (totalApartments,))
    cur.execute('''
        INSERT INTO ComplexAddress (Street, City, State, zipCode, Country)
        VALUES (?, ?, ?, ?, ?);''', (Street, City, State, zipCode, Country))
    # Closing down
    conn.commit()
    conn.close()
def show_complex_info(complexID):
    '''returns a 2D array of the requested information'''
    # Setting up
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute('''
            SELECT * FROM ComplexInformation
            LEFT JOIN ComplexAddress ON ComplexInformation.buildingID = ComplexAddress.buildingID
            WHERE ComplexInformation.buildingID = ? AND ComplexAddress.buildingID = ?;
            ''', (str(complexID), str(complexID)))
    # Fetch some data
    data = cur.fetchall()
    #doing stuff
    complexes = []
    for i in range(0, len(data)):
        for j in range(0, len(data[i])):
            complexes.append(data[i][j])
    # Closing down
    conn.commit()
    conn.close()
    # return what you fetched:
    return data


def get_complexes():
    '''returns an array of strings that are the complexes' primary keys'''
    # Setting up
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute('''
            SELECT buildingID FROM ComplexInformation;
            ''')
    # Fetch some data
    data = cur.fetchall()
    # tuples > ints
    complexes = []
    for i in range(0, len(data)):
        complexes.append(str(data[i][0]))
    # Closing down
    conn.commit()
    conn.close()
    # return what you fetched:
    return complexes

if __name__=="__main__":
    hq_sign_in()
