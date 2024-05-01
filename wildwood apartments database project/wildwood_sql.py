import sqlite3
from datetime import date

#ADRIA
def get_complexes():
    '''returns an array of the complexes' primary keys'''
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
        complexes.append(data[i][0])
    # Closing down
    conn.commit()
    conn.close()
    # return what you fetched:
    return complexes

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
    # Closing down
    conn.commit()
    conn.close()
    # return what you fetched:
    return data
def get_complex_information():
    '''returns an array of the complexes' primary keys'''
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
    # getting the address
    # Closing down
    conn.commit()
    conn.close()
    # return what you fetched:
    return data

#JACINTO
def getApartmentKey(buildingID, apartmentID):
    # Setting up
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute('''
            SELECT apartmentKey FROM Apartment WHERE 
            buildingID=? AND apartmentID=?;
            ''', (buildingID, apartmentID))
    # Fetch some data
    data = cur.fetchone()
    myKey=data[0]
    # Closing down
    conn.commit()
    conn.close()
    # return what you fetched:
    return myKey

def getComplexAddress(buildingID):
    # Setting up
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute('''
            SELECT Street, City, State, zipCode, Country FROM ComplexAddress WHERE 
            buildingID=?;
            ''', (buildingID,))
    # Fetch some data
    data = cur.fetchone()
    # getting the address
    myaddress=str(data[0])
    for i in range(1, len(data)):
        myaddress+= ", "+str(data[i])
    # Closing down
    conn.commit()
    conn.close()
    # return what you fetched:
    return myaddress

def getManagerInfo(firstName, lastName, managerID):
    # Setting up
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute('''
            SELECT managerFirstName, managerLastName, managerID, buildingID, stipend FROM Manager WHERE 
            managerFirstName=? and 
            managerLastName=? and 
            managerID=?;
            ''', (firstName, lastName, managerID))
    # Fetch some data
    data = cur.fetchone()
    # Closing down
    conn.commit()
    conn.close()
    # return what you fetched:
    return data

def getTenantID(firstName, lastName, phoneNumber):
    # Setting up
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute('''
                    SELECT tenantID FROM Tenant
                    WHERE tenantFirstName=? AND tenantLastName=? AND tenantPhoneNumber=?;
                ''', (firstName, lastName, phoneNumber))
    # Fetch data
    data = cur.fetchone()
    tenantID=int(data[0])
    # Closing down
    conn.commit()
    conn.close()
    # return what you fetched:
    return tenantID

def getleaseNumberID(apartmentKey):
    # Setting up
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute('''
                    SELECT leaseNumberID FROM Lease
                    WHERE apartmentKey=?;
                ''', (apartmentKey,))
    # Fetch data
    data = cur.fetchone()
    leaseNumberID=int(data[0])
    # Closing down
    conn.commit()
    conn.close()
    # return what you fetched:
    return leaseNumberID

def getProblemReport(apartmentKey):
    # Setting up
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute('''
            SELECT ProblemReport.problemReportDate , ProblemReport.problemType, ProblemReport.problemShortDescription, 
            Maintenance.resolution, Maintenance.resolutionDate, Maintenance.repairCompany FROM ProblemReport
            INNER JOIN Maintenance ON ProblemReport.MaintenanceKey=Maintenance.MaintenanceKey
            WHERE Maintenance.apartmentKey=?;
            ''', (apartmentKey,))
    # Fetch some data
    data = cur.fetchall()
    # Closing down
    conn.commit()
    conn.close()
    # return what you fetched:
    return data

def addTenant(firstName, lastName, phoneNumber):
    # Setting up
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute('''
            INSERT INTO Tenant(tenantFirstName, tenantLastName, tenantPhoneNumber)
            VALUES (?, ?, ?);
            ''', (firstName, lastName, phoneNumber))
    # Closing down
    conn.commit()
    conn.close()

def addLease(apartmentKey, timeoflease, deposit, rentAmount):
    # Setting up
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute(f'''
            INSERT INTO Lease(apartmentKey, startDate, endDate, deposit, rentAmount)
            VALUES(?, datetime('now', 'localtime'), datetime('now', 'localtime', '+ {timeoflease} months'), ?, ?);
            ''', (apartmentKey, deposit, rentAmount))
    # Closing down
    conn.commit()
    conn.close()

def addRent(leaseNumberID, amountPaid):
    # Setting up
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute(f'''
            INSERT INTO Rent(leaseNumberID, amountPaid, paymentDate, dueDate)
            VALUES(?, ?, datetime('now', 'localtime'), datetime('now', 'localtime'));
            ''', (leaseNumberID, amountPaid))
    # Closing down
    conn.commit()
    conn.close()

def addTenantLease(tenantID, leaseNumberID):
    # Setting up
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute('''
            INSERT INTO TenantLease(tenantID, leaseNumberID)
            VALUES (?, ?);
            ''', (tenantID, leaseNumberID))
    # Closing down
    conn.commit()
    conn.close()

def showAllTenants(managerBuildingID):
    # Setting up
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute('''
                    SELECT Tenant.tenantID, Tenant.tenantFirstName, Tenant.tenantLastName, Tenant.tenantPhoneNumber, Apartment.apartmentID FROM Tenant
                    INNER JOIN TenantLease on Tenant.tenantID=TenantLease.tenantID
                    INNER JOIN Lease on TenantLease.leaseNumberID=Lease.leaseNumberID
                    INNER JOIN Apartment on Lease.apartmentKey=Apartment.apartmentKey
                    WHERE TenantLease.leaseNumberID IN (
                    SELECT leaseNumberID FROM Lease WHERE apartmentKey IN (
                    SELECT apartmentKey FROM Apartment WHERE buildingID=?));
                ''', (managerBuildingID,))
    # Fetch all data
    data = cur.fetchall()
    alltenants=[]
    # getting the tenants
    for i in range(0, len(data)):
        tenantID=str(data[i][0])
        tenantName=str(data[i][1]) + " " + str(data[i][2])
        tenantPhone=str(data[i][3])
        tenantApartmentID=str(data[i][4])
        mytenant=tenantID+"- "+tenantName+"- "+tenantPhone+"- "+tenantApartmentID
        alltenants.append(mytenant)
    # Closing down
    conn.commit()
    conn.close()
    # return what you fetched:
    return alltenants

def showTenantInApartment(apartmentKey):
    # Setting up
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute('''
                    SELECT * FROM Tenant 
                    INNER JOIN TenantLease ON Tenant.tenantID=TenantLease.tenantID
                    WHERE TenantLease.leaseNumberID IN (
                    SELECT leaseNumberID FROM Lease WHERE apartmentKey=?);
                ''', (apartmentKey,))
    # Fetch all data
    data = cur.fetchone()
    # getting the tenant
    tenantID=str(data[0])
    tenantName=str(data[1]) + " " + str(data[2])
    tenantPhone=str(data[3])
    mytenant=tenantID+"- "+tenantName+"- "+tenantPhone
    # Closing down
    conn.commit()
    conn.close()
    # return what you fetched:
    return mytenant

def showAllApartments(managerBuildingID):
    # Setting up
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute('''
                    SELECT Apartment.apartmentID, Apartment.apartmentSize, Apartment.totalOccupancy, Lease.deposit, Lease.rentAmount FROM Apartment 
                    LEFT JOIN Lease on Lease.apartmentKey=Apartment.apartmentKey
                    WHERE buildingID=?;
                ''', (managerBuildingID,))
    # Fetch all data
    data = cur.fetchall()
    allapartments=[]
    # getting the apartments
    for i in range(0, len(data)):
        apartmentID=str(data[i][0])
        apartmentSize=str((data[i][1]))
        totalOccupancy=str(data[i][2])
        deposit=str((data[i][3]))
        rentAmount=str((data[i][4]))
        myapartment=apartmentID+"- "+apartmentSize+"- "+totalOccupancy+"- "+deposit+"- "+rentAmount
        allapartments.append(myapartment)
    # Closing down
    conn.commit()
    conn.close()
    # return what you fetched:
    return allapartments

def showAvailableApartments(managerBuildingID):
    # Setting up
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute('''
                    SELECT Apartment.apartmentID, Apartment.apartmentSize, Apartment.totalOccupancy, Lease.deposit, Lease.rentAmount FROM Apartment 
                    LEFT JOIN Lease on Lease.apartmentKey=Apartment.apartmentKey 
                    WHERE Apartment.buildingID=? AND Apartment.apartmentKey NOT IN (
                    SELECT Apartment.apartmentKey FROM Apartment 
                    INNER JOIN Lease on Lease.apartmentKey=Apartment.apartmentKey
                    WHERE buildingID=?);
                ''', (managerBuildingID, managerBuildingID))
    # Fetch all data
    data = cur.fetchall()
    allapartments=[]
    # getting the apartments
    for i in range(0, len(data)):
        apartmentID=str(data[i][0])
        apartmentSize=str(data[i][1])
        totalOccupancy=str(data[i][2])
        myapartment=apartmentID+"- "+apartmentSize+"- "+totalOccupancy
        allapartments.append(myapartment)
    # Closing down
    conn.commit()
    conn.close()
    # return what you fetched:
    return allapartments

def getRevenues(someBuildingID):
    # Setting up
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute('''
                    SELECT amountPaid FROM Rent
                    INNER JOIN Lease ON Lease.leaseNumberID=Rent.leaseNumberID
                    INNER JOIN Apartment ON Apartment.apartmentKey=Lease.apartmentKey
                    WHERE Apartment.buildingID=?;
                ''', (someBuildingID,))
    # Fetch data
    data = cur.fetchall()
    # Closing down
    conn.commit()
    conn.close()
    # return what you fetched:
    return data

def getExpenses(someBuildingID):
    # Setting up
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute('''
                    SELECT tenantExpense, businessExpense FROM Expenses
                    WHERE buildingID=?;
                ''', (someBuildingID,))
    # Fetch data
    data = cur.fetchall()
    # Closing down
    conn.commit()
    conn.close()
    # return what you fetched:
    return data

def rentBalance(apartmentKey):
    # Setting up
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute('''
                    SELECT Lease.rentAmount, Rent.amountPaid from Lease
                    INNER JOIN Rent ON Rent.leaseNumberID=Lease.leaseNumberID
                    WHERE Lease.apartmentKey=?
                ''', (apartmentKey,))
    # Fetch data
    data = cur.fetchone()
    # Closing down
    conn.commit()
    conn.close()
    # return what you fetched:
    return data

def getMonthandYear():
    # Setting up
    conn = sqlite3.connect('Wildwood_apartments.db')
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    # Write a SQL query to get something:
    cur.execute('''
                    SELECT strftime('%m', 'now', 'localtime'), strftime('%Y', 'now', 'localtime') FROM Lease;
                ''')
    # Fetch data
    data = cur.fetchone()
    # Closing down
    conn.commit()
    conn.close()
    # return what you fetched:
    return data



#BRIAN

# update the personal information of the tenant based on the parameters of what they want to update and their tenant ID

def updatePersonalTenantInfo(option, value, ID):
    conn = sqlite3.connect("Wildwood_apartments.db")
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    cur.execute(f'''UPDATE Tenant
                    SET {option}=?
                    WHERE tenantID=?; ''' , (value,ID))
    row = cur.fetchone()
    conn.commit()
    conn.close()

# retreives the tenants information based on their first name, last name, and phone number

def getTenantInfo(phone_number, firstName, lastName):
    conn = sqlite3.connect("Wildwood_apartments.db")
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    cur.execute('''SELECT tenantID, tenantFirstName, tenantLastName, tenantPhoneNumber FROM Tenant 
                WHERE tenantPhoneNumber=? AND tenantFirstName=? AND tenantLastName=?;''', (phone_number, firstName, lastName))
    row = cur.fetchone()
    conn.commit()
    conn.close()
    return row

# get all of the tenants financial information. The amount of money they paid, their deposit, and how much rent is owed

def getFinance(ID): # Selects only first tenant
    conn = sqlite3.connect("Wildwood_apartments.db")
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    cur.execute(f'''SELECT T.tenantFirstName, T.tenantLastName, R.amountPaid, L.deposit, L.rentAmount
                    FROM
                        Rent AS R 
                        JOIN Lease AS L ON L.leaseNumberID = R.leaseNumberID
                        JOIN TenantLease AS TL ON TL.leaseNumberID = L.leaseNumberID
                        JOIN Tenant AS T ON T.tenantID = TL.tenantID
                    WHERE T.tenantID = {ID} AND TL.tenantID = {ID};''')
    row = cur.fetchone()
    conn.commit()
    conn.close()
    return row

# updates the users deposit amount by adding to the total

def makeDepositPayment(value, ID):
    conn = sqlite3.connect("Wildwood_apartments.db")
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    cur.execute(f'''UPDATE Lease
                    SET deposit = deposit + {value}
                    WHERE leaseNumberID IN(
                        SELECT leaseNumberID FROM TenantLease
                        WHERE tenantID IN(
                            SELECT tenantID FROM Tenant
                            WHERE tenantID = {ID})); ''')
    row = cur.fetchone()
    conn.commit()
    conn.close()
    
# lets the user add a problem report to the database

def fileProblemReport(maintenanceKey, description, ptype):
    conn = sqlite3.connect("Wildwood_apartments.db")
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    cur.execute('''INSERT INTO ProblemReport (maintenanceKey, problemReportDate, problemShortDescription, problemType)
                    VALUES (?, date("now","localtime"), ?, ?);''',(maintenanceKey, description, ptype))
    conn.commit()
    conn.close()
    
# retrieves the tenants late exception based on their ID

def getLateException(ID):
    conn = sqlite3.connect("Wildwood_apartments.db")
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    cur.execute(f'''SELECT lateException
                                      FROM Rent
                                      WHERE leaseNumberID IN(
                                          SELECT leaseNumberID
                                          FROM Lease
                                          WHERE leaseNumberID IN(
                                              SELECT leaseNumberID
                                              FROM TenantLease
                                              WHERE tenantID IN(
                                                  SELECT tenantID
                                                  FROM Tenant
                                                  WHERE tenantID = {ID})));''')
    row = cur.fetchone()
    conn.commit()
    conn.close()
    return row

# retrieves the tenants duedate on their rent based on their ID

def getDueDate(ID):
    conn = sqlite3.connect("Wildwood_apartments.db")
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    cur.execute(f'''SELECT dueDate
                                      FROM Rent
                                      WHERE leaseNumberID IN(
                                          SELECT leaseNumberID
                                          FROM Lease
                                          WHERE leaseNumberID IN(
                                              SELECT leaseNumberID
                                              FROM TenantLease
                                              WHERE tenantID IN(
                                                  SELECT tenantID
                                                  FROM Tenant
                                                  WHERE tenantID = {ID})));''')
    row = cur.fetchone()
    conn.commit()
    conn.close()
    return row

# gets the tenants leaseID based on their tenant ID

def getLeaseID(ID):
    conn = sqlite3.connect("Wildwood_apartments.db")
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    cur.execute(f'''SELECT leaseNumberID
                FROM Rent
                WHERE leaseNumberID IN(
                    SELECT leaseNumberID
                    FROM Lease
                    WHERE leaseNumberID IN(
                        SELECT leaseNumberID
                        FROM TenantLease
                        WHERE tenantID IN(
                            SELECT tenantID
                            FROM Tenant
                            WHERE tenantID = {ID})));''')
    row = cur.fetchone()
    conn.commit()
    conn.close()
    return row

# retrieves the tenants maintenance key based on their apartment key

def getTenantsMaintenanceKey(apartmentKey):
    conn = sqlite3.connect("Wildwood_apartments.db")
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    cur.execute('''SELECT MaintenanceKey
                    FROM Maintenance WHERE apartmentKey=?;''', (apartmentKey,))
    row = cur.fetchone()
    conn.commit()
    conn.close()
    return row

# generates a maintenance key for the tenants problem report based on their apartment key

def generateMaintenanceKey(apartmentKey):
    conn = sqlite3.connect("Wildwood_apartments.db")
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    cur.execute('''INSERT INTO Maintenance (apartmentKey, resolution, resolutionDate, repairCompany)
                VALUES (?, NULL, NULL, NULL);''' ,(apartmentKey,))
    row = cur.fetchone
    conn.commit()
    conn.close()

    
# retrieves the tenants apartment key based on their ID
    
def getTenantsApartmentKey(ID):
    conn = sqlite3.connect("Wildwood_apartments.db")
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    cur.execute('''SELECT apartmentKey
                   FROM Apartment
                   WHERE apartmentKey IN(
                       SELECT apartmentKey
                       FROM Lease
                       WHERE leaseNumberID IN(
                           SELECT leaseNumberID
                           FROM TenantLease
                           WHERE tenantID=?));''',(ID,))
    row = cur.fetchone()
    conn.commit()
    conn.close()
    return row

# allow the tenant to make a payment on their rent

def makeRentPayment(value, lateEx, DoDate, leaseID):
    conn = sqlite3.connect("Wildwood_apartments.db")
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")
    cur.execute('''INSERT INTO Rent (leaseNumberID, amountPaid, paymentDate, lateException, dueDate)
                VALUES (?, ?, date('now', 'localtime'), ?, ?);''' ,(leaseID, value, lateEx, DoDate))
    row = cur.fetchone
    conn.commit()
    conn.close()
