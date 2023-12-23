-- ============= Selecting =============

-- Select all albums of a artist
SELECT * FROM albums WHERE artist_id = 1;

-- Select all songs in a specific album
SELECT * FROM songs WHERE album_id = 2;

-- Get user's favourite songs
SELECT songs.name FROM songs
JOIN user_favourite_songs ON songs.id = user_favourite_songs.song_id
WHERE user_favourite_songs.user_id = 1;

-- Get user information and artist description, if exists
SELECT * FROM user_info WHERE id = 4;


-- ============= Inserting =============

-- Create new user
INSERT INTO users (username, email, password, first_name, last_name, avatar_url)
VALUES ('username', 'email@example.com', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 'Lorem', 'Ipsum', 'https://example.com/avatar.png');

-- Create album
INSERT INTO albums (artist_id, name, date, picture_url)
VALUES (1, 'Nevermind', '2023-12-22', 'https://example.com/album.png');

-- Add a song to user's favourites
INSERT INTO user_favourite_songs (user_id, song_id)
VALUES (3, 10);

-- ============= Updating =============

-- Change user's email
UPDATE users SET email = 'email2@example.com' WHERE id = 2;

-- Change album's name
UPDATE albums SET name = 'Utopia' WHERE id = 2;

-- Increase song's streams count
UPDATE songs SET streams_count = streams_count + 1 WHERE id = 1;

-- ============= Deleting =============

-- Delete a user
DELETE FROM users WHERE id = 1;

-- Delete an album
DELETE FROM albums WHERE id = 2;

-- Remove a song from user's favourites
DELETE FROM user_favourite_songs WHERE user_id = 1 AND song_id = 2;


