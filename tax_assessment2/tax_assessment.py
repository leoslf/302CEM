import sys

if sys.version_info[0] < 3:
    input = raw_input


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
            "seperate": bool,
            "self_tax": int,
            "spouse_tax": int,
            "combined_tax": int,
        }
    """
    


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
    data["marital_status"] = bool(["n", "y"].index(marital_status))

    if data["marital_status"]:
        data["spouse_income"] = get_income("Spouse's")

    return data

def show_ouput(result):
    print ("Your seperate tax payable: %d" % result["self_tax"])
    if result["marital_status"]:
        print ("Spouse's seperate tax payable: %d" % result["spouse_tax"])
        print ("Joint Tax payable: %d" % result["combined_tax"])
        print ("Suggest: %s" % ("Seperating" if result["seperate"] else "Combining"))





if __name__ == "__main__":
    print ("Tax Calculator")
    data = get_input()
    result = tax_calculation(data)
    show_output(result)
