import os
from Tkinter import *
import tkMessageBox
import Tkinter, Tkconstants, tkFileDialog

root = Tk()
def open_file():
    root.filename = tkFileDialog.askopenfilename(title = "Select file",filetypes = (("csv files", "*.csv"),))
    if len(root.filename) < 1:
        return

    pipe = os.popen("client %s" % root.filename)
    size = int(pipe.readline())
    if size < 1:
        tkMessageBox.showerror("Error", "File Rejected by server")
    else:
        buf = pipe.read(size)
        root.filename = tkFileDialog.asksaveasfilename(title = "Select file", filetypes = (("csv files", "*.csv"), ("all files","*.*")))
        with open(root.filename, "w") as f:
            f.write(root.filename)
        tkMessageBox.showinfo("Information", "Successful:\n%s" % buf)

button = Button(root, text = "Send File", command = open_file)
button.pack()
root.mainloop()
