/*
	Update of MySQL dump to SQL Server syntax.
*/

--
-- Table structure for table [session]
--

USE [cfobjective12_rest]
GO

CREATE TABLE [dbo].[session](
	[sessionId] [smallint] IDENTITY(1,1) NOT NULL,
	[sessionTitle] [varchar](500) NULL,
	[sessionDesc] [varchar](max) NULL,
	[startDate] [datetime] NULL,
	[sessionSlug] [varchar](100) NULL,
	PRIMARY KEY CLUSTERED ([sessionId])
)

--
-- Dumping data for table [session]
--

SET IDENTITY_INSERT [session] ON

INSERT INTO
	[session] 
	([sessionId],[sessionTitle],[sessionDesc],[startDate],[sessionSlug])
VALUES
	(1,'Asian Knot Tying','Clover walks you through the making of our 2 most popular Asian Knots with Clover''s easy to use templates, the Tear Drop Knot and the Ball Knot. You will leave with a beautiful Zipper Pull or Key Ring Fob by the end of class.  This will only lead to more ideas and usese for this ancient Chinese art.','2012-05-16 08:00:00','Asian-Knot-Tying')
	,(2,'Crochet Wire & Bead Necklace','In this class you will learn how to transform simple beads and wire into a stunning choker length necklace. Pick from your choice of silver, gold, or copper wire with matching toggle clasp then add your choice of color coordinated bead packets. You do NOT need to know how to crochet to attend. This simple chain stitch technique is easy to learn but the result is extraordinary. You''ll go home with the skills to teach your customers how to design crochet and wire creations.','2012-05-16 09:00:00','Crochet-Wire-Bead-Necklace'),(3,'How to Display Your Small 3D Treasures','We all have cherished pocket-size 3D memorabilia that connects us with our parents, grandparents, children, and special events in our lives.  These items won''t fit into a scrapbook so they usually end up in a box in the closet.  Create your own Memory Globes to enjoy these wonderful reminders of your life then display them on your walls and countertops.  Use your favorite scrapbook papers and card making supplies to decorate your Memory Globe inside and out!','2012-05-16 10:00:00','How-to-Display-Your-Small-3D-Treasures')
	,(4,'It’s Back…Artistic Wire with Julianna','Join Julianna as she reignites the “Fire behind the Wire�?. Julianna will show you how to create unique projects using Artistic Wire in your creative endeavors. This technique-driven workshop is sure to inspire ideas & sales. Bring your Creative Spirit and Imagination as we reignite the passion for wire working!','2012-05-16 11:00:00','Its-Back-Artistic-Wire-with-Julianna')
	,(5,'Sticker Jewelry & More!','Learn how to make fun fashion sticker jewelry, a fabulous flower clip headband and more in this make-it-in-minutes class. We''ll play with a variety of the newest jewelry stickers and make a couple pairs of earrings, then create a decorated satin headband with a fabulous flower clip. We''ll round out our projects with another \"secret\" flower surprise project. Join us for some laid back fun and tips for ways to cross merchandise these products in your store!','2012-05-16 13:00:00','Sticker-Jewelry-More')
	,(6,'Tissue Paper Embossing:  Drawing Inspiration from Fine Arts and Gifts','\"Engage your customers with new techniques using general craft supplies.','2012-05-16 14:00:00','Tissue-Paper-Embossing')
	,(7,'StampingScrapping Designs™ Stamps & Dies','We are a preferred Stamp Partner of Spellbinders™ and have created some beautiful stamp sets that perfectly match many of Spellbinders™ dies. This class will feature many techniques and fun things using Spellbinders™ dies and StampingScrapping Designs™  stamps & dies.  We will create cards & tags using both the dies and stamps. The class will also cover care, use, and tips in creating the perfect stamped image.','2012-05-16 08:00:00','StampingScrapping-Designs-Stamps-Dies')
	,(8,'McGill Paper Blossoms','In this class you will learn to create a variety of 3 dimensional flowers and how they can boost your sales. Flowers can be used to embellish any craft project from picture frames, chip board items, albums, cards, layouts and other paper crafting projects. For retailers who offer classes, Paper Blossom are a great addition to any store class schedule.  McGill offers a wide variety of classroom support materials for their stocking retailers.','2012-05-16 09:00:00','McGill-Paper-Blossoms')
	,(9,'DCWV''s Midnight Spell Advent Calendar','Anyone young or old, will love this interactive advent calendar counting down to the creepiest day of the year, Halloween! In this class, you will create a unique, hanging 3-D calendar using DCWV''s newest Halloween stack, Midnight Spell. Goolish gooblins, creepy bugs and cackling witches will adorn the calendar which will hang from an embroidery hoop. A pocket for each day will hold a special message with either a \"trick\" or a \"treat\" to perform on that given day!','2012-05-16 10:00:00','DCWVs-Midnight-Spell-Advent-Calendar')
	,(10,'Christmas Card Making with Flower Soft®','Learn the simple card making Flower Soft® techniques of creating realistic Christmas scenes using our latest Flower Soft® colors and more!','2012-05-16 11:00:00','Christmas-Card-Making-with-Flower-Soft')
	,(11,'Binding-it-All with the Bind-it All','In this class you will be able to play with the latest and greatest products from companies such as Zutter, Shimmerz, Tombow, Bazzill, My Mind''s Eye, and more.  You will be able to complete a beautiful project that you can take with you and teach as a class at your own store.  A PDF with pictures and instructions of the project will be provided in English and Spanish for the attendees.  Make sure to not miss out!','2012-05-16 13:00:00','Binding-it-All-with-the-Bind-it-All')
	,(12,'Designer Trend Panel: Craft Fusion - Using Mixed Media to Grow Business','Is Mixed Media the new BIG trend we’ve been waiting for?  How do we grow this new interest in hands - on crafts in a technology driven age?  How can we encourage an even younger generation to join in?  ','2012-05-16 14:00:00','Designer-Trend-Panel-Craft-Fusion')
	,(17,'Test session insert','test session description','2012-05-17 08:00:00','test-session-insert')
	,(18,'Test session insert','test session description','2012-05-17 08:00:00','test-session-insert')
	,(19,'hooray for red-eye flights','test session description','2012-05-17 08:00:00','test-session-insert');

SET IDENTITY_INSERT [session] OFF


--
-- Table structure for table speaker
--

CREATE TABLE speaker (
  speakerId smallint NOT NULL IDENTITY(1,1),
  speakerName varchar(100) NULL,
  speakerBio varchar(MAX) NULL,
  speakerSlug varchar(100) NULL,
  PRIMARY KEY (speakerId)
)

--
-- Dumping data for table speaker
--

SET IDENTITY_INSERT speaker ON

INSERT INTO
	speaker
	(speakerId,speakerName,speakerBio,speakerSlug)
VALUES
	(1,'Steve','Just Steve','Steve')
	,(2,'Gypsy Gina','Watch your wallets!','Gypsy-Gina')
	,(3,'Ben Nadel','Nadel is pronounced like \"Navel\"','Ben-Nadel')
	,(4,'Smokey','Only you can prevent craft fires!','Smokey')
	,(5,'Pat','Hi, I''m Pat.','Pat')
	,(6,'Callista Bisek','I''m not really into \"open\" crafting','Callista-Bisek')
	,(7,'Marianne Ginther','I like turtles','Marianne-Ginther');

SET IDENTITY_INSERT speaker OFF


--
-- Table structure for table session_speaker
--

CREATE TABLE session_speaker (
  sessionId smallint NOT NULL,
  speakerId smallint NOT NULL,
  PRIMARY KEY (sessionId,speakerId)
)

--
-- Dumping data for table session_speaker
--

INSERT INTO
	session_speaker
VALUES (1,2),(2,1),(3,4),(4,5),(5,2),(6,1),(7,2),(7,3),(8,6),(9,3),(10,6),(11,5),(12,4),(17,3),(18,3),(19,3);


SET ANSI_PADDING OFF
GO