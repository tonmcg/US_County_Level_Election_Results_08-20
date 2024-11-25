from flask import Flask, jsonify
from flask_cors import CORS
import requests
from io import BytesIO

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

@app.route('/census/gazetteer/<int:census_year>', methods=['GET'])
def fetch_gazetteer_files(census_year):
    url = f'https://www2.census.gov/geo/docs/maps-data/data/gazetteer/{census_year}_Gazetteer/'
    response = requests.get(url)
    data = response.text
    return data

@app.route('/census/gazetteer/<int:census_year>/<string:county_file>', methods=['GET'])
def fetch_county_data(census_year, county_file):
    url = f'https://www2.census.gov/geo/docs/maps-data/data/gazetteer/{census_year}_Gazetteer/{county_file}'
    response = requests.get(url)
    data = response.text
    return data

@app.route('/census/gazetteer/<int:census_year>/ak_sldl', methods=['GET'])
def fetch_ak_sldl_data(census_year):
    url = f'https://www2.census.gov/geo/docs/maps-data/data/gazetteer/{census_year}_Gazetteer/{census_year}_Gaz_sldl_national.zip'
    response = requests.get(url)
    data = BytesIO(response.content)
    return data

@app.route('/census/state_data', methods=['GET'])
def fetch_state_data():
    url = 'https://www2.census.gov/geo/docs/reference/state.txt'
    response = requests.get(url)
    data = response.text
    return data

@app.route('/ak/results/statewide', methods=['GET'])
def fetch_ak_results():
    url = 'https://www.elections.alaska.gov/enr/results/statewide.js'
    response = requests.get(url, verify=False)
    data = response.json()
    return data

if __name__ == '__main__':
    app.run(debug=True)