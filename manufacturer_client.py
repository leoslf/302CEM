import sys

if __name__ == "__main__":
    size = int(sys.stdin.readline())
    if size < 1:
        print ("Rejected by Server")
    else:
        print (sys.stdin.read(size))

    sys.exit(size > 0)
        
