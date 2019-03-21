
def main(): # main function
    marital_status = input ("Please input your marital status. [Y/N]")

    if marital_status == "Y"or "y":
        self_income = int(input("Please input your income >"))
        print ("Personal MPF is:", mpf(self_income))
        print ("Personal Tax (separate) is:", tax(self_income))
        print ("Personal Tax (joint) is:", m_tax(self_income))
        spouse_income = int(input("Please input spouse income >"))
        print ("spouse MPF is:", mpf(spouse_income))
        print ("Spouse Tax (separate) is:", tax(spouse_income))
        print ("Spouse Tax (joint) is:", m_tax(spouse_income))
        if tax(self_income) + tax(spouse_income) > m_tax(self_income) + m_tax(spouse_income):
            print ("Recommend Tax Assessment method: Joint Assessment")
        else:
            print ("Recommend Tax Assessment method: Separate Assessment")
            
    elif marital_status == "N" or "n":
        self_income = int(input("Please input your income >"))
        print ("Personal MPF is:", mpf(self_income))
        print ("Personal Tax is:", tax(self_income))
        
    else:
        print ("Input Error")

def mpf (income): #Mandatory Contribution
    mpf = 0
    if income/12 >= 30000:
        mpf =1500
    else:
        mpf = income * 0.05
        
    return mpf

def tax (income): #Personal Tax Assessment (single)
    tax = 0
    income = income - 132000
    #Personal Allowance (single)

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
    elif income < 50000:
        income = income - 50000
        tax = 1000 + (income * 0.02)
        #Tax Bracket 1st
    if tax  < 0:
        tax = 0
        #remove negative number
    
    return tax

def m_tax (income): #Personal Tax Assessment (Married)
    tax = 0
    income = income - 264000
    #Personal Allowance (Married)

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
    elif income < 50000:
        income = income - 50000
        tax = 1000 + (income * 0.02)
        #Tax Bracket 1st
    if tax  < 0:
        tax = 0
        #remove negative number
    
    return tax

main()
