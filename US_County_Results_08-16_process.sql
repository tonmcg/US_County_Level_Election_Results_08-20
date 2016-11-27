-- create the db
-- createdb electiondb
-- psql electiondb -c 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp";'
-- psql electiondb -c 'CREATE EXTENSION IF NOT EXISTS postgis;'
-- psql electiondb -c 'CREATE EXTENSION IF NOT EXISTS postgis_topology;'
-- psql electiondb -c 'CREATE EXTENSION pg_trgm;'

-- import 2008 results and geoms
-- https://catalog.data.gov/dataset/2008-presidential-general-election-county-results-direct-download
-- because geojson is love, bring in this USGS shapefile
-- ogr2ogr -t_srs "EPSG:4326" -s_srs "EPSG:4326" -f geojson pres_results_2008.geojson elpo08p020_nt00335/elpo08p020.shp
-- then send to postgis
-- ogr2ogr -t_srs "EPSG:4326" -f "PostgreSQL" PG:"host=localhost dbname=electiondb" pres_results_2008.geojson -nln counties_2008 -nlt MULTIPOLYGON

-- import 2012 results
-- https://www.theguardian.com/news/datablog/2012/nov/07/us-2012-election-county-results-download--data
DROP TABLE IF EXISTS pres_2012;
CREATE TABLE pres_2012 (
  state_postal text,
  blank_1 text,
  county_number text,
  fips_code text,
  county_name text,
  blank_2 text,
  office_description text,
  precincts_reporting int,
  total_precincts int,
  state_candidate_number_varies_between_state_1 text,
  total_votes_cast_1 int,
  order_1 text,
  party_1 text,
  first_name_1 text,
  middle_name_1 text,
  last_name_1 text,
  junior_1 text,
  use_junior_1 text,
  incumbent_1 text,
  votes_1 int,
  winner_1 text,
  national_politician_id_npid_1 text,
  state_candidate_number_varies_between_state_2 text,
  order_2 text,
  party_2 text,
  first_name_2 text,
  middle_name_2 text,
  last_name_2 text,
  junior_2 text,
  use_junior_2 text,
  incumbent_2 text,
  votes_2 int,
  winner_2 text,
  national_politician_id_npid_2 text,
  state_candidate_number_varies_between_state_3 text,
  order_3 text,
  party_3 text,
  first_name_3 text,
  middle_name_3 text,
  last_name_3 text,
  junior_3 text,
  use_junior_3 text,
  incumbent_3 text,
  votes_3 int,
  winner_3 text,
  national_politician_id_npid_3 text,
  state_candidate_number_varies_between_state_4 text,
  order_4 text,
  party_4 text,
  first_name_4 text,
  middle_name_4 text,
  last_name_4 text,
  junior_4 text,
  use_junior_4 text,
  incumbent_4 text,
  votes_4 int,
  winner_4 text,
  national_politician_id_npid_4 text,
  state_candidate_number_varies_between_state_5 text,
  order_5 text,
  party_5 text,
  first_name_5 text,
  middle_name_5 text,
  last_name_5 text,
  junior_5 text,
  use_junior_5 text,
  incumbent_5 text,
  votes_5 int,
  winner_5 text,
  national_politician_id_npid_5 text,
  state_candidate_number_varies_between_state_6 text,
  order_6 text,
  party_6 text,
  first_name_6 text,
  middle_name_6 text,
  last_name_6 text,
  junior_6 text,
  use_junior_6 text,
  incumbent_6 text,
  votes_6 int,
  winner_6 text,
  national_politician_id_npid_6 text,
  state_candidate_number_varies_between_state_7 text,
  order_7 text,
  party_7 text,
  first_name_7 text,
  middle_name_7 text,
  last_name_7 text,
  junior_7 text,
  use_junior_7 text,
  incumbent_7 text,
  votes_7 int,
  winner_7 text,
  national_politician_id_npid_7 text,
  state_candidate_number_varies_between_state_8 text,
  order_8 text,
  party_8 text,
  first_name_8 text,
  middle_name_8 text,
  last_name_8 text,
  junior_8 text,
  use_junior_8 text,
  incumbent_8 text,
  votes_8 int,
  winner_8 text,
  national_politician_id_npid_8 text,
  state_candidate_number_varies_between_state_9 text,
  order_9 text,
  party_9 text,
  first_name_9 text,
  middle_name_9 text,
  last_name_9 text,
  junior_9 text,
  use_junior_9 text,
  incumbent_9 text,
  votes_9 int,
  winner_9 text,
  national_politician_id_npid_9 text,
  state_candidate_number_varies_between_state_10 text,
  order_10 text,
  party_10 text,
  first_name_10 text,
  middle_name_10 text,
  last_name_10 text,
  junior_10 text,
  use_junior_10 text,
  incumbent_10 text,
  votes_10 int,
  winner_10 text,
  national_politician_id_npid_10 text,
  state_candidate_number_varies_between_state_11 text,
  order_11 text,
  party_11 text,
  first_name_11 text,
  middle_name_11 text,
  last_name_11 text,
  junior_11 text,
  use_junior_11 text,
  incumbent_11 text,
  votes_11 int,
  winner_11 text,
  national_politician_id_npid_11 text,
  state_candidate_number_varies_between_state_12 text,
  order_12 text,
  party_12 text,
  first_name_12 text,
  middle_name_12 text,
  last_name_12 text,
  junior_12 text,
  use_junior_12 text,
  incumbent_12 text,
  votes_12 text,
  winner_12 text,
  national_politician_id_npid_12 text,
  state_candidate_number_varies_between_state_13 text,
  order_13 text,
  party_13 text,
  first_name_13 text,
  middle_name_13 text,
  last_name_13 text,
  junior_13 text,
  use_junior_13 text,
  incumbent_13 text,
  votes_13 int,
  winner_13 text,
  national_politician_id_npid_13 text,
  state_candidate_number_varies_between_state_14 text,
  order_14 text,
  party_14 text,
  first_name_14 text,
  middle_name_14 text,
  last_name_14 text,
  junior_14 text,
  use_junior_14 text,
  incumbent_14 text,
  votes_14 int,
  winner_14 text,
  national_politician_id_npid_14 text,
  state_candidate_number_varies_between_state_15 text,
  order_15 text,
  party_15 text,
  first_name_15 text,
  middle_name_15 text,
  last_name_15 text,
  junior_15 text,
  use_junior_15 text,
  incumbent_15 text,
  votes_15 int,
  winner_15 text,
  national_politician_id_npid_15 text,
  state_candidate_number_varies_between_state_16 text,
  order_16 text,
  party_16 text,
  first_name_16 text,
  middle_name_16 text,
  last_name_16 text,
  junior_16 text,
  use_junior_16 text,
  incumbent_16 text,
  votes_16 int,
  winner_16 text,
  national_politician_id_npid_16 text,
  total_votes_cast_2 int
);

-- cat pres_2012.csv | psql electiondb -c "\COPY pres_2012 FROM STDIN CSV HEADER"

-- import 2016 results
-- https://github.com/tonmcg/County_Level_Election_Results_12-16
DROP TABLE IF EXISTS pres_2016;
CREATE TABLE pres_2016 (
  id text,
  votes_dem double precision,
  votes_gop double precision,
  total_votes double precision,
  per_dem double precision,
  per_gop double precision,
  diff text,
  per_point_diff text,
  state_abbr text,
  county_name text,
  combined_fips text
);

-- cat 2016_US_County_Level_Presidential_Results.csv | psql electiondb -c "\COPY pres_2016 FROM STDIN CSV HEADER"

-- transform 2012 results
-- WEIRDNESS NOTE: SOME COUNTIES ARE RECORDED BY INDIVIDUAL PRECINCT AND 
-- HAVE TO BE GROUPED BY, SUMMING THE RESULTS
ALTER TABLE pres_2012 RENAME TO long_pres_2012;
DROP TABLE IF EXISTS pres_2012;
CREATE TABLE pres_2012 AS (
  WITH main AS (
    SELECT
    -- handle annoying truncation of leading zeroes from excel
      CASE 
        WHEN length(fips_code) = 4 THEN '0' || fips_code
        ELSE fips_code
      END AS fips_code,
      precincts_reporting,
      total_precincts,
      total_votes_cast_1,
      CASE 
        WHEN party_1 = 'Dem' THEN votes_1 
        WHEN party_2 = 'Dem' THEN votes_2 
        WHEN party_3 = 'Dem' THEN votes_3 
        WHEN party_4 = 'Dem' THEN votes_4 
        ELSE NULL 
      END AS dem_votes,
      CASE 
        WHEN party_1 = 'GOP' THEN votes_1 
        WHEN party_2 = 'GOP' THEN votes_2 
        WHEN party_3 = 'GOP' THEN votes_3 
        WHEN party_4 = 'GOP' THEN votes_4 
        ELSE NULL 
      END AS gop_votes 
    FROM long_pres_2012
  )
  SELECT
    fips_code,
    sum(precincts_reporting) AS precincts_reporting,
    sum(total_precincts) AS total_precincts,
    sum(total_votes_cast_1) AS total_votes_cast_1,
    sum(dem_votes) AS dem_votes,
    sum(gop_votes) AS gop_votes
  FROM main
  GROUP BY fips_code
);

-- transform 2008 results
-- WEIRDNESS NOTE: SOME OF THE COUNTIES ARE STRAIGHT UP DUPES, SOMETIMES MORE THAN
-- 100 DUPES. THESE ARE BEST GROUPED BY USING MAX
DROP TABLE IF EXISTS pres_2008;
CREATE TABLE pres_2008 AS (
  WITH main AS (
    SELECT
      CASE 
        WHEN length(fips) = 4 THEN '0' || fips
        ELSE fips
      END AS fips_code,
      county,
      total_vote,
      vote_dem,
      vote_rep AS vote_gop,
      vote_oth
    FROM counties_2008
  )
  SELECT
    fips_code,
    max(county) AS county,
    max(total_vote) AS total_vote,
    max(vote_dem) AS vote_dem,
    max(vote_gop) AS vote_gop,
    max (vote_oth) AS vote_oth
  FROM main
  GROUP BY fips_code
  );

--transform 2016 results
ALTER TABLE pres_2016 RENAME TO pres_2016_raw;
DROP TABLE IF EXISTS pres_2016;
CREATE TABLE pres_2016 AS (
  SELECT
    CASE 
      WHEN length(combined_fips) = 4 THEN '0' || combined_fips
      ELSE combined_fips
    END AS fips_code,
    county_name,
    total_votes::int AS total_vote,
    votes_dem::int AS vote_dem,
    votes_gop::int AS vote_gop,
    (total_votes::int - votes_dem::int - votes_gop::int) AS vote_oth
  FROM pres_2016_raw
);

-- create standalone county geoms
DROP TABLE IF EXISTS counties;
CREATE TABLE counties AS (
  WITH main AS (
    SELECT 
      CASE 
        WHEN length(fips) = 4 THEN '0' || fips
        ELSE fips
      END AS fips_code,
      wkb_geometry AS the_geom,
      county AS county_name,
      state AS state_name
    FROM counties_2008
  )
  SELECT 
    fips_code,
    ST_Union(the_geom) AS the_geom,
    max(county_name) AS county_name,
    max(state_name) AS state_name
  FROM main
  WHERE county_name IS NOT NULL
  GROUP BY fips_code
);

-- combine all 3 elections
DROP TABLE IF EXISTS pres_2008_2016;
CREATE TABLE pres_2008_2016 AS (
  SELECT
    p08.fips_code,
    p08.county,
    p08.total_vote::int AS total_2008,
    p08.vote_dem::int AS dem_2008,
    p08.vote_gop::int AS gop_2008,
    p08.vote_oth::int AS oth_2008,
    p12.total_votes_cast_1 AS total_2012,
    p12.dem_votes AS dem_2012,
    p12.gop_votes AS gop_2012,
    (p12.total_votes_cast_1 - p12.dem_votes - p12.gop_votes) AS oth_2012,
    p16.total_vote AS total_2016,
    p16.vote_dem AS dem_2016,
    p16.vote_gop AS gop_2016,
    p16.vote_oth AS oth_2016
  FROM pres_2008 p08
  LEFT JOIN pres_2012 p12 ON p08.fips_code = p12.fips_code
  LEFT JOIN pres_2016 p16 ON p08.fips_code = p16.fips_code
  WHERE p08.fips_code IS NOT NULL
  AND p12.fips_code IS NOT NULL
  AND p16.fips_code IS NOT NULL
);

-- Ta-da! Output table has the latest 3 election results packages by county!
-- psql electiondb -c "\\copy (SELECT * FROM pres_2008_2016) TO STDOUT CSV HEADER" > pres_2008_2016.csv
-- ogr2ogr -f GeoJSON us_counties.geojson "PG:host=localhost dbname=electiondb" -sql "SELECT fips_code,county_name,state_name,ST_Simplifypreservetopology(the_geom,0.01) FROM counties"

