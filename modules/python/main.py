from flask import Flask, jsonify, request
from flask_cors import CORS
from modules import run_java_program as rjp
from modules import fetch_process_n_update as fpu

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

def prepare_new_data(city_name):
    if city_name == "Not Found":
        return 1
    try:
        print(bcolors.HEADER,end="")
        code = rjp.run_java_program(city_name)
        print(bcolors.ENDC,end="")
        if code == 0:
            print(bcolors.OKGREEN,end="")
            print(f"Running java program Successful, code = {code}")
            print(bcolors.ENDC,end="")
        else:
            print(bcolors.FAIL,end="")
            print(f"Running java program Failed, code = {code}")
            print(bcolors.ENDC,end="")
        
    except:
        print(f"{bcolors.FAIL}Running java program Failed{bcolors.ENDC}")
        return 1

    try:
        fpu.fetch_process_n_update_weather(city_name)
        print(f"{bcolors.OKGREEN}Running Python Processing Successful{bcolors.ENDC}")
    except:
        print(f"{bcolors.FAIL}Running Python Processing Failed{bcolors.ENDC}")
        return 1
    return 0

app = Flask(__name__)
CORS(app)


@app.route('/api/weather', methods=['GET'])
def get_weather_data():
    city_name = request.args.get('city_name')
    try:
        prepare_new_data(city_name)
        json_data = fpu.fetch_process_n_update_weather(city_name)
        return jsonify(json_data)
    except:
        response = app.response_class(
        response='Error: Resource not found',
        status=404, 
        mimetype='text/plain'
    )
    return response
@app.route('/api/forecast', methods=['GET'])
def get_forecast_data():
    city_name = request.args.get('city_name')
    try:
        prepare_new_data(city_name)
        json_data = fpu.fetch_process_n_update_forecast(city_name)
        return jsonify(json_data)
    except:
        response = app.response_class(
        response='Error: Resource not found',
        status=404, 
        mimetype='text/plain'
    )
    return response

if __name__ == '__main__':

    app.run(debug=True)

