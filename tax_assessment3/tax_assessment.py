import sys
import csv

if sys.version_info[0] < 3:
    input = raw_input

def tax_bands():
    with open("tax_band.csv") as f:
        return [{key: eval(value) for key, value in d.items()} for d in csv.DictReader(f)]

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
    return int(net_income * 0.15)

def progressive_tax(nci):
    accumulation = 0
    for tax_band in tax_bands():
        if tax_band["band"] < 0 or nci <= tax_band["band"]:
            return int(accumulation + nci * tax_band["rate"])
        accumulation += int(tax_band["band"] * tax_band["rate"])
        nci -= tax_band["band"]

def tax_selection(net_income, combined = False):
    standard, progressive = standard_tax(net_income), progressive_tax(NCI(net_income, combined))
    choice_index = progressive > standard
    return [progressive, standard][int(choice_index)], choice_index

def tax_calculation(data):
    """ Tax Calculator

    Args:
        data (dict): Dictionary with these fields: 
            {
                "self_income": int,
                "spouse_income": int,
                "marital_status": bool,
            }

    Returns:
        dict: Output a dictionary with these fields:
            {
                "marital_status": bool,
                "combined": bool,
                "self_mpf": int,
                "self_tax": int,
                "spouse_mpf": int,
                "spouse_tax": int,
                "combined_tax": int,
            }
    """

    output = {
        "marital_status": data["marital_status"],
    }

    net_incomes = {type: net_income(data["%s_income" % type]) for type in ("self", "spouse")}
    for type in ("self", "spouse"):
        output["%s_mpf" % type] = MPF(int(data["%s_income" % type]))
        output["%s_tax" % type], output["%s_is_standard" % type] = tax_selection(net_incomes[type])

    output["combined_tax"], output["combined_is_standard"] = tax_selection(sum(net_incomes.values()), combined = True)

    # decide whether combined_tax is chosen by comparing it with sum of seperated taxes (self_tax + spouse_tax)
    output["combined"] = output["marital_status"] and output["combined_tax"] < (output["self_tax"] + output["spouse_tax"])
    return output

def get_input():
    data = {
        "self_income": 0,
        "spouse_income": 0,
        "marital_status": False,
    }

    def get_income(role):
        data["%s_income" % role] = int(input("%s income: " % role.capitalize()))

    get_income("self")

    marital_status = input("Marital Status [y/n]: ")[0].lower()
    data["marital_status"] = ["n", "y"].index(marital_status)

    if data["marital_status"]:
        get_income("spouse")

    return data

def fmt(role):
    return ("%s MPF: %%(%s_mpf)d\n"
            "%s seperate tax payable: %%(%s_tax)d\n"
            "%s using standard rate: %%(%s_is_standard)r\n") % tuple([role.capitalize(), role] * 3) + "-" * 80

def show_output(result):
    print (fmt("self") % result)
    if result["marital_status"]:
        print (fmt("spouse") % result)
        print ("Joint Tax payable: %(combined_tax)d" % result)
        print ("Suggest: %s" % ("Combining" if result["combined"] else "Seperating"))

if __name__ == "__main__":
    print ("Tax Calculator")
    data = get_input()
    show_output(tax_calculation(data))
