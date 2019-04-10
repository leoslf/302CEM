import os
from Tkinter import *
from tkFileDialog import *
import tkMessageBox
import ttk
from ConfigParser import *
from db_connection import *
from collections import *
from list_view import ListView
from logobar import LogoBar


class Input(Frame):
    def __init__(self, parent, context):
        Frame.__init__(self, parent)
        self.context = context
        Button(self, text="Select Input CSV", command = self.select_csv).pack()
        self.pack()

    def select_csv(self, *argv):
        filename = askopenfilename(filetypes=[("csv files", "*.csv")])
        try:
            self.context.handle_inputfile(filename)
        except Exception as e:
            tkMessageBox.showerror("Error", "Failed to handle file: \"%s\"" % filename)
            return
        tkMessageBox.showinfo("Successful", "Successfully handled input file: \"%s\"" % filename)





def scalei(n, scale):
    """
    scale function that returns integer


    Parameters
    ----------------
    n : Number
    scale : Number
        Multiplier


    Returns
    ----------------
    int
        integer result of scaling
    """
    return int(n * scale)


class GUI(Frame):
    def __init__(self, context, title, mode = 0, config_file = None):
        self.context = context
        self.root = Tk()
        Frame.__init__(self, self.root)
        self.app_name = title
        self.root.title(self.app_name)
        # self.pack()
        assert config_file
        self.config = self.load_config(config_file)

        self.init()

        self.main_ui()

        self.move_to_top()
        self.root.mainloop()

    def maximize(self, root):
        """maximize window"""
        w, h = root.winfo_screenwidth(), root.winfo_screenheight()
        self.width, self.height = w, h
        root.geometry("%dx%d+0+0" % (w, h))

        root.grid_rowconfigure(1, weight=1)
        root.grid_columnconfigure(0, weight=1)
        root.resizable(False, False)

    def load_config(self, config_file):
        config = ConfigParser()
        rc = config.read(config_file)
        if rc != [config_file]:
            raise RuntimeError("ConfigParser: config read failed")

        return OrderedDict((section, OrderedDict(config.items(section))) for section in config.sections())

    def main_ui(self):
        self.maximize(self.root)
        self.displayed_username = "System Administrator"
        self.logobar = LogoBar(self.root, self.app_name, self.displayed_username)
        frame_w = scalei(self.width, 0.9)
        self.notebook = ttk.Notebook(self.root)

        self.notebook.grid(row=1, column=0, sticky="nsew")

        self.tabs = OrderedDict()
        for name, data in self.config.items():
            self.tabs[name] = ttk.Frame(self.notebook, width=frame_w)
            self.tabs[name].pack()
            self.notebook.add(self.tabs[name], text=name)

            if "table" in data and bool(data["table"]):
                ListView(self.tabs[name], frame_w, self.height, 50, desc = True, **data).pack(expand=False)
            else:
                assert "id" in data and data["id"] == "input"
                Input(self.tabs[name], self.context)


        self.notebook.pack(fill="both", expand=True)



    def move_to_top(self):
        self.root.lift()
        self.root.attributes('-topmost', 1)
        self.root.after_idle(self.root.attributes, '-topmost', False)

    def init(self):
        self.QUIT = Button(self, text = "QUIT", command = self.quit)
        self.QUIT.pack({"side": "left"})

