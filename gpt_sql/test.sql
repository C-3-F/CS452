SELECT venue.name, venue.city FROM Venue
INNER JOIN Concert ON venue.id = concert.venue_id
INNER JOIN Artist ON concert.artist_id = artist.id;
