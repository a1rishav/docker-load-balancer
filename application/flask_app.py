from flask import Flask, request
import os,sys
import requests

app = Flask(__name__)

ip = "172.17.0.1"
ports = [4500, 4501, 4502, 4503]
global_counter = 0

@app.route('/square/')
def square():
    n = int(request.args.get("n"))
    result = "Square of {}  --> {}".format(n, n * n)
    try:
        return {"result":result}
    except Exception as err:
        return {"result":"Failed"}

@app.route('/distribute_square/')
def distribute_square():
    global global_counter
    n = int(request.args.get("n"))
    port = ports[global_counter % len(ports)]
    url = "http://{}:{}/square/?n={}".format(ip, port, n)
    
    message = "Square of {} --> request sent to -->  machine : {}:{}".format(n, ip, port)
    result = requests.get(url = url).json()
    response = message + " ---> Respose received : {}".format(result)
    global_counter += 1
   
    try:
        return {"result":response}
    except Exception as err:
        return {"result":"Failed"}


if __name__ == "__main__":
    app.run(host=os.environ['FLASKHOSTNAME'],port=os.environ['FLASKPORT'],debug=True)
