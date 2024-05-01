import wildwood_sql as db

#JACINTO
#list all the apartments and back to menu
def allApartments(someBuildingID):
    print("ID- Size- Total Occupancy- Deposit Amount- Rent Amount")
    for i in range(0, len(db.showAllApartments(someBuildingID))):
        print(db.showAllApartments(someBuildingID)[i])
    print("0- Back to main Menu")

def complexManager_menu(someBuildingID):
    #menu options
    print("*** Menu ***")
    print("1- All tenants")
    print("2- Add tenant")
    print("3- All apartments")
    print("4- Prepare Quarterly report")
    print("5- Exit")
    myChoice=int(input('Choose an option above: '))
    if myChoice==1: #ALL TENANTS
        print("ID- Name- Phone Number- Apartment ID")
        for i in range(0, len(db.showAllTenants(someBuildingID))):
            print(db.showAllTenants(someBuildingID)[i])
        complexManager_menu(someBuildingID)
    elif myChoice==2: #ADD TENANT
        if len(db.showAllApartments(someBuildingID))>len(db.showAllTenants(someBuildingID)):
            #get the tenants info first
            print("*** Tenant info ***")
            firstName=input('First name: ')
            lastName=input('Last name: ')
            phoneNumber=input('Phone number: ')
            #show the apartments still vacant
            print("*** Available apartments ***")
            print("ID- Size- Total Occupancy")
            for i in range(0, len(db.showAvailableApartments(someBuildingID))):
                print(db.showAvailableApartments(someBuildingID)[i])
            apartmentID=int(input('* Choose an apartment ID above: '))
            leaseTime=int(input('* Lease: 6 or 12 months?: ')) #Wildwood only accepts 6 or 12 months lease
            while leaseTime!=6 and leaseTime!=12:
                leaseTime=int(input('** Lease: 6 or 12 months?: '))
            #payment part; hardcoded deposit and rent because i didnt have time to implement prices according to size
            print("* Payment *")
            deposit=1500.00
            rentAmount=900.00
            print("Deposit Amount($): "+str(deposit))
            print("Rent Amount($): "+str(rentAmount))
            print("Total($): "+str(deposit+rentAmount))
            #ask for tenant payment after seeing total
            pagamento=str(input('** Make payment? (y/n): '))
            if pagamento=='y':
                db.addTenant(firstName, lastName, phoneNumber)
                db.addLease(int(db.getApartmentKey(someBuildingID, apartmentID)), leaseTime, deposit, rentAmount)
                db.addRent(db.getleaseNumberID(int(db.getApartmentKey(someBuildingID, apartmentID))), rentAmount)
                db.addTenantLease(int(db.getTenantID(firstName, lastName, phoneNumber)), db.getleaseNumberID(int(db.getApartmentKey(someBuildingID, apartmentID))))
                print("*** Tenant Added!")
                complexManager_menu(someBuildingID)
            #back to main menu if tentant dont pay
            elif pagamento=='n':
                complexManager_menu(someBuildingID)
        else:
            print("* No apartment available!")
            complexManager_menu(someBuildingID)
    elif myChoice==3: #ALL APARTMENTS
        #show all the apartments in the managers complex
        allApartments(someBuildingID)
        #manager can see the info of rented apartments
        apartmentID=int(input('* Choose a rented apartment ID above or 0 to go back to the main Menu: '))
        if apartmentID!=0:
            print("*** Apartment information ***")
            print("-----------------------")
            print("* Tenant *")
            print("ID- Name- Phone Number")
            print(db.showTenantInApartment(int(db.getApartmentKey(someBuildingID, apartmentID))))
            print("-----------------------")
            print("* Rent Balance *")
            print("Rent Amount($): "+str(db.rentBalance(int(db.getApartmentKey(someBuildingID, apartmentID)))[0]))
            print("Amount Paid($): "+str(db.rentBalance(int(db.getApartmentKey(someBuildingID, apartmentID)))[1]))
            print("Balance($): "+str(db.rentBalance(int(db.getApartmentKey(someBuildingID, apartmentID)))[0]-db.rentBalance(int(db.getApartmentKey(someBuildingID, apartmentID)))[1]))
            print("-----------------------")
            print("* Problem Report(s) *")
            print("~~~~~~~ #0 - Menu ~~~~~~~")
            for i in range(0, len(db.getProblemReport(int(db.getApartmentKey(someBuildingID, apartmentID))))):
                print("~~~~~~~ "+"Report #"+str(i+1)+" ~~~~~~~")
                print("Report date: "+ str(db.getProblemReport(int(db.getApartmentKey(someBuildingID, apartmentID)))[i][0]))
                print("Problem type: "+ str(db.getProblemReport(int(db.getApartmentKey(someBuildingID, apartmentID)))[i][1]))
                print("Description: "+ str(db.getProblemReport(int(db.getApartmentKey(someBuildingID, apartmentID)))[i][2]))
                print("Resolution: "+ str(db.getProblemReport(int(db.getApartmentKey(someBuildingID, apartmentID)))[i][3]))
                print("Resolution date: "+ str(db.getProblemReport(int(db.getApartmentKey(someBuildingID, apartmentID)))[i][4]))
                print("Repair company: "+ str(db.getProblemReport(int(db.getApartmentKey(someBuildingID, apartmentID)))[i][5]))
            print("-----------------------")
            escolha=int(input('* Choose problem to resolve or enter "0" to go back to Menu: '))
            if escolha==0:
                complexManager_menu(someBuildingID)
            else:
                db.resolveProblemReport(MaintenanceKey, resolution, repairCompany)
        else:
            complexManager_menu(someBuildingID)
    elif myChoice==4: #QUARTERLY REPORT
        print("*** Quarterly Report ***")
        print("Building #" + str(someBuildingID))
        print("Address: " + str(db.getComplexAddress(someBuildingID)))
        month = int(db.getMonthandYear()[0])
        if month==12 or month==1 or month==2:
            print("Quarter: Winter")
        elif month==9 or month==10 or month==11:
            print("Quarter: Fall")
        elif month==6 or month==7 or month==8:
            print("Quarter: Summer")
        elif month==3 or month==4 or month==5:
            print("Quarter: Spring")
        print("Year: "+db.getMonthandYear()[1])
        print("Total apartments: "+str(len(db.showAllApartments(someBuildingID))))
        print("Currently occupied: "+str(len(db.showAllTenants(someBuildingID))) + " ["+ str(100*len(db.showAllTenants(someBuildingID))/len(db.showAllApartments(someBuildingID)))+"%]")
        print("No. of changing tenants: 13"+str())#TO DO! Hard coded for now:)
        #preparing the revenue and expenses
        totalRevenue=float(db.getRevenues(someBuildingID)[0][0])
        for i in range(1, len(db.getRevenues(someBuildingID))):
            totalRevenue+=float(db.getRevenues(someBuildingID)[i][0])
        if len(db.getExpenses(someBuildingID))>0:
            totalExpense=float(db.getExpenses(someBuildingID)[0][0])+float(db.getExpenses(someBuildingID)[0][1])
            for i in range(1, len(db.getExpenses(someBuildingID))):
                totalExpense+=float(db.getExpenses(someBuildingID)[i][0])+float(db.getExpenses(someBuildingID)[i][1])
        else: totalExpense=0
        print("*Total Revenue($): "+str("{:.2f}".format(totalRevenue))) #so it displays two decimals only
        print("*Total Expenses($): "+str("{:.2f}".format(totalExpense)))
        if totalRevenue-totalExpense>=0:
            print("**Net Profit($): "+str("{:.2f}".format(totalRevenue-totalExpense)))
        else: print("**Net Loss($): "+str("{:.2f}".format(totalRevenue-totalExpense)))
        complexManager_menu(someBuildingID)
    elif myChoice==5: #EXIT
        print(f'Bye!')
    else:
        print(f'Invalid option!')

def signInManager():
    #initial Screen after after choosing to sign in as complex manager
    print("*** Sign in ***")
    firstName=input('First name: ')
    lastName=input('Last name: ')
    managerID=input('Manager ID: ')
    #the credentials are incorrent
    while bool(db.getManagerInfo(firstName, lastName, managerID))==False:
        print(f'Manager not found!')
        print("*** Sign in ***")
        firstName=input('First name: ')
        lastName=input('Last name: ')
        managerID=input('Manager ID: ')
    #the credentials are correct
    print("** Welcome " + str(db.getManagerInfo(firstName, lastName, managerID)[0]) + " " + str(db.getManagerInfo(firstName, lastName, managerID)[1]))
    print("Manager ID: " + str(db.getManagerInfo(firstName, lastName, managerID)[2]))
    print("Stipend: " + str(db.getManagerInfo(firstName, lastName, managerID)[4]))
    print("Building ID: " + str(db.getManagerInfo(firstName, lastName, managerID)[3]))
    print("Address: " + db.getComplexAddress(db.getManagerInfo(firstName, lastName, managerID)[3]))
    #print the menu for the manager
    complexManager_menu(db.getManagerInfo(firstName, lastName, managerID)[3])
if __name__=="__main__":
    #ask user how they would like to sign in
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
