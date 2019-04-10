from Tkinter import *
import ttk


def hex2tuple(s):
    """
    hex2tuple converts the input hex to tuple


    Parameters
    ----------------
    s : hexadecimal string


    Returns
    ---------------
    tuple
        len(n)//2 - tuple of 8-bit integer
    """
    return tuple(int(s[i:i+2], 16) for i in range(0, len(s), 2))

class LogoBar(Frame):
    """
    The Gradient Bar on top
    """
    def __init__(self, root, app_name, displayed_username):
        """
        __init__


        Parameters
        ----------------
        root : tkinter widget
            Parent of this wiget

        app_name : str
            String to be displayed on the Left Hand Side of the Bar

        displayed_username : str
            Displayed name of logged in user
        """
        root.update()
        width = root.winfo_width()
        self.width = width
        self.height = int(root.winfo_height() * 0.075)
        Frame.__init__(self, root, height=self.height)

        color1 = "1d2b64"
        color2 = "f8cdda"

        colors = [hex2tuple(s) for s in (color1, color2)]
        color1, color2 = colors
        canvas = self.GradientCanvas(self, color1, color2, self.height, horizontal=True)
        #canvas = self.GradientCanvas(self, (0, 198, 251), (0,91,234), self.height, True)
        Label(canvas, text=app_name)
        #lbls = [Label(canvas, text=s, fg="white", bg="green") for s in (app_name, displayed_username)]
        lbls = [Label(canvas, text=s, fg="white", bg="systemTransparent", font=("Helvetica", 20)) for s in (app_name, displayed_username)]
        xpos = [self.width * ratio for ratio in [0.02, 0.85]]
        for lbl, x in zip(lbls, xpos):
            lbl.place(x=x, y=(self.height - 26) // 2)
            
#            root.wm_attributes('-transparentcolor', "green")
        self.pack(fill=X)


    class GradientCanvas(Canvas):
        """
        GradientCanvas
        Extends tkinter.Canvas

        The Gradient background, supporting widget of LogoBar
        """
        def __init__(self, root, color1, color2, height, horizontal=False, bd=0, relief="sunken"):
            """__init__

            Parameters
            ----------
            root : tkinter container / Tk()
                parent of this object

            color1 : 3-tuple containing rgb value
                first color

            color2 : 3-tuple containing rgb value
                second color

            bd : int 
                (inherited) 

            relief: str
                (inherited)

            """
            Canvas.__init__(self, root, bd=bd, relief=relief, height=height, highlightthickness=0)

            self.root = root
            self.color1 = color1
            self.color2 = color2
            self.colors = [color1, color2]
            self.height = height
            self.horizontal = horizontal
            self.bind("<Configure>", self.draw_gradient)
            self.draw_gradient()
            #self.grid(row=0, column=0, sticky="nsew")
            #self.pack(fill="both", expand=True)
            self.pack(fill=X)#, expand=True)

        def draw_gradient(self, event=None):
            """
            draw_gradient
            The actual function that helps generate the gradient line by line.

            event: event
                (inherited)
            """
            self.delete("gradient")
            width = self.winfo_width()
            height = self.height

            if self.horizontal:
                limit = height
                colors = self.colors
                ratios = list(map(lambda comp: float(comp[1] - comp[0])/limit, zip(*colors)))
                
                for i in range(limit):
                    ncolors = list(map(lambda tup: int(tup[0] + (tup[1] * i)), zip(colors[0], ratios)))
                    #debug("ncolors: %r" % ncolors)
                    #color = "#%4.4x%4.4x%4.4x" % tuple(ncolors)
                    color = "#%02x%02x%02x" % tuple(ncolors)
                    #debug("color: %r" % color)
                    self.create_line((0, i, width, i + 1), tags=("gradient",), fill=color)
                self.lower("gradient")
            else:
                limit = width
                colors = self.colors
                ratios = list(map(lambda comp: float(comp[1] - comp[0])/limit, zip(*colors)))
                
                for i in range(limit):
                    ncolors = list(map(lambda tup: int(tup[0] + (tup[1] * i)), zip(colors[0], ratios)))
                    #debug("ncolors: %r" % ncolors)
                    #color = "#%4.4x%4.4x%4.4x" % tuple(ncolors)
                    color = "#%02x%02x%02x" % tuple(ncolors)
                    #debug("color: %r" % color)
                    self.create_line((i, 0, i + 1, height), tags=("gradient",), fill=color)
                self.lower("gradient")


