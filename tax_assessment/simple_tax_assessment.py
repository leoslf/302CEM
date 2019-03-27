import sys
if sys.version_info[0] < 3:
    input = raw_input

def main(): # main function
    while True:
        marital_status = input("Please input your marital status. [Y/N]")
        marital_status = marital_status[0].lower()
        try:
            marital_status = ["n", "y"].index(marital_status)
        except ValueError:
            print ("ValueError. Please input again")
            continue
        break

    division(marital_status)

def division(marital_status):
    if marital_status:
        self_income = int(input("Please input your income > "))
        print ("Personal MPF is:", mpf(self_income))
        print_tax("Personal", self_income)
        spouse_income = int(input("Please input spouse income >"))
       
        print ("spouse MPF is:", mpf(spouse_income))
        print_tax("Spouse", spouse_income)
        
        values = (s_tax(self_income, marital_status) + s_tax(spouse_income, marital_status) ,s_tax(self_income, False) + s_tax(spouse_income, False), tax(self_income, marital_status) + tax(spouse_income, marital_status), tax(self_income, False) + tax(spouse_income, False))
        index = values.index(min(values))
        case_labels = [
            "Recommend joint assessment using standard Tax Rate",
            "Recommend joint assessment using progressive Tax Rate",
            "Recommend separate assessment using standard Tax Rate",
            "Recommend separate assessment using progressive Tax Rate",
        ]

        print (case_labels[index])
        
        
    else:
        self_income = int(input("Please input your income > "))
        print ("Personal MPF is:", mpf(self_income)* 12)
        print ("Personal Tax (standard rate) is: %.2f" % s_tax(self_income, marital_status))
        print ("Personal Tax (progressive rate)is: %.2f" % tax(self_income, marital_status))

        if s_tax(self_income, marital_status) >= tax(self_income, marital_status):
            print ("Recommend Standard Tax Rate.")
        elif s_tax(self_income, marital_status) < tax(self_income, marital_status):
            print ("Recommend progressive Tax Rate.")
        else:
            print ("Progressive Tax Rate or Standard Tax rate.")
    
def print_tax(role, income):
    print (role, "Tax (separate, standard rate) is: %.2f" % s_tax(income, False))
    print (role, "Tax (separate, progressive rate) is: %.2f" % tax(income, False))
    print (role, "Tax (joint, standard rate) is: %.2f" % s_tax(income, True))
    print (role, "Tax (joint, progressive rate) is: %.2f" % tax(income, True))


def monthly_mpf(income):
    """ Mandatory Contribution """
    mpf = 0
    if income/12 >= 30000:
        mpf = 1500
    else:
        mpf = income * 0.05
        
    return mpf

def mpf(income):
    return monthly_mpf(income) * 12

def s_tax(income, marital_status):
    """ Standard Tax Rate Method """
    tax = 0
    allowance = 0

    if marital_status:
        allowance = 264000
    else:
        allowance = 132000

    tax = (income - allowance) * 0.15

    if tax < 0:
        tax = 0
    return tax
    #Personal Allowance standard reat

def tax(income, marital_status):
    """ Progressive Tax Rate Method """
    tax = 0
    allowance = 0

    if marital_status:
        allowance = 264000
    else:
        allowance = 132000
    #Personal allowanceance progressive rate

    income = income - allowance
    
    if income > 200000:
        income = income - 200000
        tax = 16000 + (income * 0.17)
        #Tax Bracket of remainder
    elif income > 150000:
        income = income - 150000
        tax = 9000 + (income * 0.14)
        #Tax Bracket 4th
    elif income > 100000:
        income = income - 100000
        tax = 4000 + (income * 0.10)
        #Tax Bracket 3rd
    elif income > 50000:
        income = income - 50000
        tax = 1000 + (income * 0.06)
        #Tax Bracket 2nd
    elif income <= 50000:
        income = income - 50000
        tax = 1000 + (income * 0.02)
        #Tax Bracket 1st
    if tax < 0:
        tax = 0
        #remove negative number
    
    return tax

if __name__ == "__main__":
    main()
