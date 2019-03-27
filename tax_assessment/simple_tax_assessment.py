import sys
if sys.version_info[0] < 3:
    input = raw_input

def main(): # main function

    marital_status = input("Please input your marital status. [Y/N]")
    division(marital_status)

def division(marital_status):

    if marital_status.lower() == "y":
        self_income = int(input("Please input your income > "))
        print ("Personal MPF is:", mpf(self_income)*12)
        print_tax("Personal", self_income)
        spouse_income = int(input("Please input spouse income >"))
       
        print ("spouse MPF is:", mpf(spouse_income)*12)
        print_tax("Spouse", spouse_income)
        
        a = s_tax(self_income, marital_status) + s_tax(spouse_income, marital_status),s_tax(self_income, "n") + s_tax(spouse_income, "n"), tax(self_income, marital_status) + tax(spouse_income, marital_status), tax(self_income, "n") + tax(spouse_income, "n")  
        
        if (s_tax(self_income, marital_status) + s_tax(spouse_income, marital_status)) == min(a):
            print ("Recommend joint assessment using standard Tax Rate ")   
        elif (tax(self_income, marital_status) + tax(spouse_income, marital_status)) == min(a):
            print ("Recommend joint assessment using progressive Tax Rate ")
        elif (s_tax(self_income, "n") + s_tax(spouse_income, "n")) == min(a):
            print ("Recommend separate assessment using standard Tax Rate ")
        elif (tax(self_income, marital_status) + tax(spouse_income, marital_status)) == min(a):
            print ("Recommend separate assessment using progressive Tax Rate ")
        else:
            print ("")
        
    elif marital_status.lower() == "n":
        self_income = int(input("Please input your income > "))
        print ("Personal MPF is:", mpf(self_income)* 12)
        print ("Personal Tax (standard rate) is: %.2f" % s_tax(self_income, marital_status))
        print ("Personal Tax (progressive rate)is: %.2f" % tax(self_income, marital_status))

        if s_tax(self_income, marital_status) > tax(self_income, marital_status):
            print ("Recommend Standard Tax Rate.")
        elif s_tax(self_income, marital_status) < tax(self_income, marital_status):
            print ("Recommend progressive Tax Rate.")
        else:
            print ("Progressive Tax Rate or Standard Tax rate.")

    else:
        print ("Input Error")
    
def print_tax(role, income):

    print (role, "Tax (separate, standard rate) is: %.2f" % s_tax(income, "n"))
    print (role, "Tax (separate, progressive rate) is: %.2f" % tax(income, "n"))
    print (role, "Tax (joint, standard rate) is: %.2f" % s_tax(income, "y"))
    print (role, "Tax (joint, progressive rate) is: %.2f" % tax(income, "y"))

def mpf (income):
    """ Mandatory Contribution """
    mpf = 0
    if income/12 >= 30000:
        mpf = 1500
    else:
        mpf = income * 0.05
        
    return mpf

def s_tax(income, marital_status):
    
    tax = 0
    allow = 0

    if marital_status.lower() == "y":
        allow = 264000
    elif marital_status.lower() == "n":
        allow = 132000
    else:
        print ("Error")

    tax = (income - allow) * 0.15

    if tax < 0:
        tax = 0
    return tax
    #Personal Allowance standard reat

def tax (income, marital_status):

    tax = 0
    allow = 0

    if marital_status.lower() == "y":
        allow = 264000
    elif marital_status.lower() == "n":
        allow = 132000
    else:
        print ("Error")
    #Personal Allowance progressive rate

    income = income - allow
    
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
    if tax  < 0:
        tax = 0
        #remove negative number
    
    return tax

if __name__ == "__main__":
    main()