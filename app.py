from flask import Flask, jsonify
from flask_cors import CORS
import requests
import os
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

@app.route('/census/gazetteer/<int:census_year>/dc_sldu', methods=['GET'])
def fetch_dc_sldu_data(census_year):
    url = f'https://www2.census.gov/geo/docs/maps-data/data/gazetteer/{census_year}_Gazetteer/{census_year}_Gaz_sldu_national.zip'
    response = requests.get(url)
    data = BytesIO(response.content)
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

@app.route('/dc/results/<int:ward_number>', methods=['GET'])
def fetch_dc_results(ward_number):
    url = f'https://electionresults.dcboe.org/ward/getWard/2024-General-Election/{ward_number}'
    response = requests.get(url)
    data = response.json()
    return data

@app.route('/dc/results/lastUpdated', methods=['GET'])
def fetch_dc_result_date():
    url = f'https://electionresults.dcboe.org/electionResults/getElectionInfo/2024-General-Election'
    response = requests.get(url)
    data = response.json()
    return jsonify({"LastUpdated": data.get("LastUpdated")})

@app.route('/ak/results/statewide', methods=['GET'])
def fetch_ak_results():
    url = 'https://www.elections.alaska.gov/enr/results/statewide.js'
    response = requests.get(url, verify=False)
    data = response.json()
    return data

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port, debug=True)