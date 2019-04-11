import os
import socket
import uuid
from logging import *
from multiprocessing import Process
from Manufacturer import *


def TCP_server(port):
    serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    serversocket.bind(('', port))
    serversocket.listen(5)
    return serversocket

def client_handler(client, ip, port):
    info("Incoming connection: %s:%d", ip, port)
    size_line = ""
    while True:
        ch = client.recv(1).decode('utf-8')
        if ch == '\n':
            break
        size_line += ch

    size = int(size_line)
    filebuf = client.recv(size).decode("utf-8")
    print (filebuf)
    
    filename = str(uuid.uuid4())
    input_csv = "/tmp/%s.csv" % filename
    results_csv = "/tmp/%s.result.csv" % filename
    with open(input_csv, "w") as f:
        f.write(filebuf)

    manufacturer = Manufacturer()
    try:
        manufacturer.handle_inputfile(input_csv)
    except:
        client.sendall("0".encode('utf-8'))
    else:
        results_size = os.path.getsize(results_csv)
        results_buf = ""
        with open(results_csv) as f:
            results_buf = f.read()

        client.sendall(("%d\n%s" % (results_size, results_buf)).encode("utf-8"))


    info("End: %s:%d", ip, port)
    client.close()

def run_server(port):
    basicConfig(level=DEBUG)
    server = TCP_server(port)
    while True:
        client, addr = server.accept()
        ip, port = addr
        Process(target=client_handler, args=(client, ip, port)).start()
