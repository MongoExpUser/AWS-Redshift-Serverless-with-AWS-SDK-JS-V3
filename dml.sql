
--  create stored procedure to populate artist table from synhetic list of values
CREATE OR REPLACE PROCEDURE music_video.populate_artist(IN loop_limit INTEGER, IN rand_value INTEGER) AS $$
    DECLARE 
        counter INTEGER := 0;
        -- rand_value INTEGER := (TRUNC(RANDOM()*5))::INTEGER;
    BEGIN
        WHILE counter < loop_limit LOOP
            INSERT INTO music_video.artist (year, title, singer, age, youtube_streams) VALUES 
            (  
                CASE rand_value  -- year
                    WHEN 0 THEN 2019 
                    WHEN 1 THEN 2020
                    WHEN 2 THEN 2021
                    WHEN 3 THEN 2022
                    WHEN 4 THEN 2023
                ELSE
                    2019
                END,
                CASE rand_value  -- title
                    WHEN 0 THEN 'Lovin You' 
                    WHEN 1 THEN 'Grove' 
                    WHEN 2 THEN 'In You' 
                    WHEN 3 THEN 'At Last' 
                    WHEN 4 THEN 'Top Hill' 
                ELSE 
                    'Rider Long'
                END,
                CASE rand_value -- singer
                    WHEN 0 THEN 'Davin Long' 
                    WHEN 1 THEN 'Jone Dave' 
                    WHEN 2 THEN 'Oluga Oba' 
                    WHEN 3 THEN 'Face Isong' 
                    WHEN 4 THEN 'Alaga Ijoko'

                ELSE 
                    'Saldin Jive'
                END,
                CASE rand_value  -- age
                    WHEN 0 THEN 41
                    WHEN 1 THEN 35
                    WHEN 2 THEN 25 
                    WHEN 3 THEN 32 
                    WHEN 4 THEN 20
                ELSE 
                    (TRUNC(RANDOM()*25))::INTEGER 
                END,
                CASE rand_value -- youtube_streams
                    WHEN 0 THEN (TRUNC(RANDOM()*32000))::INTEGER 
                    WHEN 1 THEN (TRUNC(RANDOM()*20000))::INTEGER 
                    WHEN 2 THEN (TRUNC(RANDOM()*10000))::INTEGER 
                    WHEN 3 THEN (TRUNC(RANDOM()*256789))::INTEGER 
                    WHEN 4 THEN (TRUNC(RANDOM()*380000))::INTEGER 
                ELSE 
                    (TRUNC(RANDOM()*25900))::INTEGER 
                END
            );
                
                counter := counter + 1;
        END LOOP;
    END;
$$ LANGUAGE 'plpgsql';


--  create stored procedure to populate producer table from synhetic list of values
CREATE OR REPLACE PROCEDURE music_video.populate_producer(IN loop_limit INTEGER,  IN rand_value INTEGER) AS $$
    DECLARE 
        counter INTEGER := 0;
        -- rand_value INTEGER := (TRUNC(RANDOM()*5))::INTEGER;
    BEGIN
        WHILE counter < loop_limit LOOP
            INSERT INTO music_video.producer (title, producer, experience_in_years) VALUES 
            (  
                CASE rand_value  -- title
                    WHEN 0 THEN 'Lovin You' 
                    WHEN 1 THEN 'Grove' 
                    WHEN 2 THEN 'In You' 
                    WHEN 3 THEN 'At Last' 
                    WHEN 4 THEN 'Top Hill' 
                ELSE 
                    'Saldin Jive'
                END,
                CASE rand_value -- producer
                    WHEN 0 THEN 'Albi Jones' 
                    WHEN 1 THEN 'Don Comando' 
                    WHEN 2 THEN 'Oalin Alagba' 
                    WHEN 3 THEN 'Fan Lakup' 
                    WHEN 4 THEN 'Aldis Mulphy' 
                ELSE 
                    'Alany Lagson'
                END,
                CASE rand_value  --  experience_in_years
                    WHEN 0 THEN 10
                    WHEN 1 THEN 8
                    WHEN 2 THEN 20 
                    WHEN 3 THEN 15 
                    WHEN 4 THEN 6
                ELSE
                    13
                END
            );
                
            counter := counter + 1;
        END LOOP;
    END;
$$ LANGUAGE 'plpgsql';


-- populate artist & producer tables
CALL music_video.populate_artist(1, 0);
CALL music_video.populate_artist(1, 1);
CALL music_video.populate_artist(1, 2);
CALL music_video.populate_artist(1, 3);
CALL music_video.populate_artist(1, 4);
-- 
CALL music_video.populate_producer(1, 0);
CALL music_video.populate_producer(1, 1);
CALL music_video.populate_producer(1, 2);
CALL music_video.populate_producer(1, 3);
CALL music_video.populate_producer(1, 4);


-- remove all data (uncomment to delete, if desired)
-- DELETE FROM music_video.artist;
-- DELETE FROM music_video.producer;
