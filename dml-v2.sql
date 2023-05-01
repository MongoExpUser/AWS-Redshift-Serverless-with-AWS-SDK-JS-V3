-- DML - version 2

-- This defers from version 1 by:
-- 1. Using both plpythonu (PL/Python — Python Procedural Language) and 
--    plpgsq (PL/pgSQL — SQL Procedural Language) for function definitions instead of ony plpgsq
-- 2. populate tables with only one stored procedure (sp) instead on separated SPs for each table
-- 3. generate more randomized values.

CREATE OR REPLACE FUNCTION music_video.synthetic_year(IN item_list SMALLINT []) 
  RETURNS INTEGER VOLATILE AS $$
  from random import choice
  random_num = choice(item_list)
  return random_num
$$ LANGUAGE 'plpythonu';

CREATE OR REPLACE FUNCTION music_video.synthetic_title(IN item_list VARCHAR(30) []) 
  RETURNS VARCHAR(30) VOLATILE AS $$
  from random import choice
  random_num = choice(item_list)
  return str(random_num)
$$ LANGUAGE 'plpythonu';

CREATE OR REPLACE FUNCTION music_video.synthetic_singer(IN item_list VARCHAR(30) []) 
  RETURNS VARCHAR(30) VOLATILE AS $$
  from random import choice
  random_num = choice(item_list)
  return str(random_num)
$$ LANGUAGE 'plpythonu';

CREATE OR REPLACE FUNCTION music_video.synthetic_producer(IN item_list VARCHAR(30) []) 
  RETURNS VARCHAR(30) VOLATILE AS $$
  from random import choice
  random_num = choice(item_list)
  return str(random_num)
$$ LANGUAGE 'plpythonu';

CREATE OR REPLACE FUNCTION music_video.synthetic_age(IN item_list SMALLINT []) 
  RETURNS INTEGER VOLATILE AS $$
  from random import choice
  random_num = choice(item_list)
  return random_num
$$ LANGUAGE 'plpythonu';

CREATE OR REPLACE FUNCTION music_video.synthetic_streams(IN item_list BIGINT []) 
  RETURNS INTEGER VOLATILE AS $$
  from random import choice
  random_num = choice(item_list)
  return random_num
$$ LANGUAGE 'plpythonu';

CREATE OR REPLACE PROCEDURE music_video.populate_tables(IN loop_limit INTEGER) AS $$
  DECLARE  
    st SMALLINT := 0;
    counter INTEGER := 0;
    year INTEGER := 0;
    title VARCHAR(30) := '';
    singer VARCHAR(30) := '';
    age INTEGER := 0;
    youtube_streams INTEGER := 0;
    producer VARCHAR(30) := '';
    experience_in_years INTEGER := 0;
  BEGIN
    WHILE counter < loop_limit LOOP
      -- value
      year = music_video.synthetic_year(ARRAY [(TRUNC(RANDOM()*(2023 - 2018) + 2018)::INTEGER)]);
      title = music_video.synthetic_title(ARRAY [
        CONCAT('Lovin You-', (music_video.synthetic_year(ARRAY [(TRUNC(RANDOM()*(9 - 1) + 1)::SMALLINT)]))::VARCHAR(30)),
        CONCAT('Grove-', (music_video.synthetic_year(ARRAY [(TRUNC(RANDOM()*(9 - 1) + 1)::SMALLINT)]))::VARCHAR(30)),
        CONCAT('In You-', (music_video.synthetic_year(ARRAY [(TRUNC(RANDOM()*(9 - 1) + 1)::SMALLINT)]))::VARCHAR(30)),
        CONCAT('At Last-', (music_video.synthetic_year(ARRAY [(TRUNC(RANDOM()*(9 - 1) + 1)::SMALLINT)]))::VARCHAR(30)),
        CONCAT('Top Hill-', (music_video.synthetic_year(ARRAY [(TRUNC(RANDOM()*(9 - 1) + 1)::SMALLINT)]))::VARCHAR(30))
      ]);
      singer = music_video.synthetic_singer(ARRAY ['Davin Long', 'Jone Dav', 'Face Ison', 'Alaga Ijoko']);
      age = music_video.synthetic_age(ARRAY [(TRUNC(RANDOM()*(50 - 20) + 20)::INTEGER)]);
      youtube_streams = music_video.synthetic_streams(ARRAY [(TRUNC(RANDOM()*(320005 - 90078) + 90078)::INTEGER)]);
      producer = music_video.synthetic_title(ARRAY ['Albi Jones', 'Don Comando', 'Oalin Alagba', 'Fan Lakup', 'Aldis Mulphy']);
      experience_in_years = music_video.synthetic_streams(ARRAY [(TRUNC(RANDOM()*(12 - 8) + 8)::INTEGER)]);
      -- insert
      INSERT INTO music_video.artist (year, title, singer, age, youtube_streams) VALUES (year, title, singer, age, youtube_streams);
      INSERT INTO music_video.producer (title, producer, experience_in_years) VALUES  (title, producer, experience_in_years);
      -- counter
      counter := counter + 1;
    END LOOP;
  END;
$$ LANGUAGE 'plpgsql';


CALL music_video.populate_tables(20);
