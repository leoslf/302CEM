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
    marital_status = input("Please input your marital status. [Y/N] ")
    marital_status = marital_status[0].lower()
    
    marital_status = ["n", "y"].index(marital_status)

    return marital_status


def main(): # main function
    division()


def deduction(total_income):
    """ Deduction calculation with predefined functions on Total Income of **a** person

    Args:
        total_income (int): Total Income of **a** person

    Returns:
        int: The required deduction on total income
    """
    # Predefined deduction functions
    deduction_functions = [mpf]

    # NOTE: [expression for variable in iterable]
    return sum([int(f(total_income)) for f in deduction_functions])

def net_income(total_income):
    return total_income - deduction(total_income)

def division():
    self_income = int(input("Please input your income > "))
    print_tax("Personal", self_income, deduction(self_income))

    incomes = [self_income]

    values = None
    index = -1
    case_labels = None
    self_net_income = net_income(self_income)


    marital_status = get_marital_status()
    if marital_status:
        spouse_income = int(input("Please input spouse income > "))
       
        print_tax("Spouse", spouse_income, deduction(spouse_income))

        incomes.append(spouse_income)

        # NOTE: map(f, [x_1, x_2, ..., x_n]) -> [f(x_1), f(x_2), ..., f(x_n)]
        net_incomes = map(net_income, incomes)
        joint_net_income = sum(net_incomes) 

        spouse_net_income = net_incomes

        values = map(int, [
            s_tax(self_net_income) + s_tax(spouse_net_income),
            s_tax(joint_net_income),
            tax(joint_net_income, True),
            tax(self_net_income, False) + tax(spouse_net_income, False),
            s_tax(self_net_income) + tax(spouse_net_income, False),
            tax(self_net_income, False) + s_tax(spouse_net_income)])


        print_tax("Joint", sum(incomes), sum(map(deduction, incomes)), True)

        eprint(values)

        index = values.index(min(values))
        case_labels = [
            "Recommend separate assessment both using standard Tax Rate",
            "Recommend joint assessment both using progressive Tax Rate",
            "Recommend joint assessment both using standard Tax Rate",
            "Recommend separate assessment both using progressive Tax Rate",
            "Recommend separate assessment Husband using standard tax rate and wife using progressive tax rate",
            "Recommend separate assessment Husband using progressive tax rate and wife using standard tax rate"
        ]


        
    else:
        values = map(int, [s_tax(self_net_income), tax(self_net_income, False)])
        index = values.index(min(values))
        case_labels = [
            "Recommend Standard Tax Rate.",
            "Recommend progressive Tax Rate."
        ]


    eprint("Required Tax: ", end = "")
    print (values[index])
    eprint(case_labels[index])
        

    
def print_tax(role, total_income, deductions, marital_status = False):
    income = total_income - deductions
    eprint("%s MPF is: %.2f" % (role, deductions))
    eprint("%s Tax in standard rate: %.2f" % (role, s_tax(income)))
    eprint("%s Tax in progressive rate: %.2f" % (role, tax(income, marital_status)))


def mpf(income):
    """ Mandatory Provident Fund (MPF) Contribution

    Args:
        income (int): Total Income of **a** person

    Returns:
        int: The employee-side MPF contribution.
    """
    if income < MPF_THRESHOLD:
        return 0

    return min(income * MPF_CONTRIBUTION, MPF_MAX)

def s_tax(income):
    """ Tax Payable at Standard Rate

    Args:
        income (int): Net Total Income (NI) = Total Income - Deductions

    Returns:
        int: The tax payable at standard rate.
        
    """
    return int(int(income) * STANDARD_TAX_RATE)


def tax(income, marital_status):
    """ Tax Payable at Progressive Rate

    Args:
        income (int): Net Total Income (NI) = Total Income - Deductions

    Returns:
        int: The tax payable at progressive rate.
    """
    tax = 0

    # Personal allowanceance progressive rate
    allowance = ALLOWANCE[marital_status]

    # Calculate the Net Charagable Income (NCI)
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
