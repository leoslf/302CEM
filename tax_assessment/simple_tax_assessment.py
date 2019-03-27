import sys
if sys.version_info[0] < 3:
    input = raw_input

MPF_THRESHOLD = 7100
MPF_CONTRIBUTION = 0.05
MPF_MAX = 18000
STANDARD_TAX_RATE = 0.15

ALLOWANCE = [132000, 264000]

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
        
        values = [s_tax(self_income) + s_tax(spouse_income),
                  tax(self_income, marital_status) + tax(spouse_income, marital_status),
                  tax(self_income, False) + tax(spouse_income, False)]

        index = values.index(min(values))
        case_labels = [
            "Recommend separate assessment using standard Tax Rate",
            "Recommend joint assessment using progressive Tax Rate",
            "Recommend separate assessment using progressive Tax Rate",
        ]

        print (case_labels[index])
        
        
    else:
        self_income = int(input("Please input your income > "))
        print ("Personal MPF is:", mpf(self_income))
        print ("Personal Tax (standard rate) is: %.2f" % s_tax(self_income))
        print ("Personal Tax (progressive rate)is: %.2f" % tax(self_income, marital_status))

        values = [s_tax(self_income), tax(self_income, False)]
        index = values.index(min(values))
        case_labels = [
            "Recommend Standard Tax Rate.",
            "Recommend progressive Tax Rate."
        ]

        print (case_labels[index])

    
def print_tax(role, income):
    print (role, "Tax (separate, standard rate) is: %.2f" % s_tax(income))
    print (role, "Tax (separate, progressive rate) is: %.2f" % tax(income, False))
    print (role, "Tax (joint, standard rate) is: %.2f" % s_tax(income))
    print (role, "Tax (joint, progressive rate) is: %.2f" % tax(income, True))


def mpf(income):
    """ Mandatory Contribution """
    if income < MPF_THRESHOLD:
        return 0
    return min(income * MPF_CONTRIBUTION, MPF_MAX)

def s_tax(income):
    """ Standard Tax Rate Method

    Personal Allowance standard rate
    """
    return income * STANDARD_TAX_RATE


def tax(income, marital_status):
    """ Progressive Tax Rate Method
    """
    tax = 0

    # Personal allowanceance progressive rate
    allowance = ALLOWANCE[marital_status]

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
