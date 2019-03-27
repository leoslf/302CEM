from __future__ import print_function

import sys

def eprint(*argv, **kwargs):
    print (file=sys.stderr, *argv, **kwargs)

if sys.version_info[0] < 3:
    old_raw_input = raw_input
    def raw_input(s):
        eprint(s, end="")
        return old_raw_input()
    input = raw_input


MPF_THRESHOLD = 7100 * 12
MPF_CONTRIBUTION = 0.05
MPF_MAX = 18000
STANDARD_TAX_RATE = 0.15

ALLOWANCE = [132000, 264000]

def get_marital_status():
    marital_status = input("Please input your marital status. [Y/N]")
    marital_status = marital_status[0].lower()
    
    marital_status = ["n", "y"].index(marital_status)

    """
    try:
        marital_status = ["n", "y"].index(marital_status)
    except ValueError:
        eprint ("ValueError. Please input again")
        continue
    """
    return marital_status


def main(): # main function
    division()


def deduction(incomes):
    return sum(map(mpf, incomes))

def division():
    self_income = int(input("Please input your income > "))
    print_tax("Personal", self_income, deduction([self_income]))

    incomes = [self_income]

    values = None
    index = -1
    case_labels = None

    marital_status = get_marital_status()
    if marital_status:
        spouse_income = int(input("Please input spouse income > "))
       
        print_tax("Spouse", spouse_income, deduction([spouse_income]))

        incomes.append(spouse_income)

        total_income = sum(incomes)
        joint_net_income = total_income - deduction(incomes)

        values = map(int, [
            s_tax(self_income - deduction([self_income])) + s_tax(spouse_income - deduction([spouse_income])),
            s_tax(joint_net_income),
            tax(joint_net_income, True),
            tax(self_income - deduction([self_income]), False) + tax(spouse_income - deduction([spouse_income]), False)])


        print_tax("Joint", total_income, deduction(incomes), True)

        eprint(values)

        index = values.index(min(values))
        case_labels = [
            "Recommend separate assessment using standard Tax Rate",
            "Recommend joint assessment using progressive Tax Rate",
            "Recommend joint assessment using standard Tax Rate",
            "Recommend separate assessment using progressive Tax Rate",
        ]


        
    else:
        values = map(int, [s_tax(self_income), tax(self_income, False)])
        index = values.index(min(values))
        case_labels = [
            "Recommend Standard Tax Rate.",
            "Recommend progressive Tax Rate."
        ]


    eprint("required tax", end = "")
    print (values[index])
    eprint(case_labels[index])
        

    
def print_tax(role, total_income, deductions, marital_status = False):
    income = total_income - deductions
    eprint("%s MPF is: %.2f" % (role, deductions))
    eprint("%s Tax in standard rate: %.2f" % (role, s_tax(income)))
    eprint("%s Tax in progressive rate: %.2f" % (role, tax(income, marital_status)))


def mpf(income):
    """ Mandatory Contribution """
    if income < MPF_THRESHOLD:
        return 0
    return min(income * MPF_CONTRIBUTION, MPF_MAX)

def s_tax(income):
    """ Standard Tax Rate Method

    Personal Allowance standard rate
    """
    return int(int(income) * STANDARD_TAX_RATE)


def tax(income, marital_status):
    """ Progressive Tax Rate Method
    """
    tax = 0

    # Personal allowanceance progressive rate
    allowance = ALLOWANCE[marital_status]

    income = int(income) - allowance
    
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
    
    return int(tax)

if __name__ == "__main__":
    main()
