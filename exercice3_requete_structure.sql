-- Création de la BDD
CREATE DATABASE IF NOT EXISTS quizz CHARSET utf8mb4;
USE quizz;

-- Création des tables
CREATE TABLE played(
played_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
successfull BOOLEAN NOT NULL,
create_at DATETIME,
user_id INT NOT NULL,
quizz_id INT NOT NULL,
question_id INT NOT NULL
)ENGINE=InnoDB;

CREATE TABLE quizz(
quizz_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
title_quizz VARCHAR(255) NOT NULL,
description_quizz TEXT,
img VARCHAR(255) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE category(
category_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
title_category VARCHAR(255) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE answer(
answer_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
text_answer VARCHAR(255) NOT NULL,
valid_answer BOOLEAN,
answer_point INT NOT NULL,
question_id INT NOT NULL
)ENGINE=InnoDB;

CREATE TABLE users(
user_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
firstname_user VARCHAR(50) NOT NULL,
lastname_user VARCHAR(50) NOT NULL,
email_user VARCHAR(50) NOT NULL,
password_user VARCHAR(100) NOT NULL,
roles_user VARCHAR(255) NOT NULL,
avatar VARCHAR(255) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE question(
question_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
title_question VARCHAR(100) NOT NULL,
description_question VARCHAR(255) NOT NULL,
img VARCHAR(255) NOT NULL,
multiple INT NOT NULL
)ENGINE=InnoDB;

-- Création des tables d'association
CREATE TABLE played_answer(
answer_id INT,
played_id INT,
PRIMARY KEY(answer_id,played_id)
)ENGINE=InnoDB;

CREATE TABLE quizz_category(
category_id INT,
quizz_id INT,
PRIMARY KEY(category_id,quizz_id)
)ENGINE=InnoDB;

CREATE TABLE quizz_question(
question_id INT,
quizz_id INT,
PRIMARY KEY(question_id,quizz_id)
)ENGINE=InnoDB;

-- Ajout des contraintes de clé etrangères
ALTER TABLE played
ADD CONSTRAINT fk_to_attached_users
FOREIGN KEY (user_id)
REFERENCES users(user_id)
ON DELETE CASCADE;

ALTER TABLE played
ADD CONSTRAINT fk_to_assigned_quizz
FOREIGN KEY (quizz_id)
REFERENCES quizz(quizz_id)
ON DELETE CASCADE;

ALTER TABLE played
ADD CONSTRAINT fk_to_played_question
FOREIGN KEY (question_id)
REFERENCES question(question_id)
ON DELETE CASCADE;

ALTER TABLE played_answer
ADD CONSTRAINT fk_to_answer_answer
FOREIGN KEY (answer_id)
REFERENCES answer(answer_id);

ALTER TABLE played_answer
ADD CONSTRAINT fk_to_answer_played
FOREIGN KEY (played_id)
REFERENCES played(played_id);

-- Answer
ALTER TABLE answer 
ADD CONSTRAINT fk_to_add_question
FOREIGN KEY (question_id)
REFERENCES question(question_id)
ON DELETE CASCADE;

-- quizz
ALTER TABLE quizz_category
ADD CONSTRAINT fk_to_qualify_category
FOREIGN KEY (category_id)
REFERENCES category(category_id);

ALTER TABLE quizz_category
ADD CONSTRAINT fk_to_qualify_quizz
FOREIGN KEY (quizz_id)
REFERENCES quizz(quizz_id);

ALTER TABLE quizz_question
ADD CONSTRAINT fk_to_contain_question
FOREIGN KEY (question_id)
REFERENCES question(question_id);

ALTER TABLE quizz_question
ADD CONSTRAINT fk_to_contain_quizz
FOREIGN KEY (quizz_id)
REFERENCES quizz(quizz_id);

-- Exercice BONUS (exercice4_requete_miseajour.sql)
INSERT INTO users (firstname_user, lastname_user, email_user, password_user, roles_user, avatar)
VALUES
('Mariana', 'Silveira', 'mariana.silveira@mail.com', MD5('pass123'), 'student', 'mariana.png'),
('Thiago', 'Costa', 'thiago.costa@mail.com', MD5('pass123'), 'student', 'thiago.png'),
('Bianca', 'Ferreira', 'bianca.ferreira@mail.com', MD5('pass123'), 'student', 'bianca.png'),
('Rafael', 'Almeida', 'rafael.almeida@mail.com', MD5('pass123'), 'student', 'rafael.png');

INSERT INTO category (title_category)
VALUES
('Mathematics'),
('Biology'),
('World History'),
('Literature'),
('Geography'),
('Sports');

INSERT INTO quizz (title_quizz, description_quizz, img)
VALUES
('Ultimate Knowledge Quiz', 'A challenging quiz covering multiple topics.', 'ultimate_knowledge.jpg'),
('Science Mastery', 'Test your knowledge of Biology, Physics and Chemistry.', 'science_mastery.jpg'),
('History Explorer', 'Questions on historical events and famous figures.', 'history_explorer.jpg');

INSERT INTO quizz_category (category_id, quizz_id)
VALUES
(1,1), (4,1), 
(2,2), (5,2),  
(3,3), (6,3);  

INSERT INTO question (title_question, description_question, img, multiple)
VALUES
('Q1', 'What is the square root of 144?', '', 0),
('Q2', 'Which organelle is the powerhouse of the cell?', '', 0),
('Q3', 'Who wrote "Pride and Prejudice"?', '', 0),
('Q4', 'What is the chemical symbol for Gold?', '', 0),
('Q5', 'In which year did the Berlin Wall fall?', '', 0),
('Q6', 'What is the capital of Canada?', '', 0),
('Q7', 'Who painted "Starry Night"?', '', 0),
('Q8', 'Solve: 15 * 3 = ?', '', 0),
('Q9', 'Which planet has the most moons?', '', 0),
('Q10', 'Who discovered penicillin?', '', 0),
('Q11', 'Which continent is Kenya located in?', '', 0),
('Q12', 'What is the largest ocean on Earth?', '', 0),
('Q13', 'Which sport uses a shuttlecock?', '', 0),
('Q14', 'Who was the first person to climb Mount Everest?', '', 0),
('Q15', 'What is the main language spoken in Argentina?', '', 0);

INSERT INTO answer (text_answer, valid_answer, answer_point, question_id)
VALUES
('10', 0, 0, 1),
('12', 0, 0, 1),
('12', 1, 1, 1),
('14', 0, 0, 1);
INSERT INTO answer (text_answer, valid_answer, answer_point, question_id)
VALUES
('Nucleus', 0, 0, 2),
('Mitochondria', 1, 1, 2),
('Ribosome', 0, 0, 2),
('Chloroplast', 0, 0, 2);
INSERT INTO answer (text_answer, valid_answer, answer_point, question_id)
VALUES
('Jane Austen', 1, 1, 3),
('Charlotte Bronte', 0, 0, 3),
('Mark Twain', 0, 0, 3),
('Leo Tolstoy', 0, 0, 3);

INSERT INTO quizz_question (question_id, quizz_id)
VALUES (1,1),(3,1),(4,1),(6,1),(8,1);

INSERT INTO quizz_question (question_id, quizz_id)
VALUES (2,2),(9,2),(10,2),(12,2),(5,2);

INSERT INTO quizz_question (question_id, quizz_id)
VALUES (7,3),(11,3),(13,3),(14,3),(15,3);
