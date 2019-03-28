import sys

if sys.version_info[0] < 3:
    input = raw_input

def MPF(total_income):
    if total_income < 7100 * 12:
        return 0
    return min(18000, total_income * 0.05)
        
def net_income(total_income):
    """ Personal Net Income """
    total_income = int(total_income)
    return total_income - MPF(total_income) 

def NCI(net_income, combined = False):
    allowance = 132000
    if combined:
        allowance *= 2
    return max(net_income - allowance, 0)

def standard_tax(net_income):
    return net_income * 0.15

def progressive_tax(nci):
    if nci <= 50000:
        return nci * 0.02
    if nci <= 100000:
        return 1000 + (nci - 50000) * 0.06
    if nci <= 150000:
        return 4000 + (nci - 100000) * 0.10
    if nci <= 200000:
        return 9000 + (nci - 150000) * 0.14

    # Remainder
    return 16000 + (nci - 200000) * 0.17


def tax_selection(net_income, combined = False):
    standard = int(standard_tax(net_income))
    progressive = int(progressive_tax(NCI(net_income, combined)))

    return [standard, progressive], int(progressive < standard)

def tax_calculation(data):
    """ Tax Calculator

    Input Format: 
        {
            "self_income": int,
            "spouse_income": int,
            "marital_status": bool,
        }

    Output Format:
        {
            "marital_status": bool,
            "combined": bool,
            "self_tax": int,
            "spouse_tax": int,
            "combined_tax": int,
        }
    """

    output = {
        "marital_status": False,
        "combined": False,
        "self_tax": 0,
        "spouse_tax": 0,
        "combined_tax": 0,
    }
    
    values, choice = tax_selection(net_income(data["self_income"]))
    output["self_tax"] = values[choice]

    values, choice = tax_selection(net_income(data["spouse_income"]))
    output["spouse_tax"] = values[choice]

    values, choice = tax_selection(net_income(data["self_income"] + data["spouse_income"]), combined = True)
    output["combined_tax"] = values[choice]

    output["combined"] = output["combined_tax"] < output["self_tax"] + output["spouse_tax"]

    return output
    


def get_input():
    data = {
        "self_income": 0,
        "spouse_income": 0,
        "marital_status": False,
    }

    def get_income(role):
        return int(input("%s income: " % role))


    data["self_income"] = get_income("Your")

    marital_status = input("Marital Status: ")[0].lower()
    data["marital_status"] = ["n", "y"].index(marital_status)

    if data["marital_status"]:
        data["spouse_income"] = get_income("Spouse's")

    return data

def show_ouput(result):
    print ("Your seperate tax payable: %d" % result["self_tax"])
    if result["marital_status"]:
        print ("Spouse's seperate tax payable: %d" % result["spouse_tax"])
        print ("Joint Tax payable: %d" % result["combined_tax"])
        print ("Suggest: %s" % ("Seperating" if not result["combined"] else "Combining"))





if __name__ == "__main__":
    print ("Tax Calculator")
    data = get_input()
    result = tax_calculation(data)
    show_output(result)
