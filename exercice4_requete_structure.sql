-- Création de la BDD
CREATE DATABASE application CHARSET utf8mb4;
USE application;

-- Création des tables
CREATE TABLE book(
id_book INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
title_book VARCHAR(50) NOT NULL,
description_book VARCHAR(255) NOT NULL,
publication_date DATE NOT NULL,
cover_book VARCHAR(255) NOT NULL,
id_author INT NOT NULL
)ENGINE=InnoDB;

CREATE TABLE author(
id_author INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
firstname_author VARCHAR(50) NOT NULL,
lastname_author VARCHAR(50) NOT NULL,
pseudo_author VARCHAR(50) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE category(
id_category INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
category_name VARCHAR(50) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE commentary(
id_commentary INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
content_commentary VARCHAR(255) NOT NULL,
created_at DATETIME,
enabled_commentary BOOLEAN NOT NULL,
id_account INT NOT NULL,
id_book INT NOT NULL
)ENGINE=InnoDB;

CREATE TABLE accounts(
id_account INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
firstname_account VARCHAR(50) NOT NULL,
lastname_account VARCHAR(50) NOT NULL,
email_account VARCHAR(50) NOT NULL,
password_account VARCHAR(100) NOT NULL,
account_created_at DATETIME NOT NULL,
status_account BOOLEAN NOT NULL
)ENGINE=InnoDB;

-- Création des tables d'association
CREATE TABLE book_category(
id_book INT,
id_category INT,
PRIMARY KEY(id_book,id_category)
)ENGINE=InnoDB;

CREATE TABLE book_account(
id_book INT,
id_account INT,
PRIMARY KEY(id_book,id_account)
)ENGINE=InnoDB;

-- Ajout des contraintes de clé etrangères
ALTER TABLE book
ADD CONSTRAINT fk_write_author
FOREIGN KEY (id_author) 
REFERENCES author(id_author)
ON DELETE CASCADE;

ALTER TABLE book_category
ADD CONSTRAINT fk_detailed_book
FOREIGN KEY (id_book)
REFERENCES book(id_book);

ALTER TABLE book_category
ADD CONSTRAINT fk_detailed_category
FOREIGN KEY (id_category)
REFERENCES category(id_category);

ALTER TABLE book_account
ADD CONSTRAINT fk_possess_book
FOREIGN KEY (id_book)
REFERENCES book(id_book);

ALTER TABLE book_account
ADD CONSTRAINT fk_possess_account
FOREIGN KEY (id_account)
REFERENCES accounts(id_account);

-- commentary
ALTER TABLE commentary
ADD CONSTRAINT fk_add_book
FOREIGN KEY (id_book)
REFERENCES book(id_book);

ALTER TABLE commentary
ADD CONSTRAINT fk_post_account
FOREIGN KEY (id_account)
REFERENCES accounts(id_account);

-- Modifications (exercice5_requete_structure.sql)
ALTER TABLE accounts
ADD COLUMN account_img VARCHAR(255) NOT NULL DEFAULT "default.png";

ALTER TABLE book
ADD COLUMN back_cover VARCHAR(255) NOT NULL;

ALTER TABLE commentary
ADD COLUMN note INT NOT NULL DEFAULT 0;

ALTER TABLE book
MODIFY publication_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- Modifications (exercice1_requete_miseajour.sql)
INSERT INTO category (category_name) VALUES
('Classic Literature'),
('Fantasy'),
('Philosophy'),
('Historical Fiction'),
('Dystopian');

INSERT INTO accounts (firstname_account, lastname_account, email_account, password_account, account_created_at, status_account)
VALUES
('Kevin', 'Wegman', 'keve@mail.com', 'mdp123', NOW(), 1),
('Alessandro', 'Marquezine', 'ale@mail.com', 'mdp123', NOW(), 1),
('Charlie', 'May', 'charlie@mail.com', 'mdp123', NOW(), 1);

INSERT INTO author (firstname_author, lastname_author, pseudo_author) VALUES
('Jorge', 'Amado','jamado'),
('Paulo','Coelho','pcoelho'),
('Machado','de Assis','massis'),
('Victor','Hugo','vhugo'),
('George','Orwell','gorwell');

INSERT INTO book (title_book, description_book, publication_date, cover_book, back_cover, id_author) VALUES
('Capitaines des Sables', 'Un grand classique de la littérature brésilienne.', NOW(), 'capitaines.jpg', 'capitaines.jpg', 1),
('Gabriela, Girofle et Cannelle', 'Roman emblématique situé en Bahia.', NOW(), 'gabriela.jpg', 'gabriela.jpg', 1),
('L\'Alchimiste', 'Un conte philosophique mondialement célèbre.', NOW(), 'alchimiste.jpg', 'alchimiste.jpg', 2),
('Brida', 'Un roman initiatique sur la magie et la quête intérieure.', NOW(), 'brida.jpg', 'brida.jpg', 2),
('Dom Casmurro', 'Un chef-d’œuvre du réalisme brésilien.', NOW(), 'domcasmurro.jpg', 'domcasmurro.jpg', 3),
('Mémoires posthumes de Brás Cubas', 'Un roman innovant et satirique.', NOW(), 'memoires.jpg', 'memoires.jpg', 3),
('Les Misérables', 'L’un des plus grands romans du XIXe siècle.', NOW(), 'lesmis.jpg', 'lesmis.jpg', 4),
('Notre-Dame de Paris', 'Roman historique centré sur la cathédrale de Paris.', NOW(), 'notredame.jpg', 'notredame.jpg', 4),
('1984', 'Une dystopie sombre et visionnaire.', NOW(), '1984.jpg', '1984.jpg', 5),
('La Ferme des Animaux', 'Une satire politique percutante.', NOW(), 'fermeanx.jpg', 'fermeanx.jpg', 5),
('La Révolte des Animaux', 'Version française alternative du chef-d’œuvre.', NOW(), 'revolteanimaux.jpg', 'revolteanimaux.jpg', 5),
('Quincas Borba', 'Roman réaliste riche en critique sociale.', NOW(), 'quincas.jpg', 'quincas.jpg', 3),
('Le Démon Familial', 'Pièce théâtrale du réalisme brésilien.', NOW(), 'demonfamilial.jpg', 'demonfamilial.jpg', 3),
('Le Zahir', 'Un roman sur la perte, l’amour et la transformation.', NOW(), 'zahir.jpg', 'zahir.jpg', 2),
('Tieta du Sertão', 'Roman du Nordeste plein de vie et de satire.', NOW(), 'tieta.jpg', 'tieta.jpg', 1);

INSERT INTO book_category (id_book, id_category) VALUES
(1, 4), (2, 4), (3, 3),
(4, 3), (5, 4), (6, 4),
(7, 4), (8, 4), (9, 5),
(10, 5), (11, 5), (12, 4),
(13, 4), (14, 3), (15, 4);

INSERT INTO book_account (id_account, id_book) VALUES
(1, 1), (1, 3), (1, 5),
(2, 7), (2, 9), (2, 11),
(3, 2), (3, 4), (3, 6);

INSERT INTO commentary (content_commentary, created_at, enabled_commentary, id_account, id_book) VALUES
('Excellent book, highly recommended.', NOW(), 1, 1, 1),
('Very interesting read.', NOW(), 1, 1, 3),
('I really enjoyed this one.', NOW(), 1, 2, 7),
('A powerful and inspiring book.', NOW(), 1, 2, 9),
('Amazing story and well written.', NOW(), 1, 3, 2),
('Deep and meaningful novel.', NOW(), 1, 3, 4);

-- Modifications (exercice2_requete_miseajour.sql)
UPDATE accounts
SET status_account = 1
WHERE id_account > 0;

UPDATE accounts
SET password_account = MD5(password_account)
WHERE id_account > 0;

UPDATE author SET pseudo_author = 'jamado' WHERE id_author = 1;
UPDATE author SET pseudo_author = 'pcoelho' WHERE id_author = 2;
UPDATE author SET pseudo_author = 'massis' WHERE id_author = 3;
UPDATE author SET pseudo_author = 'vhugo' WHERE id_author = 4;
UPDATE author SET pseudo_author = 'gorwell' WHERE id_author = 5;

UPDATE accounts
SET account_created_at = '2025-11-07'
WHERE id_account > 0;

UPDATE book
SET cover_book = 'update_cover'
WHERE LEFT(title_book,1) BETWEEN 'A' AND 'M'
AND id_book > 0;

UPDATE author
SET lastname_author = UPPER(lastname_author)
WHERE id_author > 0;

-- Modifications (exercice2_requete_miseajour.sql)
SET SQL_SAFE_UPDATES = 0;

DELETE FROM commentary
WHERE id_account BETWEEN 1 AND 2;

-- Supprimer les liaisons dans book_category
DELETE bc
FROM book_category bc
JOIN category c ON bc.id_category = c.id_category
WHERE c.category_name BETWEEN 'A' AND 'P';
-- Supprimer les categories
DELETE FROM category
WHERE category_name BETWEEN 'A' AND 'P';

-- Supprimer les liaisons book_account
DELETE ba
FROM book_account ba
JOIN book b ON ba.id_book = b.id_book
WHERE b.publication_date < '1900-01-01';
-- Supprimer les liaisons book_category
DELETE bc
FROM book_category bc
JOIN book b ON bc.id_book = b.id_book
WHERE b.publication_date < '1900-01-01';
-- Supprimer les commentaires liés à ces books
DELETE c
FROM commentary c
JOIN book b ON c.id_book = b.id_book
WHERE b.publication_date < '1900-01-01';
-- Supprimer les books
DELETE FROM book
WHERE publication_date < '1900-01-01';
-- Supprimer les commentaires liés
DELETE FROM commentary
WHERE id_account = 1;
-- Supprimer les liaisons book_account
DELETE FROM book_account
WHERE id_account = 1;
-- Supprimer le compte
DELETE FROM accounts
WHERE id_account = 1;

SET SQL_SAFE_UPDATES = 1;

describe book