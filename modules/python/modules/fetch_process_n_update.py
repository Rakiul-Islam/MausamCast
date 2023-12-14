import pandas as pd
from sqlalchemy import create_engine


def fetch_process_n_update_weather(city_name):
    # this function will fetch the weather data from the database and process it and return the processed data
    connection = create_engine('mysql+mysqlconnector://root:20081978@localhost/app_project_db')
    query = f"SELECT * FROM {city_name}_weather_data"
    df = pd.read_sql(query, connection)

    # process the data

    df.to_sql(f'processed_{city_name}_weather_data',con = connection, if_exists='replace', index=False)

    connection.dispose()

    dict_data = df.to_dict(orient='records')
    return dict_data

def fetch_process_n_update_forecast(city_name):
    # this function will fetch the forecast data from the database and process it and return the processed data
    connection = create_engine('mysql+mysqlconnector://root:20081978@localhost/app_project_db')
    
    query = f"SELECT * FROM {city_name}_forecast_data"
    df = pd.read_sql(query, connection)

    # process the data

    df.to_sql(f'processed_{city_name}_forecast_data',con = connection, if_exists='replace', index=False)

    connection.dispose()

    dict_data = df.to_dict(orient='records')
    return dict_data

def fetch_process_n_update_forecast_extra(city_name):
    # this function will fetch the forecast extra data from the database and process it and return the processed data
    connection = create_engine('mysql+mysqlconnector://root:20081978@localhost/app_project_db')
    
    query = f"SELECT * FROM {city_name}_forecast_data_extra_info"
    df = pd.read_sql(query, connection)

    # process the data

    df.to_sql(f'processed_{city_name}_forecast_data_extra_info',con = connection, if_exists='replace', index=False)

    connection.dispose()

    dict_data = df.to_dict(orient='records')
    return dict_data



if __name__ == "__main__":
    fetch_process_n_update_weather("chennai")