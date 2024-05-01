import wildwood_sql as db
import jacinto_app as complexManager
import brian_app as tenant
import adria_app as hq

def main():
    while True:
        print("*** Sign in as ***")
        print("1- HQ staff")
        print("2- Complex Manager")
        print("3- Tenant")
        print("4- Exit")
        choice=input('Choose an option above: ')
        if choice=='1':
            hq.hq_sign_in()
        elif choice=='2':
            complexManager.signInManager()
        elif choice=='3':
            tenant.tenant_menu()
        elif choice== '4':
            print("Bye!")
            break
        else:
            print('\nInvalid option!')
main()