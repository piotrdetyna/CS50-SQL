CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL CHECK(length(username) BETWEEN 1 AND 32),
    email TEXT UNIQUE NOT NULL CHECK(length(email) BETWEEN 1 AND 128),
    password TEXT NOT NULL CHECK(length(password) = 64), --sha256 hash
    first_name TEXT NOT NULL CHECK(length(first_name) BETWEEN 1 AND 64),
    last_name TEXT NOT NULL CHECK(length(last_name) BETWEEN 1 AND 64),
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    avatar_url TEXT CHECK(length(avatar_url) < 256)
);

-- each user can be an artist
CREATE TABLE artists (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER UNIQUE,
    description TEXT CHECK(length(description) < 512),
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE albums (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    artist_id INTEGER NOT NULL,
    name TEXT NOT NULL CHECK(length(name) BETWEEN 1 AND 32),
    date TEXT,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    picture_url TEXT NOT NULL CHECK(length(picture_url) BETWEEN 1 AND 256),
    FOREIGN KEY (artist_id) REFERENCES artists(id) ON DELETE CASCADE
);

CREATE TABLE songs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    album_id INTEGER,
    name TEXT NOT NULL CHECK(length(name) BETWEEN 1 AND 32),
    picture_url TEXT NOT NULL CHECK(length(picture_url) BETWEEN 1 AND 128),
    streams_count INTEGER DEFAULT 0,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (album_id) REFERENCES albums(id) ON DELETE SET NULL
);

CREATE TABLE artist_songs (
    artist_id INTEGER NOT NULL,
    song_id INTEGER NOT NULL,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (artist_id) REFERENCES artists(id) ON DELETE CASCADE,
    FOREIGN KEY (song_id) REFERENCES songs(id) ON DELETE CASCADE,
    PRIMARY KEY (artist_id, song_id)
);

CREATE TABLE user_favourite_songs (
    user_id INTEGER NOT NULL,
    song_id INTEGER NOT NULL,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (song_id) REFERENCES songs(id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, song_id)
);

CREATE TABLE user_favourite_albums (
    user_id INTEGER NOT NULL,
    album_id INTEGER NOT NULL,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (album_id) REFERENCES albums(id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, album_id)
);


-- ============= INDEXES =============

-- finding all favourite albums of a user
CREATE INDEX user_favourite_albums_user_id_index ON user_favourite_albums(user_id);

-- finding all favourite songs of a user
CREATE INDEX user_favourite_songs_user_id_index ON user_favourite_songs(user_id);

-- finding all songs associated with a specific artist
CREATE INDEX artist_songs_artist_id_index ON artist_songs(artist_id);

-- finding all artists associated with a song
CREATE INDEX artist_songs_song_id_index ON artist_songs(song_id);

-- finding all songs in an album
CREATE INDEX songs_album_id_index ON songs(album_id);

-- finding all albums by an artist
CREATE INDEX albums_artist_id_index ON albums(artist_id);


-- ============= VIEWS =============

CREATE VIEW user_info AS
SELECT users.id,
    users.username,
    users.email,
    users.first_name,
    users.last_name,
    users.avatar_url,
    users.created_at,
    artists.description artist_description
FROM users
LEFT JOIN artists ON users.id = artists.user_id;
