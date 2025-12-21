CREATE USER userone PASSWORD 'md5myPassword' CREATEUSER CREATEDB SYSLOG ACCESS UNRESTRICTED;

CREATE SCHEMA IF NOT EXISTS music_video AUTHORIZATION userone;

DROP TABLE IF EXISTS music_video.artist;
CREATE TABLE IF NOT EXISTS music_video.artist (
  id INTEGER IDENTITY(1,1),
  year SMALLINT NOT NULL,
  title VARCHAR(30)  NOT NULL,
  singer VARCHAR(30) NOT NULL,
  age SMALLINT NOT NULL,
  youtube_streams BIGINT NOT NULL
) COMPOUND SORTKEY (id, year);
-- automatic table optimization using DISTKEY
-- ALTER TABLE music_video.artist ALTER DISTSTYLE AUTO; -- the default
ALTER TABLE music_video.artist ALTER DISTSTYLE EVEN;

DROP TABLE IF EXISTS music_video.producer;
CREATE TABLE IF NOT EXISTS music_video.producer (
  id INTEGER IDENTITY(1,1),
  title VARCHAR(30) NOT NULL,
  producer VARCHAR(30) NOT NULL,
  experience_in_years SMALLINT NOT NULL
) COMPOUND SORTKEY (id, producer);
-- automatic table optimization using DISTKEY
-- ALTER TABLE music_video.producer ALTER DISTSTYLE AUTO; -- the default
ALTER TABLE music_video.producer ALTER DISTSTYLE EVEN;
