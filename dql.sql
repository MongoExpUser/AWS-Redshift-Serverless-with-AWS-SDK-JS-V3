-- DQL

-- 1.  All streamed music videos ordered by producers
SELECT  pr.producer, ar.year, ar.title, ar.singer, ar.age
FROM music_video.artist ar
INNER JOIN music_video.producer pr ON  ar.title = pr.title
ORDER BY pr.producer ASC;

-- 2. top streams music videos
SELECT ar.youtube_streams, ar.singer, ar.title, ar.age, pr.producer 
FROM music_video.artist ar
INNER JOIN music_video.producer pr ON ar.title = pr.title
ORDER BY ar.youtube_streams DESC;

-- 3. oldest-to-youngest music videos singer
SELECT ar.age, ar.singer
FROM music_video.artist ar
INNER JOIN music_video.producer pr ON ar.title = pr.title
ORDER BY ar.age DESC;

-- 4. youngest-to-oldest music videos singer
SELECT ar.age, ar.singer
FROM music_video.artist ar
INNER JOIN music_video.producer pr ON ar.title = pr.title
ORDER BY ar.age ASC;

-- 5. top streams music video since 2021
SELECT ar.youtube_streams, ar.year, ar.singer, ar.title, pr.producer
FROM music_video.artist ar
INNER JOIN music_video.producer pr ON ar.title = pr.title
WHERE ar.year >= 2021
ORDER BY ar.youtube_streams DESC;

