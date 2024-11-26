# United States General Election Presidential Results by District and County from 2008 to 2024

[![DOI](https://zenodo.org/badge/73478714.svg)](https://zenodo.org/badge/latestdoi/73478714)

## Summary
This GitHub repository provides county-level U.S. presidential election results for the years 2008, 2012, 2016, 2020, and 2024. The data comes from various reputable sources, including The Guardian, Townhall.com, Fox News, Politico, and the New York Times. While the results are exhaustive, they are not authoritative. The repository compiles these results to support academic research and analysis, offering both interactive and static visualizations of the election data.

## Table of Contents
- [Compiling Presidential Election Results](#compiling-presidential-election-results)
- [Visualizing the 2024 Presidential Election Results](#visualizing-the-2024-presidential-election-results)
  - [Visualizing Results with a Choropleth Map](#visualizing-results-with-a-choropleth-map)
    - [Create U.S. County Shapefiles](#create-us-county-shapefiles)
    - [Create Alaska House District Shapefiles](#create-alaska-house-district-shapefiles)
    - [Bind U.S. Election Results](#bind-us-election-results)
  - [Visualizing Results with a Dot Density Map](#visualizing-results-with-a-dot-density-map)

### Compiling Presidential Election Results
This GitHub repository serves as a comprehensive collection of U.S. presidential election results at the district or county level for the 2008, 2012, 2016, 2020, and 2024 elections. It draws from multiple trusted sources:

- **2008:** Compiled by [Bill Morris](https://github.com/wboykinm).
- **2012:** Extracted from an Excel file published by [The Guardian](https://www.theguardian.com/news/datablog/2012/nov/07/us-2012-election-county-results-download#data), inspired by a tweet to [John A Guerra Gomez](https://twitter.com/duto_guerra/status/790171584665378816).
- **2016:** Data scraped from [Townhall.com](http://townhall.com/election/2016/president/), inspired by a tweet to [DJ Patil](https://twitter.com/dpatil/status/796902611622436864).
- **2020:** Data scraped from [Fox News](https://www.foxnews.com/elections/2020/general-results), [Politico](https://www.politico.com/2020-election/results/president), and the [New York Times](https://www.nytimes.com/interactive/2020/11/03/us/elections/results-president.html).
- **2024:** Data scraped from [Fox News](https://www.foxnews.com/elections/2024/general-results).

Although the data in this repository is extensive, it is not considered the authoritative source. Researchers are encouraged to verify specific results from primary data sources when needed.

Additionally, the repository includes tools for visualizing presidential election results. Tony McGovern developed both an [interactive map](https://tonmcg.github.io/US_County_Level_Election_Results_08-24) and [static maps](https://github.com/tonmcg/US_County_Level_Election_Results_08-24?tab=readme-ov-file#dot-density-map) of the 2024 presidential election results. Instructions to create these static maps are also provided, making it easier for academics to analyze and present the data in a visual format.

## Visualizing the 2024 Presidential Election Results

This repository compiles various U.S. presidential election results at the county level for all states, except Alaska and Washington, D.C., where results are reported at the house district and ward level, respectively. Each result is linked to a specific geography using a unique 5-digit FIPS code, assigned by the U.S. Census Bureau's Geography Division. For more on FIPS codes, see [this page](https://www.census.gov/programs-surveys/geography/guidance/geo-identifiers.html#ti1187912100).

In this section, we bind 2024 election results to U.S. cartographic boundaries and convert them into a web-friendly format. We use the [Mapshaper Command Line Tool](https://github.com/mbloch/mapshaper/wiki/Introduction-to-the-Command-Line-Tool) to create both choropleth and dot density maps.

### Visualizing Results with a Choropleth Map

- Create a directory to hold cartographic boundary files for all election year results within this repository

```
mkdir cartography
cd cartography
mkdir 2024 2020 2016 2012 2008
```

- Navigate to the `/2024` directory

```
cd 2024
```

#### Create U.S. County Shapefiles

- Download and unzip U.S. county cartographic boundary files

```
curl 'https://www2.census.gov/geo/tiger/GENZ2023/shp/cb_2023_us_county_500k.zip' \
    -o cb_2023_us_county_500k.zip
unzip cb_2023_us_county_500k.zip
```

- Input the U.S. county shapefile
- Filter out certain states, including Alaska -- which we will process separately -- and other U.S. protectorates that we do not have data for
- Create the following new properties:
  - `geoid`: combination of `STATEFP` and `COUNTYFP`, or FIPS code
  - `state_fips`: two digit state FIPS code based on `STATEFP`
  - `county_name`: name of the county based on `NAME`
- Filter out all other fields
- Simplify the layer using the default algorithm, retaining 2% of removable vertices
- Convert the Shapefile into the Albers USA projection
- Output a TopoJSON file named `us_counties.json`

```
mapshaper \
    -i cb_2023_us_county_500k.shp name=us_counties \
    -filter 'STATEFP !== "02" && STATEFP !== "69" && STATEFP !== "66" && STATEFP !== "78" && STATEFP !== "60" && STATEFP !== "72"' \
    -each 'geoid=STATEFP + COUNTYFP,state_fips=STATEFP,county_name=NAME' \
    -filter-fields 'geoid,state_fips,county_name' \
    -simplify 2% \
    -proj albersusa \
    -o format=topojson us_counties.json \
    -o format=geojson us_counties.geojson
```

The result of these commands should output a TopoJSON file that looks like the image below. Notice how Alaska is missing from this image:
![us_counties](https://raw.githubusercontent.com/tonmcg/US_County_Level_Election_Results_08-24/master/img/us_counties.png)

#### Create Alaska House District Shapefiles

Alaska administers presidential elections at the house district-level, not the county-level like other U.S. states. To display results for Alaska, cartographic boundary files for its 40 districts must be [downloaded](https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html) and processed separately from the county-level data.

- Download and unzip Alaska lower chamber legislative district cartographic boundary files

```
curl 'https://www2.census.gov/geo/tiger/GENZ2023/shp/cb_2023_02_sldl_500k.zip' \
    -o cb_2023_02_sldl_500k.zip
unzip cb_2023_02_sldl_500k.zip
```

We now translate and assign each of these 40 house districts a unique FIPS code defined the following way:

- _ssSdd_, where _ss_ is the _state_ FIPS code, _S_ is a catch-all statewide code, and _dd_ is the house district.

For example, the FIPS code attached to election results for Alaska House District 01 is 02001: '02' represents the state FIPS code for Alaska, '0' is a catch-all statewide code, and '01' represents House District 01.

Each house district in the shapefile has properties like a unique identifier, district number, and geographic details. Our goal is to add properties that uniquely link 2024 presidential election results to Alaska's geographic layer.

- Input the Alaska House District shapefile
- Create the following new properties:
  - `district_n`: a unique, zero-padded, two-digit Alaska House District number based on the `SLDLST` property
  - `county_name`: combination of "House District " and `district_n`
  - `state_fips`: the state FIPS code given by `STATEFP`
  - `state_name`: "Alaska"
  - `geoid`: combination of `state_fips`, "9", and `district_n`
- Filter out all other fields
- Simplify the layer using the default algorithm, retaining 2% of removable vertices
- Convert the Shapefile into the Albers USA projection
- Output a TopoJSON file named `alaska_districts.json`

```
mapshaper \
    -i cb_2023_02_sldl_500k.shp name=alaska_districts \
    -each 'district_n=Number(SLDLST).toString().length === 2 ? Number(SLDLST).toString() : new Array(2 - Number(SLDLST).toString().length + 1).join("0") + Number(SLDLST).toString(),county_name="House District " + district_n,state_fips=STATEFP,state_name="Alaska",geoid=state_fips + "9" + district_n' \
    -filter-fields 'geoid,state_fips,county_name' \
    -simplify 2% \
    -proj albersusa \
    -o format=topojson alaska_districts.json \
    -o format=geojson alaska_districts.geojson
```

The result of these commands should output a TopoJSON file that looks like the image below:
![alaska_districts](https://raw.githubusercontent.com/tonmcg/US_County_Level_Election_Results_08-24/master/img/alaska_districts.png)

#### Bind U.S. Election Results

In this section, we create create a single TopoJSON file combining geometry from `us_counties.json` and `alaska_districts.json`, coloring regions by 2024 election results using Red-Blue quantiles, and showing county, state, and national boundaries. We also generate an SVG to display these results.

- Download 2024 U.S. county-level election results

```
curl 'https://raw.githubusercontent.com/tonmcg/US_County_Level_Election_Results_08-24/master/2024_US_County_Level_Presidential_Results.csv' \
    -o 2024_data.csv
```

- Combine and merge the `alaska_districts.json` and `us_counties.json` layers into a new layer
- Add DOM attributes to the county-level output, inlcuding stroke, stroke-width, and class
- Output a new `us_district_boundaries.json` TopoJSON file
- Input the `us_district_boundaries` layer
- Using the `-dissolve` command with `state_fips` as the field to dissolve on, this step merges adjacent polygons on the `state_fips` layer, thereby erasing shared boundaries and showing only the state-level boundaries
- Add DOM attributes to the state-level output, inlcuding stroke, stroke-width, and class
- Output a new `us_state_boundaries.json` TopoJSON file
- Input the `us_state_boundaries` layer
- Using the `-dissolve` command with no named input fields to dissolve on, this step merges adjacent polygons for the entire layer, thereby erasing all shared boundaries and showing only the national-level boundary
- Add DOM attributes to the national-level output, inlcuding stroke, stroke-width, and class
- Output a new `us_boundaries.json` TopoJSON file
- Input the `us_district_boundaries.json` TopoJSON file. We name the layer `us_election_districts`
- Input the `2024_data.csv` file, containing the county-level results of the 2024 presidential election
- Join the election data on to the `us_election_districts` layer
- Use the `-colorizer` command to create a JavaScript function that accepts a numerical input and returns a color defined by a quantized range of values
- Assign the returned color as the value in `fill` DOM attribute
- Ouptut a new `us_election_districts` TopoJSON file
- Combine and merge the `us_election_districts.json`, `us_state_boundaries.json`, and `us_boundaries.json` layers into a new layer
- Output a new `us_election_results` TopoJOSN file
- Output a new `us_election_results` SVG file

```
mapshaper \
    -i alaska_districts.geojson us_counties.geojson combine-files name=us_district_boundaries\
    -merge-layers \
    -style class="county" stroke="#000000" fill="none" stroke-width="0.1" \
    -o format=topojson us_district_boundaries.json \
    -o format=geojson us_district_boundaries.geojson \
    -i us_district_boundaries.geojson name=us_state_boundaries \
    -dissolve state_fips \
    -style class="state" stroke="#ffffff" fill="none" stroke-width="1" \
    -o format=topojson us_state_boundaries.json \
    -o format=geojson us_state_boundaries.geojson \
    -i us_district_boundaries.geojson name=us_boundaries \
    -dissolve \
    -style class="us" stroke="#000000" fill="none" stroke-width="0.5" \
    -o format=topojson us_boundaries.json \
    -o format=geojson us_boundaries.geojson \
    -i us_district_boundaries.geojson name=us_election_districts \
    -i 2024_data.csv string-fields=county_fips name=2024_data \
    -join target=us_election_districts 2024_data keys=geoid,county_fips \
    -colorizer name=getColor colors='#2A71AE,#6BACD0,#BFDCEB,#FACCB4,#E48268,#B82D35' breaks=0.1667,0.3334,0.5,0.6667,0.8334 \
    -style fill='getColor(per_gop)' \
    -o format=topojson us_election_districts.json \
    -o format=geojson us_election_districts.geojson \
    -i us_election_districts.geojson us_state_boundaries.geojson us_boundaries.geojson combine-files name=us_election_results \
	-merge-layers force \
	-o format=topojson us_election_results.json \
    -o format=geojson us_election_results.geojson \
    -o us_election_results.svg
```

The result of these commands should output a TopoJSON file that looks like the following:
![us_election_results](https://raw.githubusercontent.com/tonmcg/US_County_Level_Election_Results_08-24/master/img/us_election_results.png)

### Visualizing Results with a Dot Density Map

Dot density maps are great for showing where things are concentrated. Instead of comparing vote counts between counties, the map below displays the total number of votes within each county. It highlights that most votes come from counties with large, urban populations.

```
mapshaper \
    -i us_district_boundaries.geojson name=us_election_districts \
    -points inner + name=dots \
    -i 2024_data.csv string-fields=county_fips name=2024_data \
    -filter-fields county_fips,votes_gop,votes_dem \
    -each 'margin = votes_gop - votes_dem' \
    -each 'abs_margin = Math.abs(margin)' \
    -join target=dots 2024_data keys=geoid,county_fips \
    -sort abs_margin descending \
    -style r='Math.sqrt(abs_margin) * 0.02' \
    -style opacity=0.5 fill='margin > 0 ? "#B82D35": "#2A71AE"' \
    -lines state_fips target=us_election_districts \
    -style class="county" stroke="#ddd" fill="none" stroke-width="0.1" where='TYPE === "inner"' \
    -style class="us" stroke="#000000" fill="none" stroke-width="0.5" where='TYPE === "outer"' \
    -style class="state" stroke="#000000" fill="none" stroke-width="0.5" where='TYPE === "state_fips"' \
    -o us_dot_election_results.svg target=us_election_districts,dots
```

The result of these commands should output a SVG file that looks like the following:
![us_dot_election_results](https://raw.githubusercontent.com/tonmcg/US_County_Level_Election_Results_08-24/master/img/us_dot_election_results.png)