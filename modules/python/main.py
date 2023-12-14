import math
from flask import Flask, jsonify, request
import requests
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
    # this function will run the java program and then run the python program to process the data
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
# this function will return the weather data of the city
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
# this function will return the forecast data of the city
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

@app.route('/api/forecast_extra', methods=['GET'])
# this function will return the Extra forecast data of the city
def get_forecast_data_extra():
    city_name = request.args.get('city_name')
    try:
        prepare_new_data(city_name)
        json_data = fpu.fetch_process_n_update_forecast_extra(city_name)
        return jsonify(json_data)
    except:
        response = app.response_class(
        response='Error: Resource not found',
        status=404, 
        mimetype='text/plain'
    )
    return response

@app.route('/api/weather_n_forecast', methods=['GET'])
# this function will return the weather and forecast data of the city
def get_weather_n_forecast_data():
    city_name = request.args.get('city_name')
    try:
        prepare_new_data(city_name)
        json_data1 = fpu.fetch_process_n_update_weather(city_name)
        json_data2 = fpu.fetch_process_n_update_forecast(city_name)
        combined_data = {
            "weather_data": json_data1,
            "forecast_data": json_data2
        }
        return jsonify(combined_data)
    except:
        response = app.response_class(
        response='Error: Resource not found',
        status=404, 
        mimetype='text/plain'
    )
    return response

@app.route('/remote_api/weather_n_forecast', methods=['GET'])
def put_up_weather_n_forecast_data():
    # to put up the data onto jsonbin.io
    city_name = request.args.get('city_name')
    prepare_new_data(city_name)
    json_data1 = fpu.fetch_process_n_update_weather(city_name)
    json_data2 = fpu.fetch_process_n_update_forecast(city_name)

    json_data1_types = {
        'date_time': 'str',
        'city_id': 'int',
        'city_name': 'str',
        'city_coord_lon': 'float',
        'city_coord_lat': 'float',
        'city_country': 'str',
        'city_timezone': 'int',
        'city_sun_rise': 'str',
        'city_sun_set': 'str',
        'temperature_value': 'float',
        'temperature_min': 'float',
        'temperature_max': 'float',
        'temperature_unit': 'str',
        'feels_like_value': 'float',
        'feels_like_unit': 'str',
        'humidity_value': 'int',
        'humidity_unit': 'str',
        'pressure_value': 'int',
        'pressure_unit': 'str',
        'wind_speed_value': 'float',
        'wind_speed_unit': 'str',
        'wind_speed_name': 'str',
        'wind_direction_value': 'int',
        'wind_direction_code': 'str',
        'wind_direction_name': 'str',
        'clouds_value': 'int',
        'clouds_name': 'str',
        'visibility_value': 'int',
        'precipitation_mode': 'str',
        'weather_number': 'int',
        'weather_value': 'str',
        'weather_icon': 'str'
    }

    json_data2_types = {
        'from_': 'str',
        'to_': 'str',
        'symbol_number': 'int',
        'symbol_name': 'str',
        'symbol_var': 'str',
        'precipitation_probability': 'float',
        'precipitation_unit': 'str',
        'precipitation_value': 'float',
        'precipitation_type': 'str',
        'windDirection_deg': 'int',
        'windDirection_code': 'str',
        'windDirection_name': 'str',
        'windSpeed_mps': 'float',
        'windSpeed_unit': 'str',
        'windSpeed_name': 'str',
        'windGust_gust': 'float',
        'windGust_unit': 'str',
        'temperature_unit': 'str',
        'temperature_value': 'float',
        'temperature_min': 'float',
        'temperature_max': 'float',
        'feels_like_value': 'float',
        'feels_like_unit': 'str',
        'pressure_unit': 'str',
        'pressure_value': 'int',
        'humidity_value': 'int',
        'humidity_unit': 'str',
        'clouds_value': 'str',
        'clouds_all': 'int',
        'clouds_unit': 'str',
        'visibility_value': 'int',
    }

    for i in json_data1:
        i['city_sun_rise'] = i['city_sun_rise'].strftime('%a, %d %b %Y %H:%M:%S GMT')
        i['city_sun_set'] = i['city_sun_set'].strftime('%a, %d %b %Y %H:%M:%S GMT')
        i['date_time'] = i['date_time'].strftime('%a, %d %b %Y %H:%M:%S GMT')
        for key in i.keys():
            if i[key] is None:
                if json_data1_types[key] == 'str':
                    i[key] = ' '
                elif json_data1_types[key] == 'int':
                    i[key] = 0
                elif json_data1_types[key] == 'float':
                    i[key] = 0.0
            if not isinstance(i[key], str):
                if math.isnan(i[key]):
                    if json_data1_types[key] == 'str':
                        i[key] = ' '
                    elif json_data1_types[key] == 'int':
                        i[key] = 0
                    elif json_data1_types[key] == 'float':
                        i[key] = 0.0

    for i in json_data2:
        i['from_'] = i['from_'].strftime('%a, %d %b %Y %H:%M:%S GMT')
        i['to_'] = i['to_'].strftime('%a, %d %b %Y %H:%M:%S GMT')
        for key in i.keys():
            if i[key] is None:
                if json_data2_types[key] == 'str':
                    i[key] = ' '
                elif json_data2_types[key] == 'int':
                    i[key] = 0
                elif json_data2_types[key] == 'float':
                    i[key] = 0.0
            if not isinstance(i[key], str):
                if math.isnan(i[key]):
                    if json_data2_types[key] == 'str':
                        i[key] = ' '
                    elif json_data2_types[key] == 'int':
                        i[key] = 0
                    elif json_data2_types[key] == 'float':
                        i[key] = 0.0

    combined_data = {
        "weather_data": json_data1,
        "forecast_data": json_data2,
    }

    bin_id = "6537c76012a5d376598fe229"
    
    headers = {
        "Content-Type": "application/json",
        "X-Master-Key": "$2a$10$7DtsQl0ZlTmcxAKKDWqrqeuPYpSvtjNRgKRU4z9H7dOCCshhd/kI6"
    }
    
    response = requests.put(f"https://api.jsonbin.io/v3/b/{bin_id}", json=combined_data, headers=headers)
    
    # Check if the POST request was successful
    if response.status_code == 200:
        return jsonify({"message": "Data uploaded to JSONbin.io successfully"})
    else:
        return jsonify({"error": "Failed to upload data to JSONbin.io"})
    # except:
    #     return app.response_class(
    #     response='Error: Resource not found',
    #     status=404, 
    #     mimetype='text/plain'
    # )

if __name__ == '__main__':
    # app.run(debug=True)
    app.run(debug=True, host = '0.0.0.0')