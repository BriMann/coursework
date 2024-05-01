DROP TABLE IF EXISTS Cartoon;
DROP TABLE IF EXISTS Artist;
DROP TABLE IF EXISTS VoiceActor;
DROP TABLE IF EXISTS CrewArtist;
DROP TABLE IF EXISTS VoiceActorCast;
DROP TABLE IF EXISTS Crew;
DROP TABLE IF EXISTS Cast;

CREATE TABLE Cartoon(
    cartoonID INTEGER NOT NULL PRIMARY KEY,
    showName TEXT,
    channel TEXT,
    creator TEXT,
    format TEXT
);

CREATE TABLE Artist(
    artistID INTEGER NOT NULL PRIMARY KEY,
    name TEXT
);

CREATE TABLE VoiceActor(
    voiceActorID INTEGER NOT NULL PRIMARY KEY,
    name TEXT
);

CREATE TABLE CrewArtist(
    artistID INTEGER REFERENCES Artist(artistID),
    crewID INTEGER REFERENCES Crew(crewID),
    CrewArtistID INTEGER PRIMARY KEY
);

CREATE TABLE VoiceActorCast(
    voiceActorID INTEGER REFERENCES VoiceActor(voiceActorID),
    castID INTEGER REFERENCES Cast(castID),
    VoiceActorCastID INTEGER PRIMARY KEY

);

CREATE TABLE Crew(
    crewID INTEGER NOT NULL PRIMARY KEY,
    occupation TEXT,
    cartoonID INTEGER REFERENCES Cartoon(cartoonID)
);

CREATE TABLE Cast(
    castID INTEGER NOT NULL PRIMARY KEY,
    character TEXT,
    cartoonID INTEGER REFERENCES Cartoon(cartoonID)
);


INSERT INTO Artist (artistID, name)
VALUES
        (1, 'Brandon Rogers'),
        (2, 'Adam Neylan'),
        (3, 'Lauren Faust'),
        (4, 'Roman Dirge');
    
INSERT INTO VoiceActor (voiceActorID, name)
VALUES
        (1, 'Keith Ferguson'),
        (2, 'Richard Steven Horvitz');
        
INSERT INTO CrewArtist (artistID, crewID, CrewArtistID)
VALUES
        (1, 3, 1),
        (2, 3, 2),
        (3, 2, 3),
        (4, 1, 4);
        
INSERT INTO VoiceActorCast (voiceActorID, castID, VoiceActorCastID)
VALUES
        (1, 1, 1),
        (2, 2, 2),
        (2, 3, 3);
        
INSERT INTO Crew (crewID, cartoonID)
VALUES
        (1, 2),
        (2, 3),
        (3, 1);
    
INSERT INTO Cast (castID, character, cartoonID)
VALUES
        (1,'Lord Hater', 3),
        (2, 'Moxxie', 1),
        (3, 'Invader Zim', 2);
    
INSERT INTO Cartoon (cartoonID, showName, channel, creator, format)
VALUES
        (1, 'Helluva Boss', 'Youtube', 'Vivienne Medrano', '2D'),
        (2, 'Invader Zim', 'Nickelodeon', 'Johnen Vasquez', '2D'),
        (3, 'Wander Over Yonder', 'Disney', 'Craig McCraken', '2D');

    
SELECT * FROM Cartoon;
SELECT * FROM Artist;
SELECT * FROM VoiceActor;
SELECT * FROM CrewArtist;
SELECT * FROM VoiceActorCast;
SELECT * FROM Crew;
SELECT * FROM Cast;