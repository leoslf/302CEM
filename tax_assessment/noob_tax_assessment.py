import sys
if sys.version_info[0] < 3:
    input = raw_input

def main(): # main function

    marital_status = input("Please input marital status. [Y/N]")
    division(marital_status)

def division(marital_status):

    if marital_status.lower() == "y":
        self_income = int(input("Please input Husband's'income > "))
        #insert husband's income 
        self_mpf = mpf(self_income)
        print ("Personal MPF is:", mpf(self_income))
        print_tax("Personal", self_income, self_mpf)
        #output Husband's tax & MPF
        spouse_income = int(input("Please input Wife's income >"))
        #input wife's income
        spouse_mpf = mpf(spouse_income)
        join_income = self_income + spouse_income 
        join_mpf = mpf(self_income) + mpf(spouse_income)

        print ("spouse MPF is:", mpf(spouse_income))
        print_tax("Spouse", spouse_income, spouse_mpf)
        #output wife's tax & MPF
        a = (s_tax(self_income, self_mpf) + s_tax(spouse_income, spouse_mpf)), 
        (tax(join_income, "y", join_mpf)), 
        (tax(self_income, "n", self_mpf) + tax(spouse_income, "n", spouse_mpf)), 
        (s_tax(self_income, self_mpf) + tax(spouse_income, "n", spouse_mpf)), 
        (tax(self_income, "n", self_mpf) + s_tax(spouse_income, spouse_mpf))      
        
        if (s_tax(self_income, self_mpf) + s_tax(spouse_income, spouse_mpf)) == min(a):
            print ("Recommend separate assessment both using standard Tax Rate",min(a))   
        elif (tax(join_income, "y", join_mpf)) == min(a):
            print ("Recommend joint assessment both using progressive Tax Rate ",min(a))
        elif (tax(self_income, "n", self_mpf) + tax(spouse_income, "n", spouse_mpf)) == min(a):
            print ("Recommend separate assessment both using progressive Tax Rate ",min(a))
        elif (s_tax(self_income, self_income) + tax(spouse_income, "n", spouse_mpf)) == min(a):
            print ("Recommend separate assessment Husband using standard tax rate and wife using progressive tax rate",min(a))
        elif (tax(self_income, "n", self_mpf) + s_tax(spouse_income, spouse_mpf)):
            print ("Recommend separate assessment Husband using progressive tax rate and wife using standard tax rate",min(a))
        else:
            print ("")
        #recommend tax assessment and tax rate
    elif marital_status.lower() == "n":
        self_income = int(input("Please input your income > "))
        #input of single's income
        print ("Personal MPF is:", mpf(self_income))
        print ("Personal Tax (standard rate) is: %.2f" % s_tax(self_income, self_mpf))
        print ("Personal Tax (progressive rate)is: %.2f" % tax(self_income, marital_status))
        #output single's tax rate and MPF
        if s_tax(self_income) > tax(self_income, marital_status):
            print ("Recommend Standard Tax Rate.")
        elif s_tax(self_income, self_mpf) < tax(self_income, marital_status):
            print ("Recommend progressive Tax Rate.")
        else:
            print ("Progressive Tax Rate or Standard Tax rate.")
        #recommend tax rate
    else:
        print ("Input Error")
    
def print_tax(role, income, deduction):
    #output tax rate 
    print (role, "Tax (standard rate) is: %.2f" % s_tax(income, deduction))
    print (role, "Tax (separate, progressive rate) is: %.2f" % tax(income, "n", deduction))
    

def mpf (income):
    # Mandatory Contribution
    mpf = 0
    if income/12 <= 7100:
        mpf = 0
    elif income/12 >= 30000:
        mpf = 1500
    else:
        mpf = income * 0.05
    
    mpf = mpf * 12

    return mpf

def s_tax(income, deduction):
    #Standard Tax Rate
    tax = 0
    income = income - deduction
    tax = income * 0.15

    if tax < 0:
        tax = 0
    return tax
    

def tax (income, marital_status, deduction):
    #PProgressive Tax Rate 
    tax = 0
    allow = 0
    
    if marital_status.lower() == "y":
        allow = 264000
    elif marital_status.lower() == "n":
        allow = 132000
    else:
        print ("Error")
    
    income = income - allow 
    income = income - deduction
    #deduct MPF and personal allowance
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