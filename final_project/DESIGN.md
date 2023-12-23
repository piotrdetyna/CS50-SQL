# G music
See requirements: [https://cs50.harvard.edu/sql/2023/project/](https://cs50.harvard.edu/sql/2023/project/)

By Piotr Detyna

Video overview: <https://www.youtube.com/watch?v=nKBLDJlLGvg>


<a href="https://www.youtube.com/watch?v=nKBLDJlLGvg"><img src="https://piotr.detyna.pl/cs50-sql/final-project/main.jpg" alt="Final Project" style="width: 100%"></a>

## Scope

* What is the purpose of your database?

    My database is designed to **represent songs, albums, artists and relationships between them**. In the core is very similar to services like Spotify or Apple Music.
* Which people, places, things, etc. are you including in the scope of your database?
    - songs
    - albums
    - artists
    - users
* Which people, places, things, etc. are *outside* the scope of your database?
    - Payments (eg. abonaments)
    - Playlists
    - Updating streams counter for songs

## Functional Requirements

* What should a user be able to do with your database?
    - Create and manage his account
    - Browse songs, albums and artists
    - Mark his account as _artist's account_

* What's beyond the scope of what a user should be able to do with your database?
    - Manage payments
    - Update streams counter for songs

## Representation
<img src="https://piotr.detyna.pl/cs50-sql/final-project/diagram.svg" alt="Diagram" style="width: 100%">

### Entities

* Which entities will you choose to represent in your database and what attributes will those entities have?
    - **Users**: id, username, email, password, first_name, last_name, created_at, avatar_url
    - **Artists**: id, user_id, description, created_at
    - **Songs**: id, album_id, name, picture_url, streams_count, created_at
    - **Albums**: id, artist_id, name, date, created_at, picture_url

* Why did you choose the types you did?

    I chose these types, because they greatly describe and represent their real-life equivalents.
* Why did you choose the constraints you did?
    I used constraints like **NOT NULL, max length of strings, PRIMARY and FOREIGN KEYS** to ensure that the data stored is valid and consistent.

### Relationships

- **users-artists**: One-to-One. Each artist can be associated with exactly one user.
- **artists-albums**: One-to-Many. An artist can have multiple albums.
- **albums-songs**: One-to-Many. An album consists of multiple songs.
- **artists-songs** (through Artist_Songs): Many-to-Many. Artists can collaborate on multiple songs, and each song can have multiple artists.
- **users-favourite_songs**: Many-to-Many. Users can have multiple favorite songs.
- **users-favourite_albums**: Many-to-Many. Users can have multiple favorite albums.

## Optimizations

* Which optimizations (e.g., indexes, views) did you create? Why?
I created **6 indexes** to improve the performance of probably most used queries in the database:
    ```
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
    ```

## Limitations


* What are the limitations of your design?
    The design lacks payment management and probably more attributes to better describe songs, albums or artists.
* What might your database not be able to represent very well?
    My database does not represent relationships between albums and artists, because it only enables to create albums associated with only one artist.
