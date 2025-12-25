CREATE USER userone PASSWORD 'md5myPassword' CREATEUSER CREATEDB SYSLOG ACCESS UNRESTRICTED;

CREATE SCHEMA IF NOT EXISTS music_video AUTHORIZATION userone;

DROP TABLE IF EXISTS music_video.track_streams;
CREATE TABLE IF NOT EXISTS music_video.track_streams (
  id INTEGER IDENTITY(1,1),
  artist_id INTEGER NOT NULL, 
  company_id INTEGER NOT NULL,
  producer_id INTEGER NOT NULL, 
  streamer_id INTEGER NOT NULL, 
  title VARCHAR(50) NOT NULL,
  released_year SMALLINT NOT NULL,
  isrc VARCHAR(50) NOT NULL,
  monthly_youtube_streams BIGINT NOT NULL,
  monthly_amazon_streams BIGINT NOT NULL,
  streams_month VARCHAR(3) NOT NULL, -- e.g. ('JAN', 'FEB', 'MAR', ... or 'DEC')
  streams_year SMALLINT NOT NULL,  -- e.g. (2000, 2012, ... or 2025)
  created_at TIMESTAMPTZ DEFAULT GETDATE()
) COMPOUND SORTKEY (id, released_year);
-- automatic table optimization using DISTKEY
ALTER TABLE music_video.track_streams ALTER DISTSTYLE AUTO; -- the default
-- ALTER TABLE music_video.track_streams ALTER DISTSTYLE EVEN;

DROP TABLE IF EXISTS music_video.artists;
CREATE TABLE IF NOT EXISTS music_video.artists (
  id INTEGER IDENTITY(1,1)
  age SMALLINT NOT NULL,
  name VARCHAR(50) NOT NULL,
  nationality VARCHAR(50) NOT NULL,
  FOREIGN KEY(id) REFERENCES music_video.track_streams(artist_id)
);

DROP TABLE IF EXISTS music_video.producers;
CREATE TABLE IF NOT EXISTS music_video.producers (
  id INTEGER IDENTITY(1,1)
  age SMALLINT NOT NULL,
  name VARCHAR(50) NOT NULL,
  nationality VARCHAR(50) NOT NULL,
  years_of_experience SMALLINT NOT NULL,
  FOREIGN KEY(id) REFERENCES music_video.track_streams(producer_id)
);

DROP TABLE IF EXISTS music_video.companies;
CREATE TABLE IF NOT EXISTS music_video.companies (
  id INTEGER IDENTITY(1,1)
  name VARCHAR(50) NOT NULL,
  year_founded SMALLINT NOT NULL,
  FOREIGN KEY(id) REFERENCES music_video.track_streams(company_id)
);

DROP TABLE IF EXISTS music_video.streamers;
CREATE TABLE IF NOT EXISTS music_video.streamers (
  id INTEGER IDENTITY(1,1)
  name VARCHAR(50) NOT NULL,
  year_founded SMALLINT NOT NULL,
  FOREIGN KEY(id) REFERENCES music_video.track_streams(streamer_id)
);
