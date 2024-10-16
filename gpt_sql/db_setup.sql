DROP TABLE IF EXISTS ConcertStaff;
DROP TABLE IF EXISTS Sale;
DROP TABLE IF EXISTS Song;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Concert;
DROP TABLE IF EXISTS Artist;
DROP TABLE IF EXISTS Venue;

CREATE TABLE Artist
(
  id    INT          NOT NULL,
  name  VARCHAR(100) NOT NULL,
  genre VARCHAR(100) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE Concert
(
  id        INT      NOT NULL,
  date      DATETIME NOT NULL,
  artist_id INT      NOT NULL,
  venue_id  INT      NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE ConcertStaff
(
  concert_id INT NOT NULL,
  staff_id   INT NOT NULL
);

CREATE TABLE Sale
(
  id           INT          NOT NULL,
  ticket_qty   INT          NOT NULL,
  ticket_price DECIMAL(6,2) NOT NULL,
  concert_id   INT          NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE Song
(
  id        INT          NOT NULL,
  title     VARCHAR(100) NOT NULL,
  length    TIME         NOT NULL,
  artist_id INT          NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE Staff
(
  id          INT                                                                                   NOT NULL,
  name        VARCHAR(100)                                                                          NOT NULL,
  role        ENUM('Light Tech', 'Audio Engineer','Instrument Tech','Security','Venue Merchandise') NOT NULL,
  hourly_rate DECIMAL                                                                               NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE Venue
(
  id       INT          NOT NULL,
  name     VARCHAR(100) NOT NULL,
  capacity INT          NOT NULL,
  city     VARCHAR(100) NOT NULL,
  PRIMARY KEY (id)
);

ALTER TABLE Song
  ADD CONSTRAINT FK_Artist_TO_Song
    FOREIGN KEY (artist_id)
    REFERENCES Artist (id);

ALTER TABLE Concert
  ADD CONSTRAINT FK_Artist_TO_Concert
    FOREIGN KEY (artist_id)
    REFERENCES Artist (id);

ALTER TABLE Concert
  ADD CONSTRAINT FK_Venue_TO_Concert
    FOREIGN KEY (venue_id)
    REFERENCES Venue (id);

ALTER TABLE Sale
  ADD CONSTRAINT FK_Concert_TO_Sale
    FOREIGN KEY (concert_id)
    REFERENCES Concert (id);

ALTER TABLE ConcertStaff
  ADD CONSTRAINT FK_Concert_TO_ConcertStaff
    FOREIGN KEY (concert_id)
    REFERENCES Concert (id);

ALTER TABLE ConcertStaff
  ADD CONSTRAINT FK_Staff_TO_ConcertStaff
    FOREIGN KEY (staff_id)
    REFERENCES Staff (id);

