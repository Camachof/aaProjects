-- DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE questions_follows (
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  like_val BOOLEAN,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Arthur',  'Miller'),
  ('Eugene', 'O''Neill');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('Who is Arthur Miller?', 'For the life of me I can''t remember', (SELECT id FROM users WHERE fname = 'Arthur')),
  ('Data types for SQL?', 'Boolean, VARCHAR, etc.', (SELECT id FROM users WHERE fname = 'Eugene')),
  ('Third question', 'Body of third question', (SELECT id FROM users WHERE fname = 'Eugene'));
--
INSERT INTO
  questions_follows (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Arthur'), (SELECT id FROM questions WHERE title = 'Data types for SQL?'));


INSERT INTO
  replies (question_id, parent_reply_id, user_id, body)
VALUES
  ((SELECT id FROM questions WHERE title = 'Who is Arthur Miller?'), NULL, (SELECT id FROM users WHERE fname = 'Eugene'), 'YOU IDIOT! He was a playwright!'),
  ((SELECT id FROM questions WHERE title = 'Who is Arthur Miller?'), 1, (SELECT id FROM users WHERE fname = 'Eugene'), 'I''M a chilf');

INSERT INTO
  question_likes (user_id, question_id, like_val)
VALUES
  ((SELECT id FROM users WHERE fname = 'Eugene'), (SELECT id FROM questions WHERE title = 'Data types for SQL?'), 'true'),
  (1, (SELECT id FROM questions WHERE title = 'Data types for SQL?'), 'true'),
  (1, 1, 'true');
