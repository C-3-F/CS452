-- Insert into Artist table
INSERT INTO Artist (id, name, genre) VALUES
(1, 'Adele', 'Pop'),
(2, 'Miles Davis', 'Jazz'),
(3, 'Ludwig van Beethoven', 'Classical'),
(4, 'The Rolling Stones', 'Rock'),
(5, 'B.B. King', 'Blues'),
(6, 'Bob Marley', 'Reggae'),
(7, 'Kanye West', 'Hip Hop'),
(8, 'Daft Punk', 'Electronic'),
(9, 'Johnny Cash', 'Country'),
(10, 'Shakira', 'Latin'),
(11, 'Metallica', 'Metal'),
(12, 'Bob Dylan', 'Folk'),
(13, 'Aretha Franklin', 'R&B'),
(14, 'Green Day', 'Punk'),
(15, 'Arctic Monkeys', 'Indie'),
(16, 'Mahalia Jackson', 'Gospel'),
(17, 'Taylor Swift', 'Pop'),
(18, 'Snoop Dogg', 'Hip Hop'),
(19, 'David Guetta', 'Electronic'),
(20, 'Nina Simone', 'Jazz');


-- Insert into Venue table
INSERT INTO Venue (id, name, capacity, city) VALUES
(1, 'Madison Square Garden', 20000, 'New York'),
(2, 'Hollywood Bowl', 17376, 'Los Angeles'),
(3, 'Red Rocks Amphitheatre', 9525, 'Morrison'),
(4, 'The O2 Arena', 20000, 'London'),
(5, 'Sydney Opera House', 5738, 'Sydney'),
(6, 'Wembley Stadium', 90000, 'London'),
(7, 'Berlin Philharmonie', 2440, 'Berlin'),
(8, 'Radio City Music Hall', 6015, 'New York'),
(9, 'The Blue Note', 150, 'New York'),
(10, 'Ronnie Scott’s Jazz Club', 250, 'London');


-- Insert into Concert table
INSERT INTO Concert (id, date, artist_id, venue_id) VALUES
(1, '2023-05-20 19:00:00', 1, 1),
(2, '2023-06-15 20:00:00', 2, 9),
(3, '2023-07-05 19:30:00', 3, 7),
(4, '2023-08-10 20:30:00', 4, 2),
(5, '2023-09-12 18:00:00', 5, 8),
(6, '2023-10-01 18:30:00', 6, 3),
(7, '2023-11-20 19:00:00', 7, 1),
(8, '2023-12-15 19:00:00', 8, 4),
(9, '2024-01-22 20:00:00', 9, 6),
(10, '2024-02-28 19:00:00', 10, 5);


-- Insert into Staff table
INSERT INTO Staff (id, name, role, hourly_rate) VALUES
(1, 'John Doe', 'Light Tech', 25.00),
(2, 'Jane Smith', 'Audio Engineer', 30.00),
(3, 'Mike Johnson', 'Instrument Tech', 28.00),
(4, 'Emily Roberts', 'Security', 22.00),
(5, 'David Wilson', 'Venue Merchandise', 18.00),
(6, 'Sarah Parker', 'Audio Engineer', 33.00),
(7, 'Chris Green', 'Light Tech', 27.00),
(8, 'Jessica Thompson', 'Security', 24.00),
(9, 'Aaron Black', 'Instrument Tech', 29.00),
(10, 'Sophia Turner', 'Venue Merchandise', 20.00);


-- Insert into Song table
INSERT INTO Song (id, title, length, artist_id) VALUES
(1, 'Hello', '00:04:55', 1),
(2, 'Someone Like You', '00:04:45', 1),
(3, 'So What', '00:09:22', 2),
(4, 'Freddie Freeloader', '00:09:46', 2),
(5, 'Fur Elise', '00:02:50', 3),
(6, 'Moonlight Sonata', '00:05:32', 3),
(7, 'Start Me Up', '00:03:33', 4),
(8, 'Brown Sugar', '00:03:50', 4),
(9, 'The Thrill Is Gone', '00:05:01', 5),
(10, 'Lucille', '00:10:16', 5),
(11, 'Rolling in the Deep', '00:03:48', 1),
(12, 'Skyfall', '00:04:46', 1),
(13, 'Set Fire to the Rain', '00:04:02', 1),
(14, 'Blue in Green', '00:05:37', 2),
(15, 'All Blues', '00:11:34', 2),
(16, 'Flamenco Sketches', '00:09:26', 2),
(17, 'Ode to Joy', '00:06:45', 3),
(18, 'Symphony No. 5', '00:07:05', 3),
(19, 'Symphony No. 9', '00:12:30', 3),
(20, 'Jumpin’ Jack Flash', '00:03:42', 4),
(21, 'Paint It Black', '00:03:22', 4),
(22, 'Angie', '00:04:32', 4),
(23, 'Rock Me Baby', '00:03:56', 5),
(24, 'Every Day I Have The Blues', '00:02:51', 5),
(25, 'Sweet Little Angel', '00:03:49', 5),
(26, 'No Woman No Cry', '00:07:08', 6),
(27, 'Buffalo Soldier', '00:04:18', 6),
(28, 'One Love', '00:03:22', 6),
(29, 'Stronger', '00:05:12', 7),
(30, 'Gold Digger', '00:03:27', 7),
(31, 'Heartless', '00:03:31', 7),
(32, 'Get Lucky', '00:06:09', 8),
(33, 'One More Time', '00:05:20', 8),
(34, 'Around the World', '00:07:09', 8),
(35, 'Ring of Fire', '00:02:37', 9),
(36, 'Folsom Prison Blues', '00:02:43', 9),
(37, 'Hurt', '00:03:36', 9),
(38, 'Hips Don’t Lie', '00:03:38', 10),
(39, 'Waka Waka', '00:03:23', 10),
(40, 'Whenever, Wherever', '00:03:16', 10),
(41, 'Enter Sandman', '00:05:32', 11),
(42, 'Nothing Else Matters', '00:06:28', 11),
(43, 'Master of Puppets', '00:08:35', 11),
(44, 'Like a Rolling Stone', '00:06:09', 12),
(45, 'The Times They Are A-Changin’', '00:03:15', 12),
(46, 'Blowin’ in the Wind', '00:02:48', 12),
(47, 'Respect', '00:02:27', 13),
(48, 'Chain of Fools', '00:02:45', 13),
(49, 'Think', '00:02:18', 13),
(50, 'Basket Case', '00:03:03', 14),
(51, 'American Idiot', '00:02:58', 14),
(52, 'Boulevard of Broken Dreams', '00:04:20', 14),
(53, 'Do I Wanna Know?', '00:04:32', 15),
(54, 'R U Mine?', '00:03:21', 15),
(55, '505', '00:04:13', 15),
(56, 'Take My Hand, Precious Lord', '00:04:04', 16),
(57, 'Give Me This Mountain', '00:05:20', 16),
(58, 'Trouble of the World', '00:04:42', 16),
(59, 'Love Story', '00:03:55', 17),
(60, 'Shake It Off', '00:03:39', 17),
(61, 'Blank Space', '00:03:51', 17),
(62, 'Gin and Juice', '00:03:31', 18),
(63, 'Drop It Like It’s Hot', '00:04:26', 18),
(64, 'Young, Wild & Free', '00:03:27', 18),
(65, 'Titanium', '00:04:05', 19),
(66, 'Play Hard', '00:03:21', 19),
(67, 'Sexy Bitch', '00:03:15', 19),
(68, 'Feeling Good', '00:02:53', 20),
(69, 'Sinnerman', '00:10:19', 20),
(70, 'I Put a Spell on You', '00:02:34', 20);



-- Insert into Sale table
INSERT INTO Sale (id, ticket_qty, ticket_price, concert_id) VALUES
(1, 100, 150.00, 1),
(2, 200, 120.00, 1),
(3, 150, 90.00, 2),
(4, 80, 85.00, 3),
(5, 250, 95.00, 4),
(6, 300, 100.00, 5),
(7, 120, 130.00, 6),
(8, 110, 140.00, 7),
(9, 50, 50.00, 8),
(10, 75, 110.00, 9);


-- Insert into ConcertStaff table
INSERT INTO ConcertStaff (concert_id, staff_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(3, 6),
(4, 7),
(4, 8),
(5, 9),
(5, 10),
(6, 1),
(6, 2),
(7, 3),
(7, 4),
(8, 5),
(8, 6),
(9, 7),
(9, 8),
(10, 9),
(10, 10);
