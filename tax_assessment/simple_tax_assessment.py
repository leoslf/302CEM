import sys
if sys.version_info[0] < 3:
    input = raw_input

MPF_THRESHOLD = 7100 * 12
MPF_CONTRIBUTION = 0.05
MPF_MAX = 18000
STANDARD_TAX_RATE = 0.15

ALLOWANCE = [132000, 264000]

def get_marital_status():
    while True:
        marital_status = input("Please input your marital status. [Y/N]")
        marital_status = marital_status[0].lower()
        try:
            marital_status = ["n", "y"].index(marital_status)
        except ValueError:
            print ("ValueError. Please input again")
            continue
        break
    return marital_status


def main(): # main function
    division()

def deduction(incomes):
    return sum(map(mpf, incomes))

def division():
    self_income = int(input("Please input your income > "))
    print_tax("Personal", self_income - deduction([self_income]))

    incomes = [self_income]

    marital_status = get_marital_status()
    if marital_status:
        spouse_income = int(input("Please input spouse income > "))
       
        print_tax("Spouse", spouse_income - deduction([self_income]))

        incomes.append(spouse_income)

        total_income = sum(incomes)
        joint_net_income = total_income - deduction(incomes)

        values = map(int, [s_tax(joint_net_income),
                  tax(joint_net_income, True),
                  tax(self_income, False) + tax(spouse_income, False)])

        index = values.index(min(values))
        case_labels = [
            "Recommend joint assessment using standard Tax Rate",
            "Recommend joint assessment using progressive Tax Rate",
            "Recommend separate assessment using progressive Tax Rate",
        ]

        print_tax("Joint", joint_net_income, True)

        print ("required tax: %.2f" % values[index])
        print (case_labels[index])
        
        
    else:
        values = map(int, [s_tax(self_income), tax(self_income, False)])
        index = values.index(min(values))
        case_labels = [
            "Recommend Standard Tax Rate.",
            "Recommend progressive Tax Rate."
        ]

        print ("required tax: %.2f" % values[index])
        print (case_labels[index])

    
def print_tax(role, income, marital_status = False):
    print ("%s MPF is: %.2f" % (role, mpf(income)))
    print ("%s Tax in standard rate: %.2f" % (role, s_tax(income)))
    print ("%s Tax in progressive rate: %.2f" % (role, tax(income, marital_status)))


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
